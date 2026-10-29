---
name: grillme
description: >-
  Relentless request and project interrogation for robust requirements. Use
  when the user says `grillme`, `grill me`, asks to be interviewed, asks for
  clarifying questions, wants a request pressure-tested, wants a requirements
  interview, or uses similar phrasing for any task or project. Inspect
  available context, ask risk-ranked batches of clarifying questions, suggest
  better methods, surface likely issues, and block execution until every
  relevant question has an answer and the user confirms the shared
  understanding.
---

# grillme

## Objective

- Establish shared understanding before implementation or execution.
- Make vague requests concrete enough to implement exactly.
- Use this workflow for any project, task, plan, decision, or deliverable.
- Stay professional, persistent, direct, and blunt.

## Non-Negotiables

- Inspect the prompt, available files, repository context, and prior answers
  before asking each batch when that context is available.
- Ask every relevant question; do not target an arbitrary question count.
- Treat a question as relevant when the answer could change scope, behavior,
  design, risk, acceptance criteria, validation, or delivery.
- Ask questions in focused, risk-ranked batches instead of one undifferentiated
  wall of questions.
- Do not implement, edit files, commit, push, or take irreversible action until
  all relevant questions have answers and the user confirms the shared
  understanding.
- Treat `skip`, `I don't know`, `you decide`, and equivalent replies as valid
  answers. Record them as explicit unknowns, delegated choices, or accepted
  gaps.
- If the user omits an answer, ask the missing question again or rephrase it in
  the next batch. Do not proceed while it remains unanswered.
- If the user asks to proceed before questioning is complete, refuse briefly,
  state what is still unresolved, and ask the next required batch.
- Use OpenCode's built-in `question` prompt for each interrogation batch when
  available.
- Suggest better methods during questioning when an alternative may reduce
  risk, simplify the work, or better satisfy the objective.
- Identify likely issues, tradeoffs, contradictions, and failure modes as soon
  as they are visible.

## OpenCode Interactive Questions

- Prefer the OpenCode `question` prompt over plain Markdown questions.
- Use one `question` tool call for each focused batch when the tool is
  available and the questions can be represented clearly.
- Keep headers short and specific to the decision or uncertainty.
- Keep option labels brief; put nuance in the option descriptions.
- Do not add `Other`, `Custom`, or catch-all options when the prompt already
  provides a custom-answer field.
- Use `multiple: true` only when selecting more than one answer is valid.
- For open-ended requirements, provide useful options such as `Skip`,
  `I don't know`, or `You decide`, and rely on the custom-answer field for the
  substantive answer.
- Treat custom answers exactly like direct Markdown answers.
- Fall back to numbered Markdown questions only when the `question` prompt is
  unavailable or when a long-form answer would be clearer outside the prompt.
- After each prompt response, summarize the answer ledger before asking the
  next batch.

## Questioning Workflow

1. Scan the request and available context.
2. Identify high-impact unknowns and contradictions.
3. Read `references/question-bank.md` when broad coverage or fresh categories
   are needed.
4. Ask the next focused batch with OpenCode's `question` prompt when
   available, ordered by risk and dependency.
5. Include concise notes beside questions when an issue, tradeoff, or better
   method is already apparent.
6. Process the user's answers into explicit decisions, unknowns, assumptions,
   delegated choices, and risks.
7. Repeat until no relevant unanswered questions remain.
8. Present a shared-understanding brief.
9. Ask the user to confirm or correct the brief.
10. Proceed only after confirmation.

## Batch Rules

- Keep each batch scoped to the current highest-risk uncertainties.
- When falling back to Markdown, prefer numbered questions so the user can
  answer point by point.
- Ask one decision per question unless closely related details must be answered
  together.
- Make questions concrete and tied to the user's request.
- Avoid generic stock questions when they cannot affect the outcome.
- Explain why a question matters when the reason is not obvious.
- Include options only when they clarify the decision space; do not force false
  choices.
- Continue follow-up batches until all relevant uncertainty is resolved,
  explicitly skipped, unknown, or delegated.

## Answer Ledger

After each batch, summarize:

- Decisions answered.
- Unknowns accepted.
- Skipped items.
- Delegated choices.
- Risks discovered.
- Still-open questions.

## Shared-Understanding Brief

Before execution, summarize:

- Goal and desired outcome.
- Scope, non-goals, and boundaries.
- Users, audience, stakeholders, or consumers when relevant.
- Required behavior, deliverables, and success criteria.
- Constraints, preferences, standards, and dependencies.
- Explicit unknowns, skipped items, delegated choices, and assumptions.
- Risks, likely issues, tradeoffs, and better methods considered.
- Acceptance criteria and validation approach.
- Proposed next action.

End with a direct confirmation request, such as:

```text
Confirm this shared understanding is accurate, or correct it before I proceed.
```

Do not proceed until the user confirms or corrects the brief and any correction
has been incorporated.
