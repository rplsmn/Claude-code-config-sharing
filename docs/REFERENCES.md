# Project References

**Purpose:** Centralized index of reference materials, documentation, and resources for research.

**How to use:**
- **Researchers:** Read this index first to find relevant references
- **All agents:** Check here before researching to avoid duplicating work
- **Humans:** Add new references via PR or direct commit (see CONTRIBUTING_REFERENCES.md)

---

## Quick Lookup

**By Category:**
- [Configuration Management](#configuration-management)
- [Claude Code](#claude-code)
- [Shell Scripting](#shell-scripting)
- [Development Tools](#development-tools)
- [Best Practices](#best-practices)

**By Type:**
- [Official Documentation](#official-documentation)
- [Community Resources](#community-resources)
- [Research Reports](#research-reports-internal)
- [Saved Articles](#saved-articles)

---

## Official Documentation

### Claude Code

**1. Claude Code Best Practices (Anthropic Engineering)**
- **URL:** https://www.anthropic.com/engineering/claude-code-best-practices
- **Date Accessed:** 2026-01-02
- **Summary:** Official best practices for using Claude Code effectively
- **Key Topics:** CLAUDE.md structure, slash commands, personas, skills
- **Relevance:** Foundation for this project's approach
- **Local Copy:** docs/research/references/claude-code-best-practices.md (if saved)
- **Status:** ✅ Referenced in plan.md

**2. Writing a Good CLAUDE.md (HumanLayer)**
- **URL:** https://www.humanlayer.dev/blog/writing-a-good-claude-md
- **Date Accessed:** 2026-01-02
- **Summary:** Guide to writing effective CLAUDE.md configuration files
- **Key Topics:** WHAT/WHY/HOW structure, progressive disclosure, emphasis markers
- **Relevance:** Informs our CLAUDE.md best practices
- **Local Copy:** Not saved (external blog)
- **Status:** ✅ Referenced in plan.md

**3. Claude Skills Documentation**
- **URL:** https://www.claude.com/skills
- **Date Accessed:** 2026-01-02
- **Summary:** Official documentation for Claude Skills
- **Key Topics:** Skill structure, best practices, examples
- **Relevance:** Will inform Phase 3-4 skill development
- **Local Copy:** Not needed (always current online)
- **Status:** ✅ Referenced in plan.md

**8. Claude Code Slash Commands Documentation**
- **URL:** https://code.claude.com/docs/en/slash-commands
- **Date Accessed:** 2026-01-02
- **Summary:** Official documentation for creating custom slash commands
- **Key Topics:** Command structure, namespacing, arguments, frontmatter, project vs personal commands
- **Relevance:** Critical for understanding slash command deployment (Task 1.2.1)
- **Local Copy:** Not needed (official docs)
- **Status:** ⭐⭐⭐ Official

**9. Claude Code on the Web Documentation**
- **URL:** https://code.claude.com/docs/en/claude-code-on-the-web
- **Date Accessed:** 2026-01-02
- **Summary:** Official documentation for Claude Code web version
- **Key Topics:** Web capabilities, file uploads, configuration, iOS access
- **Relevance:** Answers user's question about iOS/web deployment (Task 1.2.1)
- **Local Copy:** Not needed (official docs)
- **Status:** ⭐⭐⭐ Official

**10. Claude Code on the Web | Claude Blog**
- **URL:** https://claude.com/blog/claude-code-on-the-web
- **Date Accessed:** 2026-01-02
- **Summary:** Official announcement of Claude Code web version launch
- **Key Topics:** Availability, pricing, features, roadmap
- **Relevance:** Confirms web/iOS availability and feature parity
- **Local Copy:** Not needed (official blog)
- **Status:** ⭐⭐⭐ Official

---

## Community Resources

**4. Awesome Claude Skills (GitHub)**
- **URL:** https://github.com/travisvn/awesome-claude-skills
- **Date Accessed:** 2026-01-02
- **Summary:** Curated list of Claude Skills examples and resources
- **Key Topics:** Community skills, patterns, examples
- **Relevance:** Examples and inspiration for skills development
- **Local Copy:** Not needed (actively maintained repo)
- **Status:** ✅ Referenced in plan.md

---

## Configuration Management

### chezmoi

**5. chezmoi Documentation**
- **URL:** https://www.chezmoi.io/
- **Date Accessed:** 2026-01-02
- **Summary:** Official documentation for chezmoi dotfiles manager
- **Key Topics:** Templates, encryption, multi-machine setup
- **Relevance:** Phase 2 implementation tool
- **Local Copy:** Not needed (official docs)
- **Status:** ✅ Referenced in plan.md

---

## Development Tools

### DevContainer Features

**6. DevContainer Features Documentation**
- **URL:** https://containers.dev/features
- **Date Accessed:** 2026-01-02
- **Summary:** Official specification for DevContainer Features
- **Key Topics:** Feature structure, installation, distribution
- **Relevance:** Phase 3 container integration
- **Local Copy:** Not needed (official spec)
- **Status:** ✅ Referenced in plan.md

---

## Best Practices

### MCP (Model Context Protocol)

**7. MCP Documentation**
- **URL:** https://modelcontextprotocol.io/
- **Date Accessed:** 2026-01-02
- **Summary:** Official Model Context Protocol documentation
- **Key Topics:** MCP server development, tool creation
- **Relevance:** Phase 4 MCP server implementation
- **Local Copy:** Not needed (official docs)
- **Status:** ✅ Referenced in plan.md

---

## Research Reports (Internal)

**These are research reports created by researcher agents and stored in docs/research/.**

### Compatibility Research

**R1. Claude Code Web Configuration Capabilities**
- **Location:** docs/research/compatibility/claude-code-web-config.md
- **Date:** 2026-01-02
- **Summary:** Comprehensive research on slash command support in Claude Code Web/iOS
- **Key Finding:** ✅ Web/iOS supports custom slash commands using same `.claude/commands/` structure
- **Decision Impact:** Resolves deployment question for Task 1.2.1
- **Sources:** 12 references (official docs, guides, news)
- **Status:** 📌 Complete - answers critical deployment question

**Expected structure for future reports:**
```
docs/research/
├── architecture/          # Architecture pattern research
├── frameworks/           # Tool/framework evaluations
├── best-practices/       # Best practice investigations
├── debugging/            # Debug and troubleshooting solutions
├── configuration/        # Configuration research
└── compatibility/        # Platform compatibility findings
```

---

## Saved Articles

**Full text articles saved locally for offline access and token efficiency.**

**Storage:** `docs/research/references/articles/`

*None yet - add via CONTRIBUTING_REFERENCES.md process*

---

## How to Add References

### For Humans

**Quick add (during conversation):**
```markdown
"Add reference: <URL>
Summary: <brief description>
Category: <category>
```

**Formal add (via file edit):**
1. Add entry to this file under appropriate category
2. Follow template below
3. Optionally save full article to docs/research/references/articles/
4. Commit with message: "docs: add reference for <topic>"

**Template:**
```markdown
**X. Reference Title**
- **URL:** https://example.com/article
- **Date Accessed:** YYYY-MM-DD
- **Summary:** Brief description of content
- **Key Topics:** Topic1, Topic2, Topic3
- **Relevance:** Why this is useful for the project
- **Local Copy:** Path or "Not needed"
- **Status:** ✅ Active | ⚠️ Outdated | 📌 Important
```

### For Researcher Agents

**When you find valuable sources during research:**
1. Add them to this index immediately
2. Save full text to docs/research/references/articles/ if:
   - Will be referenced frequently
   - May disappear or change
   - Required for offline work
3. Update your research report to reference this index entry
4. Commit updates to REFERENCES.md

---

## Reference Quality Ratings

**Rating system for source credibility:**

**⭐⭐⭐ High Quality:**
- Official documentation
- Peer-reviewed publications
- Well-maintained GitHub repos (>1k stars, recent activity)
- Anthropic/Claude official resources

**⭐⭐ Medium Quality:**
- Technical blogs from recognized experts
- Stack Overflow (high votes, recent)
- Conference talks and presentations
- Industry publications

**⭐ Use with Caution:**
- Personal blogs (verify author expertise)
- Outdated articles (>3 years old for tech topics)
- Single-source claims
- Marketing materials

**❌ Avoid:**
- Content farms
- Unverified claims
- Severely outdated information
- Biased promotional content

---

## Reference Update Schedule

**Review frequency:**
- **Official docs:** Check quarterly for updates
- **Community resources:** Monitor for major changes
- **Research reports:** Review annually or when invalidated
- **Saved articles:** Archive if >2 years old and unverified

**Last review:** 2026-01-02
**Next review:** 2026-04-02

---

## Token Efficiency Guidelines

**For conversation participants:**

**✅ DO:**
- Point to this index: "See REFERENCES.md #5 for chezmoi docs"
- Reference by number: "Per reference #1, Claude Code best practices..."
- Use Read tool to fetch specific references as needed

**❌ DON'T:**
- Paste full article text into conversation
- Repeatedly fetch same reference in one session
- Include reference content when summary suffices

**Token-efficient workflow:**
1. Human: "Research X, see REFERENCES.md #5 for background"
2. Researcher: Reads REFERENCES.md, then reads reference #5 if needed
3. Researcher: Cites reference #5 in findings
4. Result: ~1000 tokens vs. ~10,000 tokens for full article in conversation

---

## Adding References During Conversations

**Lightweight approach for humans:**

When delegating to researcher or providing context to any agent:

```
"I have a reference for you:
Title: <title>
URL: <url>
Relevance: <why it matters>

Please read and use for <task>"
```

Agent will:
1. Add to REFERENCES.md
2. Save to docs/research/references/ if needed
3. Use in research
4. Commit REFERENCES.md update

---

## Reference Statistics

**Total references:** 10 (external) + 1 (internal research report)
**By category:**
- Claude Code: 6
- Configuration Management: 1
- Development Tools: 1
- Best Practices: 1
- Community Resources: 1

**By type:**
- Official documentation: 9
- Community resources: 1
- Internal research: 1
- Saved articles: 0

**Last updated:** 2026-01-02

---

## Change History

### 2026-01-02 - Research: Claude Code Web Configuration
- Added references #8, #9, #10 (Claude Code slash commands and web docs)
- Added first internal research report (R1: Claude Code Web config)
- Research resolved Task 1.2.1 deployment question
- Confirmed web/iOS support for custom slash commands
- Updated statistics (10 external refs, 1 internal report)

### 2026-01-02 - Initial Setup
- Created REFERENCES.md structure
- Added 7 initial references from plan.md
- Established categorization system
- Created token efficiency guidelines
- Defined reference quality ratings
