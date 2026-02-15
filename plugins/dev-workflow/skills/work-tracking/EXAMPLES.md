# Work Tracking Examples

This file contains extensive examples of properly filled work files across different scenarios.

---

## Example 1: Bug Fix

### Work File: `20250115103000_fix_auth_token_leak.md`

```markdown
# Fix Auth Token Leak in Memory

## Status: in_progress

## Context
Authentication tokens are being stored in memory without proper cleanup after user logout. This causes memory leaks and potential security issues as old tokens remain accessible. The issue was discovered through memory profiling which showed growing token caches.

## Value Proposition
- Prevents memory leaks from accumulated tokens
- Improves security by properly invalidating old tokens
- Reduces memory footprint over application lifetime
- Aligns with security best practices for token management

## Alternatives considered (with trade-offs)
- **WeakMap for automatic GC**: Simpler implementation, but tokens could persist longer than needed if references exist elsewhere
- **Manual cleanup on logout only**: Easy to implement, but tokens from expired sessions would still leak
- **TTL-based cache with periodic cleanup** (chosen): Predictable cleanup timing, works for all sessions including abandoned ones, small overhead acceptable

## Todos
- [ ] Add TTL-based token cache implementation
  - [ ] Create TokenCache class with TTL support
  - [ ] Add periodic cleanup task (every 5 minutes)
- [ ] Update token storage to use new cache
- [ ] Implement cleanup on logout
- [ ] Add unit tests for token expiration
- [ ] Add integration test for memory leak prevention
- [ ] Update auth module documentation

## Acceptance Criteria
- Tokens are automatically removed from cache after TTL expires (default 30 minutes)
- Memory usage stabilizes after repeated login/logout cycles (verified with heap snapshots)
- Unit tests cover 90%+ of token cache functionality
- All existing auth tests still pass
- Documentation updated with token lifecycle details

## Notes
Default TTL of 30 minutes chosen based on typical session duration. This is configurable via env var `AUTH_TOKEN_TTL_MS` if needed for specific deployments.
```

---

## Example 2: New Feature

### Work File: `20250115114500_add_pdf_watermark_support.md`

```markdown
# Add PDF Watermark Support

## Status: in_progress

## Context
Users need to add watermarks to generated PDFs for branding and document identification purposes. Currently, the PDF generator supports text and images but has no watermark capability. This is frequently requested by enterprise customers who need to mark confidential documents.

## Value Proposition
- Enables brand protection through visible watermarks
- Supports document classification (CONFIDENTIAL, DRAFT, etc.)
- Customizable appearance (text, image, opacity, rotation)
- No external dependencies - uses existing PDF library

## Alternatives considered (with trade-offs)
- **Pre-render watermark images**: Simple to implement, but not customizable and increases storage needs
- **Post-processing with external tool** (e.g., pdftk): Flexible, but adds external dependency and processing time
- **Native PDF watermark rendering** (chosen): Full customization, no external dependencies, performant, leverages existing PDF library capabilities

## Todos
- [ ] Design watermark configuration schema
  - [ ] Define watermark types (text, image)
  - [ ] Define positioning options (center, corner, tiled)
  - [ ] Define style options (opacity, rotation, font)
- [ ] Implement watermark renderer
  - [ ] Text watermark with custom font and rotation
  - [ ] Image watermark with scaling and opacity
  - [ ] Tiled pattern option for full-page coverage
- [ ] Integrate watermark into PDF generation pipeline
- [ ] Add watermark API endpoints
  - [ ] POST /pdf/watermark/config
  - [ ] GET /pdf/watermark/config
- [ ] Add CLI options for watermarking
- [ ] Write comprehensive tests
  - [ ] Unit tests for each watermark type
  - [ ] Integration tests for full pipeline
  - [ ] Visual regression tests for output PDFs
- [ ] Update documentation with examples

## Acceptance Criteria
- Text watermarks support custom text, font, size, color, opacity, rotation
- Image watermarks support PNG/JPEG, scaling, opacity, rotation
- Tiled mode covers entire page with configurable spacing
- Watermarks appear on all pages or specified page ranges
- Performance impact < 100ms per page for typical watermarks
- All tests pass including visual regression tests
- API documentation includes request/response examples
- CLI help text includes watermark usage examples

## Notes
Watermark rendering happens after content but before final PDF assembly, ensuring watermarks don't interfere with text selection. The PDF library's layer support is used to keep watermarks separate from content.
```

---

## Example 3: Refactoring

### Work File: `20250115130000_refactor_user_service_layer.md`

