# Specification: `<Change Name>`

- **Change ID:** `<change-slug>`
- **Status:** `Draft` <!-- Change to `Approved` ONLY after explicit human sign-off -->
- **Approved By:** `<pending>`
- **Approval Date:** `<YYYY-MM-DD | pending>`
- **Author Agent:** Antigravity (Gemini)

---

## 1. Objective

State the problem being solved, the target user/system outcome, and why it is needed now.

## 2. Assumptions

- `A1:` <Explicit assumption validated during interview or flagged for verification>
- `A2:` <Explicit assumption>

## 3. Tech Stack & Commands

Reference or inherit from the project's `AGENTS.md` (`## Commands`):

- **Runtime / Stack:** `<e.g., TypeScript / Node 22 / FastAPI / Go 1.24>`
- **Test Command:** `<from AGENTS.md>`
- **Lint / Typecheck Command:** `<from AGENTS.md>`

## 4. Requirements & Acceptance Criteria

Every requirement must have deterministic, behavioral `Given / When / Then` acceptance criteria:

### S1: <High-level requirement name>
- **Given:** <Initial state / precondition>
- **When:** <Action or event triggers>
- **Then:** <Observable deterministic result>
- **Error Path:** <Expected error condition and structured output>

### S2: <Requirement name>
- **Given:** <Precondition>
- **When:** <Action>
- **Then:** <Result>

## 5. Invariants & Non-Functional Requirements

- **Invariants:** <System properties that must never be violated>
- **Performance / Timeouts:** <Bounded limits>
- **Security:** <Input validation, secrets handling, permissions>

## 6. Boundaries & Out of Scope

- <What this change explicitly does NOT include>
- <Deferred features or future considerations>

## 7. Open Questions

- [ ] `Q1:` <Open question needing human decision before approval>
