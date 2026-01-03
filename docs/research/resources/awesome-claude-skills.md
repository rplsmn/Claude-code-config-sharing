# Awesome Claude Skills - Resource List

**Purpose:** Reference list of curated Claude Skills repositories for discovering and sharing reusable workflows.

**Last Updated:** 2026-01-03

---

## Official Resources

### Claude Skills Documentation
- **URL:** https://www.claude.com/skills
- **Description:** Official Claude Skills documentation from Anthropic
- **Content:** Skill format specification, best practices, examples

### Claude Code Documentation
- **URL:** https://code.claude.com/docs
- **Description:** Official Claude Code documentation
- **Content:** Commands, skills, hooks, configuration

---

## Community Skill Repositories

### 1. Superpowers by obra
- **URL:** https://github.com/obra/superpowers
- **Stars:** Popular community resource
- **Description:** Comprehensive skill library for Claude Code
- **Categories:**
  - Testing (TDD, systematic debugging, verification)
  - Collaboration (brainstorming, planning, code review)
  - Development (git workflows, parallel agents, subagent-driven development)
  - Meta (writing skills, using superpowers)

**Featured Skills:**
- **test-driven-development** - RED-GREEN-REFACTOR cycle with anti-patterns guide
- **systematic-debugging** - 4-phase root cause analysis process
- **brainstorming** - Socratic design refinement
- **dispatching-parallel-agents** - Concurrent subagent workflows
- **subagent-driven-development** - Fast iteration with two-stage review

**Why It's Valuable:**
- Well-documented, production-ready skills
- Focus on software engineering best practices
- Emphasis on systematic workflows
- Meta-skills for creating new skills

---

### 2. Awesome Claude Skills by ComposioHQ
- **URL:** https://github.com/ComposioHQ/awesome-claude-skills
- **Stars:** Growing community resource
- **Description:** Curated collection of practical Claude Skills across multiple domains

**Categories:**
- **Document Processing:** docx, pdf, pptx, xlsx manipulation
- **Development & Code:** artifacts-builder, changelog-generator, D3.js, Playwright, MCP builder
- **Data & Analysis:** CSV summarization, PostgreSQL queries, root-cause tracing
- **Business & Marketing:** Brand guidelines, competitive analysis, lead research
- **Communication:** Content research, meeting transcripts, family history
- **Creative & Media:** Canvas design, image enhancement, GIFs, themes, video downloads
- **Productivity:** File organization, invoices, raffles, task iteration
- **Collaboration:** Git operations, code review, test fixing
- **Security:** Forensics, metadata extraction, threat hunting

**Featured Skills:**
- **imagen** by @sanjay3290 - Google Gemini image generation for UI mockups, icons, illustrations
- **changelog-generator** - Automated changelog from git history
- **MCP builder** - Create Model Context Protocol servers

**Why It's Valuable:**
- Broad coverage across domains
- Practical, real-world use cases
- Active community contributions
- Well-organized by category

---

### 3. Awesome Claude Skills by BehiSecc
- **URL:** https://github.com/BehiSecc/awesome-claude-skills
- **Stars:** Community-curated
- **Description:** Comprehensive directory of 50+ Claude skills organized by domain

**Categories:**
- **Document Skills:** Word, PDF, presentations, spreadsheets
- **Development & Code Tools:** Web artifacts, git, AWS CDK, testing
- **Data & Analysis:** CSV, PostgreSQL, root-cause analysis
- **Scientific Tools:** 125+ skills for bioinformatics, materials simulation
- **Writing & Research:** Content research, article extraction
- **Learning & Knowledge:** Document networking, feedback iteration
- **Media & Content:** YouTube transcripts, video downloads, image enhancement
- **Collaboration:** Git, Linear integration, meeting analysis
- **Security:** Testing, fuzzing, variable management
- **Utility:** File organization, invoices, skill templates

**Featured Skills:**
- Links to both superpowers (obra) and individual skill creators
- Scientific computing skills for research domains
- Comprehensive security and testing tools

**Why It's Valuable:**
- Most comprehensive catalog (50+ skills)
- Includes specialized/scientific domains
- Regular updates from community
- Good discovery resource

---

## How to Use These Resources

### Finding Skills for Your Project

1. **Browse by Category:**
   - Identify your project type (web development, data analysis, security, etc.)
   - Browse relevant category in awesome lists
   - Read skill descriptions and examples

