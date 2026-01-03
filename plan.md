# Claude Code Configuration Management System - Project Plan

---

**LAST UPDATED:** 2026-01-03

**CURRENT STATUS:** Phase 0 Complete (Content Creation)

**What exists now:**
- ✅ 6 slash commands (code, review, lead, research, product, devops)
- ✅ 6 agent personas (comprehensive workflow references)
- ✅ 2 methodologies (migration, greenfield)
- ✅ 2 skills (TDD, imagen)
- ✅ Web deployment patterns documented
- ✅ Manual deployment works (see README.md)
- ❌ No automation scripts yet

**Next:** Build install.sh for automated deployment (Phase 1)

---

## Project Overview

Build a comprehensive system to manage, share, and synchronize Claude Code configurations across multiple devices (4 Linux machines + iPhone via Claude Code web), including:
- Global CLAUDE.md files
- Claude commands (slash commands)
- Claude personas
- Claude Skills
- Related development environment configs

## Goals

1. **Eliminate repetitive setup** - Configure Claude Code once, deploy everywhere
2. **Version control** - Track changes to configurations over time
3. **Easy updates** - Push config changes from one machine, pull on others
4. **Container compatibility** - Work seamlessly with Podman dev containers
5. **Cross-platform** - Support Linux machines and iPhone (Claude Code web)

## Configuration Management Approaches

### Approach 1: Git + GitHub + Install Script (Baseline)

**How it works:**
- Store all configs in a Git repository
- Provide install script that clones repo and symlinks/copies files to correct locations
- Update by pulling latest changes and re-running install script

**Pros:**
- Simple, well-understood technology
- Version control built-in
- Works offline once cloned
- Easy to review changes via Git diff/history

**Cons:**
- Manual update process (must remember to pull and run script)
- No automatic sync across machines
- Requires running script after each update

**Implementation:**
```bash
curl -fsSL https://raw.githubusercontent.com/user/claude-configs/main/install.sh | sh
# or
git clone https://github.com/user/claude-configs.git ~/.claude-configs
cd ~/.claude-configs && ./install.sh
```

---

### Approach 2: Dotfiles Manager (GNU Stow / chezmoi / yadm)

**How it works:**
- Use specialized dotfiles management tools
- GNU Stow: Creates symlinks from repo to target locations
- chezmoi: Template-based with encryption, machine-specific configs
- yadm: Git wrapper specifically for dotfiles

**Pros:**
- Purpose-built for this exact use case
- Symlinks mean single source of truth (Stow)
- Machine-specific configurations (chezmoi templates)
- Encryption for sensitive data (chezmoi, yadm)
- Well-tested, mature tools

**Cons:**
- Requires installing additional tool
- Learning curve for tool-specific features
- iPhone (Claude Code web) may not support these tools

**Recommended: chezmoi**
```bash
# One-time setup
chezmoi init https://github.com/user/claude-configs.git
chezmoi apply

# Updates
chezmoi update  # Pull and apply changes in one command

# Machine-specific configs via templates
{{ if eq .chezmoi.hostname "workstation1" }}
# Workstation-specific CLAUDE.md content
{{ end }}
```

---

### Approach 3: MCP Server for Config Sync

**How it works:**
- Build a custom Model Context Protocol (MCP) server
- Provides tools for Claude Code to sync configurations
- Could integrate with GitHub, S3, or custom backend
- Claude can automatically check for/apply updates

**Pros:**
- Native integration with Claude Code
- Can be triggered automatically or on-demand
- Cross-platform (works with Claude Code web)
- Could provide smart diff/merge capabilities
- Extensible for future features

**Cons:**
- Requires building custom MCP server
- More complex than simple script approach
- Needs hosting for the sync backend
- Initial development time investment

**Implementation concept:**
```typescript
// MCP server provides tools:
- claude_config_sync_pull()  // Download latest configs
- claude_config_sync_push()  // Upload local configs
- claude_config_sync_status() // Check for updates
- claude_config_apply()      // Apply downloaded configs
```

---

### Approach 4: Container DevContainer Features

**How it works:**
- Package Claude configs as DevContainer Features
- Automatically installed when container starts
- Can version and share via GitHub/OCI registry

**Pros:**
- Perfect for Podman/Docker workflow
- Declarative configuration
- Automatic setup on container creation
- Industry-standard approach
- Can share publicly or privately

