# Team Structure and Agent Personas

**Purpose:** Document the team of agent personas, their roles, interactions, and evolution strategy.

**Last Updated:** 2026-01-02
**Status:** Phase 1 complete (4 personas), Phase 2 planned (6 personas)

---

## Team Evolution Strategy

### Phase 1: Core Team (Current) ✅

**Status:** Implemented and documented
**Team size:** 4 personas
**Suitable for:** Configuration management, tooling, small-to-medium projects

| Persona | Role | Primary Responsibility |
|---------|------|------------------------|
| **Coding** | Implementation | Write code, tests, scripts; commit changes |
| **Review** | Quality Assurance | Code review, QA, feedback, quality standards |
| **Lead** | Architecture & Strategy | Technical decisions, planning, team direction |
| **Researcher** | Investigation | Research solutions, frameworks, best practices |

**Files:**
- `persona-coding.md` (400+ lines)
- `persona-review.md` (954 lines)
- `persona-lead.md` (500+ lines)
- `persona-researcher.md` (500+ lines)
- Slash commands: `dot_claude/commands/{code,review,lead,research}.md`

**Strengths:**
- Small, focused, cross-functional
- Clear roles with minimal overlap
- Follows lean principles (minimal handoffs)
- Researcher supports all other personas

**Limitations:**
- No product/UX validation
- No DevOps/deployment expertise
- Security review not specialized
- Documentation is developer-focused

---

### Phase 2: Extended Team (Planned)

**Status:** Proposed, not yet implemented
**Team size:** 6 personas
**Suitable for:** Product development, customer-facing applications, SaaS products

**New additions:**

#### 1. Product Agent (HIGH PRIORITY)

**Role:** Product management and user experience
**Primary responsibility:** Ensure we build the right things

**Key activities:**
- Feature validation and prioritization
- User story creation and refinement
- Developer experience (DX) advocacy
- Scope management (saying "no" to non-essential work)
- Product vision maintenance
- Customer feedback integration

**When to activate:**
- User-facing features planned
- Unclear requirements or scope
- Need to prioritize features
- Product roadmap planning

**Interactions:**
- **→ Lead:** Provides requirements and context for architectural decisions
- **→ Coding:** Writes user stories and acceptance criteria
- **→ Review:** Defines product quality standards
- **← Researcher:** Requests user research, competitor analysis, UX patterns

**Files to create:**
- `persona-product.md`
- `dot_claude/commands/product.md`

---

#### 2. DevOps Agent (MEDIUM-HIGH PRIORITY)

**Role:** Operations, deployment, reliability engineering
**Primary responsibility:** Ensure reliable delivery to production

**Key activities:**
- CI/CD pipeline design and implementation
- Deployment automation and strategies
- Infrastructure as code
- Monitoring, logging, observability
- Incident response and postmortems
- Production reliability and performance

**When to activate:**
- Deployment pipeline needed
- Production reliability concerns
- Infrastructure decisions required
- Monitoring/observability setup
- Incident response

**Interactions:**
- **→ Lead:** Provides infrastructure requirements and constraints
- **→ Coding:** Defines deployment requirements, CI/CD standards
- **→ Review:** Reviews infrastructure code, runbooks, postmortems
- **← Researcher:** Requests tool comparisons, deployment strategies, best practices

**Files to create:**
- `persona-devops.md`
- `dot_claude/commands/devops.md`

---

### Phase 3: Specialist Team (Optional, On-Demand)

**Status:** Not planned for implementation yet
**Team size:** 6 core + specialists as needed
**Suitable for:** Enterprise products, regulated industries, high-scale systems

**Optional specialists (activate as needed):**

#### 3. Security Agent

**Role:** Security engineering and architecture
**Activation triggers:**
- Security-critical features
- Threat modeling required
- Compliance requirements (GDPR, SOC2, HIPAA)
- Security incident response
- Penetration testing

**Note:** Currently, Review agent handles security checks. Specialize only if needed.

---

#### 4. Documentation Agent

