# Claude Code Configurations Feature

Automatically deploy Claude Code configurations (slash commands, personas, methodologies, skills) to development containers.

## Usage

Add to your `.devcontainer/devcontainer.json`:

```json
{
  "name": "My Project",
  "image": "mcr.microsoft.com/devcontainers/base:ubuntu",
  "features": {
    "ghcr.io/rplsmn/Claude-code-config-sharing/claude-code-configs:1": {}
  }
}
```

## What Gets Installed

This feature deploys to `~/.claude/`:
- **6 Slash Commands**: `/code`, `/review`, `/lead`, `/research`, `/product`, `/devops`
- **6 Agent Personas**: Comprehensive workflow references
- **2 Methodologies**: Migration and Greenfield templates
- **2 Skills**: TDD workflow and Image generation
- **Global CLAUDE.md**: Universal workflow instructions

## Options

### `configBranch` (string)
Git branch to pull configurations from.

**Default:** `"main"`

```json
"features": {
  "ghcr.io/rplsmn/Claude-code-config-sharing/claude-code-configs:1": {
    "configBranch": "develop"
  }
}
```

### `deployToRoot` (boolean)
Deploy to `/root/.claude` instead of remote user's home directory.

**Default:** `false`

```json
"features": {
  "ghcr.io/rplsmn/Claude-code-config-sharing/claude-code-configs:1": {
    "deployToRoot": true
  }
}
```

## Example Configurations

### Minimal Setup
```json
{
  "name": "Quick Start",
  "image": "ubuntu",
  "features": {
    "ghcr.io/rplsmn/Claude-code-config-sharing/claude-code-configs:1": {}
  }
}
```

### With Custom Branch
```json
{
  "name": "Development Setup",
  "image": "ubuntu",
  "features": {
    "ghcr.io/rplsmn/Claude-code-config-sharing/claude-code-configs:1": {
      "configBranch": "experimental"
    }
  }
}
```

### Full Stack Example
```json
{
  "name": "Full Stack Dev",
  "image": "mcr.microsoft.com/devcontainers/base:ubuntu",
  "features": {
    "ghcr.io/devcontainers/features/node:1": {
      "version": "20"
    },
    "ghcr.io/devcontainers/features/python:1": {
      "version": "3.11"
    },
    "ghcr.io/rplsmn/Claude-code-config-sharing/claude-code-configs:1": {}
  }
}
```

## Compatibility

- ✅ Works with Docker and Podman
- ✅ Tested on Ubuntu, Debian, Alpine, Fedora
- ✅ Supports both root and non-root users
- ✅ Compatible with Claude Code CLI and Web

## Repository

Source: [https://github.com/rplsmn/Claude-code-config-sharing](https://github.com/rplsmn/Claude-code-config-sharing)

## License

Same as parent repository.
