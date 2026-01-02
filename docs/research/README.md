# Research Documentation

This directory contains research reports and findings from researcher agents.

## Directory Structure

```
research/
├── README.md                    # This file
├── architecture/                # Architecture pattern research
│   └── [topic].md              # Research reports on architectural decisions
├── frameworks/                  # Tool and framework evaluations
│   └── [tool-comparison].md    # Framework comparison reports
├── best-practices/              # Best practice investigations
│   └── [practice-area].md      # Best practice research
├── debugging/                   # Debug and troubleshooting solutions
│   └── [error-type].md         # Debugging guides
├── configuration/               # Configuration research
│   └── [tool-config].md        # Configuration guides
├── compatibility/               # Platform compatibility findings
│   └── [platform-topic].md     # Compatibility research
└── references/                  # Reference materials
    ├── articles/               # Saved full-text articles
    └── [other-materials]/      # Additional reference types
```

## Usage

### For Researcher Agents

**When completing research:**
1. Save your report to the appropriate category directory
2. Use the template from persona-researcher.md
3. Name file descriptively: `topic-name.md` (lowercase, hyphens)
4. Update REFERENCES.md if you found valuable external sources
5. Update implementation-log.md if research led to a decision

**Example:**
```bash
# Research: Compare dotfiles managers
# Category: frameworks
# Output: docs/research/frameworks/dotfiles-managers-comparison.md
```

### For All Agents

**Before researching:**
- Check if topic already researched: `ls docs/research/[category]/`
- Read existing reports to avoid duplicate work
- Build on previous findings rather than starting from scratch

**When citing research:**
- Reference by path: "See docs/research/frameworks/dotfiles-managers-comparison.md"
- Include in commit messages if decision based on research
- Link from implementation-log.md technical decisions

### For Humans

**Adding reference materials:**
- External articles → Save to `references/articles/`
- Add entry to `../REFERENCES.md` index
- Commit with message: `docs: add reference for [topic]`

**Requesting research:**
- Specify category if known: "Research [topic] for frameworks comparison"
- Point to existing references: "See REFERENCES.md #5 for background"
- Clarify what decision needs to be made

## File Naming Conventions

**Research reports:**
- `topic-description.md` (e.g., `shell-error-handling.md`)
- Use lowercase, hyphens for spaces
- Be descriptive but concise
- Date in filename if time-sensitive: `claude-web-config-2026-01.md`

**Reference articles:**
- `article-title.md` or `source-topic.md`
- Include source in frontmatter
- Original publication date in frontmatter

## Quality Standards

**All research reports must include:**
- [ ] Clear research question(s)
- [ ] Executive summary with recommendation
- [ ] Detailed findings
- [ ] Sources cited (with URLs and dates)
- [ ] Comparison matrix (if evaluating alternatives)
- [ ] Trade-offs explicitly stated
- [ ] Implementation notes

**See:** persona-researcher.md for complete research report template

## Token Efficiency

**Why we save research to files:**
- Files cost 0 tokens when not read
- Only costs tokens when Read tool is used
- Agents can selectively read what's needed
- Prevents re-researching same topics

**Best practice:**
- Save research once → Reference many times
- Point to files rather than pasting content
- Read selectively (just the relevant section)

## Current Research

**Completed:**
- None yet

**In Progress:**
- Task 1.2.1: Claude Code Web configuration capabilities

**Planned:**
- Shell script best practices (for task 1.4)
- chezmoi setup patterns (for Phase 2)

## Change History

### 2026-01-02 - Initial Setup
- Created research directory structure
- Established categorization system
- Defined file naming conventions
- Set quality standards
