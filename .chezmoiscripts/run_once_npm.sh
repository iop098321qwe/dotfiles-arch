#!/usr/bin/env bash

# Install npm
if ! yay -Qs npm &> /dev/null; then
  yay -S --noconfirm --needed npm
else
  echo "npm already installed."
fi

