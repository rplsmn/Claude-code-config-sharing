# Universal Workflow Instructions

**Philosophy:** Make things work. Commit working increments. No unfinished work.

---

## Core Workflow

1. **Make it work first**
   - Small, tested increments
   - Verify each change before proceeding
   - Working > perfect

2. **Commit each working increment**
   - One logical change per commit
   - Test before committing
   - Clear commit messages

3. **Branch workflow**
   - Create feature branch for each task
   - Work on branch, not main
   - Open PR to main when complete
   - Delete branch after merge

4. **No pending work**
   - Never commit unfinished features
   - No TODOs in production code
   - No "will fix later" comments
   - If broken, fix or revert

---

## Git Practices

```bash
# Start new work
git checkout -b feature/descriptive-name

# Commit working increment
git add -A
git commit -m "type: clear description"
git push -u origin feature/descriptive-name

# When complete, create PR
gh pr create --title "Clear title" --body "Summary and test plan"

# After merge
git checkout main
git pull
git branch -d feature/descriptive-name
```

**Commit types:** feat, fix, docs, refactor, test, chore

---

## Bash Script Standards

**Always use:**
```bash
#!/usr/bin/env bash
set -euo pipefail

# Quote all variables
DIR="${HOME}/.config"
if [ -d "$DIR" ]; then
    echo "Found: $DIR"
fi

# Check prerequisites
command -v git >/dev/null 2>&1 || {
    echo "Error: git required" >&2
    exit 1
}
```

**Run shellcheck before committing:**
```bash
shellcheck script.sh
```

---

## Implementation Log

Keep `implementation-log.md` in project root:

**Purpose:** Tell next agent what to do
**Optimized for:** LLM consumption, not humans
**Keep it:** Short (~100 lines max)

**Structure:**
```markdown
## Current Status
[What's done, what works]

## Next Step
[Specific next task for next agent]

## Context
[Any blockers or important decisions]
```

**Archive history to:** `docs/archive/SESSION_HISTORY.md`

---

## Documentation Philosophy

**Production docs:** Only what works NOW
**Planning docs:** Future work in plan.md only
**No:** "TODO", "Coming soon", "Will implement"
**Yes:** "Works", "Use this", "Here's how"

---

## Tools & Commands

**Essential checks before commit:**
```bash
# Shell scripts
shellcheck *.sh

# Git status
git status
git diff

# Test the change
[run relevant tests]
```

**Branch management:**
```bash
# Current branch
git branch --show-current

# Push to current branch
git push -u origin $(git branch --show-current)

# Status of all branches
git branch -a
```

---

## When Things Break

1. **Verify the problem**
   - Reproduce the issue
   - Understand root cause

2. **Fix or revert**
   - Fix: Small, tested change
   - Revert: `git revert <commit>` if fix unclear

3. **Test the fix**
   - Verify issue resolved
   - Check no new issues

4. **Commit**
   - Clear message explaining fix
   - Include what was broken + how fixed

---

## Quality Gates

**Before every commit:**
- [ ] Change works as intended
- [ ] Existing functionality still works
- [ ] No unfinished work included
- [ ] Clear commit message
- [ ] Appropriate files staged

**Before every PR:**
- [ ] All commits tested and working
- [ ] Branch up to date with main
- [ ] Clear PR description
- [ ] Test plan included

---

## Remember

- **Working code > perfect code**
- **One thing at a time**
- **Commit working increments**
- **Clean git history**
- **Documentation reflects reality**
