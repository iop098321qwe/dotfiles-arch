---
name: nbccpr
description: >-
  Create and push branches when the prompt contains `nbccpr` or `NBCCPR`.
  Use when the user wants a branch created, committed, and pushed in one
  workflow using Conventional Branch naming plus Conventional Commit
  messages.
---

# nbccpr

## Parse the command

- Detect `nbccpr` or `NBCCPR` in the prompt; treat it as an explicit
  request to create a branch, commit, and push.
- Expect syntax: `nbccpr <type> [name]`.
- Accept every branch type defined by the Conventional Branch standard
  plus documented local extensions:
  `feature`, `feat`, `bugfix`, `fix`, `hotfix`, `release`, `chore`,
  `perf`, `ai`, `copilot`, `cursor`, `claude`, and `codex`.
- Treat `perf` as the local performance branch type, for example
  `nbccpr perf optimize-query` creates `perf/optimize-query`.
- Treat only the next token, or quoted string, after `<type>` as the
  optional branch name.
- Treat any remaining prompt text as ordinary request context, not as
  `nbccpr` command syntax.
- If no branch name is provided, generate one automatically from the
  workflow-created change scope or intended commit summary after
  inspecting the work.
- Explicit branch names always override auto-generation.
- If the branch name already includes a valid prefix, for example
  `feature/add-login`, validate it with `conventional-branch`. If the
  prefix conflicts with the requested `<type>`, ask for clarification.

## Handle pre-existing uncommitted changes

- Before branch creation or new edits, check for staged, unstaged, and
  untracked files.
- If the worktree is already clean, continue without prompting.
- If pre-existing changes exist, treat them as out of scope for the
  current `nbccpr` run.
- Stash all pre-existing staged, unstaged, and untracked changes before
  `nbccpr` starts its own work so only workflow-created changes can be
  committed and pushed.
- Record the stash ref and the user's original branch or detached
  `HEAD` context before switching branches.
- Do not commit or push any pre-existing changes as part of `nbccpr`.
- If pre-existing changes cannot be isolated safely, or they directly
  conflict with the requested work, stop and ask instead of guessing.

## Create the branch with `conventional-branch`

- Follow the `conventional-branch` skill for allowed prefixes, aliases,
  normalization, validation, and branch creation.
- Read the local specification file through that skill:
  `conventional-branch/references/conventional-branch-specification.md`.
- Let `conventional-branch` detect the best base branch for the current
  repo.
- Record the exact branch name created by this step. All later commit
  and push actions must use that same branch.
- If switching branches would fail because pre-existing changes were
  not isolated successfully, stop and ask instead of guessing.
- Do not invent branch prefixes beyond the Conventional Branch
  standard and documented local extensions in the reference.

## Commit with `conventional-commits`

- Before staging or committing, verify `HEAD` is still on the created
  branch. If branch context drifted, switch back first or stop.
- Follow the `conventional-commits` skill for type, scope, and header
  format.
- Prefer the commit header that will read best in the published
  changelog, since release tooling may surface only that line.
- Put the essential feature or fix in the short header description;
  commit bodies and PR descriptions are not changelog entry text.
- Choose the type from the actual change, not the requested branch
  type. Use `fix` for faulty skill workflow guidance, `feat` for new
  skill behavior, and `docs` for explanation-only changes.
- Check the repo's release filters through `conventional-commits`;
  do not mislabel a change merely to make it appear in the changelog.
- Use `conventional-commits` to decide whether the work should be one
  commit or multiple commits.
- When multiple valid summaries are possible, choose the one that
  states the shipped result most clearly for a changelog reader.
- Commit only the changes created during the current `nbccpr`
  workflow run after pre-existing changes were isolated.
- Commit all workflow-created changes that are in scope for this
  `nbccpr` run; do not leave approved workflow-created changes behind
  uncommitted.
- Stage relevant changes only (`git add ...`).
- Split commits when that produces clearer changelog entries, not only
  when files differ by area.
- When changes include any `AGENTS.md` or `README.md` file, create a
  separate `docs` Conventional Commit that contains only those files.
  Stage them separately and do not combine them with non-doc changes.
- Never edit or stage `CHANGELOG.md`. If it is modified, stop and ask
  for the release process or tooling that updates it; do not include it
  in commits.
- Do not create empty commits.
- Include a short descriptive body, one to two sentences, that
  explains intent or impact, not just the file changes.
- Use the body for extra context, but make the header clear enough to
  stand alone in a generated changelog.
- Before each commit, read the header without its body and confirm it
  names the concrete outcome in the staged diff. Split unrelated
  outcomes if one header would hide a meaningful change.
- If workflow-created changes and pre-existing changes become mixed
  such that they cannot be separated cleanly, stop and ask instead of
  guessing.

## Push the branch

- Before pushing, verify `HEAD` is still on the created branch.
- Push only the created branch with upstream tracking:
  `git push -u origin <branch-name>`.
- Verify every commit SHA created during this `nbccpr` run is present
  on the pushed branch after the push completes.
- Do not push pre-existing worktree changes; they were intentionally
  excluded from the commits created by this workflow.
- If `origin` is missing, ask for the correct remote name.
- Report any push failures and stop.

## Preserve pre-existing changes

- Run this section only when `nbccpr` stashed pre-existing changes at
  the start of the workflow.
- Stay on the created branch after a successful push.
- Do not auto-pop the stash back onto the created branch.
- Report the stash ref and original branch or detached `HEAD` context
  so the user can decide later what to do with those preserved changes.
- If push fails, do not pop or drop the stash.

## Workflow summary

- `nbccpr` owns the end-to-end sequence: parse, isolate pre-existing
  changes, branch, stage, commit, push, and report preserved stash
  context.
- `conventional-branch` owns branch naming and branch creation
  decisions.
- `conventional-commits` owns commit structure and message decisions.
- Pre-existing worktree changes are always excluded from `nbccpr`
  commits and pushes and remain for the user to handle later.
