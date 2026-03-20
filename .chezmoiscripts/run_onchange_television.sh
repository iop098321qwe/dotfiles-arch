#!/usr/bin/env bash

# Install television
if ! yay -Qs television &> /dev/null; then
  yay -S --noconfirm --needed television
else
  echo "television already installed."
fi