**Role:** Technical writing and documentation
**Activation triggers:**
- Major product release
- Public API documentation
- Tutorial/guide creation
- Documentation audit
- Developer relations content

**Note:** Currently, Coding agent handles code documentation. Specialize for user-facing docs.

---

#### 5. Performance Agent

**Role:** Performance engineering and optimization
**Activation triggers:**
- Performance problems identified
- Scalability planning required
- Optimization sprint
- Performance testing setup

**Note:** Could be combined with DevOps agent for most projects.

---

## Lean Principles Applied

### 1. Pull-Based Work

Personas are **activated when needed**, not permanently staffed:
- Use slash commands to activate persona: `/code`, `/review`, `/lead`, etc.
- Personas can be combined (one agent, multiple hats)
- No unnecessary specialization (waste)

### 2. Cross-Functional Teams

Each persona has broad skills, not narrow specialization:
- Coding agent can write docs
- Review agent can check security
- Lead agent can research
- Researcher supports everyone

### 3. Minimal Handoffs

Work flows smoothly without excessive coordination:
```
Product → Lead → Coding → Review → DevOps
    ↑        ↑       ↑        ↑        ↑
         Researcher (supports all)
```

### 4. Continuous Improvement

Team structure evolves based on needs:
- Phase 1: Core team (sufficient for most projects)
- Phase 2: Add Product + DevOps (for product development)
- Phase 3: Specialists on-demand (for specific needs)

### 5. Respect for People

Each persona has:
- Clear role and responsibilities
- Authority to make decisions
- Access to research support
- Comprehensive documentation (persona files)
- Tools to succeed (slash commands)

---

## Team Interaction Patterns

### Pattern 1: Feature Development

**Full team workflow:**

1. **Product** validates feature (is this needed?)
2. **Lead** designs architecture (how should we build it?)
3. **Researcher** investigates approaches (what are the options?)
4. **Coding** implements (build it)
5. **Review** validates quality (is it correct?)
6. **DevOps** deploys to production (deliver it)

### Pattern 2: Bug Fix

**Streamlined workflow:**

1. **Coding** investigates and fixes
2. **Review** validates fix
3. **DevOps** deploys (if needed)

(Product and Lead not needed for simple fixes)

### Pattern 3: Architectural Decision

**Decision-focused workflow:**

1. **Lead** identifies decision needed
2. **Researcher** investigates alternatives
3. **Lead** evaluates and decides
4. **Coding** implements decision
5. **Review** validates implementation

(Product provides input if user-facing; DevOps if infrastructure-related)

### Pattern 4: Research Investigation

**Research-led workflow:**

1. **Any persona** requests research
2. **Researcher** investigates
3. **Researcher** reports findings
4. **Requesting persona** makes decision

---

## Decision Framework: When to Add Personas

### ✅ Add a new persona when:

- [ ] Gap in expertise identified (no one covers this area)
- [ ] Repeated need across multiple projects
- [ ] Specialized knowledge required (security, UX, etc.)
- [ ] Quality suffers without dedicated focus
- [ ] Work gets delayed due to missing perspective

### ❌ Don't add a persona when:

- [ ] Existing persona can handle with brief guidance
- [ ] One-time need (just give instructions)
- [ ] Over-specialization would create silos
- [ ] Team coordination overhead would increase
- [ ] No clear value demonstrated

### ⚠️ Consider combining personas when:

- [ ] Two roles frequently activated together
- [ ] Significant overlap in responsibilities
- [ ] Small project doesn't justify specialization
- [ ] Handoff overhead outweighs benefits

---

## Activation Guide

### How to Activate Personas

**Via slash commands (recommended):**
```bash
/code      # Activate coding workflow
/review    # Activate review workflow
/lead      # Activate lead/architect workflow
/research  # Activate research workflow
/product   # Activate product workflow (Phase 2)
/devops    # Activate DevOps workflow (Phase 2)
```

**Via direct instruction:**
```
"Act as the coding agent and implement feature X"
"Switch to review agent mode and check for security issues"
"As the lead, design the architecture for Y"
```

