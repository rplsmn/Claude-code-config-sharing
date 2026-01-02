# Contributing References

**Quick guide for humans to add reference materials for researcher agents**

---

## Why Add References?

References help researcher agents:
- ✅ Find authoritative sources quickly
- ✅ Avoid researching the same topic twice
- ✅ Make better-informed decisions
- ✅ Save tokens (read files vs. conversation context)
- ✅ Cite sources in research reports

---

## Quick Add (During Conversation)

**Option 1: Simple mention**
```
"I found a useful article: <URL>
It covers <topic> which is relevant for <task>"
```

The agent will read it and optionally add to REFERENCES.md.

**Option 2: Structured handoff**
```
"Add reference:
Title: Shell Script Best Practices 2026
URL: https://example.com/shell-practices
Summary: Modern shell scripting patterns and anti-patterns
Category: best-practices
Relevance: Will inform our install.sh development (task 1.4)"
```

The agent will add to REFERENCES.md immediately.

**Option 3: With saved copy**
```
"I've saved an article to docs/research/references/articles/shell-practices.md
Please add to REFERENCES.md:
- Category: Shell Scripting
- Summary: Advanced error handling patterns
- Mark as important for task 1.4"
```

Agent will update index and can reference the local copy.

---

## Formal Add (Direct File Edit)

### 1. Edit REFERENCES.md

Add entry under the appropriate category using this template:

```markdown
**X. Reference Title**
- **URL:** https://example.com/article
- **Date Accessed:** YYYY-MM-DD
- **Summary:** Brief description of content (1-2 sentences)
- **Key Topics:** Topic1, Topic2, Topic3
- **Relevance:** Why this is useful for the project
- **Local Copy:** Path or "Not needed"
- **Status:** ✅ Active | ⚠️ Outdated | 📌 Important
```

**Example:**
```markdown
**8. Advanced Bash Error Handling**
- **URL:** https://example.com/bash-errors
- **Date Accessed:** 2026-01-02
- **Summary:** Comprehensive guide to error handling with set -euo pipefail and trap
- **Key Topics:** Error handling, trap, exit codes, debugging
- **Relevance:** Critical for install.sh and update.sh development (task 1.4)
- **Local Copy:** Not needed
- **Status:** 📌 Important
```

### 2. Optionally Save Full Article

**When to save:**
- Will be referenced frequently
- May disappear or change (blog post)
- Required for offline work
- Contains code examples we'll adapt

**Where to save:**
```
docs/research/references/articles/descriptive-name.md
```

**Format:**
```markdown
---
title: Article Title
source: https://example.com/article
author: Author Name
date_published: YYYY-MM-DD
date_saved: YYYY-MM-DD
category: best-practices
---

# Article Title

[Full article content or relevant excerpts]

## Notes

[Your notes or highlights]
```

### 3. Commit

```bash
git add docs/REFERENCES.md docs/research/references/
git commit -m "docs: add reference for shell error handling"
```

---

## Categories

Add references to the appropriate category in REFERENCES.md:

- **Configuration Management** - Dotfiles, config tools, sync solutions
- **Claude Code** - Claude Code specific docs and guides
- **Shell Scripting** - Bash, shell best practices, patterns
- **Development Tools** - DevContainers, MCP, tools and frameworks
- **Best Practices** - General software engineering practices
- **Research Reports** - Internal research from researcher agents

---

## Quality Guidelines

**Prefer:**
- ✅ Official documentation
- ✅ Recent articles (<2 years old)
- ✅ Authoritative sources (recognized experts)
- ✅ Well-maintained resources

**Avoid:**
- ❌ Outdated content (>3 years for tech)
- ❌ Marketing materials (biased)
- ❌ Unverified claims
- ❌ Content farms

**Quality ratings:**
- ⭐⭐⭐ Official docs, peer-reviewed
- ⭐⭐ Expert blogs, Stack Overflow
- ⭐ Personal blogs (verify author)

---

## Token Efficiency Tips

**Why this matters:**
Large documents in conversation = expensive tokens
References in files = free (until Read)

**Best practices:**

**✅ DO:**
```
"Research chezmoi setup, see REFERENCES.md #5"
→ Agent reads index (100 tokens), then reference (1000 tokens) = 1,100 tokens
```

**❌ DON'T:**
```
"Research chezmoi, here's the full documentation: [10,000 words]"
→ Full docs in conversation = 10,000 tokens every time
```

**Efficiency gains:**
- Reference once → Use many times
- Agent reads only what's needed
- Conversations stay focused
- Research is reusable

---

## Examples

### Example 1: Quick Reference During Task

**Conversation:**
```
Human: "I found this guide on shell script testing:
https://github.com/bats-core/bats-core
It's the official BATS repo. We should use this for task 1.7 testing."

Agent: "Thanks! I'll add this to REFERENCES.md under Development Tools.
[Adds reference, includes in research for task 1.7]"
```

### Example 2: Research Background

**Conversation:**
```
Human: "Before researching task 1.2.1 (Claude Code Web),
check these references:
- REFERENCES.md #1 (Claude Code best practices)
- REFERENCES.md #2 (CLAUDE.md guide)

They might have info on web vs. local differences."

Researcher: "Reading references first..."
[Reads index, then references #1 and #2, uses in research]
```

### Example 3: Saved Article

**Conversation:**
```
Human: "I saved a detailed chezmoi tutorial to
docs/research/references/articles/chezmoi-advanced.md
Please add to REFERENCES.md and use for Phase 2 planning."

Agent: "Added as reference #9 in Configuration Management section.
Marked as 📌 Important for Phase 2."
```

---

## Integration with Research Process

**How researchers use references:**

1. **Receive task:** "Research dotfiles managers"
2. **Check REFERENCES.md:** Look for existing references
3. **Read relevant references:** Use Read tool on specific ones
4. **Conduct additional research:** WebSearch, WebFetch for new sources
5. **Add new sources:** Update REFERENCES.md with findings
6. **Write report:** Cite references by number
7. **Commit:** Update both research report and REFERENCES.md

**Result:** Future research builds on previous work, no duplication.

---

## Maintenance

**Quarterly review (every 3 months):**
- Check for outdated references (mark as ⚠️ Outdated)
- Update official documentation links if changed
- Archive old research reports if superseded
- Update statistics in REFERENCES.md

**Next review:** 2026-04-02

---

## FAQ

**Q: Should I save every URL I share?**
A: No. Save references that will be used multiple times or for important decisions. One-off links don't need indexing.

**Q: Where do I save full article text?**
A: `docs/research/references/articles/descriptive-name.md`

**Q: How do I tell the agent about a reference?**
A: During conversation: "See REFERENCES.md #5" or "Add reference: [details]"

**Q: What if the reference is a video or PDF?**
A: Add to REFERENCES.md with link. Optionally extract key points to a markdown file.

**Q: Can I reorganize REFERENCES.md?**
A: Yes, but update any references to entry numbers in research reports and docs.

**Q: How do I mark something as really important?**
A: Use status: `📌 Important` in the reference entry

---

## Quick Checklist

**Adding a reference:**
- [ ] Unique and valuable (not already in REFERENCES.md)
- [ ] Relevant to current or future tasks
- [ ] Quality source (see guidelines above)
- [ ] Proper template used
- [ ] Categorized correctly
- [ ] Committed with clear message

---

**Questions?** Ask in conversation or see docs/research/README.md for more details.
