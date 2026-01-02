# Claude Code Configuration Management System

## What (Tech Stack & Structure)

**Project Type:** Configuration management system for Claude Code
**Primary Language:** Bash (scripts), Markdown (configs/docs)
**Target Platforms:** Linux (Ubuntu, Fedora, Arch), iPhone (Claude Code web)
**Package Manager:** chezmoi (Phase 2), Git (Phase 1)

**Repository Structure:**
```
claude-configs/
├── plan.md                    # Overall project plan and approach analysis
├── implementation-log.md      # Living log of what's implemented (READ THIS FIRST)
├── qa-review.md              # QA review findings and recommendations
├── CLAUDE.md                 # This file
├── persona-coding.md         # Coding agent reference (comprehensive)
├── persona-review.md         # Review agent reference (comprehensive)
├── persona-lead.md           # Lead/architect reference (comprehensive)
├── install.sh                # Installation script (Phase 1)
├── update.sh                 # Update script (Phase 1)
├── dot_claude/               # Config files to deploy
│   ├── CLAUDE.md            # Global Claude configuration
│   ├── commands/            # Slash commands
│   │   ├── code.md         # /code - Activate coding workflow
│   │   ├── review.md       # /review - Activate review workflow
│   │   └── lead.md         # /lead - Activate architect/planning mode
│   ├── personas/            # Claude personas (future)
│   └── skills/              # Claude Skills (future)
└── docs/                    # Documentation (future)
```

---

## Why (Project Purpose)

This project solves the problem of managing Claude Code configurations across multiple devices (4 Linux machines + iPhone). The goal is to:
1. Configure Claude Code once, deploy everywhere
2. Share configuration updates easily
3. Version control all configs
4. Support dev containers (Podman)
5. Minimize setup time (< 2 minutes per machine)

---

## How (Development Workflow)

### CRITICAL: Read Before Acting

**YOU MUST read these files in order BEFORE starting any work:**
1. `plan.md` - Understand overall architecture and phased approach
2. `implementation-log.md` - See current status and next tasks
3. `qa-review.md` - Review quality standards and previous findings
4. This file (CLAUDE.md) - Understand project-specific practices

**Then activate your role:**
- **Coding agents:** Use `/code` command (references `persona-coding.md` for comprehensive details)
- **Review agents:** Use `/review` command (references `persona-review.md` for comprehensive details)
- **Lead/Architect agents:** Use `/lead` command (references `persona-lead.md` for comprehensive details)

### Workflow for Coding Agent

**IMPORTANT: Use the `/code` slash command to activate coding workflow.**

The `/code` command (in `dot_claude/commands/code.md`) provides:
- Session startup checklist (what to read first)
- Core workflow and standards
- Shell scripting patterns
- Testing requirements
- Commit and push guidelines

**For comprehensive details, see `persona-coding.md`** (400+ lines covering):
- Detailed workflow explanations
- Shell scripting templates and patterns
- Anti-patterns with good/bad examples
- Testing requirements and validation commands
- Problem-solving approaches
- Quality standards and success metrics

**Quick workflow summary:**
1. Read: plan.md → implementation-log.md → qa-review.md → CLAUDE.md → persona-coding.md
2. Create TodoWrite list, mark ONE task in_progress
3. Test thoroughly before committing
4. Update implementation-log.md when complete
5. Commit and push to branch
6. Create PR for human review

**Key practices:**
- ALWAYS use TodoWrite to track progress
- Mark only ONE task as in_progress at a time
- Complete tasks fully before starting new ones
- Update implementation-log.md after completing each major task
- Test your changes before committing
- Run shellcheck on bash scripts
- Quote all variables in shell scripts

---

### Workflow for Reviewer Agent

**IMPORTANT: Use the `/review` slash command to activate review workflow.**

The `/review` command (in `dot_claude/commands/review.md`) provides:
- Session startup checklist (what to read first)
- 7-step review checklist (acceptance criteria → code → config → security → docs → testing → usability)
- Issue categorization (Critical/Important/Suggestion)
- Feedback writing guidelines
- After-review checklist

