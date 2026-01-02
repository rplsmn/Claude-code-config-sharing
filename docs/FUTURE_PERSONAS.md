# Future Persona Suggestions (Phase 3+)

**Purpose:** Ideas for additional team members to build in future Claude sessions
**Status:** Suggestions only - NOT implemented yet
**Last Updated:** 2026-01-02

---

## Current Team (Phase 2 - Complete)

✅ **6 Core Personas:**
1. Coding - Implementation
2. Review - QA
3. Lead - Architecture
4. Researcher - Investigation
5. Product - Feature validation, UX
6. DevOps - Deployment, reliability

---

## Phase 3: Specialist Personas (On-Demand)

Create these personas when needed, not proactively. Use pull-based activation.

### 1. Designer Agent (HIGHEST PRIORITY)

**Gap:** Visual design, branding, theming, UI aesthetics

**Core responsibilities:**
- Color schemes and palettes (brand colors, accessible contrast)
- Typography systems (font families, sizes, hierarchy)
- Spacing and layout grids (8pt/4pt systems)
- Visual component design (buttons, cards, forms)
- Dark mode and theme variants
- Icon and illustration selection
- Brand identity and style guides
- Design system documentation

**When to activate:**
- Building user-facing applications with GUI
- Creating brand identity
- Designing marketing materials
- Accessibility compliance (WCAG color contrast)
- Theming and white-labeling features

**Key deliverables:**
- Style guide (colors, typography, spacing)
- Component design specs
- Design system documentation
- Figma/design files (if applicable)
- Theme configuration files (CSS variables, tokens)

**Workflow integration:**
- Product defines WHAT users need → Designer defines HOW it looks → Coding implements
- Review validates accessibility and usability
- Lead ensures design system is maintainable

**Skills needed:**
- Visual design principles (contrast, hierarchy, balance)
- Color theory and accessibility
- Typography and readability
- Design systems thinking
- CSS/styling knowledge
- Brand consistency

---

### 2. Security Agent (MEDIUM PRIORITY)

**Gap:** Security architecture, threat modeling, compliance

**Core responsibilities:**
- Threat modeling and attack surface analysis
- Security architecture review
- Penetration testing mindset
- Vulnerability scanning and assessment
- Security best practices enforcement
- Compliance validation (GDPR, SOC2, HIPAA)
- Security incident response
- Secrets management review

**When to activate:**
- Handling sensitive data (PII, credentials, financial)
- Authentication/authorization systems
- API security design
- Compliance requirements
- Security audit preparation
- Post-incident analysis

**Key deliverables:**
- Threat models (STRIDE, attack trees)
- Security architecture diagrams
- Security test plans
- Compliance checklists
- Security runbooks
- Incident response procedures

**Workflow integration:**
- Lead designs architecture → Security reviews for vulnerabilities
- Coding implements → Security validates secure coding practices
- Review includes security checklist
- DevOps ensures secure deployment

**Current coverage:**
- Review agent handles basic security checks
- Specialize when security is critical to product

---

### 3. Documentation Agent (MEDIUM PRIORITY)

**Gap:** Technical writing, user-facing documentation

**Core responsibilities:**
- User guides and tutorials
- API documentation
- Developer documentation
- Onboarding guides
- FAQ and troubleshooting
- Release notes and changelogs
- Documentation architecture
- Content strategy

**When to activate:**
- Major product release
- Public API launch
- Open source project documentation
- User onboarding optimization
- Documentation audit
- Developer relations content

**Key deliverables:**
- User guides (getting started, tutorials, how-tos)
- API reference documentation
- Architecture documentation
- Troubleshooting guides
- Video scripts or walkthrough content
- Documentation site structure

**Workflow integration:**
- Product defines user needs → Documentation creates user guides
- Coding writes code comments → Documentation creates API docs
- Lead creates architecture → Documentation explains for users
- Review validates clarity and accuracy

**Current coverage:**
- Coding agent handles code documentation (comments, README)
- Specialize for user-facing, polished documentation

---

### 4. Performance Agent (LOW PRIORITY)

**Gap:** Performance engineering, optimization, scalability

**Core responsibilities:**
- Performance profiling and benchmarking
- Bottleneck identification
- Optimization strategies
- Scalability planning
- Load testing and stress testing
- Performance budgets
- Caching strategies
- Database query optimization

