# Deploying Claude Code Config to Web/iOS

**Target:** Claude Code Web (browser at claude.ai/code or iOS app)

## How Web Differs from CLI

**CLI:** Uses local `~/.claude/` directory, persists between sessions
**Web:** Runs on Anthropic VMs, clones GitHub repo, **fresh environment per session**

**Key Implication:** Personal configs in `~/.claude/` don't persist on Web

## Deployment Strategies

### Strategy 1: Project-Level Commands (Recommended)

**What:** Store commands in `.claude/commands/` within your project repository

**Steps:**
```bash
# In your project
cp -r dot_claude/commands .claude/
cp -r dot_claude/methodologies .claude/
cp -r dot_claude/skills .claude/
git add .claude/
git commit -m "Add Claude Code config"
git push
```

**Result:** Commands available every session (persisted via Git)

**Pros:** Simple, reliable, no automation needed
**Cons:** Config duplicated per project

---

### Strategy 2: SessionStart Hook (Auto-Deploy)

**What:** Use `.claude/settings.json` to auto-deploy configs on session start

**Steps:**
```bash
# Copy SessionStart hook template
cp examples/claude-settings-web.json your-project/.claude/settings.json

# Edit to point to your config location
# Hook runs on every session start, deploys to ~/.claude/
```

**Example hook:**
```json
{
  "hooks": {
    "sessionStart": {
      "command": "cp -r .claude/commands ~/.claude/ && cp -r .claude/methodologies ~/.claude/ && cp -r .claude/skills ~/.claude/"
    }
  }
}
```

**Pros:** Configs deployed automatically
**Cons:** Runs every session (slight startup delay)

---

### Strategy 3: Shared Config Repo

**What:** SessionStart hook clones shared config repo, deploys to `~/.claude/`

**Steps:**
```bash
# Copy shared repo template
cp examples/claude-settings-shared-repo.json your-project/.claude/settings.json

# Edit to point to your config repo
# Hook clones repo and deploys on session start
```

**Example hook:**
```json
{
  "hooks": {
    "sessionStart": {
      "command": "git clone https://github.com/you/claude-configs /tmp/configs && cp -r /tmp/configs/dot_claude/* ~/.claude/"
    }
  }
}
```

**Pros:** Single source of truth for all projects
**Cons:** Network dependency, slower startup

---

## What Persists on Web

| Item | CLI | Web | How to Persist |
|------|-----|-----|----------------|
| `.claude/commands/` (project) | ✅ | ✅ | Via Git (automatic) |
| `~/.claude/commands/` (personal) | ✅ | ❌ | Use SessionStart hook |
| `.claude/settings.json` | ✅ | ✅ | Via Git (automatic) |
| SessionStart hooks | ✅ | ✅ | Via Git (automatic) |
| Methodologies, skills | ✅ | ⚠️ | Deploy via hook or project-level |

## Recommendation

**For single project:** Use Strategy 1 (project-level)
**For multiple projects:** Use Strategy 3 (shared config repo with SessionStart hook)

## See Also

- [QUICK_START.md](QUICK_START.md) - Detailed deployment instructions
- `examples/claude-settings-web.json` - SessionStart hook template
- `examples/claude-settings-shared-repo.json` - Shared repo template
- [Research: Web vs CLI](research/compatibility/web-vs-cli-config.md) - Full research findings
