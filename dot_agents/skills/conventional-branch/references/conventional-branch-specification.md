# Conventional Branch 1.1.0 Reference

Source: <https://conventionalbranch.org/#specification>

## Overview

Conventional Branch is a specification for adding human-readable and
machine-readable meaning to Git branch names.

It defines a structured branch naming convention intended to make branch
names more readable and actionable. The specification suggests a set of
standard prefixes while also noting that teams may define custom naming
conventions when needed. Consistent naming helps teams identify branch
purpose quickly and can support automation.

## Summary

Conventional Branch refers to a structured and standardized naming
convention for Git branches that aims to make branches more readable and
actionable.

### Key Points

1. Purpose-driven branch names: Each branch name clearly indicates its
   purpose, making it easier for developers to understand what the
   branch is for.
2. Integration with CI/CD: Consistent branch names can help automated
   systems, such as CI/CD pipelines, trigger specific actions based on
   branch type.
3. Team collaboration: Explicit branch purpose reduces misunderstandings
   and makes it easier for team members to switch between tasks.

## Specification

### Branch Naming Structure

The branch specification supports the following structure:

```text
<type>/<description>
```

### Purpose Prefixes

- `feature/` or `feat/`: For new features.
  Examples: `feature/add-login-page`, `feat/add-login-page`
- `bugfix/` or `fix/`: For bug fixes.
  Examples: `bugfix/fix-header-bug`, `fix/header-bug`
- `hotfix/`: For urgent fixes.
  Example: `hotfix/security-patch`
- `release/`: For branches preparing a release.
  Example: `release/v1.2.0`
- `chore/`: For non-code tasks such as dependency or documentation
  updates.
  Example: `chore/update-dependencies`

### AI Agent Source Prefixes

- `ai/`: Generic prefix for any AI coding agent.
  Example: `ai/refactor-auth-flow`
- `copilot/`: GitHub Copilot.
  Example: `copilot/add-login-page`
- `cursor/`: Cursor.
  Example: `cursor/fix-header-bug`
- `claude/`: Claude Code by Anthropic.
  Example: `claude/security-patch`
- `codex/`: OpenAI Codex.
  Example: `codex/optimize-query`

### Trunk Branches

The trunk branches `main`, `master`, and `develop` do not use a prefix.

### Basic Rules

1. Use lowercase alphanumerics, hyphens, and dots.
   Always use lowercase letters (`a-z`), numbers (`0-9`), and hyphens
   (`-`) to separate words. Avoid special characters, underscores, and
   spaces. For release branches, dots (`.`) may appear in the
   description to represent version numbers, such as `release/v1.2.0`.
2. Do not use consecutive, leading, or trailing hyphens or dots.
   Hyphens and dots must not appear consecutively, and they must not
   appear at the start or end of the description.
   Invalid examples: `feature/new--login`, `release/v1.-2.0`,
   `feature/-new-login`, `release/v1.2.0.`
3. Keep branch names clear and concise.
   Branch names should be descriptive while remaining brief.
4. Include ticket numbers when applicable.
   If a project management ticket exists, include it to improve
   traceability. Example: `feature/issue-123-new-login`

### Formal Grammar

The specification defines valid branch names with the following
Augmented Backus-Naur Form (ABNF) grammar:

```abnf
branch-name     = trunk-branch / prefixed-branch
trunk-branch    = "main" / "master" / "develop"
prefixed-branch = type "/" description
type            = "feature" / "feat" / "bugfix" / "fix"
                / "hotfix" / "release" / "chore"
                / "ai" / "copilot" / "cursor"
                / "claude" / "codex"
description     = desc-segment *("-" desc-segment)
desc-segment    = 1*(ALPHA / DIGIT) *("." 1*(ALPHA / DIGIT))
ALPHA           = %x61-7A   ; lowercase a-z
DIGIT           = %x30-39   ; 0-9
```

Note: Consecutive hyphens or dots, and hyphens or dots at the start or
end of the description, are not permitted.

### Examples

| Branch Name                   | Valid | Notes                           |
| ----------------------------- | ----- | ------------------------------- |
| `main`                        | Yes   | Trunk branch                    |
| `master`                      | Yes   | Trunk branch                    |
| `develop`                     | Yes   | Trunk branch                    |
| `feature/add-login-page`      | Yes   | New feature                     |
| `feat/add-login-page`         | Yes   | Short alias for feature         |
| `bugfix/fix-header-bug`       | Yes   | Bug fix                         |
| `fix/header-bug`              | Yes   | Short alias for bugfix          |
| `hotfix/security-patch`       | Yes   | Urgent fix                      |
| `release/v1.2.0`              | Yes   | Release with version            |
| `chore/update-dependencies`   | Yes   | Non-code task                   |
| `feature/issue-123-new-login` | Yes   | Feature with ticket number      |
| `Feature/Add-Login`           | No    | Uppercase letters not allowed   |
| `feature/new--login`          | No    | Consecutive hyphens not allowed |
| `feature/-new-login`          | No    | Leading hyphen in description   |
| `feature/new-login-`          | No    | Trailing hyphen in description  |
| `release/v1.-2.0`             | No    | Hyphen adjacent to dot          |
| `fix/header bug`              | No    | Spaces not allowed              |
| `fix/header_bug`              | No    | Underscores not allowed         |
| `ai/refactor-auth-flow`       | Yes   | Generic AI agent prefix         |
| `copilot/add-login-page`      | Yes   | GitHub Copilot                  |
| `cursor/fix-header-bug`       | Yes   | Cursor                          |
| `claude/security-patch`       | Yes   | Claude Code by Anthropic        |
| `codex/optimize-query`        | Yes   | OpenAI Codex                    |
| `unknown/some-task`           | No    | Unknown prefix type             |

