# Research: Claude Code Web Configuration Capabilities

**Requested by:** QA Review finding (Task 1.2.1)
**Date:** 2026-01-02
**Context:** User is on Claude Code Web (iOS app) and needs to know how to use custom slash commands
**Decision needed:** Can slash commands be deployed to Claude Code Web, and if so, how?

---

## Executive Summary

**Answer:** ✅ **YES - Claude Code Web and iOS support custom slash commands using the SAME configuration structure as CLI**

**Key Findings:**
- Custom slash commands work identically on Web, iOS, and CLI
- Configuration uses `.claude/commands/` (project) and `~/.claude/commands/` (personal)
- No install script needed for web - upload `.claude/commands/` files directly to projects
- Web version supports CLAUDE.md, hooks, and all core features
- Available to Pro ($20/month) and Max ($100-200/month) subscribers at claude.ai/code

**Confidence:** High
**Rationale:** Official documentation and multiple authoritative sources confirm feature parity

---

## Detailed Findings

### Finding 1: Claude Code Web Availability

**What it is:**
- Web version of Claude Code available at claude.ai/code
- Also accessible via Claude iOS app (Code tab)
- Rolled out to Pro and Max subscribers in late 2025

**Sources:**
- [Claude Code on the web - Official Docs](https://code.claude.com/docs/en/claude-code-on-the-web)
- [Anthropic brings Claude Code to the web | TechCrunch](https://techcrunch.com/2025/10/20/anthropic-brings-claude-code-to-the-web/)
- [Claude Code on the web | Claude Blog](https://claude.com/blog/claude-code-on-the-web)

---

### Finding 2: Custom Slash Commands on Web

**How they work:**

**Project Commands:**
- Location: `.claude/commands/*.md`
- Scope: Available in specific project
- Sharing: Checked into git, shared with team
- Format: Markdown files with optional frontmatter

**Personal Commands:**
- Location: `~/.claude/commands/*.md`
- Scope: Available across all projects
- Sharing: Personal, not checked into git
- Format: Same markdown structure

**On Web/iOS:**
- Upload `.claude/commands/` directory to project (via file upload or git)
- Commands automatically recognized
- Same syntax as CLI: `/<command-name> [arguments]`
- Supports namespacing via subdirectories

**Sources:**
- [Slash Commands - Official Docs](https://code.claude.com/docs/en/slash-commands)
- [Claude Code Slash Commands Cheat Sheet](https://www.devsheets.io/sheets/claude-code-slash-commands)

---

### Finding 3: Configuration Structure

**Hierarchical Settings:**

1. **User settings:** `~/.claude/settings.json` (applies to all projects)
2. **Project settings:** `.claude/settings.json` (shared with team, in git)
3. **Local project settings:** `.claude/settings.local.json` (personal, gitignored)

**On Web/iOS:**
- Settings can be uploaded as files
- CLAUDE.md files work identically
- Hooks system available (`.claude/hooks/`)
- SessionStart hooks for environment setup

**Key Insight:**
The web version uses the SAME file structure, just accessed through web interface instead of filesystem.

**Sources:**
- [Slash Commands Documentation](https://code.claude.com/docs/en/slash-commands)
- [How I use Claude Code (+ tips)](https://www.builder.io/blog/claude-code)

---

### Finding 4: Web vs CLI Differences

**Feature Parity:**
- ✅ Custom slash commands (same)
- ✅ CLAUDE.md configuration (same)
- ✅ Hooks system (same)
- ✅ File uploads and references (same)
- ✅ Command namespacing (same)
- ✅ Argument support (same)

**Potential Limitations:**
- ⚠️ Terminal-specific features may differ (sandbox tools)
- ⚠️ Local filesystem access patterns different
- ⚠️ Some integrations may be CLI-only (VS Code, JetBrains)

**Not explicitly documented:**
- How `~/.claude/commands/` (personal commands) work on web
- Whether global personal commands sync across web sessions

**Sources:**
- [Claude Code on the Web Guide](https://www.cursor-ide.com/blog/claude-code-on-the-web)
- [Slash Commands Official Docs](https://code.claude.com/docs/en/slash-commands)

---

### Finding 5: Deployment Workflow for Web/iOS

**Recommended Approach:**

**Option A: Git-based (Best for teams)**
1. Create `.claude/commands/` in repository
2. Add slash command files (e.g., `code.md`, `review.md`)
3. Commit and push to git
4. Open project on claude.ai/code
5. Commands automatically available

**Option B: Direct upload (Personal projects)**
1. Navigate to claude.ai/code
2. Upload `.claude/commands/` directory
3. Commands immediately available in that session

**Option C: Project templates**
1. Create template repo with `.claude/` structure
2. Fork/clone for new projects
3. Commands included automatically

**For this project:**
- Commands already exist in repository: `dot_claude/commands/*.md`
- Need to either:
  - Move to `.claude/commands/` (standard location), OR
  - Document that `dot_claude/` is the source, deploy to `.claude/` in projects

**Sources:**
- [Slash Commands Documentation](https://code.claude.com/docs/en/slash-commands)
- [Complete Guide for Developers](https://www.igmguru.com/blog/claude-code)

---

## Comparison: Web vs CLI

| Feature | CLI | Web/iOS | Notes |
|---------|-----|---------|-------|
| Custom slash commands | ✅ | ✅ | Identical syntax and structure |
| `.claude/commands/` | ✅ | ✅ | Same directory structure |
| `~/.claude/commands/` | ✅ | ⚠️ | Unclear how personal commands work on web |
| CLAUDE.md | ✅ | ✅ | Same format and function |
| Hooks | ✅ | ✅ | SessionStart and other hooks supported |
| File uploads | ✅ | ✅ | Web supports drag-drop and git |
| MCP servers | ✅ | ✅ | Model Context Protocol supported |
| Terminal access | ✅ | ⚠️ | Limited on web (sandbox) |
| Local filesystem | ✅ | ❌ | Web uses cloud storage/git |
| Cost | Free (API) | $20-200/mo | Pro/Max subscription required |

---

## Recommendation

**For this project's needs:**

### Immediate Solution (Current State)

**Commands are deployable to Web/iOS RIGHT NOW:**

1. **For local Linux machines:**
   ```bash
   mkdir -p ~/.claude/commands
   cp dot_claude/commands/*.md ~/.claude/commands/
   ```

2. **For Claude Code Web (iOS):**
   - Open project at claude.ai/code
   - Upload `.claude/` directory with commands
   - OR: Structure repository with `.claude/commands/` at root
   - Commands work immediately

3. **For future projects:**
   - Use standard `.claude/commands/` location in repos
   - Commands work across CLI, Web, iOS automatically

### Long-term Recommendation

**Restructure repository:**
```
claude-configs/
├── .claude/                  # Standard location (not dot_claude)
│   ├── commands/
│   │   ├── code.md
│   │   ├── review.md
│   │   ├── lead.md
│   │   └── research.md
│   ├── CLAUDE.md            # Project config
│   └── hooks/               # Future hooks
└── install.sh               # Deploys .claude/ to projects
```

**Why:**
- `.claude/` is the standard location (not `dot_claude/`)
- Works on CLI, Web, iOS without modification
- No confusion about deployment location
- Follows official documentation conventions

---

## Implementation Notes

### Next Steps

1. **Immediate (for user):**
   - Test slash commands on claude.ai/code by uploading current `dot_claude/commands/`
   - Verify commands work as expected
   - Document any web-specific issues found

2. **Short-term (Phase 1):**
   - Consider renaming `dot_claude/` to `.claude/` for standard compliance
   - Update install.sh to deploy to `.claude/` not `~/.claude/`
   - Document web deployment in README.md

3. **Medium-term (Phase 2):**
   - Test personal commands (`~/.claude/commands/`) on web if needed
   - Document workarounds for web limitations if any found
   - Create web-specific setup guide

### Testing Checklist

- [ ] Upload `.claude/commands/` to claude.ai/code project
- [ ] Test each slash command (/code, /review, /lead, /research)
- [ ] Verify file references work (@filename)
- [ ] Test CLAUDE.md recognition
- [ ] Document any differences from CLI behavior
- [ ] Create CLAUDE_WEB_SETUP.md guide

---

## Open Questions

**Questions needing further research:**

1. **Personal commands on web:** How does `~/.claude/commands/` work for web users?
   - Hypothesis: May need to upload to each project, or doesn't exist on web
   - Test: Create personal command, check availability across web projects

2. **Command syncing:** Do commands sync across devices for same user?
   - Hypothesis: Project commands (git) yes, personal commands unclear
   - Test: Add command on iOS, check on web

3. **Hook limitations:** Are there hooks that don't work on web?
   - Hypothesis: Terminal-specific hooks may not function
   - Test: Try SessionStart hook with bash commands

4. **Performance:** Any latency differences between CLI and web?
   - Hypothesis: Web may have slight delay for file operations
   - Test: Time command execution on both platforms

---

## References

All sources cited:

### Official Documentation
1. [Slash Commands - Claude Code Docs](https://code.claude.com/docs/en/slash-commands) - How slash commands work
2. [Claude Code on the web - Official Docs](https://code.claude.com/docs/en/claude-code-on-the-web) - Web version capabilities
3. [Claude Code on the web | Claude Blog](https://claude.com/blog/claude-code-on-the-web) - Official announcement

### Technical Guides
4. [How I use Claude Code (+ tips)](https://www.builder.io/blog/claude-code) - Practical usage guide
5. [Shipyard | Claude Code CLI Cheatsheet](https://shipyard.build/blog/claude-code-cheat-sheet/) - Configuration reference
6. [Claude Code Slash Commands Cheat Sheet](https://www.devsheets.io/sheets/claude-code-slash-commands) - Quick reference

### Community Resources
7. [GitHub - wshobson/commands](https://github.com/wshobson/commands) - Production-ready slash commands
8. [GitHub - hesreallyhim/awesome-claude-code](https://github.com/hesreallyhim/awesome-claude-code) - Curated list
9. [GitHub - qdhenry/Claude-Command-Suite](https://github.com/qdhenry/Claude-Command-Suite) - Professional commands

### News and Analysis
10. [Anthropic brings Claude Code to the web | TechCrunch](https://techcrunch.com/2025/10/20/anthropic-brings-claude-code-to-the-web/) - Launch coverage
11. [Claude Code on the Web Complete Guide](https://www.cursor-ide.com/blog/claude-code-on-the-web) - Comprehensive guide
12. [The Definitive Guide to Using Claude Code on Your Phone](https://sealos.io/blog/claude-code-on-phone) - Mobile usage

---

## Appendix: Command File Format

**Minimal slash command example:**
```markdown
---
description: Brief description shown in command list
---

# Command Name

Instructions for Claude in natural language.

You can use $ARGUMENTS for user input.
```

**Advanced example with all features:**
```markdown
---
description: Code review with security focus
allowed-tools: ["Read", "Grep", "WebSearch"]
model: sonnet
argument-hint: "[file-pattern]"
---

# Security-Focused Code Review

Review the codebase for:
1. Security vulnerabilities
2. Code quality issues
3. Best practice violations

Focus on: $ARGUMENTS

Use Read tool to examine files.
Cite specific line numbers in findings.
```

---

**Research completed:** 2026-01-02
**Researcher:** Researcher agent
**Status:** Complete
**Next action:** Update REFERENCES.md with new sources, report to QA review
