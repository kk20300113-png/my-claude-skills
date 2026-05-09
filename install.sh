#!/usr/bin/env bash
# my-claude-skills — installer
# Usage: bash install.sh
# Copies all skills into ~/.claude/skills/
# Clone first: git clone https://github.com/kk20300113-png/my-claude-skills.git && cd my-claude-skills && bash install.sh

set -e

SKILLS_DIR="${HOME}/.claude/skills"
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo ""
echo "my-claude-skills — installing to ${SKILLS_DIR}"
echo ""

mkdir -p "${SKILLS_DIR}"

# Install shared components if present
if [ -d "${REPO_DIR}/shared" ]; then
  echo "Installing shared components..."
  mkdir -p "${SKILLS_DIR}/shared"
  cp -r "${REPO_DIR}/shared/." "${SKILLS_DIR}/shared/"
  echo "  shared/"
fi

# Install each skill directory (skip non-skill items)
SKIP=("shared" ".git" ".github" "node_modules")
echo "Installing skills..."

for dir in "${REPO_DIR}"/*/; do
  skill=$(basename "${dir}")
  skip=false
  for s in "${SKIP[@]}"; do
    [ "${skill}" = "${s}" ] && skip=true && break
  done
  ${skip} && continue
  [ ! -f "${dir}SKILL.md" ] && continue

  mkdir -p "${SKILLS_DIR}/${skill}"
  cp -r "${dir}." "${SKILLS_DIR}/${skill}/"
  echo "  /${skill}"
done

echo ""
echo "Install complete. Restart Claude Code for all skills to load."
echo ""
echo "Quick-start:"
echo "  /brainstorming              — design-before-code gate"
echo "  /quick-development          — fast scoped builds (<5 files)"
echo "  /systematic-debugging       — structured debug methodology"
echo "  /dispatching-parallel-agents — multi-agent orchestration"
echo "  /writing-plans              — implementation plan authoring"
echo ""
echo "Optional dependencies (install separately):"
echo "  GSD:       npx get-shit-done-cc --global"
echo "  GStack:    /gstack-upgrade"
echo "  Superpowers: /using-superpowers"
echo ""
