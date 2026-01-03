# DevContainer Feature Notes

## Testing Locally (Before Publishing)

### Option 1: Test with Local Path
Create a test project with `.devcontainer/devcontainer.json`:

```json
{
  "name": "Test Feature",
  "image": "ubuntu",
  "features": {
    "/workspace/src/claude-code-configs": {}
  }
}
```

### Option 2: Test with devcontainer CLI
```bash
# Install devcontainer CLI
npm install -g @devcontainers/cli

# Test the feature
devcontainer features test \
  --features claude-code-configs \
  --base-image ubuntu:latest \
  src/claude-code-configs
```

## Publishing to GitHub Container Registry

### Prerequisites
1. Repository must be public or have proper GHCR permissions
2. GitHub Actions workflow for building and publishing
3. Semantic versioning tags (v1.0.0, v1.1.0, etc.)

### Auto-Publishing Workflow

Create `.github/workflows/release.yml`:

```yaml
name: Release Features
on:
  push:
    tags:
      - 'v*'

jobs:
  release:
    runs-on: ubuntu-latest
    permissions:
      contents: read
      packages: write
    steps:
      - uses: actions/checkout@v4
      - name: Publish Features
        uses: devcontainers/action@v1
        with:
          publish-features: "true"
          base-path-to-features: "./src"
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```

### Manual Release Process

1. Tag a release:
```bash
git tag v1.0.0
git push origin v1.0.0
```

2. GitHub Actions automatically publishes to:
```
ghcr.io/rplsmn/Claude-code-config-sharing/claude-code-configs:1
ghcr.io/rplsmn/Claude-code-config-sharing/claude-code-configs:1.0
ghcr.io/rplsmn/Claude-code-config-sharing/claude-code-configs:1.0.0
```

## Usage After Publishing

Users add to their `.devcontainer/devcontainer.json`:

```json
{
  "features": {
    "ghcr.io/rplsmn/Claude-code-config-sharing/claude-code-configs:1": {}
  }
}
```

## Directory Structure

```
src/
└── claude-code-configs/           # Feature name (must match "id" in json)
    ├── devcontainer-feature.json  # Metadata
    ├── install.sh                 # Install script
    ├── README.md                  # User documentation
    └── NOTES.md                   # This file (dev notes)
```

## Platform Compatibility

Tested on:
- ✅ Ubuntu (apt)
- ✅ Debian (apt)
- ⏳ Alpine (apk) - TODO
- ⏳ Fedora (dnf) - TODO

## Known Issues

None currently.

## Future Enhancements

1. Add option to customize install location
2. Support for specifying specific config version/tag
3. Validation of installed configs
4. Integration tests
