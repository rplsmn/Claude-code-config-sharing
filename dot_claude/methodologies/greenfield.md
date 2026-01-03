# Greenfield Methodology

**Project Type:** New Software Development / Build from Scratch

**Use this methodology when:**
- Starting a new project with no existing codebase
- Building a new feature/service from scratch
- Prototyping or proof-of-concept
- Creating greenfield microservice or application

---

## Methodology Overview

Greenfield projects emphasize **thoughtful planning before coding** with focus on:
- **Validate before building** (build the right thing)
- **Design before implementing** (architect for success)
- **Start small, iterate** (MVP → enhancements)
- **Quality from day one** (tests, CI/CD, docs)
- **Continuous validation** (does it solve the problem?)

---

## Phase Structure

### Phase 1: Product Discovery & Validation

**Objective:** Ensure we're building the right thing before writing any code

**Activate:** Product Agent (primary), Lead Agent (secondary)

**Deliverables:**
- Problem statement (what problem are we solving?)
- User stories / Job Stories (who benefits and how?)
- Success criteria (how do we know it works?)
- Requirements (functional and non-functional)
- Scope definition (MVP vs future enhancements)
- DX review (if building developer tools)

**Approach:**
1. **5-Question Validation Framework** (Product Agent):
   - **Problem**: What problem does this solve?
   - **User**: Who experiences this problem?
   - **Alternative**: How do they solve it today?
   - **Value**: Why is our solution better?
   - **Evidence**: How do we know this is a real problem?

2. **User Story Creation**:
   ```
   When [situation],
   I want to [action],
   So I can [outcome].

   Example:
   When deploying to production,
   I want to automatically run smoke tests,
   So I can catch critical failures immediately.
   ```

3. **MoSCoW Prioritization**:
   - **Must Have**: Core functionality (MVP scope)
   - **Should Have**: Important but not critical (phase 2)
   - **Could Have**: Nice to have (backlog)
   - **Won't Have**: Explicitly out of scope

**Tools:** `/product` command, user interviews, market research

**Success Criteria:**
- [ ] Problem statement validated (people actually have this problem)
- [ ] User stories written for MVP scope
- [ ] Success criteria defined (measurable)
- [ ] Requirements prioritized (MoSCoW)
- [ ] Stakeholder approval obtained

---

### Phase 2: Architecture & Technical Design

**Objective:** Design the system architecture before writing code

**Activate:** Lead Agent (primary), Researcher Agent (as needed)

**Deliverables:**
- Architecture diagram (components, data flow)
- Technology stack decisions (language, framework, database, etc.)
- API design (endpoints, contracts, payloads)
- Data model (database schema, entities, relationships)
- Architectural Decision Records (ADRs) for key choices
- Non-functional requirements plan (performance, security, scalability)
- Deployment architecture (infrastructure, CI/CD)

**Approach:**
1. **Architectural Decision Process** (Lead Agent):
   - Define constraints (team skills, budget, timeline)
   - Generate alternatives (3+ options per decision)
   - Evaluate trade-offs (decision matrix)
   - Document decision (ADR format)
   - Plan for change (how to pivot if wrong)

2. **Research for Unknowns**:
   - Delegate to Researcher agent for framework comparisons
   - Investigate best practices for chosen domain
   - Study similar systems for patterns

3. **Design Patterns Selection**:
   - Choose architectural patterns (layered, hexagonal, microservices, etc.)
   - Select design patterns (repository, factory, strategy, etc.)
   - Define coding standards and conventions

**Tools:** `/lead` command, `/research` command, architecture tools, ADR templates

**Success Criteria:**
- [ ] Architecture diagram completed and reviewed
- [ ] Technology stack chosen with rationale (ADRs)
- [ ] API contracts designed (OpenAPI/Swagger spec)
- [ ] Data model designed (ERD or schema)
- [ ] Key architectural decisions documented (ADRs)
- [ ] Lead approval to proceed to implementation

---

### Phase 3: Foundation & Infrastructure

**Objective:** Set up project infrastructure before feature development

**Activate:** DevOps Agent (primary), Coding Agent (secondary)

**Deliverables:**
- Repository initialized (Git, branching strategy)
- Project structure created (directories, modules)
- Build system configured (package.json, Makefile, etc.)
- CI/CD pipeline set up (tests, linting, deployment)
- Development environment (Docker, dev containers, README)
- Code quality tools (linters, formatters, pre-commit hooks)
- Observability foundation (logging, metrics, tracing setup)

