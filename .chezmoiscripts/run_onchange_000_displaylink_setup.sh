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

# Install Linux Headers, EVDI, and DisplayLink
spin 'Installing DisplayLink packages...' \
  omarchy pkg aur add evdi-dkms displaylink
spin 'Installing Linux headers...' omarchy pkg add linux-headers

if gum confirm --default=false "Enable DisplayLink Drivers?"; then

  # Load udl kernel module
  spin 'Loading udl kernel module...' sudo modprobe udl

  # Enable and start displaylink service
  spin 'Starting DisplayLink service...' \
    sudo systemctl enable --now displaylink.service

  if gum confirm --default=false \
    "Reboot to load DisplayLink Drivers and udl module?"; then
    reboot now
  else
    echo "Skipping reboot... "
    echo "Reboot to enable DisplayLink drivers."
  fi
else
  echo "Skipping DisplayLink Drivers installation."
fi
