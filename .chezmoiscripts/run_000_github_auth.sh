#!/usr/bin/env bash

set -euo pipefail

warn() {
  printf 'GitHub authentication warning: %s\n' "$*" >&2
}

fail() {
  printf 'GitHub authentication error: %s\n' "$*" >&2
  exit 1
}

command -v gh >/dev/null 2>&1 || \
  fail 'gh is required to authenticate with GitHub.'

if gh auth status --hostname github.com >/dev/null 2>&1; then
  exit 0
fi

warn 'GitHub authentication is required.'

if [[ ! -t 0 ]]; then
  fail 'authentication requires an interactive terminal.'
fi

omarchy sudo passwordless 30

gh auth login -cw

if ! gh auth status --hostname github.com >/dev/null 2>&1; then
  fail 'authentication failed.'
fi
