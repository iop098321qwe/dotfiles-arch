#!/usr/bin/env bash

# Install Proton Pass CLI
if ! yay -Qs pass-cli &> /dev/null; then
  yay -S --noconfirm --needed proton-pass-cli-bin
else
  echo "proton-pass-cli-bin already installed."
fi
