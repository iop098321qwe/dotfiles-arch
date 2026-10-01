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

# TEMPORARY ESPANSO AUR BYPASS START
# TODO: Remove this block once espanso-wayland builds correctly from the AUR.
print_espanso_aur_workaround() {
  cat <<'EOF' >&2
Espanso AUR workaround notice:
- espanso-wayland currently fails because the PKGBUILD references:
  espanso/src/res/linux/icon.png
- Upstream renamed that file to:
  espanso/src/res/linux/espanso.png
- To build manually, edit the AUR PKGBUILD and replace icon.png with
  espanso.png in the x11 and wayland package functions.
- If the split package conflict appears, build/install only espanso-wayland
  and avoid installing espanso-x11.
- Remove this temporary bypass once the AUR package is fixed.
EOF
}

if [[ -t 0 ]] && command -v gum >/dev/null 2>&1; then
  print_espanso_aur_workaround

  if gum confirm --default=false \
    'Bypass Espanso install while espanso-wayland AUR is broken?'; then
    printf 'Skipping Espanso installation so Chezmoi can continue.\n' >&2
    exit 0
  fi
fi
# TEMPORARY ESPANSO AUR BYPASS END

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
