#!/usr/bin/env bash

# Install Proton Pass
if ! yay -Qs proton-pass &> /dev/null; then
  yay -S --noconfirm --needed proton-pass-bin
else
  echo "proton-pass-bin already installed."
fi
