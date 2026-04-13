#!/usr/bin/env bash

# Install glow
if ! yay -Qs glow &> /dev/null; then
  yay -S --noconfirm --needed glow
else
  echo "glow already installed."
fi

