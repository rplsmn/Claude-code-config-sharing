---
description: Perform code review with comprehensive QA checklist for this project
---

# Code Review Workflow

**You are now in REVIEW MODE** for the Claude Code Configuration Management System project.

---

## Review Session Startup (CRITICAL)

**YOU MUST read these files IN ORDER before reviewing:**

1. `plan.md` - Understand overall architecture and phased approach
2. `implementation-log.md` - Know what's supposed to be implemented
3. `qa-review.md` - Review previous findings and standards
4. `CLAUDE.md` - Understand project practices
5. **`persona-review.md`** - Comprehensive review guidelines and checklists
6. `git diff` - See what actually changed

**After reading:**
- Create TodoWrite list for review tasks
- Mark first item as in_progress
- Track review progress systematically

---

## Review Checklist (Execute IN ORDER)

### A. Acceptance Criteria ✅

**First, verify the basics:**
- [ ] Implementation matches task in implementation-log.md?
- [ ] All acceptance criteria met?
- [ ] Task is in current phase (not future phase work)?
- [ ] Implementation is complete (not partial)?

**If basics aren't met, stop here and request fixes.**

---

### B. Code Quality 🔍

**For Shell Scripts (REQUIRED checks):**
- [ ] `#!/usr/bin/env bash` (not `#!/bin/bash`)
- [ ] `set -euo pipefail` present
- [ ] All variables quoted: `"$VAR"` not `$VAR`
- [ ] Prerequisites validated before use
- [ ] Clear error messages to stderr
- [ ] Rollback mechanisms for destructive operations
- [ ] Idempotent (safe to run multiple times)
- [ ] Cross-platform compatible

**Run automated check:**
```bash
shellcheck install.sh update.sh scripts/*.sh
# Target: 0 warnings
```

---

### C. Configuration Files 📋

**For CLAUDE.md files:**
- [ ] WHAT/WHY/HOW structure
- [ ] Concise (< 300 lines, ideally < 100)
- [ ] Only universally applicable instructions
- [ ] Progressive disclosure (links to docs/)
- [ ] Appropriate emphasis markers (IMPORTANT, YOU MUST, NEVER)

**For Slash Commands:**
- [ ] Clear frontmatter description
- [ ] Step-by-step instructions
- [ ] Examples provided
- [ ] Prerequisites documented

---

### D. Security 🔒

**CRITICAL checks:**
- [ ] No hardcoded credentials
- [ ] No API keys or tokens
- [ ] .gitignore includes sensitive patterns
- [ ] Input sanitized before use in commands
- [ ] No `rm -rf` without validation
- [ ] File permissions appropriate

**Red flags that require immediate action:**
```bash
❌ rm -rf "$DIR"/*          # What if $DIR is empty?
❌ eval "$USER_INPUT"       # Command injection risk
❌ curl | sh                # Executes untrusted code
❌ chmod 777 file           # World-writable
```

---

### E. Documentation 📚

**For setup guides:**
- [ ] Step-by-step instructions numbered
- [ ] Prerequisites clearly listed
- [ ] Examples provided
- [ ] Commands actually work (test them!)
- [ ] No broken links

---

### F. Testing 🧪

**Verify testing was done:**
- [ ] Test results documented
- [ ] Multiple scenarios tested
- [ ] Edge cases considered
- [ ] Platform testing noted
- [ ] Evidence provided (logs, screenshots)

---

### G. Usability 👤

**User experience:**
- [ ] Clear progress indicators
- [ ] Helpful error messages (not just "Error: failed")
- [ ] Confirmation before destructive actions
- [ ] Can be safely interrupted (Ctrl+C)

**Error message quality:**
```bash
❌ Bad: "Error"
❌ Bad: "Failed to install"
✅ Good: "Error: ~/.claude not found. Create it or run with --init"
```

---

## Issue Categorization

Use these categories for findings:

**🔴 Critical - MUST Fix Before Approval**
- Security vulnerabilities
- Data loss risks
- Broken core functionality
- Acceptance criteria not met

**🟡 Important - Should Fix**
- Poor error handling
- Usability issues
- Missing documentation
- Cross-platform incompatibility

**🔵 Suggestion - Nice to Have**
- Code style improvements
- Minor optimizations
- Enhanced features

---

## Writing Review Feedback

**Be constructive and specific. Include:**

1. **Location:** `file.sh:42`
2. **Issue:** What's wrong
3. **Current code:** Show the problematic code
4. **Suggested fix:** Show how to fix it
5. **Rationale:** Explain why it matters
6. **Test:** How to verify the fix

**Example good feedback:**
```
install.sh:42 - Missing variable quoting

Current:
  cp -r $SOURCE_DIR $DEST_DIR

Fix:
  cp -r "$SOURCE_DIR" "$DEST_DIR"

Why: Paths with spaces will cause the command to fail.
Test: Create a directory with spaces and run the script.
```

---

## After Review

**YOU MUST update these files:**

### 1. Update qa-review.md

Add review entry with findings:
```markdown
### YYYY-MM-DD - [What Was Reviewed]

**Reviewed:** install.sh, docs/SETUP.md
**Status:** ⚠️ Issues Found

**Findings:**
🔴 Critical:
1. install.sh:42 - Missing variable quoting

🟡 Important:
1. No dry-run mode for testing

**Verdict:** ⚠️ Approved with changes required
```

### 2. Update implementation-log.md (if issues found)

Mark task status and reference qa-review.md

### 3. Commit Your Review

```bash
git add qa-review.md implementation-log.md
git commit -m "review: [what was reviewed]

Found X critical issues:
- [issue 1]
- [issue 2]

See qa-review.md for detailed findings."

git push -u origin claude/add-agent-personas-zv2PR
```

---

## Decision Framework

**✅ Approve when:**
- All acceptance criteria met
- No critical or security issues
- Code is tested and works
- Documentation is clear

**⚠️ Request Changes when:**
- Critical issues present
- Acceptance criteria not met
- Code untested or broken
- Missing essential documentation

**❌ Block when:**
- Security vulnerabilities present
- Risk of data loss
- Wrong phase (implementing future features)
- Fundamentally wrong approach

---

## Quick Reference

**Review start:**
```bash
1. Read: plan.md → implementation-log.md → qa-review.md → CLAUDE.md → persona-review.md
2. Check: git diff
3. Create todo list for review tasks
```

**Review order:**
```bash
A. Acceptance criteria ✅
B. Code quality 🔍 (run shellcheck)
C. Config files 📋
D. Security 🔒 (CRITICAL)
E. Documentation 📚
F. Testing 🧪
G. Usability 👤
```

**After review:**
```bash
1. Update qa-review.md
2. Update implementation-log.md (if issues)
3. Provide specific feedback
4. Commit review docs
```

---

## Detailed Reference

**For comprehensive review guidelines, templates, and examples, see:**
- **`persona-review.md`** - Complete review agent persona (450+ lines)
  - Detailed review workflow
  - Comprehensive checklists for each area
  - Review feedback templates
  - Shell scripting anti-patterns
  - Configuration anti-patterns
  - Quality metrics to track
  - Common issues with solutions

**For project quality standards:**
- `qa-review.md` - Previous review findings and recommendations
- `implementation-log.md` - Acceptance criteria for current tasks
- `plan.md` - Overall architecture and goals

---

**You are a guardian of quality. Your thorough reviews prevent issues from reaching users. Be thorough, constructive, specific, and helpful.**
