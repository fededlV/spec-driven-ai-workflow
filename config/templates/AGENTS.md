# Project Agent Rules (`AGENTS.md`)

> This file defines project-specific commands, architecture boundaries, conventions, and quality gates.  
> Both the Specification Agent and Build Agent consult this contract.

## Commands

Fill in the exact commands used by the Build Agent (Claude Code / Test Runner) for verification and builds:

- **Install / Setup:** `<e.g., npm ci | uv sync | go mod download | cargo build>`
- **Test (All):** `<e.g., npm test | pytest | go test ./... | cargo test>`
- **Test (Single / Focused):** `<e.g., npx vitest run <path> | pytest <path> -k <test>>`
- **Typecheck:** `<e.g., npx tsc --noEmit | mypy src | cargo check>`
- **Lint / Format Check:** `<e.g., npm run lint | ruff check . | golangci-lint run>`
- **Build:** `<e.g., npm run build | go build ./... | cargo build --release>`

## Architecture & Structure

Document core directories and architectural boundaries:

- `src/` or `app/`: Core application and domain logic
- `tests/`: Automated unit, integration, and end-to-end test suites
- `specs/`: Change specifications (`specs/<change>/{spec.md,tasks.md,handoff.md}`)
- `docs/adr/`: Architectural Decision Records (`NNNN-<slug>.md`)
- `GLOSSARY.md`: Ubiquitous domain terminology

## Style & Engineering Conventions

- **Design:** Enforce SOLID, separation of concerns, and explicit module boundaries.
- **Robustness:** Validate boundary inputs; fail fast with typed/structured errors; no swallowed exceptions.
- **Simplicity:** Reject speculative abstraction (YAGNI); prefer simple, explicit code over cleverness.
- **Stack Conventions:** `<e.g., strict TypeScript, Pydantic v2 models, hexagonal architecture, rust idioms>`

## Testing & Quality Gates

- **Default:** Test-Driven Development (Red -> Green -> Refactor) using commands in `## Commands`.
- **Behavioral:** Test observable behavior through public interfaces, never private internals.
- **Coverage:** Cover happy paths, boundary edge cases, and failure modes.
- **Isolation:** Never hit live external network endpoints or production databases in tests; use deterministic fixtures or testcontainers.

## Operational Boundaries

- **Always:**
  - Require `specs/<change>/spec.md` with `Status: Approved` before writing implementation code.
  - Run focused tests and lint/typecheck before committing each task slice.
  - Use Conventional Commits (`feat:`, `fix:`, `refactor:`, `test:`, `docs:`, `chore:`) without AI attribution lines.
  - Limit commit slices to roughly `<= 400` changed lines.
- **Ask First:**
  - Adding third-party dependencies or bumping major versions.
  - Changing database schemas, public API contracts, or authentication flows.
  - Modifying CI/CD pipelines, Dockerfiles, or environment variables.
- **Never:**
  - Commit secrets, `.env` files, API keys, or credentials.
  - Bypass or disable tests, typechecks, or the `Status: Approved` spec gate.
  - Mutate production data without an explicit migration and rollback plan.

## Definition of Done (DoD)

- [ ] All acceptance criteria (`S#`) in `specs/<change>/spec.md` verified.
- [ ] All `Test`, `Typecheck`, `Lint`, and `Build` commands in `## Commands` pass with zero errors.
- [ ] Edge cases, error paths, and failure modes covered by tests.
- [ ] `specs/<change>/tasks.md` and `specs/<change>/handoff.md` updated with final status and commits.
- [ ] Architectural decisions recorded in `docs/adr/` and saved to persistent memory.
