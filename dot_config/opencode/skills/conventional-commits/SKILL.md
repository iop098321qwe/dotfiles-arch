---
name: conventional-commits
description: >-
  Apply Conventional Commits for git and GitHub work. Use for creating or
  naming branches, composing commit messages, writing PR titles and bodies,
  preparing release notes, or standardizing git and GitHub metadata.
---

# Conventional Commits Workflow

## Establish repo rules

- Inspect CONTRIBUTING, commitlint configs, .gitmessage, and release tooling.
- Follow repo-specific constraints over this skill when they conflict.
- Match existing commit casing and scope patterns when they are consistent.

## Format commit headers

- Use `<type>[optional scope][!]: <description>`.
- Keep the description imperative, present tense, and under 72 characters.
- Avoid trailing periods and avoid capitalization unless a proper noun.

## Choose commit types

- **feat**: Use for new user-visible capability, API surface, endpoint, CLI
  command, or configuration option. Do not use for internal refactors or bug
  fixes that do not introduce new capability.
- **fix**: Use for correcting faulty behavior, regressions, or incorrect output.
  Include when adding tests for the bug in the same commit.
- **docs**: Use for documentation-only changes, such as README, guides, or
  inline docs, with no production code behavior change.
- **style**: Use for formatting-only changes, such as whitespace or lint fixes,
  with no behavior change and no structural refactor.
- **refactor**: Use for internal code restructuring with no behavior or
  performance change, such as renames, moves, or simplification.
- **perf**: Use for performance improvements that affect speed, memory, or
  resource usage, even if behavior is unchanged.
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
- Split commits or omit scope when changes span multiple areas.

## Mark breaking changes

- Use `!` in the header when the change requires consumer action.
- Add a `BREAKING CHANGE:` footer when migration or impact details are needed.
- Ensure the description or footer explicitly states what breaks and why.

## Write bodies and footers

- Use the body to explain motivation, context, or migration steps.
- Use footers for issue references and trailers like `Refs:`, `Closes:`, or
  `Reviewed-by:` in git trailer format.
- Keep `BREAKING CHANGE:` footers uppercase and include a clear description.

## Resolve mixed changes

- Prefer multiple commits when changes naturally fit different types or scopes.
- If a single commit is required, choose the highest user impact type in this
  order: feat, fix, perf, refactor, docs, test, build, ci, chore.
- Avoid `chore` when any specific type applies.

## Name branches

- Allow only these creatable branch prefixes: `feature/`, `bugfix/`,
  `hotfix/`, `release/`, `docs/`, `test/`, `refactor/`, and `chore/`.
- Treat `main`, `master`, and `develop` as reserved literal branch names,
  not prefixes.
- Do not create `main`, `master`, or `develop` unless the user explicitly
  requests it.
- Create `hotfix/*` branches from `main`, or `master` when `master` is the
  repository's default/main branch.
- Create all other allowed branch types from `develop`.
- Use `prefix/short-description` with a lowercase kebab-case description.
- Validate creatable names with
  `^(feature|bugfix|hotfix|release|docs|test|refactor|chore)\/[a-z0-9]+(?:-[a-z0-9]+)*$`.
- Valid examples: `feature/add-sso-login`, `bugfix/fix-null-check`.
- Invalid examples: `main/foo`, `master/foo`, `develop/foo`, `Feature/new-ui`,
  `bugfix/fix_bug`, `release/`.

## Align PR titles and bodies

- Use Conventional Commit header format for PR titles when squash merging.
- Keep PR titles aligned to the primary commit type and scope.
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

- Map `feat` to Features, `fix` to Fixes, `perf` to Performance, and `docs` to
  Documentation sections.
- Group `build`, `ci`, `chore`, and `refactor` under Maintenance.
- Call out breaking changes prominently with migration guidance.

## Reference the full standard

- Read `references/conventional-commits.md` for the complete specification.