**When to activate:**
- Performance problems identified
- Scalability planning required
- Optimization sprint
- Performance testing setup
- High-traffic product launch

**Key deliverables:**
- Performance profiles and flame graphs
- Optimization recommendations
- Load test results
- Performance budgets
- Caching architecture
- Scalability plans

**Workflow integration:**
- Lead designs for performance → Performance validates approach
- Coding implements → Performance profiles and optimizes
- DevOps monitors production → Performance investigates issues

**Current coverage:**
- DevOps handles operational performance monitoring
- Specialize for deep optimization work

---

### 5. Data Agent (LOW PRIORITY)

**Gap:** Data modeling, analytics, data engineering

**Core responsibilities:**
- Database schema design
- Data modeling (relational, NoSQL)
- Analytics and reporting
- Data pipeline design
- ETL/ELT processes
- Data quality and validation
- Analytics instrumentation
- Query optimization

**When to activate:**
- Complex data modeling needed
- Analytics system design
- Data pipeline implementation
- Reporting and dashboards
- Data migration projects

**Key deliverables:**
- Database schemas
- Data models (ERD, UML)
- Analytics tracking plans
- Data pipeline architecture
- Query optimization guides

**Workflow integration:**
- Product defines metrics → Data designs analytics
- Lead designs architecture → Data models schemas
- Coding implements → Data validates queries

---

### 6. QA/Testing Agent (LOW PRIORITY)

**Gap:** Comprehensive test strategy, test automation

**Core responsibilities:**
- Test strategy and planning
- Test case design
- Automated test implementation
- Integration testing
- End-to-end testing
- Test data generation
- Testing framework selection
- Quality metrics

**When to activate:**
- Complex testing requirements
- Test automation needed
- Quality metrics tracking
- Testing framework setup

**Key deliverables:**
- Test plans and strategies
- Automated test suites
- Test coverage reports
- Testing documentation

**Current coverage:**
- Review agent handles quality validation
- Coding agent writes unit tests
- Specialize for comprehensive test automation

---

## Decision Framework: When to Add New Personas

### ✅ Create a new persona when:

- [ ] **Repeated need** - Same type of work happens frequently
- [ ] **Specialized knowledge required** - Current team lacks expertise
- [ ] **Quality suffers** - Work is done poorly without specialist
- [ ] **Clear value proposition** - Specialist would significantly improve outcomes
- [ ] **Multiple projects need it** - Not just one-time need

### ❌ Don't create a new persona when:

- [ ] **One-time need** - Just give specific instructions this once
- [ ] **Current team can handle** - Existing persona can do it with brief guidance
- [ ] **Over-specialization** - Would create silos and handoff overhead
- [ ] **Unclear value** - Can't articulate clear benefit

---

## Persona Template (For Future Implementation)

When creating a new persona, use this structure:

```markdown
# [Name] Agent Persona

**Role:** [One-line description]
**Focus:** [Key focus areas]
**Mode:** [Working style - e.g., analytical, creative, systematic]

---

## Core Identity

You are [description]. You:
- [Key responsibility 1]
- [Key responsibility 2]
- [Key responsibility 3]

---

## Your Workflow (ALWAYS Follow This)

### 1. Session Startup
- Read: plan.md, implementation-log.md, qa-review.md, CLAUDE.md
- Create TodoWrite list
- Understand context before acting

### 2. [Main Workflow Section]
[Core process steps]

### 3. [Secondary Workflow]
[Supporting processes]

---

## Delegating to Other Agents

### To Lead Agent
- [When and what to delegate]

### To Researcher Agent
- [Research requests]

### To Coding Agent
- [Implementation requests]

### To Review Agent
- [Review requests]

---

## [Role] Artifacts You Create

### 1. [Artifact Type]
**Location:** [Where to save]
**Format:** [Template or structure]

---

## Key [Role] Principles

1. **Principle 1** - [Explanation]
2. **Principle 2** - [Explanation]

---

## Anti-Patterns to Avoid

### ❌ Anti-Pattern 1
**Problem:** [What goes wrong]
**Solution:** [How to avoid]

---

## Success Metrics

**You're doing well when:**
- [ ] [Metric 1]
- [ ] [Metric 2]

**Red flags:**
- [ ] [Warning sign 1]
- [ ] [Warning sign 2]

---

## Quick Reference

**Before [key action]:**
1. ✅ [Checklist item 1]
2. ✅ [Checklist item 2]

**Your core job:**
- [Primary responsibility]
- [Secondary responsibility]
- [Tertiary responsibility]
```

