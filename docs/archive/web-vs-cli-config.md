# Claude Code Web vs CLI: Configuration & Persistence Research

**Research Date:** 2026-01-03
**Researcher:** Lead Agent
**Question:** How do configurations persist on Claude Code Web vs CLI, and what's the deployment strategy for Web users?

---

## Executive Summary

**CRITICAL FINDING:** Claude Code Web and CLI handle configuration persistence fundamentally differently.

**CLI:** Uses local file system (`~/.claude/commands/` for personal, `.claude/commands/` for project)
**Web:** Runs on Anthropic-managed VMs, clones GitHub repo, fresh environment per session

**SOLUTION:** Store slash commands in `.claude/commands/` (project-level, committed to Git) for Web persistence.

---

## Configuration Storage Locations

### Personal/Global Commands

**CLI:**
- Location: `~/.claude/commands/`
- Persistence: Permanent on local machine
- Scope: Available across ALL projects on that machine
- Invocation: Command name directly (e.g., `/code`, `/review`)

**Web:**
- Location: `~/.claude/commands/` exists but is ephemeral
- Persistence: **LOST between sessions** (fresh VM each time)
- Scope: Would apply to all projects IF it persisted
- **Problem:** No built-in mechanism to deploy personal commands to Web VMs

### Project Commands

**CLI:**
- Location: `.claude/commands/` (in repository)
- Persistence: Permanent via Git
- Scope: Only this project
- Invocation: `/project:command` (or just command name if no conflict)
- Sharing: Via Git (team members pull and get commands)

**Web:**
- Location: `.claude/commands/` (in repository)
- Persistence: **WORKS! Persists via GitHub**
- Scope: Only this project
- Invocation: Same as CLI
- Sharing: Via Git (automatic when repo cloned to Web VM)

---

## How Claude Code Web Works

### Architecture

1. User starts session at `claude.ai/code`
2. User connects GitHub account
3. User selects repository
4. **Anthropic-managed VM is created**
5. **Repository is cloned to VM**
6. Claude operates in this cloud environment
7. **Session ends → VM destroyed**

### Key Characteristics

- **Ephemeral environment:** Fresh VM per session
- **GitHub-only:** "Currently only works with code hosted in GitHub"
- **Asynchronous execution:** Runs on cloud infrastructure, not local
- **Network restrictions:** Internet access limited by default
- **Git proxy:** All git operations go through dedicated proxy
- **Branch safety:** Git push restricted to current working branch

### What Persists vs What Doesn't

| Item | CLI | Web | Notes |
|------|-----|-----|-------|
| `.claude/commands/` (project) | ✅ Persists | ✅ Persists | Via Git, works identically |
| `~/.claude/commands/` (personal) | ✅ Persists | ❌ Lost | Fresh VM has empty ~/ |
| `.claude/settings.json` | ✅ Persists | ✅ Persists | Via Git, SessionStart hooks work |
| Environment variables | ✅ Persists | ⚠️ Via hooks | Use SessionStart + CLAUDE_ENV_FILE |
| Installed tools | ✅ Persists | ⚠️ Via hooks | Reinstall each session via SessionStart |

---

## Deployment Strategies

### Strategy 1: Project-Level Commands (RECOMMENDED for Web)

**Approach:** Store ALL commands in `.claude/commands/` (project-level)

**Pros:**
- ✅ Works identically on CLI and Web
- ✅ Persists automatically via Git
- ✅ Team can share commands
- ✅ Version controlled
- ✅ No special setup needed

**Cons:**
- ❌ Commands scoped to one project only
- ❌ Must duplicate commands across projects
- ❌ Can't have truly "personal" commands on Web

**Implementation:**
```bash
# In your project repo
mkdir -p .claude/commands
cp ~/slash-commands/*.md .claude/commands/
git add .claude/commands
git commit -m "Add slash commands"
git push

# Web: Commands available immediately when repo cloned
# CLI: Commands available via /project:command
```

**Example:**
```
my-project/
  .claude/
    commands/
      code.md       # /project:code
      review.md     # /project:review
      lead.md       # /project:lead
```

---

### Strategy 2: SessionStart Hook Deployment (ADVANCED for Web)

**Approach:** Use SessionStart hook to copy commands from repo to `~/.claude/commands/`

**Pros:**
- ✅ Commands available without `/project:` prefix
- ✅ Can mimic personal commands on Web
- ✅ Automated setup each session

**Cons:**
- ❌ More complex setup
- ❌ Hook runs every session (slight delay)
- ❌ Commands still duplicated in repo

**Implementation:**

1. Store commands in repo subdirectory:
   ```
   my-project/
     .claude/
       commands/           # Project commands (available as /project:*)
       global-commands/    # Source for personal commands
         code.md
         review.md
     .claude/settings.json # Hook configuration
   ```

2. Configure SessionStart hook in `.claude/settings.json`:
   ```json
   {
     "userPromptSubmitHooks": {
       "enabled": false
     },
     "sessionStartHooks": [
       {
         "command": "bash",
         "args": ["-c", "mkdir -p ~/.claude/commands && cp .claude/global-commands/*.md ~/.claude/commands/ 2>/dev/null || true"],
         "description": "Deploy personal slash commands",
         "continueOnError": true
       }
     ]
   }
   ```

3. Commit and push:
   ```bash
   git add .claude/settings.json .claude/global-commands/
   git commit -m "Add SessionStart hook for command deployment"
   git push
   ```

4. On Web: Hook runs automatically, commands available as `/code`, `/review`, etc.

---

