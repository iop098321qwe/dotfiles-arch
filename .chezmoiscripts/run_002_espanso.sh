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

# Install Espanso
spin 'Installing Espanso...' omarchy pkg aur add espanso-wayland

if ! command -v espanso >/dev/null 2>&1; then
  printf 'Espanso setup warning: espanso is not available after install attempt.\n' >&2
  exit 0
fi

# Ensure the Espanso service is registered.
if ! spin 'Registering Espanso service...' espanso service register; then
  printf 'Espanso setup warning: could not register the user service.\n' >&2
fi

# Espanso can report a startup timeout even when systemd shows the unit as active.
if systemctl --user is-active --quiet espanso.service; then
  exit 0
fi

if ! spin 'Starting Espanso service...' \
  systemctl --user start espanso.service; then
  printf 'Espanso setup warning: systemd reported a startup failure.\n' >&2
fi

if ! systemctl --user is-active --quiet espanso.service; then
  printf 'Espanso setup warning: espanso.service is still not active.\n' >&2
fi
