#!/usr/bin/env bash
set -euo pipefail

#
# Claude Code Configuration Web Installer
# One-line install from GitHub without cloning
#
# Usage:
#   curl -fsSL https://raw.githubusercontent.com/rplsmn/Claude-code-config-sharing/main/web-install.sh | sh
#

# Configuration
REPO_URL="https://github.com/rplsmn/Claude-code-config-sharing"
REPO_BRANCH="${CLAUDE_CONFIG_BRANCH:-main}"
TEMP_DIR=$(mktemp -d)

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Logging functions
log_info() {
    echo -e "${GREEN}✓${NC} $1"
}

log_warn() {
    echo -e "${YELLOW}⚠${NC} $1"
}

log_error() {
    echo -e "${RED}✗${NC} $1" >&2
}

# Cleanup on exit
cleanup() {
    if [ -d "$TEMP_DIR" ]; then
        log_info "Cleaning up temporary files..."
        rm -rf "$TEMP_DIR"
    fi
}
trap cleanup EXIT

# Main installation
main() {
    echo ""
    echo "Claude Code Configuration Web Installer"
    echo "========================================"
    echo ""
    echo "Repository: $REPO_URL"
    echo "Branch: $REPO_BRANCH"
    echo ""

    # Check prerequisites
    log_info "Checking prerequisites..."

    if ! command -v curl >/dev/null 2>&1; then
        log_error "curl is required but not installed"
        exit 1
    fi

    if ! command -v tar >/dev/null 2>&1; then
        log_error "tar is required but not installed"
        exit 1
    fi

    # Download repository
    log_info "Downloading configuration from GitHub..."

    TARBALL_URL="${REPO_URL}/archive/refs/heads/${REPO_BRANCH}.tar.gz"

    if ! curl -fsSL "$TARBALL_URL" | tar -xz -C "$TEMP_DIR"; then
        log_error "Failed to download repository"
        exit 1
    fi

    # Find extracted directory (GitHub creates repo-branch format)
    EXTRACTED_DIR=$(find "$TEMP_DIR" -maxdepth 1 -type d -name "Claude-code-config-sharing-*" | head -1)

    if [ -z "$EXTRACTED_DIR" ] || [ ! -d "$EXTRACTED_DIR" ]; then
        log_error "Failed to locate extracted repository"
        exit 1
    fi

    log_info "Repository downloaded successfully"

    # Run the regular install script
    log_info "Running installation..."
    echo ""

    cd "$EXTRACTED_DIR"

    if [ ! -f "install.sh" ]; then
        log_error "install.sh not found in repository"
        exit 1
    fi

    chmod +x install.sh

    # Run install.sh with force flag to avoid interactive prompt
    ./install.sh --force

    echo ""
    log_info "Installation complete!"
    echo ""
    echo "Next steps:"
    echo "  1. Start a new Claude Code session"
    echo "  2. Try a slash command (e.g., /code)"
    echo "  3. Check ~/.claude/CLAUDE.md for workflow guidelines"
    echo ""
}

# Run main
main