**Approach:**
1. **Infrastructure as Code**:
   - Define infrastructure needs
   - Create deployment configurations
   - Set up environments (dev, staging, prod)

2. **CI/CD Pipeline**:
   ```
   On commit:
     1. Lint code
     2. Run tests
     3. Build artifacts
     4. Deploy to staging (if main branch)
     5. Run smoke tests
     6. Deploy to production (if tagged release)
   ```

3. **Developer Experience**:
   - One-command setup (`npm install && npm start`)
   - Clear README with quickstart
   - Example requests / usage guide

**Tools:** `/devops` command, `/code` command, infrastructure tools

**Success Criteria:**
- [ ] Repository set up with clear structure
- [ ] CI/CD pipeline running successfully
- [ ] Development environment documented
- [ ] Code quality tools integrated
- [ ] First deployment to staging successful

---

### Phase 4: MVP Implementation Loop

**Objective:** Build minimum viable product iteratively

**Activate:** Coding → Review → Product → Lead (iterative)

**Workflow Per Feature:**

```
┌─────────────────────────────────────────────────┐
│ Select Next MVP Feature from Backlog            │
└─────────────┬───────────────────────────────────┘
              │
              ▼
┌─────────────────────────────────────────────────┐
│ PRODUCT: Validate Feature Fits MVP Scope        │
│ - Is this truly Must Have?                      │
│ - Can we defer to later?                        │
│ - Any dependencies?                             │
└─────────────┬───────────────────────────────────┘
              │
              ▼
┌─────────────────────────────────────────────────┐
│ CODING: Implement Feature (TDD)                 │
│ - Write tests first (red)                       │
│ - Implement feature (green)                     │
│ - Refactor for quality                          │
│ - Update documentation                          │
└─────────────┬───────────────────────────────────┘
              │
              ▼
┌─────────────────────────────────────────────────┐
│ REVIEW: Code Quality & Correctness              │
│ - Tests comprehensive?                          │
│ - Code quality good?                            │
│ - Follows architecture?                         │
│ - Documentation updated?                        │
└─────────────┬───────────────────────────────────┘
              │
              ├─── Issues Found ───┐
              │                    │
              ▼                    ▼
         ✅ Approved        ❌ Needs Fixes
              │                    │
              │                    └─── Back to CODING
              ▼
┌─────────────────────────────────────────────────┐
│ PRODUCT: Validate Feature Solves Problem        │
│ - Try the feature (manual test)                 │
│ - Does it solve user story?                     │
│ - UX acceptable?                                │
│ - Ready for users?                              │
└─────────────┬───────────────────────────────────┘
              │
              ├─── Not Quite ───┐
              │                 │
              ▼                 ▼
         ✅ Approved      🔄 Refinement Needed
              │                 │
              │                 └─── Back to CODING
              ▼
┌─────────────────────────────────────────────────┐
│ LEAD: Strategic Review                          │
│ - Aligns with architecture?                     │
│ - Technical debt acceptable?                    │
│ - Ready to ship?                                │
└─────────────┬───────────────────────────────────┘
              │
              ▼
┌─────────────────────────────────────────────────┐
│ Merge to Main → Deploy → Monitor                │
└─────────────┬───────────────────────────────────┘
              │
              ▼
┌─────────────────────────────────────────────────┐
│ MVP Complete? → Next Feature : Ship MVP          │
└─────────────────────────────────────────────────┘
```

**Persona Sequence:**
1. **Product** (`/product`): Validates feature is in scope
2. **Coding** (`/code`): Implements using TDD
3. **Review** (`/review`): Validates code quality
4. **Product** (`/product`): Validates feature solves problem
5. **Lead** (`/lead`): Strategic review (periodic, not every feature)
6. Repeat until MVP complete

**Success Criteria Per Feature:**
- [ ] User story acceptance criteria met
- [ ] Tests written and passing
- [ ] Code review approved
- [ ] Product validation passed
- [ ] Deployed to staging successfully

---

### Phase 5: MVP Launch & Validation

**Objective:** Ship MVP to users and gather feedback

**Activate:** DevOps → Product → Lead

