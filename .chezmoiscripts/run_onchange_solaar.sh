#!/usr/bin/env bash

# Install solaar
if ! yay -Qs solaar &> /dev/null; then
  yay -S --noconfirm --needed solaar
else
  echo "solaar already installed."
fi

