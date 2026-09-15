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

# Install syncthing
spin 'Installing Syncthing...' omarchy pkg add syncthing

# Enable and start the syncthing service
spin 'Starting Syncthing service...' \
  systemctl --user enable --now syncthing.service
