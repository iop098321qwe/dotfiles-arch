#!/usr/bin/env bash

# Install Brave Origin Browser
if ! yay -Qs brave-origin-nightly &> /dev/null; then
  yay -S --noconfirm --needed brave-origin-nightly-bin
else
  echo "Brave Origin Browser already installed."
fi