**Cons:**
- Only works for containerized environments
- Doesn't help with bare metal installs
- iPhone (Claude Code web) doesn't use containers

**Implementation:**
```json
// devcontainer.json
{
  "features": {
    "ghcr.io/user/devcontainer-features/claude-configs:latest": {
      "version": "1.0.0"
    }
  }
}
```

---

### Approach 5: Cloud Sync + Local Watcher

**How it works:**
- Store configs in cloud storage (Dropbox, Syncthing, Nextcloud)
- Use file watcher or systemd service to detect changes
- Automatically copy to Claude Code locations when changed

**Pros:**
- Real-time sync across all devices
- Works on iPhone (if using supported cloud service)
- No manual intervention needed
- Change on one machine, automatically appears on others

**Cons:**
- Requires cloud storage service
- More complex setup (watchers, services)
- Potential for sync conflicts
- Less explicit version control

**Implementation:**
```bash
# systemd service watching ~/Dropbox/claude-configs
# When files change, copy to ~/.claude/
```

---

## Recommended Hybrid Approach

**Combine the best of multiple approaches:**

1. **Primary: Git + chezmoi** (Approaches 1 + 2)
   - Version control via Git/GitHub
   - Smart deployment via chezmoi
   - Machine-specific configurations
   - Encryption for sensitive data

2. **Containers: DevContainer Feature** (Approach 4)
   - Auto-install configs when creating dev containers
   - Reference the same Git repo as chezmoi

3. **Future: Custom MCP Server** (Approach 3)
   - Phase 2 enhancement
   - Provides `/config-sync` command in Claude Code
   - Smart updates without leaving Claude

## Project Structure

```
claude-configs/
├── .chezmoi.yaml.tmpl          # chezmoi configuration
├── .chezmoiignore              # Files to not manage
├── README.md                   # Documentation
├── install.sh                  # Fallback script for non-chezmoi users
│
├── dot_claude/                 # Maps to ~/.claude/
│   ├── CLAUDE.md               # Global CLAUDE.md
│   ├── settings.json.tmpl      # Settings (machine-specific via template)
│   │
│   ├── commands/               # Slash commands
│   │   ├── review.md
│   │   ├── test.md
│   │   └── deploy.md
│   │
│   ├── personas/               # Claude personas
│   │   ├── code-reviewer.md
│   │   ├── senior-dev.md
│   │   └── security-auditor.md
│   │
│   └── skills/                 # Claude Skills
│       ├── tdd-workflow/
│       ├── api-design/
│       └── devops-automation/
│
├── devcontainer-feature/       # DevContainer Feature
│   ├── devcontainer-feature.json
│   └── install.sh
│
├── mcp-server/                 # Future: Custom MCP server
│   ├── package.json
│   └── src/
│
└── docs/                       # Documentation
    ├── SETUP.md
    ├── UPDATING.md
    └── CUSTOMIZING.md
```

## Implementation Phases

### Phase 0: Content Creation & Planning (COMPLETE ✅)
**Goal:** Create configuration content worth sharing

**Status:** Complete (2026-01-03)

**Deliverables:**
- ✅ 6 agent personas (comprehensive workflow references)
- ✅ 6 slash commands (workflow activation)
- ✅ 2 methodologies (migration, greenfield templates)
- ✅ 2 skills (TDD, image generation)
- ✅ Web deployment documentation and examples
- ✅ Manual deployment instructions
- ✅ Project planning documents (this file, CLAUDE.md)

**Result:** Users can deploy configs manually using README.md instructions.

---

### Phase 1: Core Git + Script Foundation (NOT STARTED)
**Goal:** Automate deployment with install script

**Tasks:**
1. Create repository structure
2. Document current Claude Code config locations
3. Build install.sh script to deploy configs
4. Write comprehensive README
5. Test on one Linux machine
6. Test on second Linux machine
7. Document iPhone (Claude web) setup process

**Deliverables:**
- Working Git repository
- Install script
- Documentation

---

### Phase 2: chezmoi Integration (Enhanced)
**Goal:** Smart, template-based configuration management

**Tasks:**
1. Convert repository to chezmoi format
2. Create machine-specific templates
3. Add encryption for sensitive data
4. Write migration guide from Phase 1
5. Test across all Linux machines
6. Update documentation