---

## Slash Command Template

```markdown
---
description: [One-line description for command palette]
---

# [Role] Workflow

You are now in **[Role] Agent** mode. Your role is [description].

## Session Startup Checklist

**CRITICAL: Read these files FIRST (in order):**

1. ✅ `plan.md` - [Why read this]
2. ✅ `implementation-log.md` - [Why read this]
3. ✅ `qa-review.md` - [Why read this]
4. ✅ `CLAUDE.md` - [Why read this]
5. ✅ `persona-[name].md` - YOUR comprehensive reference (500+ lines)

**After reading, create TodoWrite list for [role] work.**

---

## Your Core Responsibilities

### 1. [Primary Responsibility]
[Brief explanation and checklist]

### 2. [Secondary Responsibility]
[Brief explanation and checklist]

---

## Delegation Guide

### To [Other Agent]
- [What to delegate and when]

---

## [Role] Artifacts You Create

### 1. [Artifact Type]
**Location:** [Path]

---

## Key [Role] Principles

1. **Principle 1** - [Brief]
2. **Principle 2** - [Brief]

---

## Success Metrics

**You're doing well when:**
- [Metric]

**Red flags:**
- [Warning sign]

---

## Quick Decision Framework

**Before [action]:**
1. ✅ [Check]

**Your core job:**
- [Responsibility]

---

## Important Notes

- **See persona-[name].md for comprehensive details** (500+ lines)
- **Use TodoWrite** to track work
- **Work closely with [other agents]** for [purpose]

---

**Remember:** [Key takeaway message]
```

---

## Implementation Checklist (For Future Claude Session)

When building a new persona, follow this checklist:

**Phase 1: Planning (Lead Agent)**
- [ ] Validate need using decision framework
- [ ] Define role scope and boundaries
- [ ] Identify delegation patterns
- [ ] Plan workflow integration

**Phase 2: Creation (Coding Agent)**
- [ ] Create `persona-[name].md` (500+ lines)
  - [ ] Core identity section
  - [ ] Workflow sections
  - [ ] Delegation guide
  - [ ] Artifacts templates
  - [ ] Principles and anti-patterns
  - [ ] Success metrics
- [ ] Create `dot_claude/commands/[name].md`
  - [ ] Session startup checklist
  - [ ] Core responsibilities summary
  - [ ] Delegation quick reference
  - [ ] Success metrics
- [ ] Deploy to `.claude/commands/[name].md`

**Phase 3: Documentation (Review Agent)**
- [ ] Update `docs/TEAM_STRUCTURE.md`
  - [ ] Add to team roster
  - [ ] Update interaction patterns
  - [ ] Add to capabilities matrix
- [ ] Update `implementation-log.md`
  - [ ] Document creation
  - [ ] Update team status
  - [ ] Note change history
- [ ] Update `CLAUDE.md` if needed
  - [ ] Add to quick reference
  - [ ] Update workflow guidance

**Phase 4: Testing**
- [ ] Test slash command activation
- [ ] Verify persona file references work
- [ ] Validate delegation patterns
- [ ] Check integration with existing personas

---

## Recommended Priority Order

If building Phase 3 personas incrementally:

**First:** Designer Agent
- Clear gap (visual design not covered)
- High value for user-facing products
- Complements Product agent well

**Second:** Security Agent
- Critical for production applications
- Regulatory compliance needs
- Risk mitigation

**Third:** Documentation Agent
- Important for product launches
- User onboarding optimization
- Open source projects

**Last (as needed):**
- Performance Agent (only if performance problems)
- Data Agent (only if complex data modeling)
- QA/Testing Agent (only if test automation needed)

---

## Notes

**Lean reminder:**
- Don't build all specialists upfront (waste)
- Create when demonstrated need exists
- Pull-based activation (slash commands)
- Keep team small and cross-functional

**Current team (6 personas) is sufficient for:**
- Configuration management (this project)
- Most backend/CLI projects
- Early-stage product development
- Internal tooling

**Expand to specialists when:**
- GUI/visual design needed (Designer)
- Security critical (Security)
- Large user base (Documentation)
- Performance problems (Performance)

---

**Last Updated:** 2026-01-02
**Status:** Suggestions for future implementation
**Next Session:** Choose 1-2 personas to build based on current project needs