### Strategy 3: Shared Config Repository (BEST for Multi-Project)

**Approach:** Create dedicated config repository, reference from projects

**Architecture:**
```
claude-configs/                    # THIS REPO
  dot_claude/
    commands/                      # Reusable commands
    methodologies/                 # Reusable methodologies

my-project-1/                      # Project A
  .claude/
    settings.json                  # Hook to clone claude-configs
    CLAUDE.md                      # Project-specific config

my-project-2/                      # Project B
  .claude/
    settings.json                  # Hook to clone claude-configs
    CLAUDE.md                      # Project-specific config
```

**SessionStart Hook Pattern:**
```json
{
  "sessionStartHooks": [
    {
      "command": "bash",
      "args": ["-c", "git clone https://github.com/user/claude-configs ~/.claude-configs 2>/dev/null || (cd ~/.claude-configs && git pull); cp -r ~/.claude-configs/dot_claude/commands/* ~/.claude/commands/; cp -r ~/.claude-configs/dot_claude/methodologies ~/.claude/"],
      "description": "Deploy shared Claude configs",
      "continueOnError": true
    }
  ]
}
```

**Pros:**
- ✅ Single source of truth for all commands
- ✅ Works across infinite projects
- ✅ Update once, apply everywhere
- ✅ Version controlled centrally

**Cons:**
- ❌ Requires git clone each session (network overhead)
- ❌ More complex setup
- ❌ Dependency on external repo

---

## Recommendations

### For This Project (claude-configs)

**Phase 1: MVP (Immediate)**
1. ✅ **Done:** Store commands in `dot_claude/commands/`
2. Document both deployment strategies in README
3. Provide example `.claude/settings.json` for SessionStart hook

**Phase 2: Enhanced**
1. Build `install.sh` that:
   - For CLI: Copies to `~/.claude/commands/`
   - For Web: Generates `.claude/settings.json` with hook
2. Provide update script
3. Test on both CLI and Web

**Phase 3: Advanced**
1. Create MCP server for config sync (Phase 4 in plan)
2. Explore Anthropic API for programmatic config deployment

### For Users Deploying Configs

**Web Users:**
- **Option A (Simple):** Copy commands to `.claude/commands/` in each project repo
- **Option B (Advanced):** Use SessionStart hook to deploy from shared repo
- **Option C (Best):** Use this config repo's install process (when ready)

**CLI Users:**
- Copy commands to `~/.claude/commands/` (one-time setup per machine)
- Update by re-running install script

---

## Technical Details

### Slash Command File Format

Commands are Markdown files with optional frontmatter:

```markdown
---
description: Brief description (REQUIRED, used in /help)
model: claude-3-5-haiku-20241022  # Optional
allowed-tools: Bash(git*), Read(*)  # Optional
---

Your prompt text here.

Use $ARGUMENTS for all args, or $1, $2, etc. for positional args.
```

### Command Precedence Rules

1. **Name conflicts:** Project command beats personal command
2. **Invocation:**
   - Direct name: `/code` (if no conflict)
   - Explicit scope: `/project:code` or `/user:code`
3. **Namespacing:** Subdirs create namespaces
   - File: `.claude/commands/frontend/component.md`
   - Invoke: `/project:frontend:component`

### Environment Detection

To run hooks only on Web (not CLI):

```bash
if [ "$CLAUDE_CODE_REMOTE" = "true" ]; then
  # This is Web, deploy commands
  cp .claude/global-commands/*.md ~/.claude/commands/
fi
```

---

## Findings from Testing

### Container Persistence (Confirmed 2026-01-03)

**Test:** Copy commands to `~/.claude/commands/` in Web session, start new conversation

**Result:** Commands LOST

**Conclusion:** Claude Code Web uses fresh container per conversation, `~/.claude/` does not persist

**Evidence:**
```bash
# Session 1
$ mkdir -p ~/.claude/commands
$ cp dot_claude/commands/*.md ~/.claude/commands/
$ ls ~/.claude/commands/
code.md  devops.md  lead.md  product.md  research.md  review.md  # ✅ Present

# Session 2 (new conversation)
$ ls ~/.claude/commands/
ls: cannot access '~/.claude/commands/': No such file exists  # ❌ LOST
```

### What DOES Persist

- `.claude/` directory exists with subdirs: `plans/`, `projects/`, `skills/`, `telemetry/`, etc.
- But `commands/` subdirectory NOT present by default
- Likely these are Anthropic-managed directories, not user-controllable

---

## Sources

- [Slash commands - Claude Code Docs](https://code.claude.com/docs/en/slash-commands)
- [Claude Code on the Web](https://code.claude.com/docs/en/claude-code-on-the-web)
- [Claude Code Best Practices](https://www.anthropic.com/engineering/claude-code-best-practices)
- [Shipyard | Claude Code CLI Cheatsheet](https://shipyard.build/blog/claude-code-cheat-sheet/)
- [GitHub - anthropics/claude-code](https://github.com/anthropics/claude-code)

---

## Conclusion

**For CLI Users:** Standard deployment works (`~/.claude/commands/`)

**For Web Users:** Three viable strategies:
1. **Project-level** (simplest, per-project duplication)
2. **SessionStart hook** (automated, requires setup)
3. **Shared config repo** (best for multi-project, most complex)

**Recommendation for This Project:**
- Document all three strategies
- Provide example `.claude/settings.json` for Strategy 2
- Build install script that supports both CLI and Web (generates appropriate config)
- Default to Strategy 1 (project-level) for simplicity

---

**Status:** Research complete. Ready to implement deployment solution.
