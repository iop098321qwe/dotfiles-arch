#!/usr/bin/env bash

set -euo pipefail

readonly REQUIRED_CHANNEL="edge"
readonly STATE_DIR="${XDG_STATE_HOME:-$HOME/.local/state}/chezmoi"
readonly REBOOT_MARKER="$STATE_DIR/omarchy-edge-channel-reboot-required"

fail() {
  printf 'Error: %s\n' "$*" >&2
  exit 1
}

current_boot_id() {
  if [[ ! -r /proc/sys/kernel/random/boot_id ]]; then
    fail 'could not read the current boot ID to enforce the Omarchy edge reboot.'
  fi

  local boot_id
  boot_id=$(</proc/sys/kernel/random/boot_id)
  printf '%s\n' "$boot_id"
}

current_omarchy_channel() {
  omarchy version channel 2>/dev/null || true
}

is_omarchy_edge() {
  local channel="$1"

  [[ $channel == "$REQUIRED_CHANNEL" ]]
}

prompt_reboot() {
  printf '%s\n' \
    'Dotfiles initialization is deferred until after a reboot.' \
    'Reboot, then rerun chezmoi apply.'

  if [[ ! -t 0 ]] || ! command -v gum >/dev/null 2>&1; then
    return
  fi

  if gum confirm 'Reboot now to finish Omarchy edge setup?'; then
    if ! omarchy system reboot; then
      printf 'Warning: reboot command failed; reboot manually before rerunning.\n' >&2
    fi
  fi
}

require_interactive_gum() {
  command -v gum >/dev/null 2>&1 || \
    fail 'gum is required to confirm switching Omarchy to the edge channel.'

  [[ -t 0 ]] || \
    fail 'Omarchy is not on edge; rerun initialization in an interactive terminal.'
}

prompt_switch_to_edge() {
  local channel="$1"

  require_interactive_gum

  gum style --border normal --padding '1 2' \
    'Omarchy edge channel is required before dotfiles initialization.' \
    '' \
    "Current channel: ${channel:-unknown}" \
    '' \
    "This will run 'omarchy channel set edge', update Omarchy/packages," \
    'and stop dotfiles initialization until after a reboot.'

  printf '\n'
  if ! gum confirm 'Switch Omarchy to edge now?'; then
    fail 'Omarchy edge channel is required before dotfiles initialization.'
  fi
}

require_omarchy_edge() {
  command -v omarchy >/dev/null 2>&1 || \
    fail 'omarchy is required before dotfiles initialization.'

  local boot_id marker_boot channel
  boot_id=$(current_boot_id)
  channel=$(current_omarchy_channel)

  if [[ -f $REBOOT_MARKER ]]; then
    marker_boot=$(<"$REBOOT_MARKER")
    if [[ $marker_boot == "$boot_id" ]]; then
      printf '%s\n' \
        'Omarchy edge setup completed during the current boot.' \
        'A fresh reboot is required before dotfiles initialization can continue.'
      prompt_reboot
      exit 1
    fi

    if is_omarchy_edge "$channel"; then
      rm -f "$REBOOT_MARKER"
      return
    fi

    rm -f "$REBOOT_MARKER"
  fi

  if is_omarchy_edge "$channel"; then
    return
  fi

  prompt_switch_to_edge "$channel"

  omarchy channel set edge

  channel=$(current_omarchy_channel)
  if ! is_omarchy_edge "$channel"; then
    fail "Omarchy is channel '${channel:-unknown}' after switching."
  fi

  mkdir -p "$STATE_DIR"
  printf '%s\n' "$boot_id" >"$REBOOT_MARKER"
  printf '%s\n' 'Omarchy is now on the edge channel.'
  prompt_reboot
  exit 1
}

require_omarchy_edge
