#!/usr/bin/env bash

set -euo pipefail

proton_pass_vault='Personal'
github_pass_item='GitHub'
github_pass_field='Password'

info() {
  printf 'GitHub authentication: %s\n' "$*" >&2
}

warn() {
  printf 'GitHub authentication warning: %s\n' "$*" >&2
}

fail() {
  printf 'GitHub authentication error: %s\n' "$*" >&2
  exit 1
}

copy_github_password_from_proton_pass() {
  local password status xtrace_enabled
  xtrace_enabled=0

  command -v pass-cli >/dev/null 2>&1 || {
    warn 'pass-cli is unavailable; GitHub password was not copied.'
    return 0
  }

  command -v wl-copy >/dev/null 2>&1 || {
    warn 'wl-copy is unavailable; GitHub password was not copied.'
    return 0
  }

  pass-cli info >/dev/null 2>&1 || {
    warn 'Proton Pass CLI is not authenticated; GitHub password was not copied.'
    return 0
  }

  case $- in
  *x*)
    xtrace_enabled=1
    set +x
    ;;
  esac

  if password=$(pass-cli item view \
    --vault-name "$proton_pass_vault" \
    --item-title "$github_pass_item" \
    --field "$github_pass_field" 2>/dev/null); then
    status=0
  else
    status=$?
  fi

  if (( status != 0 )); then
    if (( xtrace_enabled )); then
      set -x
    fi
    warn "could not read $github_pass_field from Proton Pass item '$github_pass_item'."
    return 0
  fi

  if [[ -z $password ]]; then
    if (( xtrace_enabled )); then
      set -x
    fi
    warn "Proton Pass item '$github_pass_item' has an empty $github_pass_field field."
    return 0
  fi

  if ! printf '%s' "$password" | wl-copy; then
    if (( xtrace_enabled )); then
      set -x
    fi
    warn 'could not copy GitHub password to the clipboard.'
    return 0
  fi

  if (( xtrace_enabled )); then
    set -x
  fi

  info 'copied GitHub password from Proton Pass to the clipboard.'
}

command -v gh >/dev/null 2>&1 || \
  fail 'gh is required to authenticate with GitHub.'

if gh auth status --hostname github.com >/dev/null 2>&1; then
  exit 0
fi

warn 'GitHub authentication is required.'
copy_github_password_from_proton_pass

if [[ ! -t 0 ]]; then
  fail 'authentication requires an interactive terminal.'
fi

gh auth login -cw

if ! gh auth status --hostname github.com >/dev/null 2>&1; then
  fail 'authentication failed.'
fi
