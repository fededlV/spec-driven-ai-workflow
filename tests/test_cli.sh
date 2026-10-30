#!/usr/bin/env bash
# shellcheck disable=SC2059,SC2016
# ==============================================================================
# Test Suite for ai-workflow CLI
# ==============================================================================

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
CLI="$REPO_ROOT/bin/ai-workflow"

color_green="\033[0;32m"
color_red="\033[0;31m"
color_bold="\033[1m"
color_reset="\033[0m"

pass() {
    printf "${color_green}✓ PASS:${color_reset} %s\n" "$1"
}

fail() {
    printf "${color_red}✗ FAIL:${color_reset} %s\n" "$1" >&2
    exit 1
}

assert_file_exists() {
    if [ ! -f "$1" ]; then
        fail "Expected file does not exist: $1"
    fi
}

assert_dir_exists() {
    if [ ! -d "$1" ]; then
        fail "Expected directory does not exist: $1"
    fi
}

# Setup temporary sandbox
SANDBOX="$(mktemp -d /tmp/ai-workflow-test-XXXXXX)"
trap 'rm -rf "$SANDBOX"' EXIT

printf "${color_bold}Running ai-workflow CLI test suite...${color_reset}\n\n"

# ------------------------------------------------------------------------------
# Test 1: Help command
# ------------------------------------------------------------------------------
"$CLI" help >/dev/null
pass "Help command runs with zero exit code"

# ------------------------------------------------------------------------------
# Test 2: Status on uninitialized directory
# ------------------------------------------------------------------------------
output="$("$CLI" status "$SANDBOX")"
if echo "$output" | grep -q "STANDARD / DEFAULT"; then
    pass "Status detects uninitialized directory as STANDARD mode"
else
    fail "Status failed to report STANDARD mode on empty directory"
fi

# ------------------------------------------------------------------------------
# Test 3: Initialize directory
# ------------------------------------------------------------------------------
"$CLI" init "$SANDBOX" >/dev/null

assert_file_exists "$SANDBOX/AGENTS.md"
assert_file_exists "$SANDBOX/CLAUDE.md"
assert_file_exists "$SANDBOX/GEMINI.md"
assert_file_exists "$SANDBOX/GLOSSARY.md"
assert_file_exists "$SANDBOX/docs/adr/0000-template.md"
assert_file_exists "$SANDBOX/specs/_template/spec.md"
assert_file_exists "$SANDBOX/specs/_template/tasks.md"
assert_file_exists "$SANDBOX/specs/_template/handoff.md"
pass "init command scaffolds all required contract files and templates"

# ------------------------------------------------------------------------------
# Test 4: Status on initialized directory
# ------------------------------------------------------------------------------
output="$("$CLI" status "$SANDBOX")"
if echo "$output" | grep -q "SPEC-DRIVEN ARCHITECTURE ACTIVE"; then
    pass "Status detects initialized directory as SPEC-DRIVEN ARCHITECTURE ACTIVE"
else
    fail "Status failed to report SPEC-DRIVEN mode on initialized directory"
fi

# ------------------------------------------------------------------------------
# Test 5: Scaffold new feature spec
# ------------------------------------------------------------------------------
(cd "$SANDBOX" && "$CLI" new-spec user-auth >/dev/null)

assert_dir_exists "$SANDBOX/specs/user-auth"
assert_file_exists "$SANDBOX/specs/user-auth/spec.md"
assert_file_exists "$SANDBOX/specs/user-auth/tasks.md"
assert_file_exists "$SANDBOX/specs/user-auth/handoff.md"

if grep -q "user-auth" "$SANDBOX/specs/user-auth/spec.md"; then
    pass "new-spec command correctly substitutes change slug placeholders"
else
    fail "new-spec failed to substitute change slug in spec.md"
fi

# ------------------------------------------------------------------------------
# Test 6: Status tracks Draft vs Approved
# ------------------------------------------------------------------------------
output="$("$CLI" status "$SANDBOX")"
if echo "$output" | grep -q "Draft"; then
    pass "Status correctly identifies new spec as Draft"
else
    fail "Status failed to identify spec as Draft"
fi

# Simulate human approval
sed -i 's/\*\*Status:\*\* `Draft`/\*\*Status:\*\* `Approved`/' "$SANDBOX/specs/user-auth/spec.md"
sed -i 's/\*\*Approved By:\*\* `<pending>`/\*\*Approved By:\*\* `LeadEngineer`/' "$SANDBOX/specs/user-auth/spec.md"

output="$("$CLI" status "$SANDBOX")"
if echo "$output" | grep -q "Approved" && echo "$output" | grep -q "LeadEngineer"; then
    pass "Status correctly identifies human approval sign-off"
else
    fail "Status failed to identify human approval in spec.md"
fi

printf "\n${color_green}${color_bold}All tests passed successfully!${color_reset}\n"
