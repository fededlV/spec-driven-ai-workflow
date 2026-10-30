# Tasks & Slices: `<Change Name>`

- **Change ID:** `<change-slug>`
- **Specification:** [`spec.md`](./spec.md)
- **Status:** Pending Approval

---

## Task Breakdown (Dependency Ordered Vertical Slices)

Each slice must be bounded (`<= 400` changed lines), implementable in one TDD cycle, and verified before committing.

- [ ] **T1: <Initial vertical slice or domain foundation>**
  - **Covers:** `S1`
  - **Risk:** Tier 1 (Low) | Tier 2 (Medium) | Tier 3 (High)
  - **Target Files:** `<e.g., src/domain/entity.ts, tests/domain/entity.test.ts>`
  - **Verification:** `<Exact command from AGENTS.md, e.g., npm test path/to/test>`
  - **Commit:** pending

- [ ] **T2: <Core logic or integration slice>**
  - **Covers:** `S2`
  - **Risk:** Tier 1 | Tier 2 | Tier 3
  - **Target Files:** `<paths>`
  - **Verification:** `<command>`
  - **Commit:** pending

- [ ] **T3: <API / Presentation / End-to-end seam>**
  - **Covers:** `S1`, `S2`
  - **Risk:** Tier 1 | Tier 2 | Tier 3
  - **Target Files:** `<paths>`
  - **Verification:** `<command>`
  - **Commit:** pending