**Deliverables:**
- MVP deployed to production
- Usage documentation published
- Monitoring dashboards set up
- User feedback collection mechanism
- Success metrics measurement

**Approach:**
1. **Launch Preparation**:
   - Final testing in staging
   - Smoke tests automated
   - Rollback plan documented
   - Monitoring alerts configured

2. **Deployment** (DevOps):
   - Deploy to production
   - Run smoke tests
   - Monitor for errors
   - Validate success criteria

3. **Validation** (Product):
   - Gather user feedback
   - Measure success metrics
   - Identify gaps and issues
   - Prioritize next enhancements

**Tools:** `/devops` command, `/product` command, monitoring tools

**Success Criteria:**
- [ ] MVP deployed without critical issues
- [ ] Success metrics being measured
- [ ] User feedback being collected
- [ ] Monitoring and alerts working
- [ ] Team ready for iteration

---

### Phase 6: Iteration & Enhancement

**Objective:** Build on MVP based on real user feedback

**Activate:** Product → Lead → Coding → Review (loop)

**Approach:**
- **Data-Driven Decisions**: Use metrics and feedback to prioritize
- **Same Loop**: Product validates → Lead designs → Coding implements → Review validates
- **Continuous Improvement**: Refactor, optimize, enhance

**Enhancement Categories:**
- **Should Have** features from original prioritization
- **User-Requested** features from feedback
- **Technical Improvements**: Performance, refactoring, debt reduction
- **Could Have** features if time permits

---

## Persona Interaction Pattern

### Primary Flow (MVP Development)

**Feature Implementation Loop:**
```
Product (validate scope) → Coding (implement) → Review (validate quality) → Product (validate solution)
└────────────────────────────┬────────────────────────────┘
                             │
                             └──→ Repeat for each feature

Lead reviews periodically (milestone reviews, not every feature)
```

### Supporting Flows

**When researching technology choices:**
```
Lead → Researcher (investigate options) → Lead (decide)
```

**When setting up infrastructure:**
```
Lead (design) → DevOps (implement) → Review (validate)
```

**When launching:**
```
DevOps (deploy) → Product (validate with users) → Lead (strategic review)
```

---

## Quality Gates

**Gate 1: Product Validation**
- [ ] Problem validated (people need this)
- [ ] User stories defined
- [ ] Success criteria clear
- **Decision:** Proceed to architecture?

**Gate 2: Architecture Approval**
- [ ] Architecture designed and reviewed
- [ ] Technology stack chosen with rationale
- [ ] API contracts designed
- **Decision:** Proceed to implementation?

**Gate 3: MVP Feature Complete**
- [ ] All Must Have features implemented
- [ ] Tests passing
- [ ] Product validation passed
- **Decision:** Ship MVP?

**Gate 4: Post-Launch**
- [ ] MVP deployed successfully
- [ ] Success metrics positive
- [ ] No critical issues
- **Decision:** Continue iteration or pivot?

---

## Key Principles for Greenfield Projects

### 1. Validate Before Building
- Product discovery prevents building wrong thing
- User stories ensure focus on value
- Success criteria provide clear goals

### 2. Design Before Implementing
- Architecture decisions made thoughtfully
- Trade-offs considered explicitly
- Technical debt minimized from start

### 3. Start Small, Iterate
- MVP first (Must Have only)
- Ship early, get feedback
- Iterate based on real usage

### 4. Quality from Day One
- CI/CD set up before first feature
- Tests written alongside code (TDD)
- Code review on every change
- Documentation maintained continuously

### 5. Continuous Product Validation
- Product agent validates feature solves problem
- Not just "does it work?" but "does it help?"
- Metrics and feedback drive decisions

---

## Common Pitfalls to Avoid

❌ **Skipping product discovery**
- Risk: Build wrong thing, waste time
- Fix: Use product agent to validate before coding

❌ **Architecture by accident**
- Risk: Technical debt, hard to change later
- Fix: Lead agent designs architecture upfront

❌ **MVP scope creep**
- Risk: Never ship, over-engineer
- Fix: Product agent enforces Must Have only

❌ **No CI/CD from start**
- Risk: Manual deployments, slow feedback
- Fix: DevOps sets up automation early

❌ **Skipping code review**
- Risk: Quality issues, inconsistent code
- Fix: Review every PR before merge

❌ **Building without user validation**
- Risk: Build features nobody uses
- Fix: Product validates feature solves problem

