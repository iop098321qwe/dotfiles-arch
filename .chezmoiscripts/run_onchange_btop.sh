#!/usr/bin/env bash

# Install btop
if ! yay -Qs btop &> /dev/null; then
  yay -S --noconfirm --needed btop
else
  echo "btop already installed."
fi

