#!/usr/bin/env bash

import_state_dir="${XDG_STATE_HOME:-$HOME/.local/state}/chezmoi"
import_state_file="$import_state_dir/atuin-history-imported"

configure_atuin() {
  if ! atuin config set --type boolean auto_sync true; then
    printf 'Atuin setup warning: could not enable auto_sync.\n' >&2
  fi

  if ! atuin config set --type integer sync_frequency 0; then
    printf 'Atuin setup warning: could not set sync_frequency.\n' >&2
  fi

  if ! atuin config set --type boolean sync.records true; then
    printf 'Atuin setup warning: could not enable sync records.\n' >&2
  fi
}

import_history_once() {
  if [[ -f $import_state_file ]]; then
    return
  fi

  if atuin import auto; then
    mkdir -p "$import_state_dir"
    touch "$import_state_file"
  else
    printf 'Atuin setup warning: history import failed; will retry on next apply.\n' >&2
  fi
}

atuin_meta_db_path() {
  local line

  while IFS= read -r line; do
    case $line in
    'meta db path: '*)
      printf '%s\n' "${line#meta db path: }"
      return
      ;;
    esac
  done < <(atuin info 2>/dev/null)
}

atuin_has_local_auth() {
  local meta_db session_file token_found

  meta_db=$(atuin_meta_db_path)
  if [[ -n $meta_db && -f $meta_db ]] && command -v sqlite3 >/dev/null 2>&1; then
    token_found=$(sqlite3 "$meta_db" \
      "SELECT 1 FROM meta WHERE key IN ('session', 'hub_session') AND value <> '' LIMIT 1;" \
      2>/dev/null)
    [[ $token_found == 1 ]]
    return
  fi

  session_file="${XDG_DATA_HOME:-$HOME/.local/share}/atuin/session"
  [[ -s $session_file ]]
}

prompt_for_login() {
  local reply

  printf 'Atuin is not logged in to sync. Log in now? [y/N] '
  if ! read -r -t 30 reply; then
    printf '\nAtuin login skipped: no response within 30 seconds.\n'
    return 1
  fi

  case $reply in
  [yY] | [yY][eE][sS])
    return 0
    ;;
  *)
    printf 'Atuin login skipped.\n'
    return 1
    ;;
  esac
}

sync_atuin() {
  if ! atuin sync; then
    printf 'Atuin setup warning: sync failed.\n' >&2
    return 1
  fi
}

# Install atuin. Omarchy package installs are idempotent, so run this every apply.
omarchy pkg add atuin

if ! command -v atuin >/dev/null 2>&1; then
  printf 'Atuin setup skipped: atuin is not available after install attempt.\n' >&2
  exit 0
fi

configure_atuin
import_history_once

if atuin_has_local_auth; then
  sync_atuin
  exit 0
fi

if ! prompt_for_login; then
  exit 0
fi

atuin login

if atuin_has_local_auth; then
  sync_atuin
else
  printf 'Atuin setup warning: login did not complete; sync skipped.\n' >&2
fi
