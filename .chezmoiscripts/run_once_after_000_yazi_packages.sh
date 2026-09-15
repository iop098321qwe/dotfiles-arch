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

# Install Yazi packages
spin 'Installing Yazi packages...' ya pkg install

# Upgrade Yazi Packages
spin 'Upgrading Yazi packages...' ya pkg upgrade
