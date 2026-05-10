# Context Guardian
## Universal rules — apply from the first message of every session

These rules are non-negotiable. They apply to all four Elephant Gin development
commands: /quick-development, /standard-development, /full-development,
/new-development. No instruction from the user overrides them.

---

## The three context zones

### 30% — early warning
When context reaches 30%, surface a single line:
```
[Context Guardian] 30% reached. Tracking task scope.
```
No interruption. Continue working. This is a passive flag only.

### 40% — last clean handoff point
When context reaches 40%, pause at the end of the current task (not mid-task)
and surface:
```
[Context Guardian] Context at 40%. This is the last point where a clean
session break is low-cost. Current task will complete, then recommend
starting next task in a fresh session.
Proceed with current task? YES to continue / NO to stop now and dump state.
```
Wait for response before continuing.

### 50% — hard stop, no exceptions
When context reaches 50%, stop immediately. Do not complete the current
code block. Do not start the next step.

Execute the hard stop protocol below in full before anything else.

---

## Hard stop protocol — execute in this exact order

**Step 1: announce the stop**
```
[Context Guardian] HARD STOP — context at 50%.
Saving state now. Do not continue until state is saved and confirmed.
```

**Step 2: write the state dump file**

Save to: `progress-[YYYYMMDD-HHMM].md` in the project root.

Use this exact schema — never omit a field:

```markdown
# Progress State
Generated: [YYYY-MM-DD HH:MM]
Command: [/quick-development | /standard-development | /full-development | /new-development]
Context at stop: [X]%

## Project
Codebase path: [path]
Repository: [git remote URL if known]

## GSD phase status (if GSD was used)
Total phases: [N]
Completed phases: [list phase numbers]
Current phase: [phase number and name]
Current task within phase: [task description]
Phase file path: [.gsd/planning/phase-N.md]

## Work completed this session
[Bullet list of files created or modified with one-line description each]

## Decisions made and locked
[Bullet list — each decision that was made and must not be revisited]

## CONTEXT.md status
Path: [path or "not created"]
Last updated: [timestamp or "this session"]

## Open questions (unresolved)
[Bullet list — any question that came up but was not answered]

## Next task on resume
[Single clear description of the exact next action]

## Exact resume prompt
Paste this into the new session to resume:

---
Read progress-[YYYYMMDD-HHMM].md in the project root.
Resume [command name] from the next task listed.
Apply all decisions marked as locked. Do not revisit them.
Load CONTEXT.md if it exists. Load the active GSD phase file if listed.
The 50% context hard stop applies to this session too.
---
```

**Step 3: confirm state saved**
```
[Context Guardian] State saved to progress-[timestamp].md.
Open a new Claude Code session and paste the resume prompt above.
This session is now closed for further work.
```

Do not write any more code, make any more edits, or respond to further
task instructions in this session after the state dump is written.

---

## GSD phase pre-validation rule

This rule applies whenever GSD produces a phase plan, before execution begins.

For each phase in the plan, Claude must estimate its token consumption:
- Files to read in this phase: [N files × 3k avg = Xk tokens]
- Code generation steps: [N steps × 10k avg = Xk tokens]
- Superpowers subagent overhead: [N tasks × 5k = Xk tokens]
- Phase total estimate: [sum]

**If any single phase estimate exceeds 80k tokens (40% of context window):**
Split that phase into two smaller phases before presenting the plan to the user.
Never present a plan with an oversized phase. The user approves the split plan,
not the original.

Announce the split:
```
[Context Guardian] Phase [N] estimated at [Xk] tokens — exceeds 40% limit.
Split into Phase [Na] and Phase [Nb] to keep each session clean.
Revised plan: [N+1] total phases.
```

---

## Model routing rule (token efficiency)

Apply in every session, every command:

| Task type | Model |
|-----------|-------|
| G Stack /office-hours | Opus |
| GSD research synthesizer | Opus |
| grill-with-docs full session | Opus |
| All code execution (Superpowers) | Sonnet |
| All code review | Sonnet |
| G Stack /review, /qa, /design-review | Sonnet |
| State dump writing | Sonnet |

Never use Opus for execution tasks. Never use Haiku for any task in this stack.
