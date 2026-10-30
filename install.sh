#!/usr/bin/env bash
# ==============================================================================
# Installer for Spec-Driven AI Development Workflow
# https://github.com/your-username/spec-driven-ai-workflow
# ==============================================================================

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/ai-workflow"
BIN_DIR="${HOME}/.local/bin"

color_green="\033[0;32m"
color_blue="\033[0;34m"
color_yellow="\033[1;33m"
color_red="\033[0;31m"
color_bold="\033[1m"
color_reset="\033[0m"

printf "${color_bold}====================================================${color_reset}\n"
printf "${color_bold}  Spec-Driven AI Workflow — Installer${color_reset}\n"
printf "${color_bold}====================================================${color_reset}\n\n"

# 1. Check prerequisites
printf "${color_blue}ℹ Checking prerequisites...${color_reset}\n"
for cmd in bash git sed grep; do
    if ! command -v "$cmd" >/dev/null 2>&1; then
        printf "${color_red}✗ Required command '$cmd' is missing.${color_reset}\n" >&2
        exit 1
    fi
done
printf "${color_green}✓ Prerequisites satisfied.${color_reset}\n\n"

# 2. Install templates and global reference
printf "${color_blue}ℹ Installing configuration and templates to:${color_reset} %s\n" "$CONFIG_DIR"
mkdir -p "$CONFIG_DIR/templates/docs/adr"
mkdir -p "$CONFIG_DIR/templates/specs/_template"

cp "$SCRIPT_DIR/config/GLOBAL_RULES.md" "$CONFIG_DIR/GLOBAL_RULES.md"
cp "$SCRIPT_DIR/config/templates/AGENTS.md" "$CONFIG_DIR/templates/"
cp "$SCRIPT_DIR/config/templates/CLAUDE.md" "$CONFIG_DIR/templates/"
cp "$SCRIPT_DIR/config/templates/GEMINI.md" "$CONFIG_DIR/templates/"
cp "$SCRIPT_DIR/config/templates/GLOSSARY.md" "$CONFIG_DIR/templates/"
cp "$SCRIPT_DIR/config/templates/docs/adr/0000-template.md" "$CONFIG_DIR/templates/docs/adr/"
cp "$SCRIPT_DIR/config/templates/specs/_template/"* "$CONFIG_DIR/templates/specs/_template/"

printf "${color_green}✓ Configuration and templates installed.${color_reset}\n\n"

# 3. Install CLI binary
printf "${color_blue}ℹ Installing CLI tool to:${color_reset} %s/ai-workflow\n" "$BIN_DIR"
mkdir -p "$BIN_DIR"
cp "$SCRIPT_DIR/bin/ai-workflow" "$BIN_DIR/ai-workflow"
chmod +x "$BIN_DIR/ai-workflow"
printf "${color_green}✓ CLI tool installed.${color_reset}\n\n"

# 4. Check PATH
if [[ ":$PATH:" != *":$BIN_DIR:"* ]]; then
    printf "${color_yellow}⚠ Notice: %s is not in your PATH.${color_reset}\n" "$BIN_DIR"
    printf "  Add the following line to your ~/.bashrc or ~/.zshrc:\n"
    printf "    export PATH=\"\$HOME/.local/bin:\$PATH\"\n\n"
else
    printf "${color_green}✓ %s is already in your PATH.${color_reset}\n\n" "$BIN_DIR"
fi

# 5. Agent Setup Guidance
printf "${color_bold}Setup Instructions for Your AI Agents:${color_reset}\n\n"
printf "1. ${color_bold}Claude Code:${color_reset}\n"
printf "   Ensure ~/.claude/CLAUDE.md includes project scoping and references AGENTS.md.\n"
printf "2. ${color_bold}Antigravity (Gemini):${color_reset}\n"
printf "   Ensure ~/.gemini/GEMINI.md allows default coding while respecting project GEMINI.md.\n"
printf "3. ${color_bold}Other AI Assistants (Cursor, Codex, Windsurf):${color_reset}\n"
printf "   See docs/ADAPTING_OTHER_TOOLS.md for how to adapt the AGENTS.md and spec gates.\n\n"

printf "${color_green}${color_bold}Installation successful!${color_reset} Run '${color_bold}ai-workflow help${color_reset}' to get started.\n"
