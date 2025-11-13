#!/bin/sh

# Install Proton Pass
if ! yay -Qs proton-pass-bin &> /dev/null; then
  yay -S --noconfirm --needed proton-pass-bin
else
  echo "proton-pass-bin already installed."
fi