---

## Success Metrics

**Product Success:**
- [ ] User stories completed: 100% of Must Have
- [ ] Success criteria met (measurable)
- [ ] User feedback positive

**Technical Success:**
- [ ] Test coverage > 80%
- [ ] CI/CD pipeline working
- [ ] Zero critical bugs in production
- [ ] Performance meets requirements

**Process Success:**
- [ ] All features passed product validation
- [ ] Architecture followed consistently
- [ ] Documentation up to date

---

## Example: Building a REST API Service

### Phase 1: Product Discovery
- **Problem**: Internal teams need user authentication service
- **User Story**: "When building new services, I want to use centralized auth, so I don't reimplement it each time"
- **Success Criteria**: 3+ teams using it, < 100ms auth check
- **MVP Scope**: Login, logout, token validation (Must Have)
- **Deferred**: SSO, 2FA, password reset (Should Have)

### Phase 2: Architecture
- **Stack**: Node.js/TypeScript, PostgreSQL, Redis
- **Pattern**: Hexagonal architecture
- **API**: REST (OpenAPI spec)
- **ADR-001**: Chose JWT over sessions (stateless scaling)
- **ADR-002**: Chose PostgreSQL over MongoDB (relational user data)

### Phase 3: Foundation
- Repository: GitHub with main/feature branch strategy
- CI/CD: GitHub Actions (lint → test → build → deploy)
- Structure: src/domain, src/application, src/infrastructure
- Tools: ESLint, Prettier, Jest, Docker

### Phase 4: MVP Implementation
```
Feature 1: User Registration
  Product: Validate scope (MVP? Yes)
  Coding: TDD - tests → implementation
  Review: Code quality check
  Product: Test feature manually
  Result: ✅ Merged

Feature 2: Login
  Product: Validate scope
  Coding: Implement JWT generation
  Review: Security review
  Product: Test login flow
  Result: ✅ Merged

Feature 3: Token Validation
  Product: Validate scope
  Coding: Implement middleware
  Review: Performance check
  Product: Test with real service
  Result: ✅ Merged
```

### Phase 5: Launch
- Deployed to production
- 3 teams integrated successfully
- Auth checks average 45ms (✅ < 100ms)
- No critical issues first week

### Phase 6: Iteration
- Added password reset (user feedback)
- Added refresh tokens (Should Have)
- Optimized to 30ms (performance improvement)
- Planning SSO integration (Could Have)

**Result:** MVP shipped in 3 weeks, 5 teams using it after 2 months

---

## Template Checklist

Use this checklist when starting a new greenfield project:

**Setup:**
- [ ] Copy this methodology to project `.claude/METHODOLOGY.md`
- [ ] Customize for specific project type
- [ ] Identify stakeholders

**Phase 1: Product Discovery**
- [ ] Activate product agent (`/product`)
- [ ] Answer 5-question validation framework
- [ ] Write user stories
- [ ] Prioritize using MoSCoW
- [ ] Define success criteria

**Phase 2: Architecture**
- [ ] Activate lead agent (`/lead`)
- [ ] Design architecture diagram
- [ ] Choose technology stack (ADRs)
- [ ] Design API contracts
- [ ] Document key decisions

**Phase 3: Foundation**
- [ ] Activate devops agent (`/devops`)
- [ ] Initialize repository
- [ ] Set up CI/CD pipeline
- [ ] Configure code quality tools
- [ ] Write setup documentation

**Phase 4: MVP Development**
- [ ] For each feature: Product → Coding → Review → Product
- [ ] Keep tests passing always
- [ ] Deploy to staging continuously
- [ ] Lead reviews at milestones

**Phase 5: Launch**
- [ ] Final staging validation
- [ ] Deploy to production (`/devops`)
- [ ] Set up monitoring
- [ ] Gather user feedback (`/product`)

**Phase 6: Iterate**
- [ ] Measure success metrics
- [ ] Prioritize enhancements
- [ ] Continue feature loop
- [ ] Refactor and optimize

---

## References

- Lean Startup (MVP concept)
- Test-Driven Development (TDD)
- Continuous Integration / Continuous Deployment (CI/CD)
- Architectural Decision Records (ADRs)
- User Story Mapping

---

**Last Updated:** 2026-01-03
**Maintained By:** Lead Agent
**Version:** 1.0