**For comprehensive details, see `persona-review.md`** (450+ lines covering):
- Detailed review workflow and checklists
- Review feedback templates
- Shell scripting anti-patterns to watch for
- Configuration and documentation anti-patterns
- Decision framework (when to approve/request changes/block)
- Quality metrics to track
- Common issues with solutions

**Quick workflow summary:**
1. Read: plan.md → implementation-log.md → qa-review.md → CLAUDE.md → persona-review.md
2. Check git diff to see what changed
3. Create TodoWrite list for review tasks
4. Execute review checklist in order
5. Document findings in qa-review.md
6. Update implementation-log.md if issues found
7. Commit review documentation
8. Provide specific, constructive feedback

**Review focus areas:**
- Acceptance criteria met
- Shell script quality (shellcheck, quoting, error handling)
- Config file best practices
- Security (no secrets, safe operations)
- Documentation clarity
- Testing evidence
- Usability

---

### Workflow for Lead/Architect Agent

**IMPORTANT: Use the `/lead` slash command to activate architect/planning mode.**

The `/lead` command (in `dot_claude/commands/lead.md`) provides:
- Architectural decision process (7 steps)
- Design principles to apply
- Technology evaluation framework
- Risk management guidelines
- Pre-release review checklist

**For comprehensive details, see `persona-lead.md`** (500+ lines covering):
- Complete decision process with templates
- Design principles with applications
- Risk management framework
- Technology evaluation criteria
- Architectural patterns and anti-patterns
- Communication templates (ADRs, implementation plans)
- Scale planning considerations

**Quick workflow summary:**
1. Read: plan.md → implementation-log.md → qa-review.md → CLAUDE.md → persona-lead.md
2. Define problem clearly (stakeholders, constraints, success criteria)
3. Research existing solutions and best practices
4. Generate 3+ alternatives with trade-offs
5. Evaluate using decision matrix
6. Document decision with ADR
7. Create phased implementation plan
8. Update project docs (implementation-log.md, plan.md)

**Key responsibilities:**
- Strategic thinking and architectural decisions
- Evaluate trade-offs before choosing approaches
- Create clear implementation plans for coding agents
- Review major changes before releases
- Manage technical debt consciously
- Provide direction to the team
- Think long-term while being pragmatic

---

### Workflow for Researcher Agent

**IMPORTANT: Use the `/research` slash command to activate research mode.**

The `/research` command (in `dot_claude/commands/research.md`) provides:
- Research process (understand → gather → analyze → document → report)
- 6 research types (architecture, frameworks, best practices, debugging, config, compatibility)
- Decision matrix templates
- Source quality evaluation framework
- Communication templates for different agent types

**For comprehensive details, see `persona-researcher.md`** (500+ lines covering):
- Research types and approaches
- Information gathering techniques (WebSearch, WebFetch, Task/Explore)
- Analysis frameworks (decision matrix, trade-offs)
- Documentation templates (research reports, quick notes)
- Source evaluation criteria
- Communication style per agent type
- Quality standards and anti-patterns

**Quick workflow summary:**
1. Read: plan.md → implementation-log.md → qa-review.md → CLAUDE.md → persona-researcher.md
2. Clarify research question (what, why, for whom, constraints)
3. Gather information from multiple sources (web + codebase)
4. Analyze and compare alternatives systematically
5. Document findings in docs/research/[category]/
6. Report to requester with clear recommendation
7. Update implementation-log.md if research informs decision

**Key responsibilities:**
- Investigate solutions, frameworks, and best practices
- Support lead agent with architecture/tool evaluation research
- Support coding agent with debugging/framework/config research
- Compare alternatives using decision matrices
- Cite sources and assess quality
- Provide actionable recommendations
- Document findings for future reference

---

## Delegating Research Tasks

**IMPORTANT: Don't research everything yourself - leverage the researcher agent!**

### When to Delegate