**Via persona file reference:**
```
"Follow persona-coding.md guidelines to implement X"
"Review this code using persona-review.md checklist"
```

---

## Success Metrics

### Team Effectiveness Metrics

**Lean metrics:**
- **Lead time:** Time from idea to production (target: minimize)
- **Cycle time:** Time from start coding to deployed (target: < 1 day)
- **Deployment frequency:** How often we deploy (target: multiple/day)
- **Change fail rate:** % deployments causing issues (target: < 5%)
- **Time to restore:** How quickly we fix production issues (target: < 1 hour)

**Team health metrics:**
- **Handoff count:** # times work changes hands (target: minimize)
- **Context switching:** # persona changes per session (target: < 3)
- **Blocked time:** Time waiting for dependencies (target: < 10%)
- **Rework rate:** % work redone due to quality issues (target: < 5%)

### Persona-Specific Metrics

| Persona | Success Metric |
|---------|----------------|
| Product | Features used by users (not built and abandoned) |
| Lead | Architectural decisions documented and followed |
| Researcher | Research findings applied to decisions |
| Coding | Code quality (tests passing, shellcheck clean) |
| Review | Issues found before production (not after) |
| DevOps | Zero-downtime deployments, MTTR < 1 hour |

---

## Anti-Patterns to Avoid

### ❌ Anti-Pattern 1: Too Many Personas

**Problem:** 10+ personas, excessive coordination overhead
**Solution:** Keep core team small (4-6), add specialists only as needed

### ❌ Anti-Pattern 2: Persona Silos

**Problem:** "Not my job" mentality, strict role boundaries
**Solution:** Cross-functional skills, personas can wear multiple hats

### ❌ Anti-Pattern 3: Permanent Specialization

**Problem:** Always activate all personas, even for simple tasks
**Solution:** Pull-based activation, use minimal team for task

### ❌ Anti-Pattern 4: No Clear Ownership

**Problem:** Multiple personas trying to do same work
**Solution:** Clear role definitions, use TodoWrite to track who's doing what

### ❌ Anti-Pattern 5: Skipping Researcher

**Problem:** Making decisions without evidence or investigation
**Solution:** Delegate research tasks, make data-driven decisions

---

## Next Steps

### Immediate (This Session)

**Decision needed:**
1. Should we create Product and DevOps personas now (Phase 2)?
2. Or wait until we have a concrete need?

**Recommendation (Lead Agent):**
- **Yes, create Product persona** - Valuable even for this project (validate features)
- **Yes, create DevOps persona** - Needed for install.sh testing, CI/CD later
- **No specialists yet** - Wait for demonstrated need

### Short-Term (Phase 1 Completion)

1. Test current 4 personas with real work
2. Document pain points and gaps
3. Gather evidence for Phase 2 decision

### Medium-Term (Phase 2 Planning)

1. Create persona-product.md and product.md slash command
2. Create persona-devops.md and devops.md slash command
3. Test 6-persona team on feature development
4. Update this document with findings

---

## References

**Team structure research:**
- [Lean Software Development Principles](https://www.lean.org/lexicon-terms/software-development/)
- [Team Topologies](https://teamtopologies.com/) - Stream-aligned teams
- [Accelerate (DORA Metrics)](https://www.devops-research.com/research.html)

**Agent persona best practices:**
- persona-coding.md - Implementation patterns
- persona-review.md - Quality standards
- persona-lead.md - Architectural decision-making
- persona-researcher.md - Research methodology

**Claude Code configuration:**
- docs/research/compatibility/claude-code-web-config.md
- CLAUDE.md - Project practices

---

## Change History

### 2026-01-02 - Initial Team Structure Analysis

- Documented Phase 1 team (4 personas)
- Proposed Phase 2 expansion (6 personas)
- Defined lean principles and interaction patterns
- Created decision framework for adding personas
- Recommended Product and DevOps additions
- Established success metrics

**Decision:** Recommend creating Product and DevOps personas now (Phase 2)
**Rationale:** Both provide value even for small projects, establish patterns early
**Next action:** Lead agent to create persona files and slash commands
