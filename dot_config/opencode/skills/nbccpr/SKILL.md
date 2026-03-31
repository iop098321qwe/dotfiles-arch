---
name: nbccpr
description: >-
  Create and push Conventional Commit branches when the prompt contains
  `nbccpr` or `NBCCPR`. Use when the user specifies a branch type (feature,
  bugfix, release, hotfix) and needs a new branch created, changes committed
  with Conventional Commit headers plus descriptive bodies, and the branch
  pushed to the remote repository.
---

# NBCCPR Branch + Commit Workflow

## Parse the command

- Detect `nbccpr` or `NBCCPR` in the prompt; treat it as an explicit request
  to create a branch, commit, and push.
- Expect syntax: `nbccpr <type> [branch-name] [task context]`.
- Accept types: `feature`, `bugfix`, `release`, `hotfix`.
- Treat the next token (or quoted string) after `<type>` as the branch name
  when it is provided. Any remaining text is task context, not part of the
  branch name.
- If no branch name is provided, generate one automatically from task context
  when available. If there is no task context, generate the slug from the
  intended Conventional Commit header description after inspecting the
  changes. If that is still empty, fall back to `auto-update`.
- Explicit branch names always override auto-generation.
- If the branch name already includes a valid prefix (for example,
  `feature/add-login`), reuse it only if the prefix matches `<type>`;
  otherwise ask for clarification.
- Slugify the branch name to lowercase kebab-case (ASCII only). Replace
  spaces or underscores with `-`, drop punctuation, collapse repeats, and
  trim leading or trailing `-`.

## Choose the base branch

- Use `develop` for `feature`, `bugfix`, and `release`.
- Use `main` for `hotfix`.
- If the required base branch does not exist locally or remotely, stop and
  ask.

## Create and switch the branch

- Fetch remote refs if available (`git fetch origin`) and check out the base
  branch.
- Ensure the base branch is up to date (`git pull --ff-only`).
- Create and switch to the new branch: `git switch -c <type>/<slug>`.
- If the working tree is dirty and switching branches fails, ask whether to
  stash, commit, or proceed from the current branch.

## Commit with Conventional Commits

- Follow the `conventional-commits` skill for type, scope, and header
  format.
- Stage relevant changes only (`git add ...`).
- When changes include `AGENTS.md` or `README.md` (any path), create a
  separate `docs` Conventional Commit that contains only those files.
  Stage them separately and do not combine them with non-doc changes.
- Do not create empty commits.
- Include a short descriptive body (1-2 sentences) that explains intent or
  impact, not just the file changes.

## Push the branch

- Push with upstream tracking: `git push -u origin <type>/<slug>`.
- If `origin` is missing, ask for the correct remote name.
- Report any push failures and stop.
