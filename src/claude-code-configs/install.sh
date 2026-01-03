#!/usr/bin/env bash
set -euo pipefail

#
# DevContainer Feature: Claude Code Configurations
# Automatically deploys Claude Code configs when container starts
#

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

log_info() {
    echo -e "${GREEN}✓${NC} $1"
}

log_warn() {
    echo -e "${YELLOW}⚠${NC} $1"
}

log_error() {
    echo -e "${RED}✗${NC} $1" >&2
}

echo ""
echo "=========================================="
echo "  Claude Code Configurations Feature"
echo "=========================================="
echo ""

# Get options from devcontainer-feature.json
CONFIG_BRANCH="${CONFIGBRANCH:-main}"
DEPLOY_TO_ROOT="${DEPLOYTOROOT:-false}"

# Determine target user and home directory
REMOTE_USER="${_REMOTE_USER:-root}"
REMOTE_USER_HOME="${_REMOTE_USER_HOME:-/root}"

if [ "$DEPLOY_TO_ROOT" = "true" ]; then
    TARGET_USER="root"
    TARGET_HOME="/root"
else
    TARGET_USER="$REMOTE_USER"
    TARGET_HOME="$REMOTE_USER_HOME"
fi

log_info "Installing Claude Code configurations for user: $TARGET_USER"
log_info "Target directory: $TARGET_HOME/.claude"
log_info "Configuration branch: $CONFIG_BRANCH"

# Validate prerequisites
if ! command -v curl >/dev/null 2>&1; then
    log_error "curl is required but not installed"
    exit 1
fi

if ! command -v tar >/dev/null 2>&1; then
    log_error "tar is required but not installed"
    exit 1
fi

# Download repository
REPO_URL="https://github.com/rplsmn/Claude-code-config-sharing"
TEMP_DIR=$(mktemp -d)

log_info "Downloading configurations from GitHub..."

TARBALL_URL="${REPO_URL}/archive/refs/heads/${CONFIG_BRANCH}.tar.gz"

if ! curl -fsSL "$TARBALL_URL" | tar -xz -C "$TEMP_DIR"; then
    log_error "Failed to download repository"
    rm -rf "$TEMP_DIR"
    exit 1
fi

# Find extracted directory
EXTRACTED_DIR=$(find "$TEMP_DIR" -maxdepth 1 -type d -name "Claude-code-config-sharing-*" | head -1)

if [ -z "$EXTRACTED_DIR" ] || [ ! -d "$EXTRACTED_DIR" ]; then
    log_error "Failed to locate extracted repository"
    rm -rf "$TEMP_DIR"
    exit 1
fi

log_info "Repository downloaded successfully"

# Deploy configurations
log_info "Deploying configurations..."

TARGET_DIR="$TARGET_HOME/.claude"

# Create target directory if it doesn't exist
mkdir -p "$TARGET_DIR"

# Deploy each component from dot_claude/
if [ -d "${EXTRACTED_DIR}/dot_claude" ]; then
    SOURCE_DIR="${EXTRACTED_DIR}/dot_claude"

    # Deploy commands
    if [ -d "${SOURCE_DIR}/commands" ]; then
        log_info "Installing slash commands..."
        cp -r "${SOURCE_DIR}/commands" "$TARGET_DIR/"
    fi

    # Deploy methodologies
    if [ -d "${SOURCE_DIR}/methodologies" ]; then
        log_info "Installing methodologies..."
        cp -r "${SOURCE_DIR}/methodologies" "$TARGET_DIR/"
    fi

    # Deploy skills
    if [ -d "${SOURCE_DIR}/skills" ]; then
        log_info "Installing skills..."
        cp -r "${SOURCE_DIR}/skills" "$TARGET_DIR/"
    fi

    # Deploy global CLAUDE.md
    if [ -f "${SOURCE_DIR}/CLAUDE.md" ]; then
        log_info "Installing global CLAUDE.md..."
        cp "${SOURCE_DIR}/CLAUDE.md" "$TARGET_DIR/"
    fi
else
    log_error "dot_claude directory not found in repository"
    rm -rf "$TEMP_DIR"
    exit 1
fi

# Fix permissions if deploying to non-root user
if [ "$TARGET_USER" != "root" ]; then
    log_info "Fixing permissions for user: $TARGET_USER"
    chown -R "$TARGET_USER:$TARGET_USER" "$TARGET_DIR"
fi

# Cleanup
rm -rf "$TEMP_DIR"

# Verify installation
if [ -d "$TARGET_DIR/commands" ]; then
    CMD_COUNT=$(find "$TARGET_DIR/commands" -name "*.md" -type f | wc -l)
    log_info "Installation complete! Found $CMD_COUNT slash commands"
else
    log_warn "Commands directory not found after installation"
fi

echo ""
log_info "Claude Code configurations deployed to: $TARGET_DIR"
echo ""
echo "Available slash commands:"
if [ -d "$TARGET_DIR/commands" ]; then
    find "$TARGET_DIR/commands" -name "*.md" -type f | while read -r cmd; do
        cmd_name=$(basename "$cmd" .md)
        echo "  /$cmd_name"
    done
else
    echo "  /code, /review, /lead, /research, /product, /devops"
fi
echo ""
log_info "Start a Claude Code session and try a slash command!"
echo ""
