#!/usr/bin/env bash

# Install Linux Headers, EVDI, and DisplayLink
omarchy pkg aur add evdi-dkms displaylink
omarchy pkg add linux-headers

if gum confirm "Enable DisplayLink Drivers?"; then

  # Load udl kernel module
  sudo modprobe udl

  # Enable and start displaylink service
  sudo systemctl enable --now displaylink.service

  if gum confirm "Reboot to load DisplayLink Drivers and udl module?"; then
    reboot now
  else
    echo "Skipping reboot... "
    echo "Reboot to enable DisplayLink drivers."
  fi
else
  echo "Skipping DisplayLink Drivers installation."
fi
