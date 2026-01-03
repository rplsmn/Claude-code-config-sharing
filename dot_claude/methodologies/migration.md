# Migration Methodology

**Project Type:** System Migration / Rewrite / Platform Translation

**Use this methodology when:**
- Migrating from one language/framework to another (Java→TypeScript, Python→Go, etc.)
- Rewriting legacy system with modern stack
- Platform translation (monolith→microservices, on-prem→cloud)
- Re-implementation with feature parity requirement

---

## Methodology Overview

Migration projects require **systematic, incremental approach** with heavy emphasis on:
- **Understanding before changing** (reverse engineering existing system)
- **Test coverage first** (safety net before changes)
- **Logical dependency order** (login before features needing auth)
- **Tight feedback loops** (small slices, validate early)
- **Continuous validation** (no regressions)

---

## Phase Structure

### Phase 1: Discovery & Architecture Mapping

**Objective:** Understand the existing system completely before changing anything

**Activate:** Researcher Agent (primary), Lead Agent (secondary)

**Deliverables:**
- Architecture map (components, dependencies, data flow)
- API contract documentation (all endpoints, payloads, behaviors)
- Database schema documentation
- External integration inventory
- Non-functional requirements (performance, security, compliance)
- Dependency graph (what depends on what)
- Edge cases and business rules documentation

**Approach:**
1. **Discovery Agent Workflow:**
   - Map every touchpoint (endpoints, controllers, services, repositories)
   - Use AST tools to track code dependencies
   - Document API contracts with examples
   - Identify critical paths and high-risk areas
   - Create visual diagrams (architecture, data flow, sequence)

2. **Reverse Engineer Agent:**
   - Analyze existing codebase structure
   - Extract business logic and rules
   - Document implicit behaviors and assumptions
   - Identify technical debt and anti-patterns (to avoid replicating)

**Tools:** `/research` command, AST analyzers, API documentation tools, diagramming

**Success Criteria:**
- [ ] Complete API contract for every endpoint
- [ ] Dependency graph shows all relationships
- [ ] Architecture diagram approved by lead
- [ ] Edge cases documented with examples
- [ ] Non-functional requirements quantified

---

### Phase 2: Test Suite Development

**Objective:** Build comprehensive test coverage as safety net BEFORE migration

**Activate:** Coding Agent (test mode), Review Agent

**Deliverables:**
- Integration test suite (all API endpoints)
- Contract tests (API behavior verification)
- Data validation tests (schema, constraints)
- Performance baseline tests
- Test data sets (happy path, edge cases, error cases)

**Approach:**
1. **Test-First Strategy:**
   - Write tests against EXISTING system
   - Capture current behavior (even if imperfect)
   - Document deviations from expected behavior
   - Establish performance baselines

2. **Coverage Requirements:**
   - 100% API endpoint coverage (integration tests)
   - Critical business logic unit tested
   - All edge cases from discovery phase tested
   - Error handling and failure modes tested

**Tools:** `/code` command (test focus), testing frameworks, API testing tools

**Success Criteria:**
- [ ] Every endpoint has integration test
- [ ] Test suite runs green against current system
- [ ] Performance baselines documented
- [ ] Edge cases from discovery all tested
- [ ] CI pipeline runs test suite automatically

---

### Phase 3: Slice Identification & Planning

**Objective:** Break migration into logical, testable increments

**Activate:** Lead Agent (primary), Product Agent (secondary)

**Deliverables:**
- Atomic Migration Units (AMUs) list
- Migration order (dependency-respecting sequence)
- Domain grouping (related functionality together)
- Risk assessment per AMU
- Success criteria per AMU

**Approach:**
1. **Slice by Domain or Endpoint:**
   - Group related endpoints (e.g., "authentication", "orders", "payments")
   - Identify dependencies (login must come before user profile)
   - Consider business value (high-value features first? or low-risk first?)

2. **Migration Order Example:**
   ```
   Domain 1: Authentication
   - Migration: /login, /logout, /refresh-token
   - Evolutions: Performance improvements, security hardening

   Domain 2: User Management (depends on auth)
   - Migration: /users, /profile, /settings
   - Evolutions: Enhanced validation, better error messages

   Domain 3: Orders (depends on auth + users)
   - Migration: /orders, /cart, /checkout
   - Evolutions: New features, improved UX
   ```

3. **Risk Assessment:**
   - High risk: Complex business logic, many dependencies, performance-critical
   - Medium risk: Moderate complexity, some dependencies
   - Low risk: Simple CRUD, few dependencies, well-tested

**Tools:** `/lead` command, decision matrices, dependency visualization

**Success Criteria:**
- [ ] Every endpoint assigned to an AMU
- [ ] AMU order respects dependencies (no circular deps)
- [ ] Risk level assigned to each AMU
- [ ] Success criteria defined per AMU
- [ ] Effort estimates (small/medium/large) per AMU

---

### Phase 4: Domain Migration Loop

**Objective:** Migrate one domain at a time with tight validation loop

