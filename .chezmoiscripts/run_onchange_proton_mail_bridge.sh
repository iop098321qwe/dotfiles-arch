#!/usr/bin/env bash

# Install Proton Mail Bridge
if ! yay -Qs protonmail-bridge &> /dev/null; then
  yay -S --noconfirm --needed protonmail-bridge
  systemctl --user enable protonmail-bridge
  systemctl --user start protonmail-bridge   
else
  echo "protonmail-bridge already installed."
fi

