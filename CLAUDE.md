# Claude Code Configuration Management System

## What (Tech Stack & Structure)

**Project Type:** Configuration management system for Claude Code
**Primary Language:** Bash (scripts), Markdown (configs/docs)
**Target Platforms:** Linux (Ubuntu, Fedora, Arch), iPhone (Claude Code web)
**Package Manager:** chezmoi (Phase 2), Git (Phase 1)

**Repository Structure:**
```
claude-configs/
├── plan.md                    # Overall project plan and approach analysis
├── implementation-log.md      # Living log of what's implemented (READ THIS FIRST)
├── qa-review.md              # QA review findings and recommendations
├── CLAUDE.md                 # This file
├── persona-coding.md         # Coding agent persona and best practices
├── persona-review.md         # Review agent persona and best practices
├── install.sh                # Installation script (Phase 1)
├── update.sh                 # Update script (Phase 1)
├── dot_claude/               # Config files to deploy
│   ├── CLAUDE.md            # Global Claude configuration
│   ├── commands/            # Slash commands
│   ├── personas/            # Claude personas
│   └── skills/              # Claude Skills
└── docs/                    # Documentation
```

---

## Why (Project Purpose)

This project solves the problem of managing Claude Code configurations across multiple devices (4 Linux machines + iPhone). The goal is to:
1. Configure Claude Code once, deploy everywhere
2. Share configuration updates easily
3. Version control all configs
4. Support dev containers (Podman)
5. Minimize setup time (< 2 minutes per machine)

---

## How (Development Workflow)

### CRITICAL: Read Before Acting

**YOU MUST read these files in order BEFORE starting any work:**
1. `plan.md` - Understand overall architecture and phased approach
2. `implementation-log.md` - See current status and next tasks
3. `qa-review.md` - Review quality standards and previous findings
4. This file (CLAUDE.md) - Understand project-specific practices
5. **Your persona file:**
   - **Coding agents:** Read `persona-coding.md` for coding best practices and workflow
   - **Review agents:** Read `persona-review.md` for review standards and checklist

### Workflow for Coding Agent

**IMPORTANT: If you are the coding agent, read `persona-coding.md` for comprehensive coding guidelines, shell script standards, and workflow details.**

**Starting a work session:**
1. Read the instruction files above (including persona-coding.md)
2. Create a todo list with TodoWrite for your planned work
3. Mark the current task as in_progress
4. Do the work incrementally, updating todos as you go
5. Update implementation-log.md when task is complete
6. Commit changes with descriptive message
7. Push to branch: `claude/config-management-system-hEF7I`
8. Open PR for human review

**During work:**
- ALWAYS use TodoWrite to track progress
- Mark only ONE task as in_progress at a time
- Complete tasks fully before starting new ones
- Update implementation-log.md after completing each major task
- Test your changes before committing

**Example workflow:**
```bash
# After finishing implementation of install.sh:
# 1. Update implementation-log.md
# 2. Commit your work
git add install.sh implementation-log.md
git commit -m "feat: implement install.sh with backup and rollback

- Add error handling with set -euo pipefail
- Backup existing configs before install
- Rollback mechanism on failure
- Dry-run mode for testing
- Cross-platform support

Updated implementation-log.md with completion status."

# 3. Push to branch
git push -u origin claude/config-management-system-hEF7I

# 4. Create PR (if session complete)
gh pr create --title "Phase 1: Core installation script" --body "$(cat <<'EOF'
## Summary
- Implemented install.sh with full error handling
- Added backup and rollback mechanisms
- Tested on Ubuntu and Fedora

## Test plan
- [ ] Test fresh install on Ubuntu
- [ ] Test fresh install on Fedora
- [ ] Test with existing configs (should backup)
- [ ] Test rollback on failure
- [ ] Test dry-run mode
EOF
)"
```

---

### Workflow for Reviewer Agent

**IMPORTANT: If you are the review agent, read `persona-review.md` for comprehensive review guidelines, quality checklists, and feedback templates.**

**Starting a review session:**
1. Read plan.md, implementation-log.md, qa-review.md (including persona-review.md)
2. Check git diff to see what changed
3. Create todo list for review tasks
4. Follow review checklists in qa-review.md and persona-review.md
5. Document findings in qa-review.md
6. Update implementation-log.md if issues found
7. Commit qa-review.md updates
8. Add PR review comments

**Review focus areas:**
- Shell script quality (error handling, quoting, idempotency)
- Config file best practices (concise, universally applicable)
- Documentation clarity (step-by-step, examples)
- Security (no hardcoded secrets, safe operations)
- Cross-platform compatibility
- Test coverage

**Example review workflow:**
```bash
# After reviewing install.sh:
# 1. Update qa-review.md with findings
# 2. Commit review
git add qa-review.md
git commit -m "review: install.sh implementation

Found 2 issues:
- Missing input validation for custom install path
- Should check for shellcheck before committing

Otherwise looks good. Approved with minor changes."

# 3. If issues found, update implementation-log.md
# 4. Push and add PR comments
```

---

## Important Project-Specific Practices

### 1. Progressive Implementation

IMPORTANT: This project is implemented in 4 phases. DO NOT skip ahead to later phases.

**Current phase:** Check implementation-log.md for current phase
**Phase order:**
1. Phase 1: Git + Script (MVP)
2. Phase 2: chezmoi integration
3. Phase 3: DevContainer Feature
4. Phase 4: MCP Server

### 2. Documentation-Driven Development

**YOU MUST update documentation as you code:**
- Update implementation-log.md when completing tasks
- Update qa-review.md when reviewing
- Update docs/ when changing behavior
- Keep README.md in sync with features

