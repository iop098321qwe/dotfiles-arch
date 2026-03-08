#!/usr/bin/env bash

# Install diffnav
if ! yay -Qs diffnav &> /dev/null; then
  yay -S --noconfirm --needed diffnav-bin
else
  echo "diffnav already installed."
fi