**Activate:** Lead → Coding → Review → Lead (iterative)

**Workflow Per Domain:**

```
┌─────────────────────────────────────────────────┐
│ Start Domain Migration                          │
└─────────────┬───────────────────────────────────┘
              │
              ▼
┌─────────────────────────────────────────────────┐
│ LEAD: Plan Implementation Approach              │
│ - Review discovery docs for this domain         │
│ - Design new architecture (patterns, structure) │
│ - Identify technical decisions needed           │
│ - Create implementation task list               │
└─────────────┬───────────────────────────────────┘
              │
              ▼
┌─────────────────────────────────────────────────┐
│ CODING: Implement Domain                        │
│ - Translate endpoint(s) to new stack            │
│ - Preserve API contract (same inputs/outputs)   │
│ - Implement business logic from discovery docs  │
│ - Ensure tests pass (green)                     │
└─────────────┬───────────────────────────────────┘
              │
              ▼
┌─────────────────────────────────────────────────┐
│ REVIEW: Validate Implementation                 │
│ - API contract matches original?                │
│ - All tests green?                              │
│ - Code quality acceptable?                      │
│ - Performance meets baseline?                   │
│ - Security considerations addressed?            │
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
│ LEAD: Gate Decision - Ship This Domain?         │
│ - Acceptance criteria met?                      │
│ - No regressions?                               │
│ - Ready for production?                         │
└─────────────┬───────────────────────────────────┘
              │
              ├─── Yes ──────┬──── No (fix issues)
              │              │
              ▼              └─── Back to LEAD/CODING
┌─────────────────────────────────────────────────┐
│ DEVOPS: Deploy Domain                           │
│ - Deploy to staging                             │
│ - Run smoke tests                               │
│ - Deploy to production                          │
│ - Monitor for issues                            │
└─────────────┬───────────────────────────────────┘
              │
              ▼
┌─────────────────────────────────────────────────┐
│ Next Domain OR Evolutions Phase                 │
└─────────────────────────────────────────────────┘
```

**Persona Sequence:**
1. **Lead** (`/lead`): Plans implementation approach for domain
2. **Coding** (`/code`): Implements the migration
3. **Review** (`/review`): Validates quality and correctness
4. **Lead** (`/lead`): Makes ship/no-ship decision (gate)
5. **DevOps** (`/devops`): Deploys if approved
6. Repeat for next domain

**Success Criteria Per Domain:**
- [ ] All endpoints in domain migrated
- [ ] Test suite 100% green
- [ ] API contracts match original exactly
- [ ] Performance meets or exceeds baseline
- [ ] No regressions in other domains
- [ ] Lead approval to ship

---

### Phase 5: Evolutions & Enhancements

**Objective:** After migration complete, add improvements

**Activate:** Product → Lead → Coding → Review

**Approach:**
- Now that feature parity achieved, safe to evolve
- Product agent validates which enhancements add value
- Lead designs architecture improvements
- Coding implements, Review validates

**Examples of Evolutions:**
- Performance optimizations
- Better error handling
- New features not in original
- UX improvements
- Security hardening
- API improvements (better contracts, versioning)

---

## Persona Interaction Pattern

### Primary Flow (90% of work)

**Domain Migration Loop:**
```
Lead (plan) → Coding (implement) → Review (validate) → Lead (ship decision)
└─────────────────┬─────────────────────────┘
                  │
                  └──→ Repeat for each domain
```

### Supporting Flows

**When stuck or need research:**
```
Coding/Lead → Researcher (investigate) → Coding/Lead (continue)
```

**When defining new features (evolutions phase):**
```
Product (validate need) → Lead (design) → Coding (implement) → Review (validate)
```

**When deploying:**
```
Lead (approve) → DevOps (deploy) → Monitor
```

---

## Quality Gates

**Gate 1: Discovery Complete**
- [ ] Architecture map approved by lead
- [ ] All API contracts documented
- [ ] Dependency graph validated
- **Decision:** Proceed to test suite development?

**Gate 2: Test Suite Ready**
- [ ] 100% endpoint coverage achieved
- [ ] Tests green against current system
- [ ] Performance baselines established
- **Decision:** Proceed to migration?

**Gate 3: Per-Domain Migration**
- [ ] All domain endpoints migrated
- [ ] Tests green (no regressions)
- [ ] Lead approval obtained
- **Decision:** Ship this domain?

**Gate 4: Full Migration Complete**
- [ ] All domains migrated and shipped
- [ ] Full system tests green
- [ ] Performance validated
- **Decision:** Decommission old system?

---

## Key Principles for Migrations