### 3. Shell Script Standards

**ALWAYS use these patterns in bash scripts:**
```bash
#!/usr/bin/env bash
set -euo pipefail

# Validate prerequisites
command -v git >/dev/null 2>&1 || {
    echo "Error: git is required but not installed" >&2
    exit 1
}

# Quote all variables
INSTALL_DIR="${HOME}/.claude"
if [ -d "$INSTALL_DIR" ]; then
    echo "Found existing installation at: $INSTALL_DIR"
fi

# Backup before changes
backup_configs() {
    local backup_dir="$HOME/.claude-backup-$(date +%Y%m%d-%H%M%S)"
    cp -r "$INSTALL_DIR" "$backup_dir"
    echo "Backed up to: $backup_dir"
}

# Provide rollback
rollback() {
    echo "Installation failed. Rolling back..." >&2
    # Rollback logic here
}
trap rollback ERR
```

**Run shellcheck before committing:**
```bash
shellcheck install.sh update.sh scripts/*.sh
```

### 4. Configuration File Best Practices

**For CLAUDE.md files:**
- Follow WHAT/WHY/HOW structure
- Keep under 300 lines (ideally < 100)
- Only universally applicable instructions
- Use progressive disclosure (link to detailed docs)
- No style guidelines (use linters)
- Emphasis markers: "IMPORTANT", "YOU MUST", "NEVER"

**For slash commands:**
- Clear frontmatter description
- Specific, actionable instructions
- Include usage examples

**For skills:**
- Follow community best practices
- "Write instructions as if for a human collaborator"
- Include test scenarios

### 5. Testing Requirements

**Before marking a task complete:**
- Test on at least one Linux distribution
- Verify against acceptance criteria in implementation-log.md
- Run shellcheck on any modified scripts
- Validate markdown with markdownlint (if available)
- Test destructive operations in VM/container first

### 6. Git Commit Practices

**Commit message format:**
```
<type>: <short description>

<detailed description>
<what changed and why>

<any breaking changes or notes>
```

**Types:** feat, fix, docs, test, refactor, review, chore

**Examples:**
```
feat: add install.sh with backup mechanism

Implements installation script with:
- Error handling (set -euo pipefail)
- Backup of existing configs
- Rollback on failure
- Dry-run mode
- Cross-platform support (Ubuntu, Fedora, Arch)

Updated implementation-log.md to mark task 1.4 complete.
```

### 7. Branch and PR Workflow

**Branch:** Always work on `claude/config-management-system-hEF7I`

**Before pushing:**
- Ensure all todos are completed or updated
- Update implementation-log.md
- Run basic tests
- Commit all changes

**Push with retry:**
```bash
git push -u origin claude/config-management-system-hEF7I
# If network error, retry with exponential backoff
```

**PR creation:**
- Title: Clear, descriptive
- Body: Summary bullets + Test plan checklist
- Link to relevant issues
- Tag for human review

### 8. Handling Unknowns

**If you need to research config locations:**
- Use Task tool with Explore agent
- Document findings in implementation-log.md
- Update docs/CONFIG_LOCATIONS.md

**If you're unsure about approach:**
- Check plan.md for guidance
- Check qa-review.md for previous similar issues
- Ask specific questions rather than guessing

---

## Critical Reminders

**IMPORTANT: For ALL agents working on this project:**

1. **READ FIRST, CODE SECOND** - Always read plan.md, implementation-log.md, qa-review.md before starting
2. **USE TODOWRITE** - Track progress with todo lists, update frequently
3. **ONE TASK AT A TIME** - Only one todo should be in_progress
4. **UPDATE LOGS** - Always update implementation-log.md after completing work
5. **COMMIT REGULARLY** - Commit after completing each discrete task
6. **TEST BEFORE COMMIT** - Verify changes work before committing
7. **PUSH TO CORRECT BRANCH** - Always use `claude/config-management-system-hEF7I`
8. **CREATE PRS** - Open PR at end of session for human review

**NEVER:**
- Skip reading instruction files
- Forget to update implementation-log.md
- Commit without testing
- Push to wrong branch
- Leave todos in inconsistent state
- Implement features from future phases

---

## Quick Reference

**Key files to always check:**
- `plan.md` - Overall architecture
- `implementation-log.md` - Current status, next tasks
- `qa-review.md` - Quality standards, previous issues
- `persona-coding.md` - Coding agent guidelines (for coders)
- `persona-review.md` - Review agent guidelines (for reviewers)

**Before starting work:**
1. Read instruction files
2. Create todo list
3. Mark task in_progress

**After completing work:**
1. Update implementation-log.md
2. Update qa-review.md (if reviewer)
3. Commit changes
4. Push to branch
5. Create PR

**Common commands:**
```bash
# Run tests
shellcheck *.sh scripts/*.sh

# Check current phase
grep "Current phase" implementation-log.md

# See next task
grep "Next Steps for Coding Agent" implementation-log.md

# Push with retry
git push -u origin claude/config-management-system-hEF7I
```

---

## Resources

**Best practices researched:**
- [Claude Code Best Practices](https://www.anthropic.com/engineering/claude-code-best-practices)
- [Writing a Good CLAUDE.md](https://www.humanlayer.dev/blog/writing-a-good-claude-md)
- [Claude Skills](https://www.claude.com/skills)
- [Awesome Claude Skills](https://github.com/travisvn/awesome-claude-skills)

**Configuration management tools:**
- [chezmoi Documentation](https://www.chezmoi.io/)
- [DevContainer Features](https://containers.dev/features)
- [MCP Documentation](https://modelcontextprotocol.io/)

**Progressive disclosure docs:**
See `docs/` directory for detailed guides on specific topics
