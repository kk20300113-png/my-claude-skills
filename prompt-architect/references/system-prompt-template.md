# System Prompt Template

Use this structure when generating system prompts for AI agents.
Adapt section depth to complexity — simple agents need less, complex agents need more.

---

## Template Structure

```
## Role & Identity
You are [AGENT NAME], a [ROLE DESCRIPTION] specialising in [DOMAIN].
Your tone is [TONE]. Your expertise level is [LEVEL].
[Optional: You work for / on behalf of [COMPANY/PERSON].]

## Primary Objectives
Your main responsibilities are:
1. [TASK 1]
2. [TASK 2]
3. [TASK 3]

## Context & Domain Knowledge
[BACKGROUND CONTEXT the agent needs — market, data sources, key entities,
relevant terminology. Be specific. Do not leave this generic.]

## Input Format
You will receive: [DESCRIPTION OF INPUTS — queries, documents, tool results, etc.]

## Output Format
Always respond with:
- [FORMAT SPEC: structure, length, headers, tone, JSON schema if applicable]
- [EXAMPLE OUTPUT SNIPPET if helpful]

[If output is parsed downstream, add:]
Wrap all outputs in XML tags using this structure:
<o>
  <[SECTION_1]>[content]</[SECTION_1]>
  <[SECTION_2]>[content]</[SECTION_2]>
</o>
Begin every response with: <o>

## Reasoning Instructions
[CHOOSE ONE OR MORE:]
- Think step by step before giving your final answer. Show your reasoning.       ← CoT
- For each claim, cite your source or data point.                                ← RAG/Citation
- Use the [Thought → Action → Observation] loop before responding.              ← ReAct
- If uncertain, state your confidence level explicitly.                          ← Calibration

## Tools & Integrations
[LIST AVAILABLE TOOLS, APIs, MCP SERVERS — name, purpose, when to use each]

## Constraints & Guardrails
- NEVER [hard constraint 1]
- NEVER [hard constraint 2]
- Always [positive constraint]
- If asked about [out-of-scope topic], redirect to [appropriate response]

## Few-Shot Examples (if applicable)
### Example 1
Input: [EXAMPLE INPUT]
Output: [EXAMPLE OUTPUT]

### Example 2
Input: [EXAMPLE INPUT]
Output: [EXAMPLE OUTPUT]
```

---

## Quality Checks Before Finalising

- [ ] Role is specific (not "a helpful assistant")
- [ ] Domain context is grounded with real entities/data
- [ ] Output format is unambiguous
- [ ] At least one reasoning instruction present for complex tasks
- [ ] Hard constraints stated explicitly
- [ ] Tone matches the intended audience
- [ ] If output is parsed downstream → XML tags + prefill instruction included
- [ ] Eval test cases defined (typical, edge, adversarial)

---

## Eval Test Case Block (append after prompt delivery)

```
🧪 SUGGESTED TEST CASES

Test 1 — Typical input: [most common expected input]
✅ Pass if: [what a good output looks like]

Test 2 — Edge case: [unusual but valid input]
✅ Pass if: [what Claude should do differently here]

Test 3 — Adversarial: [input designed to break format or scope]
✅ Pass if: [Claude handles gracefully — no hallucination, no constraint violation]
```

---

## XML Structuring Patterns for Agent Outputs

Use when: outputs feed another agent, get parsed by code, or land in a structured UI.

### General intelligence output:
```xml
<o>
  <summary>[2–3 sentence synthesis]</summary>
  <key_findings>
    <finding>[Finding 1]</finding>
    <finding>[Finding 2]</finding>
  </key_findings>
  <recommendation>[Action or conclusion]</recommendation>
</o>
```

### Citation-traced research (CarbonIQ / AIRD):
```xml
<o>
  <claim>[Extracted or synthesised claim]</claim>
  <source tier="1">[Direct document citation]</source>
  <confidence>high | medium | low</confidence>
</o>
```

### LNG / commodity market brief:
```xml
<market_brief>
  <supply>[Supply dynamics]</supply>
  <demand>[Demand signals]</demand>
  <geopolitical>[Risk factors]</geopolitical>
  <price_direction>[Directional view]</price_direction>
</market_brief>
```

**Prefill instruction:** Add to end of system prompt:
```
Begin every response with: <o>
```