**Deliverables:**
- chezmoi-managed configs
- Template examples
- Migration guide

---

### Phase 3: DevContainer Feature (Container Support)
**Goal:** Automatic config setup in Podman containers

**Tasks:**
1. Create DevContainer Feature structure
2. Package for distribution
3. Test with various base images
4. Document usage
5. Publish to GitHub Container Registry (optional)

**Deliverables:**
- DevContainer Feature
- Usage documentation
- Example devcontainer.json

---

### Phase 4: MCP Server (Advanced Automation)
**Goal:** Native Claude Code integration for config sync

**Tasks:**
1. Design MCP server API
2. Implement config sync tools
3. Add update notifications
4. Create installation documentation
5. Test with Claude Code
6. Add intelligent diff/merge

**Deliverables:**
- Working MCP server
- Claude Code integration
- Sync documentation

---

## Configuration Categories

### 1. Global CLAUDE.md
**Location:** `~/.claude/CLAUDE.md`
**Purpose:** Instructions for all Claude sessions
**Content:**
- Project-agnostic best practices
- Coding standards
- Preferred tools and workflows
- Communication preferences

### 2. Slash Commands
**Location:** `~/.claude/commands/*.md`
**Purpose:** Reusable command shortcuts
**Examples:**
- `/review` - Code review workflow
- `/test` - Run tests with specific patterns
- `/deploy` - Deployment checklist
- `/commit` - Smart commit message generation

### 3. Personas
**Location:** `~/.claude/personas/*.md`
**Purpose:** Role-specific behaviors
**Examples:**
- Senior Developer (architecture focus)
- Code Reviewer (quality focus)
- Security Auditor (security focus)
- DevOps Engineer (infrastructure focus)

### 4. Skills
**Location:** `~/.claude/skills/*/`
**Purpose:** Reusable workflows
**Examples:**
- TDD workflow
- API design patterns
- Database migration procedures
- CI/CD automation

### 5. Tool Permissions
**Location:** `~/.claude.json` or `.claude/settings.json`
**Purpose:** Pre-approved tools
**Content:**
- Allowlisted tools for non-interactive use
- MCP server configurations

## Success Criteria

1. **Time to setup:** New machine configured in < 2 minutes
2. **Update propagation:** Config change deployed to all machines in < 5 minutes
3. **Container support:** Dev containers automatically configured
4. **Version control:** All changes tracked in Git
5. **Documentation:** Complete setup/update/customization guides
6. **Cross-platform:** Works on Linux + iPhone (Claude web)

## Testing Plan

### Test Scenarios

1. **Fresh install on new Linux machine**
   - Measure setup time
   - Verify all configs applied correctly
   - Check file permissions

2. **Update existing configuration**
   - Make change on Machine A
   - Deploy to Machine B, C, D
   - Verify consistency

3. **Machine-specific configs**
   - Different settings per machine
   - Templates render correctly
   - No conflicts

4. **Container environment**
   - Start dev container
   - Verify auto-configuration
   - Check persistence

5. **iPhone (Claude web)**
   - Manual config process (no scripts)
   - Document steps
   - Verify functionality

## Risk Mitigation

1. **Config conflicts:** Use chezmoi's merge strategies
2. **Data loss:** Git version control + backups
3. **Sync failures:** Fallback to manual install script
4. **Platform incompatibility:** Document platform-specific instructions
5. **Sensitive data exposure:** Use chezmoi encryption for secrets

## Future Enhancements

1. **Web UI** for config management
2. **Automated tests** for config validation
3. **Config marketplace** for sharing community configs
4. **Smart merge** for handling conflicts
5. **Analytics** on config usage patterns
6. **Integration** with other dotfiles

## References

- [Claude Code Best Practices](https://www.anthropic.com/engineering/claude-code-best-practices)
- [Writing a Good CLAUDE.md](https://www.humanlayer.dev/blog/writing-a-good-claude-md)
- [Claude Skills](https://www.claude.com/skills)
- [Awesome Claude Skills](https://github.com/travisvn/awesome-claude-skills)
- [chezmoi Documentation](https://www.chezmoi.io/)
- [DevContainer Features](https://containers.dev/features)
- [MCP Documentation](https://modelcontextprotocol.io/)
