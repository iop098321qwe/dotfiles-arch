---
name: conventional-commits
description: >-
  Apply Conventional Commits for git and GitHub work. Use for creating or
  naming branches, composing commit messages, writing PR titles and bodies,
  preparing release notes, or standardizing git and GitHub metadata.
---

# conventional-commits

## Establish repo rules

- Inspect CONTRIBUTING, commitlint configs, .gitmessage, and release tooling.
- Follow repo-specific constraints over this skill when they conflict.
- Match existing commit casing and scope patterns when they are consistent.
- Check the release preset, included commit types, section mappings, and merge
  strategy before predicting what the generated changelog will contain.
- If release configuration is unavailable, state that uncertainty rather than
  assuming every Conventional Commit type appears in the changelog.
- When release tooling generates published changelog entries from commit
  headers, treat the header as user-facing copy that should make sense on
  its own.
- Never edit CHANGELOG.md directly. If CHANGELOG.md appears in staged
  or unstaged changes, stop and ask for the repo's release tooling or
  workflow before proceeding.

## Format commit headers

- Use `<type>[optional scope][!]: <description>`.
- Treat `<description>` as the short subject in the header, distinct from the
  longer commit body or PR description.
- Keep the description imperative, present tense, and under 72 characters.
- Avoid trailing periods and avoid capitalization unless a proper noun.

## Write changelog-ready summaries

- Treat the commit header as publishable changelog copy. Many generated
  changelogs surface only the type, scope, and description.
- Lead with the shipped result, behavior change, or affected surface area,
  not with internal implementation details or review activity.
- Make the description specific enough to stand on its own without the
  commit body, PR title, or surrounding discussion.
- Assume commit bodies and PR descriptions are omitted from changelog entries.
  Put the essential outcome and affected behavior in the header itself.
- Avoid vague summaries like `update workflow`, `improve docs`,
  `misc cleanup`, or `address feedback` when a more concrete result is
  available.
- Choose descriptions that still read naturally after the scope is shown
  in the changelog as `**scope:** description`.
- Do not repeat the scope term in the description when it makes the entry
  redundant.
- Prefer:
  - `feat(nbccpr): prompt for dirty worktree handling`
  - `fix(conventional-branch): fall back to local trunk branches`
  - `docs(conventional-commits): explain changelog-first commit headers`
- Avoid:
  - `feat(nbccpr): improve workflow`
  - `fix(conventional-branch): fix bug`
  - `docs(conventional-commits): update skill`

## Choose commit types

- Classify the actual change, not its file extension, branch prefix, or desired
  changelog visibility. Never use `feat` or `fix` solely to force inclusion.
- Treat skill instructions as behavior-defining content: correcting faulty
  workflow guidance warrants `fix`; adding a workflow capability warrants
  `feat`. Use `docs` for explanatory changes that do not change skill behavior.
- **feat**: Use for new user-visible capability, API surface, endpoint, CLI
  command, or configuration option. Do not use for internal refactors or bug
  fixes that do not introduce new capability.
- **fix**: Use for correcting faulty behavior, regressions, or incorrect output.
  Include when adding tests for the bug in the same commit.
- **docs**: Use for documentation-only changes, such as README, guides, or
  inline docs, with no code or skill workflow behavior change.
- **style**: Use for formatting-only changes, such as whitespace or lint fixes,
  with no behavior change and no structural refactor.
- **refactor**: Use for internal code restructuring with no behavior or
  performance change, such as renames, moves, or simplification.
- **perf**: Use for performance improvements that affect speed, memory, or
  resource usage, even if behavior is unchanged.
  Example: `perf(db): reduce query allocations`.
- **test**: Use for adding or updating tests without changing production code.
- **build**: Use for build system, toolchain, dependency, or packaging changes,
  including lockfile updates when they are the primary change.
- **ci**: Use for CI pipeline, workflow, or automation config changes.
- **chore**: Use for maintenance tasks not covered by other types, such as
  repo housekeeping or non-production configuration updates.
- **revert**: Use for reverting prior commits and include refs to reverted SHAs
  in footers.

## Select scopes

- Use a scope when the change targets a specific subsystem or domain.
- Use lowercase kebab-case and avoid spaces or commas.
- Prefer scopes that help a changelog reader locate the affected area
  quickly.
- Split commits or omit scope when changes span multiple areas.

## Mark breaking changes

