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

# Install RustDesk
spin 'Installing RustDesk...' omarchy pkg aur add rustdesk-bin

# Enable and start the RustDesk service
spin 'Starting RustDesk service...' \
  sudo systemctl enable --now rustdesk.service
