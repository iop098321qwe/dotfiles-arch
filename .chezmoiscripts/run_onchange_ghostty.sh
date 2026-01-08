#!/usr/bin/env bash

# Install Ghostty
if ! yay -Qs ghostty &> /dev/null; then
  yay -S --noconfirm --needed ghostty
else
  echo "ghostty already installed."
fi

