#!/usr/bin/env bash

# Install entr
if ! yay -Qs entr &> /dev/null; then
  yay -S --noconfirm --needed entr
else
  echo "entr already installed."
fi

