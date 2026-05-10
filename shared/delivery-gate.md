# Delivery Gate
## Two variants — load the correct one per command

| Command | Variant |
|---------|---------|
| /quick-development | Lightweight |
| /standard-development | Full |
| /full-development | Full |
| /new-development | Full |

No exceptions. Never apply the full gate to /quick-development.
Never apply the lightweight gate to /standard, /full, or /new-development.

---

## Variant A — Lightweight (for /quick-development only)

**Purpose:** Verify code quality and correctness for small, scoped changes.
No security scan. No architectural review. Fast by design.

**Step 1: Superpowers /code-review**

Trigger: `using the Superpowers code-review skill, review the changes
made in this session against the original task description.`

The review checks:
- Does the code do what the task described?
- Are there obvious bugs or regressions introduced?
- Does the change break any existing tests?
- Is the code readable and consistent with the surrounding style?

**Outcome:**

PASS — no issues, or only low-severity notes:
```
[Delivery Gate — Lightweight] PASS
Changes reviewed. No blocking issues found.
[List any low-severity notes for the user's awareness]
Ready to commit.
```

FAIL — any medium or high severity issue found:
```
[Delivery Gate — Lightweight] FAIL
Issue found: [description]
Severity: [medium | high]
Fix required before commit.
[Route to Superpowers /debug if it is a logic bug]
[Route to direct edit if it is a style or correctness issue]
```

After fixing, re-run the lightweight gate. Do not commit until PASS.

---

## Variant B — Full (for /standard, /full, /new-development)

**Purpose:** Verify spec compliance, code quality, security, and architectural
soundness before any PR is created or any code is merged.

**Step 1: Superpowers /code-review**

Same as lightweight step 1.
Also checks: does the implementation match the spec or GSD phase plan?

**Step 2: G Stack /review**

Trigger: `using G Stack /review, perform a staff-engineer-level review
of all changes made in this build session.`

G Stack /review checks:
- Security: XSS, injection, auth gaps, exposed credentials, unsafe defaults
- Completeness: anything in the spec or phase plan that was not implemented
- Architecture: any shortcuts that will cause pain at scale
- Edge cases: scenarios the implementation does not handle

**Step 3: Evaluate combined results**

| Severity | Action |
|----------|--------|
| Critical (security gap, data loss risk) | Block PR. Fix immediately. Re-run full gate. |
| High (spec gap, missing error handling) | Block PR. Fix before merge. Re-run full gate. |
| Medium (style, minor incompleteness) | Note in PR description. Fix in next session. |
| Low (suggestions, polish) | Log only. No fix required. |

**Outcome:**

PASS:
```
[Delivery Gate — Full] PASS
Superpowers /code-review: PASS
G Stack /review: PASS — [N] notes ([X] medium, [Y] low)
No blocking issues. PR approved.
Medium notes logged for next session: [list if any]
```

FAIL:
```
[Delivery Gate — Full] FAIL — PR blocked
Blocking issues: [list with severity]
Fix each blocking issue, then re-run the full delivery gate.
Do not create the PR until this gate returns PASS.
```

After fixing all blocking issues, re-run the full gate from Step 1.
Do not skip Step 1 on the re-run.

---

## G Stack /qa — when to add it

The full delivery gate does NOT include G Stack /qa by default.
Add /qa only when the build includes UI changes.

Rule: if any of the following are true, run G Stack /qa after the full
delivery gate passes:
- New pages or routes were added
- Existing page layouts were modified
- User-facing interactions were changed
- A Playwright test does not already cover the affected flow

/qa runs the Playwright BFS loop (breadth-first through all app flows).
Requires 2 consecutive clean passes before the build is considered QA-complete.

If no UI changes: skip /qa, proceed directly to commit and PR.