```markdown
# Refactor User Service Layer

## Status: in_progress

## Context
The user service has grown organically over 2 years and now has 4000+ lines in a single file with mixed concerns (validation, business logic, data access, notifications). This makes the code hard to understand, test, and maintain. Recent changes have introduced bugs due to unclear dependencies.

## Value Proposition
- Improved code organization and separation of concerns
- Easier testing through smaller, focused modules
- Better onboarding for new developers
- Reduced bug surface area through clearer interfaces
- Foundation for future features (user preferences, audit log)

## Alternatives considered (with trade-offs)
- **Extract to microservice**: Cleanest separation, but adds network overhead, deployment complexity, and data consistency challenges
- **Vertical slicing by feature**: Good for feature teams, but would duplicate common logic and complicate sharing
- **Layered extraction within module** (chosen): Maintains monolith simplicity while improving organization, no performance impact, easier to reason about data flow

## Todos
- [ ] Map current dependencies and interactions
  - [ ] Document all public methods and their callers
  - [ ] Identify shared utilities vs domain-specific logic
- [ ] Design new module structure
  - [ ] UserRepository (data access)
  - [ ] UserValidator (input validation)
  - [ ] UserDomain (business logic)
  - [ ] UserNotifier (side effects)
- [ ] Extract UserRepository layer
- [ ] Extract UserValidator layer
- [ ] Extract UserDomain layer
- [ ] Extract UserNotifier layer
- [ ] Update all callers to use new interfaces
- [ ] Add integration tests for cross-layer flows
- [ ] Update service documentation

## Acceptance Criteria
- Each module is under 500 lines
- No circular dependencies between modules
- All existing tests pass without modification (black-box compatible)
- Integration tests cover main user flows (create, update, delete, authenticate)
- Module documentation describes responsibilities and interfaces
- Performance benchmarks show no regression
- Code coverage remains above 80%

## Notes
The refactoring maintains backward compatibility through facade methods in UserService. These can be deprecated gradually. The new structure follows the Repository pattern for data access and Service layer pattern for business logic.
```

---

## Example 4: Performance Optimization

### Work File: `20250115140000_optimize_database_query_performance.md`

```markdown
# Optimize Database Query Performance

## Status: in_progress

## Context
The dashboard loading time has increased from 200ms to 2.5s over the past 3 months. Analysis shows the main query joins 8 tables and returns 50K rows, most of which are filtered client-side. The N+1 query problem is also present in related data fetching.

## Value Proposition
- Reduce dashboard load time to < 500ms
- Lower database CPU usage by ~70%
- Improve scalability for growing data volume
- Better user experience, especially for power users

## Alternatives considered (with trade-offs)
- **Add database indexes only**: Quick win, but doesn't solve N+1 or client-side filtering
- **Implement query result caching**: Fast for repeated queries, but adds staleness and complexity
- **Denormalize data**: Very fast reads, but makes updates complex and risks inconsistency
- **Query optimization + selective indexes** (chosen): Addresses root cause, maintains data integrity, simpler architecture, 80% of benefit for 20% of effort

## Todos
- [ ] Profile and identify slow queries
  - [ ] Use EXPLAIN ANALYZE on main queries
  - [ ] Identify missing indexes
  - [ ] Identify N+1 query patterns
- [ ] Optimize main dashboard query
  - [ ] Move filtering to database WHERE clause
  - [ ] Add pagination (LIMIT/OFFSET or cursor)
  - [ ] Select only required columns
- [ ] Fix N+1 queries
  - [ ] Use JOIN for related data
  - [ ] Implement dataloader pattern for batched fetching
- [ ] Add targeted indexes
  - [ ] Composite index on (user_id, created_at)
  - [ ] Covering index for common filter combinations
- [ ] Add query performance monitoring
- [ ] Load test to verify improvements
- [ ] Document query optimization patterns

## Acceptance Criteria
- Dashboard loads in < 500ms for typical user (p95)
- Database query count reduced by >60%
- Database CPU usage reduced by >70% under load
- EXPLAIN ANALYZE shows index usage for all queries
- Load test supports 100 concurrent dashboard loads
- Query performance metrics visible in monitoring dashboard
- Developer documentation includes query optimization guidelines

## Notes
Focus on p95 latency rather than average, as outliers hurt user experience most. The dataloader pattern is implemented once and reused across all batch queries. Indexes are added incrementally with monitoring to verify they're being used.
```

---

## Example 5: Security Fix

### Work File: `20250115150000_fix_sql_injection_vulnerability.md`

```markdown
# Fix SQL Injection Vulnerability in Search

## Status: in_progress

## Context
Security audit identified a SQL injection vulnerability in the search feature. User input is concatenated directly into SQL queries without parameterization. This could allow attackers to execute arbitrary SQL commands, potentially accessing or deleting sensitive data.

## Value Proposition
- **Critical security fix** - prevents SQL injection attacks
- Protects user data from unauthorized access/deletion
- Meets compliance requirements (SOC2, PCI-DSS)
- Aligns with secure coding standards

## Alternatives considered (with trade-offs)
- **Input validation/sanitization only**: Quick but unreliable - attackers can bypass validation
- **ORM with automatic escaping**: Good but requires significant refactoring of existing code
- **Parameterized queries** (chosen): Industry best practice, minimal code changes, provably secure, works with existing database layer

## Todos
- [ ] Audit all code locations with SQL string concatenation
  - [ ] Search for `+ "`, `concat(`, `sprintf(` in SQL contexts
  - [ ] Check raw query execution paths
