# Ralph Loop Gate
## Explicit consent required before any autonomous execution

The Ralph Loop runs Claude headless via `claude -p` in background sessions.
Each session spawns independently, consumes its own token budget, and exits.
This gate must fire before any autonomous mode begins. It cannot be bypassed.

---

## When this gate fires (per command)

| Command | Gate fires |
|---------|-----------|
| /quick-development | Never — no Ralph Loop in this command |
| /standard-development | Only if 3 or more phases are planned |
| /full-development | Always — no exceptions |
| /new-development | Always — no exceptions |

---

## Token calculation formula

Before presenting the gate, calculate the midpoint estimate:

```
Midpoint = number of phases × 50,000 tokens per phase
```

Example: 6 phases × 50k = 300k tokens midpoint estimate

This is a midpoint, not a guarantee. Simple phases may consume 30k.
Complex phases with heavy research may consume 80k. The midpoint is
the most likely outcome for a mixed workload.

Do not round down or present an optimistic figure.
Present the midpoint as calculated.

---

## Gate presentation format

Present this exactly. Fill in the bracketed values from the current plan.

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⚠  RALPH LOOP — explicit approval required
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Phases planned:     [N]
Headless sessions:  [N] (one per phase)
Token estimate:     [N phases] × ~50k = ~[X]k tokens (midpoint)

On Claude Max subscription:   absorbed within plan limits
On API billing (Sonnet):      approximately $[X] at current rates
  [calculate: Xk tokens ÷ 1000 × $0.003 for input, $0.015 for output]
  [use 70/30 input/output split for estimate]

[If brownfield — /full-development only, add this warning:]
⚠  Brownfield risk: autonomous mode on existing code carries higher
   misfire risk than greenfield. Manual mode recommended unless the
   phase plan has been reviewed and approved line by line.

MANUAL mode:    you approve each phase before it runs
                slower, more control, lower token risk
AUTONOMOUS:     all [N] phases run unattended until complete
                walk away, come back to a built project

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Type YES for autonomous / NO for manual
No default. This does not proceed without your explicit choice.
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

---

## After the user responds

**If YES (autonomous):**
```
Autonomous mode confirmed. Starting Ralph Loop.
Each phase will run in a fresh headless session.
Context guardian (50% hard stop) applies within each session.
Progress will be logged to .gsd/planning/ after each phase.
You will be notified when all [N] phases complete or if any phase fails.
```

Invoke phases sequentially:
```bash
claude -p "Execute GSD phase 1 from .gsd/planning/phase-01.md
using Superpowers TDD. Apply context-guardian 50% hard stop.
Save progress-[timestamp].md on any stop. Report summary on completion."
```
Wait for completion summary. Then invoke phase 2, and so on.
Never invoke two phases simultaneously unless the GSD plan explicitly
marks them as parallel-safe.

**If NO (manual):**
```
Manual mode confirmed. I will present each phase for your approval
before executing it. Starting with Phase 1.
```

Present Phase 1 summary from the GSD plan. Wait for approval.
On approval, execute Phase 1 using Superpowers TDD.
On completion, present Phase 2 summary. Repeat.

**If the user types anything other than YES or NO:**
Re-present the gate. Do not interpret ambiguous responses.
Do not proceed without an explicit YES or NO.

---

## Session failure handling

If a headless session fails mid-phase:
1. The progress-[timestamp].md state dump from that session is in the project root
2. Do not automatically retry — surface the failure to the user
3. Present: "Phase [N] failed. State saved to [file]. Review the failure before retrying."
4. Wait for the user to confirm before restarting that phase
