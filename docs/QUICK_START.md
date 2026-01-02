# Quick Start Guide

**Purpose:** Get slash commands working in < 5 minutes on any platform (CLI, Web, iOS)

**Last Updated:** 2026-01-02

---

## For Claude Code Web / iOS Users (Fastest)

**You're on Claude Code Web (iPhone) - this is the easiest method:**

### Step 1: Create .claude Directory

```bash
# In your project root (this repository)
mkdir -p .claude/commands
```

### Step 2: Copy Slash Commands

```bash
# Copy all slash commands to standard location
cp dot_claude/commands/*.md .claude/commands/
```

### Step 3: Commit and Push

```bash
git add .claude/
git commit -m "feat: activate slash commands"
git push -u origin claude/setup-team-structure-kR8VO
```

### Step 4: Open on Claude Code Web

1. Go to [claude.ai/code](https://claude.ai/code)
2. Open this project
3. **Slash commands work immediately!**

### Step 5: Test Commands

Try these in a new Claude Code session:

```
/code      # Activate coding workflow
/review    # Activate review workflow
/lead      # Activate lead/architect mode
/research  # Activate research mode
```

**Expected result:** Claude will load the corresponding workflow from `.claude/commands/`

---

## For Linux CLI Users

### Option A: Project Commands (Shared with Team)

Same as above - create `.claude/commands/` in your project.

### Option B: Personal Commands (Available Everywhere)

```bash
# Deploy to your personal commands directory
mkdir -p ~/.claude/commands

# Copy all slash commands
cp dot_claude/commands/*.md ~/.claude/commands/

# Commands now available in ALL your projects
```

**Difference:**
- `.claude/commands/` = Project-specific, checked into git, shared with team
- `~/.claude/commands/` = Personal, not in git, available across all projects

---

## Understanding the Directory Structure

### Current Structure (Source)

```
claude-configs/
├── dot_claude/              # Source location (chezmoi convention)
│   └── commands/
│       ├── code.md         # Coding workflow
│       ├── review.md       # Review workflow
│       ├── lead.md         # Lead/architect workflow
│       └── research.md     # Research workflow
└── persona-*.md            # Detailed persona documentation
```

### Deployed Structure (Target)

**For project commands:**
```
your-project/
└── .claude/                # Standard location
    └── commands/
        ├── code.md
        ├── review.md
        ├── lead.md
        └── research.md
```

**For personal commands:**
```
~/.claude/                  # User home directory
└── commands/
    ├── code.md
    ├── review.md
    ├── lead.md
    └── research.md
```

**Why `dot_claude/` in repo?**
- chezmoi convention: `dot_` → `.` when deployed
- Allows versioning of dotfiles in git
- Phase 2 will use chezmoi for automated deployment

---

## Verifying Commands Work

### Test 1: List Available Commands

In Claude Code, type:
```
/
```

You should see your custom commands listed:
- `/code` - Activate coding workflow
- `/lead` - Activate lead/architect workflow
- `/research` - Activate research workflow
- `/review` - Activate review workflow

### Test 2: Activate a Command

Try:
```
/lead
```

**Expected response:**
```
<command-message>lead is running...</command-message>

[Claude loads instructions from .claude/commands/lead.md]

I'm now in lead/architect mode. I'll read the project context...
[Starts lead workflow from persona-lead.md]
```

### Test 3: Check File References

Commands reference persona files. Verify Claude can read them:

```
After using /code command, ask:
"Can you see persona-coding.md?"

Expected: "Yes, I can read persona-coding.md with detailed coding guidelines"
```

---

## Troubleshooting

### Problem: "Command not found"

**Cause:** Commands not in correct location

**Fix:**
```bash
# Check if .claude/commands/ exists
ls -la .claude/commands/

# Should show: code.md, review.md, lead.md, research.md
# If not found, repeat Step 2 above
```

### Problem: "Command does nothing"

**Cause:** Malformed command file

**Fix:**
```bash
# Verify file format
cat .claude/commands/code.md | head -20

# Should start with:
# ---
# description: Activate coding workflow
# ---
```

### Problem: "Can't find persona files"

**Cause:** Persona files not in project root

**Fix:**
```bash
# Verify persona files exist
ls -la persona-*.md

# Should show:
# persona-coding.md
# persona-review.md
# persona-lead.md
# persona-researcher.md
```

### Problem: "Commands work on CLI but not Web"

**Cause:** Different working directories

**Fix:**
- On Web: Ensure `.claude/commands/` checked into git
- Push changes: `git push`
- Refresh Claude Code Web session
- Re-open project

---

## What Each Command Does

### `/code` - Coding Agent

**Purpose:** Activate implementation workflow

**What it does:**
1. Loads persona-coding.md reference
2. Reminds you to read: plan.md, implementation-log.md, qa-review.md, CLAUDE.md
3. Activates coding best practices (shell scripting, testing, git workflow)
4. Creates TodoWrite list for tracking work

**Use when:** Implementing features, fixing bugs, writing scripts

---

### `/review` - Review Agent

**Purpose:** Activate QA review workflow

**What it does:**
1. Loads persona-review.md reference
2. Provides 7-step review checklist
3. Activates quality standards (shell scripts, configs, security, docs, testing)
4. Documents findings in qa-review.md

**Use when:** Reviewing code, validating quality, checking acceptance criteria

---

### `/lead` - Lead/Architect Agent

**Purpose:** Activate architectural decision-making workflow

**What it does:**
1. Loads persona-lead.md reference
2. Provides architectural decision process (7 steps)
3. Activates design thinking (alternatives, trade-offs, documentation)
4. Creates implementation plans

**Use when:** Making architectural decisions, planning features, designing systems

---

### `/research` - Research Agent

**Purpose:** Activate research workflow

**What it does:**
1. Loads persona-researcher.md reference
2. Provides research process (understand → gather → analyze → document → report)
3. Activates research best practices (sources, decision matrices, trade-off analysis)
4. Saves findings to docs/research/

**Use when:** Investigating solutions, comparing frameworks, debugging, finding best practices

---

## Next Steps After Quick Start

### 1. Read the Persona Files (Important!)

The slash commands are **shortcuts** that reference detailed persona files:

```bash
# Read these to understand each role deeply:
cat persona-coding.md    # 400+ lines of coding guidance
cat persona-review.md    # 954 lines of review framework
cat persona-lead.md      # 500+ lines of architectural process
cat persona-researcher.md # 500+ lines of research methodology
```

**Progressive disclosure:**
- Slash command = Summary (what to do)
- Persona file = Details (how to do it well)

### 2. Test the Workflow

Try a complete workflow:

```bash
# 1. Plan (as lead)
/lead
"Analyze what's needed to complete Phase 1 Task 1.2"

# 2. Research (as researcher)
/research
"Research Claude Code configuration file locations"

# 3. Implement (as coding agent)
/code
"Implement install.sh based on research findings"

# 4. Review (as review agent)
/review
"Review install.sh for quality and security"
```

### 3. Customize Commands (Optional)

**Add your own commands:**

```bash
# Create new command
cat > .claude/commands/deploy.md <<'EOF'
---
description: Deploy to production with checks
---

# Deployment Workflow

Before deploying:
1. Run all tests
2. Check git status (no uncommitted changes)
3. Verify version number updated
4. Run build
5. Deploy with rollback plan
EOF

# Now use: /deploy
```

### 4. Read Project Documentation

**Required reading for all agents:**
1. `plan.md` - Overall architecture and approach
2. `implementation-log.md` - Current status and next tasks
3. `qa-review.md` - Quality standards and findings
4. `CLAUDE.md` - Project-specific practices

**Optional deep-dives:**
- `docs/TEAM_STRUCTURE.md` - Team personas and interactions
- `docs/research/` - Research findings
- `README.md` - Project overview

---

## Platform-Specific Notes

### Claude Code Web (iOS)

**Advantages:**
- ✅ No installation required
- ✅ Access from anywhere
- ✅ Same slash commands as CLI
- ✅ File upload via drag-drop or git

**Limitations:**
- ⚠️ Personal commands (`~/.claude/commands/`) may not persist across sessions
- ⚠️ Terminal access limited (sandbox mode)
- ⚠️ Local filesystem access different from CLI

**Workaround:** Use project commands (`.claude/commands/`) checked into git

### Claude Code CLI (Linux)

**Advantages:**
- ✅ Full terminal access
- ✅ Personal commands persist
- ✅ Local filesystem access
- ✅ Integration with local tools

**Limitations:**
- ⚠️ Requires installation
- ⚠️ One machine at a time

**Recommendation:** Use install script (Phase 1 task 1.4) to deploy to all machines

---

## FAQ

### Q: Should I use project or personal commands?

**Use project commands (`.claude/commands/`) when:**
- Commands are project-specific
- You want to share with team (checked into git)
- You're on Claude Code Web (iOS)

**Use personal commands (`~/.claude/commands/`) when:**
- Commands apply to all your projects
- You don't want to commit to git
- You're on CLI and want consistency across projects

### Q: Can I modify the commands?

**Yes!** Commands are just markdown files:

```bash
# Edit a command
vim .claude/commands/code.md

# Test immediately
/code
```

### Q: Do I need all 4 commands?

**No.** Start with what you need:
- Solo developer: `/code` and `/review` sufficient
- Team lead: All 4 commands useful
- Researcher: `/research` and `/lead` most relevant

### Q: What if I'm not using git?

You can still use commands:
```bash
# Create .claude/commands/ without git
mkdir -p .claude/commands
cp dot_claude/commands/*.md .claude/commands/

# Use immediately (no commit needed)
```

### Q: How do commands compare to personas?

**Slash commands:**
- Quick activation
- Summary of workflow
- Points to persona files

**Persona files:**
- Comprehensive reference
- Detailed examples and anti-patterns
- 400-900 lines of guidance

**Use both:** Command for quick start, persona for deep reference

---

## Getting Help

**If commands don't work:**
1. Check troubleshooting section above
2. Verify file locations: `ls -la .claude/commands/`
3. Check file format: `cat .claude/commands/code.md | head`
4. Review research: `docs/research/compatibility/claude-code-web-config.md`

**For questions about workflow:**
- Read relevant persona file (persona-coding.md, etc.)
- Check project docs (plan.md, implementation-log.md)
- Ask in Claude Code session with context

**For project-specific help:**
- See CLAUDE.md for project practices
- See implementation-log.md for current status
- See qa-review.md for quality standards

---

**Last updated:** 2026-01-02
**Maintained by:** Lead agent
**Status:** ✅ Ready to use
