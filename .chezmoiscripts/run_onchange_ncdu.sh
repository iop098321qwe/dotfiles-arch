#!/usr/bin/env bash

# Install ncdu
if ! yay -Qs ncdu &> /dev/null; then
  yay -S --noconfirm --needed ncdu
else
  echo "ncdu already installed."
fi

