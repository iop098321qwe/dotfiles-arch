# AGENTS.md

## Purpose

This file guides AI coding agents working in `conventional-branch/`.
All work must follow best practices and industry standards where
applicable.

## Scope

This file covers the `conventional-branch/` skill package only.
It supplements the repository-root `AGENTS.md` and does not replace
verified repo-wide rules, tooling, or release automation.

## Formatting Rules

- Keep lines at 80 characters or fewer when practical.
- Allow longer lines only for URLs, code blocks, hashes, or commands
  that cannot be wrapped cleanly.

## Quick Start

- Read `SKILL.md` first to understand the skill entry point.
- Read `references/conventional-branch-specification.md` before
  changing branch rules or examples.
- Run `git status --short --branch` from the repo root before editing.

## Environment

- Git is required for day-to-day work in this skill package.
- Verification needed: no runtime version, package manager version, or
  environment variables are defined inside `conventional-branch/`.

## Repository Overview

- `SKILL.md` is the skill entry point for Conventional Branch usage.
- `references/` holds the full specification and documented local
  extensions used by the skill.
- Empty helper files are tracked beside the skill and must be treated
  carefully until their exact workflow role is verified.

## Tracked Files Overview

- `AGENTS.md`: Package-scoped instructions for agents working here.
- `SKILL.md`: Conventional Branch workflow skill definition.
- `done.txt`: Verification needed: tracked empty file with no verified
  documented workflow in this repo.
- `inbox.txt.tuxedo-lock`: Verification needed: tracked empty lock file
  with no verified documented workflow in this repo.
- `references/conventional-branch-specification.md`: Full Conventional
  Branch specification and documented local extensions used by the skill.
- `todo.txt`: Manual-only file that agents must never touch.

## Architecture

- This package has one executable knowledge entry point: `SKILL.md`.
- `SKILL.md` should stay concise and delegate detailed branch rules to
  `references/conventional-branch-specification.md`.
- The reference file is the source of truth for allowed branch types,
  naming grammar, documented local extensions, and branch examples.

## Commands

- `git status --short --branch`: confirm repo state before editing.
- `git diff --stat`: review pending scope before committing.
- `git ls-files conventional-branch`: review tracked files in this
  package.

## Testing

- No automated test suite is defined for this skill package.
- Use manual Markdown review to verify frontmatter, headings, wrapping,
  and referenced file paths.
- Do not claim test coverage or automated validation that is not
  present.

## Linting and Formatting

- No package-local formatter or linter config is defined here.
- Keep Markdown structure consistent with other skills in this repo.
- Repository commits are checked by commitlint through the repo's Husky
  `commit-msg` hook.

## CI and Release

- No package-local CI configuration is defined in this directory.
- Repository documentation deployment is managed from the repo root;
  do not invent package-local release steps.
- Never create, edit, or update active `CHANGELOG.md` files manually.

## Conventions

- Keep `SKILL.md` focused on workflow instructions and triggers.
- Keep detailed standards in `references/` instead of duplicating them
  across the skill body.
- Re-check branch examples against the local specification before
  keeping them.
- Never read, create, edit, delete, move, stage, commit, or otherwise
  touch `todo.txt`; only the user may modify it manually.
- For small related corrections on the current branch, prefer amending
  the relevant in-progress commit instead of creating separate fixup,
  chore, or cleanup commits unless the change is logically distinct or
  the user asked for separate history.

## Security and Compliance

- Never commit secrets, credentials, tokens, or private keys.
- Treat the local specification copy as reference material; do not
  replace it with unverified summaries.

## Dependencies and Services

- Git is the only verified external dependency for this package.
- Verification needed: no external services, databases, queues, or
  storage are defined for this package.

## Troubleshooting

- If branch guidance conflicts with the skill body, update the skill to
  match `references/conventional-branch-specification.md`.
- If the purpose of tracked empty helper files is unclear, inspect git
  history before changing surrounding documentation.

## Refining Existing AGENTS.md

- Re-check every statement against files in `conventional-branch/`.
- Remove stale, duplicated, or speculative instructions.
- Replace vague wording with exact file paths and verified commands.
- Keep bullets short and easy for AI agents to scan.
- Preserve this section order when improving the file.

## Maintenance

- After any code, config, or doc change in this package, verify that
  this file still matches the tracked files and workflow.
- Update this file when package scope, commands, or tracked files
  change.
- Remove stale instructions instead of appending historical notes.
