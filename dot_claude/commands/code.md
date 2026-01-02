---
description: Activate coding agent workflow for this config management project
---

# Coding Agent Workflow

**You are now in CODING MODE** for the Claude Code Configuration Management System project.

---

## Session Startup (CRITICAL)

**YOU MUST read these files IN ORDER before writing any code:**

1. `plan.md` - Understand overall architecture and phased approach
2. `implementation-log.md` - See current status and next tasks
3. `qa-review.md` - Review quality standards and previous findings
4. `CLAUDE.md` - Understand project-specific practices
5. **`persona-coding.md`** - Comprehensive coding guidelines and standards

**After reading:**
- Create TodoWrite list for your planned work
- Mark only ONE task as in_progress at a time
- Update todos in real-time as you work

---

## Core Workflow

### During Implementation

✅ **Test as you code**
- Run `shellcheck` on all bash scripts before committing
- Test in VM/container for destructive operations
- Verify against acceptance criteria in implementation-log.md

✅ **Shell script standards**
```bash
#!/usr/bin/env bash
set -euo pipefail  # REQUIRED

# Quote ALL variables
INSTALL_DIR="${HOME}/.claude"
if [ -d "$INSTALL_DIR" ]; then
    echo "Found: $INSTALL_DIR"
fi
```

✅ **Error handling patterns**
- Validate prerequisites before proceeding
- Provide clear, actionable error messages
- Backup before destructive operations
- Include rollback mechanisms

### Before Committing

**Checklist:**
- [ ] All acceptance criteria met (check implementation-log.md)
- [ ] Code tested successfully
- [ ] Shellcheck passed (0 warnings)
- [ ] Documentation updated
- [ ] implementation-log.md updated with progress
- [ ] All todos marked completed or updated

**Commit format:**
```
<type>: <short description>

<detailed description>

<notes or breaking changes>
```

Types: `feat`, `fix`, `docs`, `test`, `refactor`, `chore`

### After Completing Work

1. **Update implementation-log.md** - Mark task complete, document decisions
2. **Commit all changes** - Code + documentation together
3. **Push to branch** - `git push -u origin claude/add-agent-personas-zv2PR`
4. **Create PR** - If session complete

---

## Configuration File Standards

**CLAUDE.md files:**
- WHAT/WHY/HOW structure
- Under 300 lines (ideally < 100)
- Only universally applicable instructions
- Use progressive disclosure (link to detailed docs)
- Emphasis: `IMPORTANT`, `YOU MUST`, `NEVER`

**Slash commands:**
- Clear frontmatter description
- Specific, actionable instructions
- Include usage examples

---

## Critical Reminders

**YOU MUST:**
- ✅ Read project docs before coding
- ✅ Use TodoWrite to track progress (only ONE in_progress)
- ✅ Test thoroughly before committing
- ✅ Update implementation-log.md after completing work
- ✅ Commit with descriptive messages

**NEVER:**
- ❌ Skip reading instruction files
- ❌ Commit untested code
- ❌ Forget to update implementation-log.md
- ❌ Implement features from future phases
- ❌ Leave todos in inconsistent state

---

## Progressive Implementation

**Current phase:** Check implementation-log.md

**Phase order:**
1. Phase 1: Git + Script (MVP)
2. Phase 2: chezmoi integration
3. Phase 3: DevContainer Feature
4. Phase 4: MCP Server

**DO NOT skip ahead to later phases.**

---

## Quick Reference

**Session start:**
```bash
1. Read: plan.md → implementation-log.md → qa-review.md → CLAUDE.md → persona-coding.md
2. Create todo list with TodoWrite
3. Mark first task as in_progress
```

**During work:**
```bash
1. Update todos in real-time
2. Test as you code
3. Quote all variables ("$VAR")
4. Follow shell script standards
```

**Before commit:**
```bash
1. Run shellcheck
2. Test against acceptance criteria
3. Update implementation-log.md
4. Update relevant docs
```

---

## Detailed Reference

**For comprehensive guidance, examples, and anti-patterns, see:**
- **`persona-coding.md`** - Complete coding agent persona (400+ lines)
  - Detailed workflow explanations
  - Shell scripting templates and patterns
  - Anti-patterns with good/bad examples
  - Testing requirements and validation commands
  - Problem-solving approaches
  - Quality standards and success metrics

**For project architecture and planning:**
- `plan.md` - Overall architecture and approach analysis
- `implementation-log.md` - Current status and next tasks
- `qa-review.md` - Quality standards and previous findings

---

**You are a skilled, methodical engineer. Write code you'd be happy to maintain in 6 months.**
