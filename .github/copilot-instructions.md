# Claude Code Skills — Copilot Instructions

This workspace uses Claude Code with 185+ skills at `~/.claude/skills/`.
Invoke skills with `/skill-name` in Claude Code (terminal or VS Code extension).

## Development Workflow Skills

| Skill | When to use |
|---|---|
| `/brainstorming` | Design-before-code gate. Do NOT write code until design is approved. |
| `/quick-development` | Fast scoped builds: <5 files, <3 tasks. Routes to standard if scope grows. |
| `/standard-development` | Mid-size features with planning checkpoint. |
| `/full-development` | Large features: full PRD + architecture + task list before coding. |
| `/new-development` | Greenfield projects from scratch. |
| `/writing-plans` | Write a structured implementation plan before starting. |
| `/executing-plans` | Run an already-approved plan step-by-step. |

## Debugging Skills

| Skill | When to use |
|---|---|
| `/diagnose` | Structured debug: Reproduce → Minimize → Hypothesize → Instrument → Fix → Regression-test |
| `/systematic-debugging` | Deep debugging with instrumentation and hypothesis tracking. |
| `/grill-with-docs` | Validate your fix/approach against official library docs before committing. |

## Quality & Review Skills

| Skill | When to use |
|---|---|
| `/requesting-code-review` | Prepare and submit code for structured review. |
| `/receiving-code-review` | Process incoming review feedback methodically. |
| `/verification-before-completion` | Gate to run before marking any task done. |
| `/test-driven-development` | Enforce RED-GREEN-REFACTOR. Write failing test first. |

## Agent Orchestration Skills

| Skill | When to use |
|---|---|
| `/dispatching-parallel-agents` | Run multiple agents in parallel for independent sub-tasks. |
| `/subagent-driven-development` | Delegate implementation to specialized sub-agents. |
| `/using-git-worktrees` | Work on multiple branches in parallel via git worktrees. |
| `/finishing-a-development-branch` | Branch completion checklist before PR. |

## Architecture Skills

| Skill | When to use |
|---|---|
| `/improve-codebase-architecture` | Analyze and improve architecture of an existing codebase. |
| `/prototype` | Build a quick proof of concept before full implementation. |
| `/zoom-out` | Step back and assess the big picture before diving in. |

## Utility Skills

| Skill | When to use |
|---|---|
| `/triage` | Assess and prioritize a backlog of issues or tasks. |
| `/to-prd` | Convert a feature request into a Product Requirements Document. |
| `/to-issues` | Break a feature or PRD into GitHub issues. |
| `/using-superpowers` | Overview of all superpowers skills and when to use them. |
| `/writing-skills` | Learn how to author new Claude Code skills (TDD-based). |

---

Skills repo: https://github.com/kk20300113-png/my-claude-skills
Install: `git clone https://github.com/kk20300113-png/my-claude-skills.git && cd my-claude-skills && bash install.sh`
