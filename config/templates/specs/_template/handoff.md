# Handoff State: `<Change Name>`

- **Change ID:** `<change-slug>`
- **Active Agent:** Antigravity (Gemini) -> Claude Code
- **Date:** `<YYYY-MM-DD>`

---

## 1. Specification Handoff (Antigravity -> Claude Code)

- [ ] Requirements aligned via `interview-me`
- [ ] `spec.md` drafted with verifiable acceptance criteria (`S#`)
- [ ] `tasks.md` sliced into dependency-ordered vertical units (`T#`)
- [ ] Human approval obtained (`Status: Approved` in `spec.md`)

## 2. Spec-Challenge Notes (Claude Code Ground Phase)

Claude Code must audit `spec.md` and `tasks.md` before coding:

- **Contradictions / Gaps:** <None detected | list findings>
- **Boundary / Edge Cases Identified:** <Notes>
- **Resolved Clarifications:** <Notes>

## 3. Build Progress (Claude Code Implementation)

| Task | Status | Verified Commands | Commit SHA | Notes |
|---|---|---|---|---|
| `T1` | pending | `<command>` | - | - |
| `T2` | pending | `<command>` | - | - |
| `T3` | pending | `<command>` | - | - |

## 4. Post-Build Verification & Antigravity Review (Optional)

- [ ] All `S#` acceptance criteria confirmed passing in code and tests
- [ ] Git diff inspected against `spec.md` (no scope drift or unaddressed criteria)
- [ ] Definition of Done verified
- [ ] Durable decisions recorded in `docs/adr/` and saved to persistent memory
