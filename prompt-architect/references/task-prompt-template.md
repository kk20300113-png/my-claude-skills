# Task Prompt Template

Use this structure when generating one-off task prompts (research, analysis, writing, etc.).
Lean on the techniques that match the complexity level.

---

## Template Structure

```
[ROLE ASSIGNMENT — optional but powerful]
You are a [EXPERT ROLE] with deep knowledge of [DOMAIN].

[TASK INSTRUCTION — be precise, use action verbs]
Your task is to [VERB + DELIVERABLE].

[CONTEXT BLOCK]
Here is the relevant context:
<context>
- [KEY FACT / DATA POINT 1]
- [KEY FACT / DATA POINT 2]
- [SOURCE or DOCUMENT if applicable]
</context>

[CONSTRAINTS]
- Limit your response to [LENGTH].
- Write in [TONE] for [AUDIENCE].
- Do not include [EXCLUSION].
- Focus specifically on [SCOPE LIMITER].

[REASONING INSTRUCTION — for complex tasks]
Think step by step. First identify [X], then analyse [Y], finally synthesise [Z].

[OUTPUT FORMAT INSTRUCTION]
Structure your response as follows:
<o>
  <[SECTION_1]>[SECTION 1 content]</[SECTION_1]>
  <[SECTION_2]>[SECTION 2 content]</[SECTION_2]>
  <[SECTION_3]>[SECTION 3 content]</[SECTION_3]>
</o>

[FEW-SHOT EXAMPLES — for structured/repeatable tasks]
Here is an example of the output format I want:
Input: [EXAMPLE]
Output: [EXAMPLE OUTPUT]

[CLOSING INSTRUCTION + PREFILL ANCHOR]
Begin your response with: <o>
```

---

## Technique Selection by Task Type

| Task | Recommended Technique |
|---|---|
| Market research / briefing | CoT + XML structured output + prefill |
| Competitive / OSINT analysis | ReAct-style: gather → synthesise → conclude |
| Email drafting | Role assignment + tone constraint + few-shot example |
| Financial modelling explanation | CoT + citation requirement |
| Sentiment / classification | Few-shot with 2–4 labelled examples |
| Data extraction from documents | XML schema + prefill to enforce format |
| Multi-source synthesis | Prompt chaining: extract → compare → conclude |
| Agent tool orchestration | ReAct: Thought → Action → Observation loop |
| Pipeline / downstream parsing | XML structuring + prefill + schema spec |

---

## Failure Mode Diagnostic (for iteration)

If improving an existing prompt, map the symptom to the fix before rewriting:

| Symptom | Fix |
|---|---|
| Too vague / generic | Add role grounding + specific named entities |
| Ignores constraints | Move to explicit NEVER / ALWAYS block |
| Inconsistent format | Add XML schema + prefill instruction |
| Too verbose | Add hard length constraint per section |
| Hallucinating facts | Add "cite your source" or ground in provided context |
| Misses the point | Add CoT: "Think step by step before answering" |
| Broken JSON / XML output | Add prefill (`{` or `<o>`) + validate schema spec |
| Inconsistent across runs | Add 2–4 few-shot examples + define pass criteria |

---

## Eval Test Cases (append after prompt delivery)

Always define 3 test cases before shipping a task prompt:

```
🧪 TEST CASES

Test 1 — Typical: [most expected input scenario]
✅ Pass if: [describe ideal output]

Test 2 — Edge case: [unusual but valid input]
✅ Pass if: [what should change vs. typical]

Test 3 — Adversarial: [input designed to break scope or format]
✅ Pass if: [graceful handling, no hallucination, constraints respected]
```

---

## Power Phrases to Use

**For reasoning quality:**
- "Think step by step before answering."
- "First, consider [X]. Then, analyse [Y]. Finally, synthesise [Z]."
- "If you are uncertain, say so explicitly rather than guessing."

**For output quality:**
- "Be specific and concrete — avoid generalisations."
- "Use data points and named entities where possible."
- "Do not repeat the question. Go straight to the answer."

**For role grounding:**
- "You have 20 years of experience in [DOMAIN]."
- "You are briefing a [AUDIENCE ROLE] who needs [LEVEL OF DETAIL]."
- "Respond as if you are a senior [ROLE] at [COMPANY TYPE]."

**For format enforcement:**
- "Respond ONLY with valid JSON. No preamble or explanation."
- "Wrap your output in <o></o> tags. Begin with: <o>"
- "Use this exact structure: [SCHEMA]"
- "Keep each section to 3 sentences maximum."

**For XML + prefill:**
- "Structure your response inside <o></o> tags."
- "Begin your response with: <o>"
- "Begin your response with: {" *(for JSON)*
