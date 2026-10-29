---
name: conventional-branch
description: >-
  Create, name, and validate Git branches against the Conventional Branch
  specification. Use when creating a new branch, choosing a branch name,
  checking whether a branch name is compliant, or preparing a branch before
  commit and push workflows.
---

# conventional-branch

## Use the local reference first

- Read `references/conventional-branch-specification.md` before generating,
  validating, or normalizing a branch name.
- Treat that reference as the authoritative source for allowed prefixes,
  grammar, documented local extensions, and valid and invalid examples.
- Prefer the full prefix names when generating a name automatically:
  `feature`, `bugfix`, `hotfix`, `release`, `chore`, `perf`, `ai`, `copilot`,
  `cursor`, `claude`, and `codex`.
- Use the local extension `perf/` for improvements to speed, memory, or
  resource usage, for example `perf/optimize-query`.
- Accept the official short aliases `feat` and `fix` when the user explicitly
  requests them or when an existing workflow already uses them.

## Branch rules

- Create prefixed branches as `<type>/<description>`.
- Treat `main`, `master`, and `develop` as trunk branches, not creatable
  prefixed names.
- Keep descriptions lowercase and use only alphanumerics, hyphens, and dots
  allowed by the specification.
- Do not produce spaces, underscores, uppercase letters, consecutive hyphens,
  consecutive dots, or leading or trailing hyphens or dots.
- Use dots in descriptions only when the specification allows them, such as
  release versions like `release/v1.2.0`.

## Create a branch

1. Gather the branch intent.
   - Identify the requested branch type.
   - Identify a short description of the work.
   - If the user provides a ticket number, include it in the description.
2. Assemble and normalize the name.
   - Lowercase everything.
   - Replace spaces and underscores with `-`.
   - Remove punctuation that the specification disallows.
   - Collapse duplicate separators and trim invalid leading or trailing
     characters.
3. Validate the final name against
   `references/conventional-branch-specification.md`.
   - If the requested name conflicts with the specification, repair it before
     creating the branch.
   - If the repair would materially change the user's intent, ask one short
     clarification question.
4. Detect the best base branch for this repository.
   - Prefer the remote default branch when it can be detected.
   - If the remote default branch is unavailable, fall back to the first local
     trunk branch that exists in this order: `develop`, `main`, `master`.
5. Create and switch to the branch from that base.
   - Update the base branch first when the repository workflow expects it.
   - Create the new branch and switch to it.
6. Confirm the result.
   - Report the final branch name.
   - Report the base branch used.
   - Remind the user to push with upstream tracking when they are ready.

## Validation and correction

- If the user asks whether a branch name is valid, compare it against the
  reference file instead of guessing.
- If the name is invalid, explain the specific rule it breaks and provide a
  compliant replacement.
- If multiple compliant names are reasonable, choose the most concise one that
  preserves intent.

## Relationship to other skills

- Use this skill for branch naming and branch creation decisions.
- Use `conventional-commits` for commit message, PR title, and release-note
  conventions.
- In compound workflows such as `nbccpr`, this skill should own branch naming
  and validation while the other workflow skill owns commit creation and push.
