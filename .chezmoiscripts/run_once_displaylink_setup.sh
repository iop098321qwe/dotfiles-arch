#!/usr/bin/env bash

if gum confirm "Install DisplayLink Drivers?"; then
  # Install Linux Headers, EVDI, and DisplayLink
  yay -S --noconfirm --needed linux-headers evdi-dkms displaylink
  
  # Load udl kernel module
  sudo modprobe udl
  
  # Enable displaylink service
  sudo systemctl enable displaylink.service
  
  # Start displaylink service
  sudo systemctl start displaylink.service
  
  if gum confirm "Reboot to load DisplayLink Drivers and udl module?"; then
    reboot now
  else
    echo "Skipping reboot... Please ensure you reboot to enable DisplayLink drivers."
  fi
else
  echo "Skipping DisplayLink Drivers installation."
fi