2. **Search by Use Case:**
   - Use GitHub search within repositories
   - Search for keywords like "testing", "git", "image", "data"
   - Check skill README for detailed usage

3. **Evaluate Quality:**
   - Check if skill has clear documentation
   - Look for usage examples
   - Verify it follows Claude Skills format (SKILL.md with frontmatter)
   - Check for dependencies and prerequisites

### Installing Skills

**Option 1: Manual Copy**
```bash
# Download skill directory
git clone https://github.com/obra/superpowers
cp -r superpowers/skills/test-driven-development ~/.claude/skills/

# Or from this repo
cp -r dot_claude/skills/test-driven-development ~/.claude/skills/
```

**Option 2: Via Config System (Recommended)**
```bash
# Include in your config repo (this project)
cp -r downloaded-skill/ dot_claude/skills/
git add dot_claude/skills/
git commit -m "Add [skill-name] skill"

# Deploy via SessionStart hook (Web)
# Skills automatically deployed from .claude/skills/
```

**Option 3: Project-Specific**
```bash
# Add to project's .claude/skills/
mkdir -p .claude/skills/
cp -r skill-directory/ .claude/skills/
git add .claude/skills/
git commit -m "Add project-specific skills"
```

### Contributing Skills

**To superpowers (obra):**
1. Fork repository
2. Create skill following `writing-skills` skill guidelines
3. Test thoroughly
4. Submit pull request

**To awesome lists (ComposioHQ, BehiSecc):**
1. Create your skill in separate repo
2. Follow Claude Skills format (SKILL.md with YAML frontmatter)
3. Submit PR adding link to awesome list

**To this config repo:**
1. Add skill to `dot_claude/skills/`
2. Update documentation
3. Test deployment
4. Create PR

---

## Skill Quality Guidelines

### Good Skills Have:
- ✅ Clear SKILL.md with YAML frontmatter
- ✅ Specific, actionable instructions
- ✅ Usage examples
- ✅ Prerequisites documented
- ✅ Error handling guidance
- ✅ Real-world use cases

### Avoid:
- ❌ Vague or ambiguous instructions
- ❌ Missing dependencies
- ❌ No examples
- ❌ Overly complex workflows
- ❌ Undocumented requirements

---

## Skills Included in This Config Repo

### 1. Test-Driven Development (TDD)
- **Source:** obra/superpowers
- **Location:** `dot_claude/skills/test-driven-development/`
- **Description:** RED-GREEN-REFACTOR cycle with comprehensive anti-patterns guide
- **Use When:** Implementing features, fixing bugs, refactoring code

### 2. Imagen (Image Generation)
- **Source:** sanjay3290/ai-skills
- **Location:** `dot_claude/skills/imagen/`
- **Description:** Generate images using Google Gemini API for UI mockups, icons, illustrations
- **Use When:** Need visual assets, mockups, diagrams, illustrations
- **Requirements:** GEMINI_API_KEY, Python 3.6+, google-generativeai package

---

## Future Skills to Consider

**From Superpowers:**
- **systematic-debugging** - Methodical bug hunting
- **brainstorming** - Collaborative design refinement
- **dispatching-parallel-agents** - Concurrent workflows
- **using-git-worktrees** - Parallel development branches

**From Awesome Lists:**
- **changelog-generator** - Automated changelogs from git
- **MCP builder** - Create MCP servers
- **playwright** - E2E testing automation
- **d3-visualization** - Data visualization

**Custom Skills to Create:**
- **architecture-decision-record** - ADR creation workflow
- **pr-description-generator** - Generate PR descriptions from commits
- **api-documentation** - OpenAPI spec generation
- **performance-profiling** - Systematic performance analysis

---

## Related Resources

### Official Documentation
- [Claude Skills Overview](https://www.claude.com/skills)
- [Claude Code Docs](https://code.claude.com/docs)
- [Anthropic Blog - Claude Code Best Practices](https://www.anthropic.com/engineering/claude-code-best-practices)

### Community
- [Claude Discord](https://discord.gg/anthropic) - Community discussions
- [GitHub Topics](https://github.com/topics/claude-skills) - Browse skills by topic

---

**Updated:** 2026-01-03
**Maintainer:** Lead Agent
**Version:** 1.0

**Contributing:** Found a great skill? Add it to this document and submit a PR!