### 1. Understand Before Changing
- Never start coding without complete discovery
- Reverse engineer existing system thoroughly
- Document implicit behaviors (they're features!)

### 2. Test Coverage is Safety Net
- Tests written BEFORE migration starts
- Tests run against old system first (establish baseline)
- Tests validate new system (prove equivalence)

### 3. Logical Dependency Order
- Login before features requiring authentication
- Database schema before features using it
- Shared utilities before features using them

### 4. Small Slices, Tight Loops
- Domain at a time, not big-bang migration
- Coding → Review → Lead loop is FAST (hours, not days)
- Ship early, ship often, get feedback

### 5. No Regressions Allowed
- Every commit keeps tests green
- Performance must meet baseline
- API contracts must match (unless explicitly changing)

### 6. Lead Approval Before Shipping
- Lead reviews BEFORE domain goes to production
- Lead ensures quality, completeness, safety
- Lead makes final ship/no-ship decision

---

## Common Pitfalls to Avoid

❌ **Starting coding before discovery complete**
- Risk: Miss edge cases, have to rewrite later
- Fix: Complete discovery phase, get lead approval first

❌ **Skipping test suite development**
- Risk: No safety net, regressions undetected
- Fix: Write tests against old system before migrating

❌ **Big-bang migration (all at once)**
- Risk: Hard to debug, all-or-nothing, high risk
- Fix: Slice into domains, migrate incrementally

❌ **Ignoring dependencies**
- Risk: Migrate feature before its dependency, breaks
- Fix: Create dependency graph, respect order

❌ **Shipping without lead review**
- Risk: Quality issues, missed requirements, regressions
- Fix: Lead gate before every domain ships

❌ **Replicating technical debt**
- Risk: Migrate bugs and anti-patterns to new system
- Fix: Discovery identifies debt, evolutions fix it

---

## Success Metrics

**Completeness:**
- [ ] Feature parity: 100% of endpoints migrated
- [ ] Test coverage: 100% of tests green
- [ ] Documentation: All domains documented

**Quality:**
- [ ] Zero regressions from old system
- [ ] Performance meets or exceeds baseline
- [ ] Code quality meets standards

**Process:**
- [ ] Every domain passed lead gate
- [ ] All phases completed in order
- [ ] Evolutions planned for post-migration

---

## Example: Java Spring → Node.js/TypeScript Migration

### Phase 1: Discovery
- Map all REST endpoints (50 endpoints across 8 controllers)
- Document database schema (PostgreSQL, 25 tables)
- Extract business logic from services
- Document Spring Security auth flow

### Phase 2: Test Suite
- Write integration tests for all 50 endpoints
- Test database operations
- Test authentication flows
- Baseline: API response times < 200ms

### Phase 3: Slicing
- Domain 1: Auth (login, logout, token refresh)
- Domain 2: Users (profile, settings)
- Domain 3: Products (catalog, search)
- Domain 4: Orders (cart, checkout, history)
- Domain 5: Admin (dashboard, reports)

### Phase 4: Migration Loop
```
Domain 1 (Auth):
  Lead: Design JWT implementation in Node
  Coding: Implement auth endpoints
  Review: Validate token flow, security
  Lead: Approve, ship to staging
  DevOps: Deploy, monitor

Domain 2 (Users):
  Lead: Design user service architecture
  Coding: Implement user endpoints
  Review: Validate business logic
  Lead: Approve, ship
  ...repeat
```

### Phase 5: Evolutions
- Add rate limiting (not in original)
- Improve error messages (better than original)
- Add request tracing (observability)
- Performance optimizations

**Result:** 50 endpoints migrated over 6 weeks, zero regressions, 20% performance improvement

---

## Template Checklist

Use this checklist when starting a new migration project:

**Setup:**
- [ ] Copy this methodology to project `.claude/METHODOLOGY.md`
- [ ] Customize for specific migration (languages, frameworks)
- [ ] Define success criteria
- [ ] Identify stakeholders

**Phase 1: Discovery**
- [ ] Create `docs/architecture/` for discovery docs
- [ ] Activate researcher agent (`/research`)
- [ ] Map all endpoints, components, dependencies
- [ ] Lead reviews and approves discovery

**Phase 2: Test Suite**
- [ ] Create `tests/integration/` for endpoint tests
- [ ] Activate coding agent in test mode (`/code`)
- [ ] Achieve 100% endpoint coverage
- [ ] Establish performance baselines

**Phase 3: Planning**
- [ ] Create `docs/migration-plan.md`
- [ ] Activate lead agent (`/lead`)
- [ ] Define AMUs and domains
- [ ] Create dependency-respecting order

**Phase 4: Migrate**
- [ ] For each domain: Lead → Coding → Review → Lead
- [ ] Keep tests green always
- [ ] Get lead approval before shipping
- [ ] Deploy via DevOps agent

**Phase 5: Evolve**
- [ ] Activate product agent to validate enhancements
- [ ] Continue Lead → Coding → Review loop
- [ ] Add improvements beyond original

---

## References

- Domain-Driven Design (for domain slicing)
- Strangler Fig Pattern (incremental migration)
- Test-Driven Development (test coverage first)
- Continuous Integration (keep tests green)

---

**Last Updated:** 2026-01-03
**Maintained By:** Lead Agent
**Version:** 1.0
