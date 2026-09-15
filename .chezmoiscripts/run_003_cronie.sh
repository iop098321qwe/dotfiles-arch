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

# Install cronie
spin 'Installing Cronie...' omarchy pkg add cronie

# Enable and start the cronie service
spin 'Starting Cronie service...' sudo systemctl enable --now cronie.service
