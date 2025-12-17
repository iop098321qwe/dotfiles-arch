#!/usr/bin/env bash

# Install Brave Browser
if ! yay -Qs brave &> /dev/null; then
  yay -S --noconfirm --needed brave-bin
else
  echo "brave browser already installed."
fi

