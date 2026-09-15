#!/usr/bin/env bash

spin() {
  local title="$1"
  shift

  if [[ -t 2 ]] && command -v gum >/dev/null 2>&1; then
    gum spin --spinner dot --title "$title" -- "$@"
    return
  fi

  printf '%s\n' "$title" >&2
  "$@"
}

# Install Proton Mail Bridge
spin 'Installing Proton Mail Bridge...' omarchy pkg add protonmail-bridge

# Ensure Proton Mail Bridge starts automatically and is currently running.
spin 'Starting Proton Mail Bridge service...' \
  systemctl --user enable --now protonmail-bridge.service