**Perfect for delegation:**
- Framework/tool comparisons (which one should we use?)
- Architecture pattern research (how do others solve this?)
- Best practices verification (what's the 2026 standard?)
- Configuration research (how to set up tool X?)
- Debugging/troubleshooting (why does error Y happen?)
- Compatibility research (does feature A work on platform B?)

**Don't delegate when:**
- Simple documentation lookup (use WebFetch)
- Answer is in docs/REFERENCES.md (read it yourself)
- You already know the answer
- Quick (<30 min) decision needed

### How to Delegate

**Simple format:**
```
"Research [topic]
Question: [specific question]
For: [what you'll do with answer]
Constraints: [platform, time, etc.]
See REFERENCES.md #X for background (if relevant)"
```

**What you get back:**
- Clear recommendation with rationale
- Comparison matrix (if evaluating alternatives)
- Implementation guidance with code examples
- Sources cited for verification
- Research saved to docs/research/ (reusable!)

### Benefits

**Token efficiency:**
- Researcher handles web searches (not in your context)
- Results saved to files (0 tokens until Read)
- Can reference research forever

**Better decisions:**
- Systematic comparison of alternatives
- Authoritative sources cited
- Trade-offs explicitly stated
- Evidence-based, not gut feel

**See your persona file for detailed delegation examples:**
- Coding agent: See persona-coding.md "Delegating Research Tasks"
- Lead agent: See persona-lead.md "Delegating Research to Researcher Agent"
- Review agent: See persona-review.md "Delegating to Researcher Agent"

---

## Important Project-Specific Practices

### 1. Progressive Implementation

IMPORTANT: This project is implemented in 4 phases. DO NOT skip ahead to later phases.

**Current phase:** Check implementation-log.md for current phase
**Phase order:**
1. Phase 1: Git + Script (MVP)
2. Phase 2: chezmoi integration
3. Phase 3: DevContainer Feature
4. Phase 4: MCP Server

### 2. Documentation-Driven Development

**YOU MUST update documentation as you code:**
- Update implementation-log.md when completing tasks
- Update qa-review.md when reviewing
- Update docs/ when changing behavior
- Keep README.md in sync with features

### 3. Shell Script Standards

**ALWAYS use these patterns in bash scripts:**
```bash
#!/usr/bin/env bash
set -euo pipefail

# Validate prerequisites
command -v git >/dev/null 2>&1 || {
    echo "Error: git is required but not installed" >&2
    exit 1
}

# Quote all variables
INSTALL_DIR="${HOME}/.claude"
if [ -d "$INSTALL_DIR" ]; then
    echo "Found existing installation at: $INSTALL_DIR"
fi

# Backup before changes
backup_configs() {
    local backup_dir="$HOME/.claude-backup-$(date +%Y%m%d-%H%M%S)"
    cp -r "$INSTALL_DIR" "$backup_dir"
    echo "Backed up to: $backup_dir"
}

# Provide rollback
rollback() {
    echo "Installation failed. Rolling back..." >&2
    # Rollback logic here
}
trap rollback ERR
```

**Run shellcheck before committing:**
```bash
shellcheck install.sh update.sh scripts/*.sh
```

### 4. Configuration File Best Practices

**For CLAUDE.md files:**
- Follow WHAT/WHY/HOW structure
- Keep under 300 lines (ideally < 100)
- Only universally applicable instructions
- Use progressive disclosure (link to detailed docs)
- No style guidelines (use linters)
- Emphasis markers: "IMPORTANT", "YOU MUST", "NEVER"

**For slash commands:**
- Clear frontmatter description
- Specific, actionable instructions
- Include usage examples

**For skills:**
- Follow community best practices
- "Write instructions as if for a human collaborator"
- Include test scenarios

### 5. Testing Requirements

**Before marking a task complete:**
- Test on at least one Linux distribution
- Verify against acceptance criteria in implementation-log.md
- Run shellcheck on any modified scripts
- Validate markdown with markdownlint (if available)
- Test destructive operations in VM/container first

### 6. Git Commit Practices

**Commit message format:**
```
<type>: <short description>

<detailed description>
<what changed and why>

<any breaking changes or notes>
```

**Types:** feat, fix, docs, test, refactor, review, chore

**Examples:**
```
feat: add install.sh with backup mechanism

Implements installation script with:
- Error handling (set -euo pipefail)
- Backup of existing configs
- Rollback on failure
- Dry-run mode
- Cross-platform support (Ubuntu, Fedora, Arch)

Updated implementation-log.md to mark task 1.4 complete.
```

### 7. Branch and PR Workflow

**Branching strategy:**
- Claude creates a NEW branch for each task/session automatically
- Branch naming: `claude/descriptive-task-name-XXXXX`
- Always push to the current branch (not main)
- After review and validation: Merge PR to `main`
- After merge: Delete the feature branch

**Before pushing:**
- Ensure all todos are completed or updated
- Update implementation-log.md
- Run basic tests
- Commit all changes

**Push with retry:**
```bash
# Push to current branch (Claude creates these automatically)
git push -u origin $(git branch --show-current)
# If network error, retry with exponential backoff
```

**PR creation:**
- Title: Clear, descriptive
- Body: Summary bullets + Test plan checklist
- Link to relevant issues
- Tag for human review
- **Target: main branch**

### 8. Handling Unknowns

**If you need to research config locations:**
- Use Task tool with Explore agent
- Document findings in implementation-log.md
- Update docs/CONFIG_LOCATIONS.md

**If you're unsure about approach:**
- Check plan.md for guidance
- Check qa-review.md for previous similar issues
- Ask specific questions rather than guessing

---

## Critical Reminders

**IMPORTANT: For ALL agents working on this project:**

1. **READ FIRST, CODE SECOND** - Always read plan.md, implementation-log.md, qa-review.md before starting
2. **USE TODOWRITE** - Track progress with todo lists, update frequently
3. **ONE TASK AT A TIME** - Only one todo should be in_progress
4. **UPDATE LOGS** - Always update implementation-log.md after completing work
5. **COMMIT REGULARLY** - Commit after completing each discrete task
6. **TEST BEFORE COMMIT** - Verify changes work before committing
7. **PUSH TO CURRENT BRANCH** - Push to the branch Claude created (not main)
8. **CREATE PRS** - Open PR targeting main at end of session for human review

**NEVER:**
- Skip reading instruction files
- Forget to update implementation-log.md
- Commit without testing
- Push to wrong branch
- Leave todos in inconsistent state
- Implement features from future phases

---

## Quick Reference

**Key files to always check:**
- `plan.md` - Overall architecture
- `implementation-log.md` - Current status, next tasks
- `qa-review.md` - Quality standards, previous issues

**Activate your role:**
- **Coding agents:** `/code` command (see `dot_claude/commands/code.md`)
  - References `persona-coding.md` for comprehensive details
- **Review agents:** `/review` command (see `dot_claude/commands/review.md`)
  - References `persona-review.md` for comprehensive details
- **Lead/Architect agents:** `/lead` command (see `dot_claude/commands/lead.md`)
  - References `persona-lead.md` for comprehensive details
- **Researcher agents:** `/research` command (see `dot_claude/commands/research.md`)
  - References `persona-researcher.md` for comprehensive details
  - For investigating solutions, frameworks, best practices, debugging

**Before starting work:**
1. Read instruction files (plan.md, implementation-log.md, qa-review.md, CLAUDE.md)
2. Use `/code`, `/review`, `/lead`, or `/research` command to activate workflow
3. Create todo list with TodoWrite
4. Mark task in_progress

**After completing work:**
1. Update implementation-log.md
2. Update qa-review.md (if reviewer)
3. Document research findings in docs/research/ (if researcher)
4. Commit changes
5. Push to branch
6. Create PR

**Common commands:**
```bash
# Run tests
shellcheck *.sh scripts/*.sh

# Check current phase
grep "Current phase" implementation-log.md

# See next task
grep "Next Steps for Coding Agent" implementation-log.md

# Check current branch
git branch --show-current

# Push to current branch
git push -u origin $(git branch --show-current)
```

---

## Resources

**Best practices researched:**
- [Claude Code Best Practices](https://www.anthropic.com/engineering/claude-code-best-practices)
- [Writing a Good CLAUDE.md](https://www.humanlayer.dev/blog/writing-a-good-claude-md)
- [Claude Skills](https://www.claude.com/skills)
- [Awesome Claude Skills](https://github.com/travisvn/awesome-claude-skills)

**Configuration management tools:**
- [chezmoi Documentation](https://www.chezmoi.io/)
- [DevContainer Features](https://containers.dev/features)
- [MCP Documentation](https://modelcontextprotocol.io/)

**Progressive disclosure docs:**
See `docs/` directory for detailed guides on specific topics
