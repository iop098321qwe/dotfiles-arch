#!/usr/bin/env bash

# Install Sponge
if ! yay -Qs sponge &> /dev/null; then
  yay -S --noconfirm --needed moreutils
else
  echo "sponge already installed."
fi

