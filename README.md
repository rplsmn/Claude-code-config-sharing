# Claude Code Configuration Sharing

Share Claude Code configurations (commands, skills, methodologies, personas) across machines and containers.

## What's Included

**6 Slash Commands** (`dot_claude/commands/`)
- `/code` - Coding agent workflow
- `/review` - Review/QA workflow
- `/lead` - Architecture/planning workflow
- `/research` - Investigation workflow
- `/product` - Product management workflow
- `/devops` - DevOps/SRE workflow

**6 Agent Personas** (Root directory: `persona-*.md`)
- Comprehensive workflow references for each agent type
- Detailed best practices, templates, examples
- 700-1100 lines each of actionable guidance

**2 Methodology Templates** (`dot_claude/methodologies/`)
- Migration methodology (rewriting existing systems)
- Greenfield methodology (new development)

**2 Claude Skills** (`dot_claude/skills/`)
- Test-Driven Development (TDD workflow)
- Imagen (image generation via Gemini API)

**Deployment Examples** (`examples/`)
- SessionStart hooks for automated deployment
- Shared config repo patterns

## Quick Start

### Web Users (iOS app / browser at claude.ai/code)

**Option 1: Project-level (simplest)**
```bash
# In your project repository
cp -r dot_claude/* .claude/
git add .claude/
git commit -m "Add Claude Code config"
```

**Option 2: Auto-deploy with SessionStart hook**
```bash
# In your project repository
cp examples/claude-settings-web.json .claude/settings.json
# Hook will auto-deploy commands/skills on session start
```

### CLI Users

```bash
# Deploy to global config (one-time per machine)
cp -r dot_claude/commands ~/.claude/
cp -r dot_claude/methodologies ~/.claude/
cp -r dot_claude/skills ~/.claude/

# Or deploy everything
cp -r dot_claude/* ~/.claude/
```

See [docs/QUICK_START.md](docs/QUICK_START.md) for detailed instructions.

## Repository Structure

```
dot_claude/              # Config files to deploy
├── commands/            # Slash commands (6)
├── methodologies/       # Workflow templates (2)
└── skills/              # Reusable skills (2)

persona-*.md             # Comprehensive agent references (6)
examples/                # Deployment patterns
docs/                    # Documentation
CLAUDE.md                # Project-specific instructions
```

## Documentation

- [QUICK_START.md](docs/QUICK_START.md) - Detailed deployment guide
- [REFERENCES.md](docs/REFERENCES.md) - External resources
- [plan.md](plan.md) - Project roadmap and future phases

## Project Goal

Make Claude Code configurations shareable and deployable across:
- Multiple machines (Linux, macOS)
- Claude Code Web (iOS app, browser)
- Dev containers (Podman, Docker)

Currently supports manual deployment. Future phases will add automation (install.sh, chezmoi, DevContainer Features).

See [plan.md](plan.md) for details.
