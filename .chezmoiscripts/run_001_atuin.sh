#!/usr/bin/env bash

import_state_dir="${XDG_STATE_HOME:-$HOME/.local/state}/chezmoi"
import_state_file="$import_state_dir/atuin-history-imported"
proton_pass_vault='Personal'
atuin_pass_item='Atuin'

fail() {
  printf 'Atuin setup error: %s\n' "$*" >&2
  exit 1
}

spin() {
  local title
  title="$1"
  shift

  if [[ -t 2 ]] && command -v gum >/dev/null 2>&1; then
    gum spin --spinner dot --title "$title" -- "$@"
    return
  fi

  printf '%s\n' "$title" >&2
  "$@"
}

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

pass_field() {
  local field value
  field="$1"

  if ! value=$(spin "Reading Atuin $field from Proton Pass..." \
    bash -c \
      'pass-cli item view --vault-name "$1" --item-title "$2" --field "$3" 2>/dev/null' \
      bash "$proton_pass_vault" "$atuin_pass_item" "$field"); then
    printf \
      "Atuin setup error: could not read '%s' from Proton Pass item '%s'.\n" \
      "$field" "$atuin_pass_item" >&2
    return 1
  fi

  if [[ -z $value ]]; then
    printf \
      "Atuin setup error: Proton Pass item '%s' has an empty '%s' field.\n" \
      "$atuin_pass_item" "$field" >&2
    return 1
  fi

  printf '%s' "$value"
}

login_atuin_from_proton_pass() {
  local key key_fifo password status tmp_dir username writer

  command -v pass-cli >/dev/null 2>&1 || \
    fail 'pass-cli is required to automate Atuin login.'

  command -v script >/dev/null 2>&1 || \
    fail 'script(1) is required to automate the hidden Atuin password prompt.'

  pass-cli info >/dev/null 2>&1 || \
    fail 'Proton Pass CLI is not authenticated.'

  set +x
  username=$(pass_field Username) || exit 1
  password=$(pass_field Password) || exit 1
  key=$(pass_field 'Atuin Key') || exit 1

  if ! tmp_dir=$(mktemp -d "${TMPDIR:-/tmp}/atuin-login.XXXXXX"); then
    fail 'could not create a secure temporary directory for Atuin login.'
  fi

  if ! chmod 700 "$tmp_dir"; then
    rm -rf "$tmp_dir"
    fail 'could not secure the temporary Atuin login directory.'
  fi

  key_fifo="$tmp_dir/key"
  if ! mkfifo "$key_fifo"; then
    rm -rf "$tmp_dir"
    fail 'could not create the temporary Atuin key pipe.'
  fi

  { printf '%s\n' "$key" >"$key_fifo"; } &
  writer=$!

  if [[ -t 2 ]] && command -v gum >/dev/null 2>&1; then
    printf '%s\n' "$password" | \
      ATUIN_USERNAME="$username" \
      ATUIN_KEY_FIFO="$key_fifo" \
      gum spin --spinner dot --show-error --title 'Signing in to Atuin...' -- \
        script --quiet --return --echo never \
          -c 'atuin login --username "$ATUIN_USERNAME" < "$ATUIN_KEY_FIFO"' \
          /dev/null
  else
    printf 'Signing in to Atuin...\n' >&2
    printf '%s\n' "$password" | \
      ATUIN_USERNAME="$username" \
      ATUIN_KEY_FIFO="$key_fifo" \
      script --quiet --return --echo never \
        -c 'atuin login --username "$ATUIN_USERNAME" < "$ATUIN_KEY_FIFO"' \
        /dev/null
  fi
  status=$?

  kill "$writer" 2>/dev/null || true
  wait "$writer" 2>/dev/null || true
  rm -rf "$tmp_dir"

  return "$status"
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

if login_atuin_from_proton_pass && atuin_has_local_auth; then
  sync_atuin
else
  fail 'automated login did not complete; sync skipped.'
fi