- Use `!` in the header when the change requires consumer action.
- Name the incompatible behavior in the header so the impact remains visible
  when bodies and footers are omitted from the changelog entry.
- Add a `BREAKING CHANGE:` footer when migration or impact details are needed.
- Ensure the description or footer explicitly states what breaks and why.

## Write bodies and footers

- Use the body to explain motivation, context, or migration steps.
- Keep bodies as supplemental context; do not put the only explanation of a
  feature or fix there, since generated entries omit these descriptions.
- Preserve required breaking-change footers for release parsing even when
  ordinary bodies are excluded from changelog entries.
- Use footers for issue references and trailers like `Refs:`, `Closes:`, or
  `Reviewed-by:` in git trailer format.
- Keep `BREAKING CHANGE:` footers uppercase and include a clear description.

## Resolve mixed changes

- Prefer multiple commits when changes naturally fit different types or scopes.
- Split commits when separate changes would read more clearly as separate
  changelog entries.
- Always split README.md or AGENTS.md updates into their own `docs` commit
  and include a brief body describing the documentation changes.
- If a single commit is required, choose the highest user impact type in this
  order: feat, fix, perf, refactor, docs, test, build, ci, chore.
- Avoid `chore` when any specific type applies.
- Keep commit history readable: for small corrections, clarifications, or
  follow-up changes that belong to an existing commit on the current branch,
  prefer amending the relevant commit instead of creating a new fixup, chore, or
  cleanup commit. Create a separate commit only when the change is logically
  distinct, user-requested, or amending would unexpectedly rewrite
  shared/published history. This helps keep Conventional Commit history and
  generated changelogs clear.

## Name branches

- Allow only these creatable branch prefixes: `feature/`, `bugfix/`,
  `hotfix/`, `release/`, `docs/`, `test/`, `refactor/`, `perf/`, and `chore/`.
- Use `perf/` for performance improvements affecting speed, memory, or
  resource usage.
- Treat `main`, `master`, and `develop` as reserved literal branch names,
  not prefixes.
- Do not create `main`, `master`, or `develop` unless the user explicitly
  requests it.
- Do not create a bare `docs` branch name. Treat `docs` as a prefix only.
- Create `hotfix/*` branches from `main`, or `master` when `master` is the
  repository's default/main branch.
- Create all other allowed branch types from `develop`.
- For documentation requests, create `docs/<short-description>` and derive a
  descriptive lowercase kebab-case slug from the requested doc changes.
- Avoid generic docs slugs like `update-docs` or `misc`; include the docs area
  and intent when possible.
- Use `prefix/short-description` with a lowercase kebab-case description.
- Validate creatable names with
  `^(feature|bugfix|hotfix|release|docs|test|refactor|perf|chore)\/[a-z0-9]+(?:-[a-z0-9]+)*$`.
- Valid examples: `feature/add-sso-login`, `bugfix/fix-null-check`,
  `docs/update-api-auth-guide`, `perf/optimize-query`.
- Invalid examples: `main/foo`, `master/foo`, `develop/foo`, `Feature/new-ui`,
  `bugfix/fix_bug`, `release/`, `docs`, `docs/`, `docs/update-docs`.

## Align PR titles and bodies

- Use Conventional Commit header format for PR titles when squash merging.
- Keep PR titles aligned to the primary commit type and scope.
- When the PR title becomes the squash commit header, make it changelog-ready
  on its own. Do not rely on the PR description or individual commit bodies.
- Review the final squash message because the hosting platform may prefill it
  differently from the PR title.
- Use this PR body template when the repo has no standard:

```text
## Summary
-

## Testing
-

## Breaking Changes
-
```

## Prepare release notes

- Follow the repository's verified release preset and section mappings.
- For manually organized notes without a configured mapping, group `feat` as
  Features, `fix` as Fixes, `perf` as Performance, and `docs` as Documentation;
  group `build`, `ci`, `chore`, and `refactor` as Maintenance. Do not assume
  automatic generators include all of these types.
- Call out breaking changes prominently with migration guidance.

## Review before committing

- Read each header alone as a prospective changelog entry. Confirm it states
  the concrete outcome without the body or PR description.
- Verify the type and scope against the actual staged diff and repo rules.
- Check known release filters without changing the type merely for visibility.
- Split unrelated outcomes when one header would hide a meaningful change.

## Reference the full standard

- Read `references/conventional-commits.md` for the complete specification.