- [ ] Identify all vulnerable query patterns
- [ ] Replace with parameterized queries
  - [ ] Update search query to use $1, $2 placeholders
  - [ ] Update filter query to use parameterized form
  - [ ] Update sort order to use whitelist (not user input)
- [ ] Add input validation as defense in depth
  - [ ] Validate input length limits
  - [ ] Validate input character sets
- [ ] Add security tests
  - [ ] Test with SQL injection payloads (e.g., "'; DROP TABLE--")
  - [ ] Test with UNION-based injection attempts
  - [ ] Test with time-based blind injection
- [ ] Run full regression test suite
- [ ] Document secure query patterns

## Acceptance Criteria
- ALL SQL queries use parameterized placeholders ($1, $2 or ?)
- No string concatenation in SQL query construction
- Input validation passes good inputs and blocks bad inputs
- Security tests pass with 100+ injection payloads
- All existing functional tests pass
- Code review confirms no new vulnerabilities introduced
- Security documentation updated with query patterns
- Fix deployed to production within 24 hours (critical severity)

## Notes
This is a **critical security issue** (CVSS 9.8). Time to deployment is prioritized over perfect code organization. A follow-up task can refactor the query layer for better structure. All developers should be notified about the vulnerability pattern to prevent recurrence.
```

---

## Example 6: Documentation

### Work File: `20250115160000_document_api_authentication_flow.md`

```markdown
# Document API Authentication Flow

## Status: in_progress

## Context
The API authentication system is poorly documented. New developers struggle to understand how tokens work, how to refresh them, and how to handle errors. This leads to repeated questions in Slack and bugs in client implementations.

## Value Proposition
- Faster onboarding for new developers
- Reduced support burden
- Fewer authentication-related bugs
- Better integration experience for external API users

## Alternatives considered (with trade-offs)
- **Video walkthrough only**: Engaging but hard to reference and update
- **Inline code comments only**: Always in sync but scattered and incomplete picture
- **Comprehensive written docs + diagrams** (chosen): Searchable, referenceable, complete picture, can include code examples and diagrams

## Todos
- [ ] Document authentication architecture overview
  - [ ] Create Mermaid diagram showing auth flow
  - [ ] Describe token types and lifecycle
  - [ ] Explain refresh token mechanism
- [ ] Document API endpoints
  - [ ] POST /auth/login
  - [ ] POST /auth/refresh
  - [ ] POST /auth/logout
  - [ ] GET /auth/verify
- [ ] Add code examples
  - [ ] JavaScript/TypeScript client example
  - [ ] Python client example
  - [ ] curl examples for each endpoint
- [ ] Document error responses
  - [ ] Invalid credentials
  - [ ] Expired token
  - [ ] Invalid refresh token
- [ ] Document security best practices
  - [ ] Token storage recommendations
  - [ ] HTTPS requirement
  - [ ] Token rotation guidance
- [ ] Create troubleshooting guide
  - [ ] Common errors and solutions
  - [ ] Debugging tips
- [ ] Review with support team for clarity
- [ ] Publish to documentation site

## Acceptance Criteria
- Authentication flow diagram shows all steps and decision points
- Each endpoint has: description, request, response, error cases, code example
- Code examples are tested and actually work
- Troubleshooting guide covers top 10 most common support questions
- Documentation passes review by support team
- New developer can implement auth in < 1 hour using docs
- Link to docs added to API README

## Notes
Documentation is written in AsciiDoc to match the existing docs site. Diagrams use Mermaid for easy version control. Code examples are automatically tested using the examples test suite to ensure they stay current.
```

---

## Quick Reference: Acceptance Criteria Patterns

### For Bug Fixes:
- Reproduces the bug (test case included)
- Fix resolves the issue (test now passes)
- No regressions (all existing tests pass)
- Edge cases covered

### For Features:
- Core functionality works as specified
- API/UI is intuitive and documented
- Error cases are handled gracefully
- Performance meets requirements
- Tests cover happy path + edge cases

### For Refactoring:
- Behavior unchanged (tests pass)
- Code is simpler/more maintainable
- No performance regression
- Documentation updated

### For Security:
- Vulnerability eliminated
- Attack patterns tested and blocked
- No new vulnerabilities introduced
- Security review completed
- Incident report filed (if production issue)

### For Performance:
- Meets specific performance metric (e.g., < 500ms)
- Load test validates under realistic traffic
- No regression in functionality
- Monitoring/alerting in place
- Baseline documented for future comparison
