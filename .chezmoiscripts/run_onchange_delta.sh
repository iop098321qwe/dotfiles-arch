#!/usr/bin/env bash

# Install delta diff tool
if ! yay -Qs delta &> /dev/null; then
  yay -S --noconfirm --needed git-delta
else
  echo "delta already installed."
fi