## Local Extensions

This skill also accepts `perf/` for performance improvements affecting
speed, memory, or resource usage. This is a documented local extension,
not an upstream Conventional Branch 1.1.0 prefix.

For local validation, use the standard grammar above with this additional
type alternative. All existing description rules still apply.

```abnf
type =/ "perf"
```

- Valid: `perf/optimize-query`, `perf/reduce-memory-usage`.
- Invalid: `perf/`, `Perf/optimize-query`, `perf/optimize--query`.
- Pair performance changes with the Conventional Commit type `perf`,
  for example `perf(db): reduce query allocations`.

## Conclusion

- Clear communication: The branch name alone communicates the purpose
  of the code change.
- Automation-friendly: The convention can hook into automated workflows
  for different branch types such as `feature` and `release`.
- Scalability: The naming scheme works well for larger teams handling
  many tasks in parallel.

Conventional Branch is designed to improve project organization,
communication, and automation in Git workflows.

## Tooling

The page recommends the following tools for adopting and enforcing the
specification:

- [`commit-check`](https://github.com/commit-check/commit-check): Check
  branch names, commit messages, and related Git metadata locally.
- [`commit-check-action`](https://github.com/commit-check/commit-check-action):
  Validate branch names automatically in GitHub Actions.
- [VSCode Conventional Branch](https://marketplace.visualstudio.com/items?itemName=pshaddel.conventional-branch):
  Create Conventional Branch names from Visual Studio Code.
- [Conventional Branch Skill](https://github.com/conventional-branch/conventional-branch/blob/main/skills/conventional-branch/SKILL.md):
  Teach AI coding assistants how to create valid Conventional Branch
  names.

Install the skill with:

```bash
npx skills add conventional-branch/conventional-branch --skill conventional-branch
```

## FAQ

### How does Conventional Branch relate to Conventional Commits?

Conventional Branch is inspired by
[Conventional Commits](https://www.conventionalcommits.org) and follows
a similar philosophy: bring human-readable and machine-readable
structure to Git metadata. Conventional Commits standardizes commit
messages, while Conventional Branch standardizes branch names. The two
specifications complement each other.

### Why are branch types less detailed than Conventional Commits?

Branches are temporary and mainly used until merged. The page explains
that introducing many additional branch types such as `build`, `ci`,
`docs`, `style`, or `refactor` would be unnecessary and make branches
harder to manage and remember.

### Can teams define their own branch types?

Yes. The specification defines a recommended set of types, but teams may
define additional custom types to fit their workflow. The page advises
documenting custom types clearly so team members and automation tools
understand them.

### What changed between v1.1.0 and v1.0.0?

Version `1.1.0` adds AI agent source prefixes as its main new feature.
It also introduces a versioned website so users can browse both the
`v1.0.0` and `v1.1.0` specifications. Existing `v1.0.0` branch names
remain valid, so the change is non-breaking.

### Why add AI Agent Source Prefixes?

The page explains that AI coding agents such as GitHub Copilot, Cursor,
Claude Code, and OpenAI Codex are increasingly used to generate code and
pull requests. Standardizing prefixes for those agents enables:

1. Quick identification so reviewers and tools can recognize
   AI-generated pull requests.
2. Tool validation so tools such as `commit-check` can validate AI agent
   branches against the specification.
3. A registration standard so new AI agents can adopt a documented
   prefix instead of inventing ad hoc patterns.

The generic `ai/` prefix is available for AI agents without a dedicated
prefix, or for teams that prefer a vendor-neutral identifier.

### How should long-lived branches like `develop` or `staging` be handled?

Long-lived integration or environment branches that are part of the core
specification, such as `main`, `master`, and `develop`, are treated as
trunk branches and do not require a prefix. Teams may also choose to
treat additional long-lived branches such as `staging` or `production`
as trunk-like branches by convention, but those extensions are outside
the formal grammar.

### What tools can automatically identify non-compliant branch names?

The page recommends:

- [`commit-check`](https://github.com/commit-check/commit-check) for
  checking branch names against the specification.
- [`commit-check-action`](https://github.com/commit-check/commit-check-action)
  for GitHub-hosted repositories.

## License

- License: [Creative Commons CC BY 4.0](https://creativecommons.org/licenses/by/4.0/)
- Created and maintained by
  [Xianpeng Shen](https://github.com/shenxianpeng)
- Project repository:
  <https://github.com/conventional-branch/conventional-branch>
