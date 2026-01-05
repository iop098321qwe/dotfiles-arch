#!/usr/bin/env bash

# Install sshs
if ! yay -Qs sshs &> /dev/null; then
  yay -S --noconfirm --needed sshs
else
  echo "sshs already installed."
fi

