#!/usr/bin/env bash
set -euo pipefail

#
# Claude Code Configuration Installer
# Deploys configs from this repo to ~/.claude/
#

# Configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_DIR="${SCRIPT_DIR}/dot_claude"
TARGET_DIR="${HOME}/.claude"
BACKUP_DIR="${HOME}/.claude-backup-$(date +%Y%m%d-%H%M%S)"
DRY_RUN=false

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Usage information
usage() {
    cat << EOF
Usage: $0 [OPTIONS]

Deploy Claude Code configurations to ~/.claude/

OPTIONS:
    -h, --help      Show this help message
    -d, --dry-run   Show what would be done without making changes
    -f, --force     Skip confirmation prompt

EXAMPLES:
    $0                  # Interactive installation
    $0 --dry-run        # Preview changes
    $0 --force          # Install without confirmation

EOF
    exit 0
}

# Parse arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -h|--help)
            usage
            ;;
        -d|--dry-run)
            DRY_RUN=true
            shift
            ;;
        -f|--force)
            FORCE=true
            shift
            ;;
        *)
            echo "Unknown option: $1"
            usage
            ;;
    esac
done

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

# Validation
validate_prerequisites() {
    log_info "Validating prerequisites..."

    if [ ! -d "$SOURCE_DIR" ]; then
        log_error "Source directory not found: $SOURCE_DIR"
        log_error "Are you running this script from the repository root?"
        exit 1
    fi

    if [ ! -d "${SOURCE_DIR}/commands" ]; then
        log_error "Commands directory not found: ${SOURCE_DIR}/commands"
        log_error "Repository structure may be corrupted"
        exit 1
    fi

    log_info "Prerequisites validated"
}

# Backup existing configuration
backup_existing() {
    if [ -d "$TARGET_DIR" ]; then
        log_warn "Existing configuration found at: $TARGET_DIR"

        if [ "$DRY_RUN" = true ]; then
            log_info "[DRY RUN] Would backup to: $BACKUP_DIR"
            return
        fi

        log_info "Creating backup: $BACKUP_DIR"
        cp -r "$TARGET_DIR" "$BACKUP_DIR"
        log_info "Backup created successfully"
    else
        log_info "No existing configuration found (fresh install)"
    fi
}

# Deploy configuration
deploy_configs() {
    log_info "Deploying Claude Code configuration..."

    if [ "$DRY_RUN" = true ]; then
        log_info "[DRY RUN] Would deploy:"
        find "$SOURCE_DIR" -type f | while read -r file; do
            rel_path="${file#$SOURCE_DIR/}"
            echo "  - $rel_path"
        done
        return
    fi

    # Create target directory if it doesn't exist
    mkdir -p "$TARGET_DIR"

    # Deploy each component
    local components=("commands" "methodologies" "skills" "CLAUDE.md")

    for component in "${components[@]}"; do
        if [ -e "${SOURCE_DIR}/${component}" ]; then
            log_info "Deploying: $component"
            cp -r "${SOURCE_DIR}/${component}" "$TARGET_DIR/"
        else
            log_warn "Skipping missing component: $component"
        fi
    done

    log_info "Configuration deployed successfully"
}

# Verify deployment
verify_deployment() {
    log_info "Verifying deployment..."

    if [ "$DRY_RUN" = true ]; then
        log_info "[DRY RUN] Would verify deployment"
        return
    fi

    local errors=0

    # Check commands
    if [ -d "${TARGET_DIR}/commands" ]; then
        local cmd_count
        cmd_count=$(find "${TARGET_DIR}/commands" -name "*.md" -type f | wc -l)
        if [ "$cmd_count" -gt 0 ]; then
            log_info "Found $cmd_count slash command(s)"
        else
            log_error "No slash commands found"
            ((errors++))
        fi
    else
        log_error "Commands directory missing"
        ((errors++))
    fi

    # Check CLAUDE.md
    if [ -f "${TARGET_DIR}/CLAUDE.md" ]; then
        log_info "Global CLAUDE.md deployed"
    else
        log_warn "Global CLAUDE.md not found (optional)"
    fi

    # Check methodologies
    if [ -d "${TARGET_DIR}/methodologies" ]; then
        log_info "Methodologies deployed"
    else
        log_warn "Methodologies not found (optional)"
    fi

    # Check skills
    if [ -d "${TARGET_DIR}/skills" ]; then
        log_info "Skills deployed"
    else
        log_warn "Skills not found (optional)"
    fi

    if [ $errors -gt 0 ]; then
        log_error "Verification failed with $errors error(s)"
        return 1
    fi

    log_info "Verification complete"
    return 0
}

# Rollback on failure
rollback() {
    log_error "Installation failed!"

    if [ -d "$BACKUP_DIR" ]; then
        log_warn "Rolling back to backup..."
        rm -rf "$TARGET_DIR"
        mv "$BACKUP_DIR" "$TARGET_DIR"
        log_info "Rollback complete"
    fi

    exit 1
}

# Show summary
show_summary() {
    echo ""
    echo "========================================"
    echo "  Claude Code Configuration Installed"
    echo "========================================"
    echo ""
    echo "Configuration location: $TARGET_DIR"

    if [ -d "$BACKUP_DIR" ] && [ "$DRY_RUN" = false ]; then
        echo "Backup location: $BACKUP_DIR"
    fi

    echo ""
    echo "Available slash commands:"
    if [ -d "${TARGET_DIR}/commands" ] && [ "$DRY_RUN" = false ]; then
        find "${TARGET_DIR}/commands" -name "*.md" -type f | while read -r cmd; do
            cmd_name=$(basename "$cmd" .md)
            echo "  /$cmd_name"
        done
    else
        echo "  /code, /review, /lead, /research, /product, /devops"
    fi

    echo ""
    echo "Next steps:"
    echo "  1. Start a new Claude Code session"
    echo "  2. Try a slash command (e.g., /code)"
    echo "  3. Check ~/.claude/CLAUDE.md for workflow guidelines"
    echo ""

    if [ -d "$BACKUP_DIR" ] && [ "$DRY_RUN" = false ]; then
        echo "To restore previous config:"
        echo "  rm -rf $TARGET_DIR && mv $BACKUP_DIR $TARGET_DIR"
        echo ""
    fi
}

# Main installation flow
main() {
    echo ""
    echo "Claude Code Configuration Installer"
    echo "===================================="
    echo ""

    if [ "$DRY_RUN" = true ]; then
        log_info "DRY RUN MODE - No changes will be made"
        echo ""
    fi

    # Validate
    validate_prerequisites

    # Show what will be installed
    echo ""
    echo "Source: $SOURCE_DIR"
    echo "Target: $TARGET_DIR"
    echo ""

    # Confirm unless force flag
    if [ "${FORCE:-false}" != true ] && [ "$DRY_RUN" = false ]; then
        read -rp "Continue with installation? [y/N] " response
        if [[ ! "$response" =~ ^[Yy]$ ]]; then
            echo "Installation cancelled"
            exit 0
        fi
    fi

    # Set up error handling
    if [ "$DRY_RUN" = false ]; then
        trap rollback ERR
    fi

    # Execute installation
    backup_existing
    deploy_configs
    verify_deployment || rollback

    # Success
    if [ "$DRY_RUN" = false ]; then
        show_summary
    else
        echo ""
        log_info "[DRY RUN] Installation preview complete"
        log_info "Run without --dry-run to install"
    fi
}

# Run main
main
