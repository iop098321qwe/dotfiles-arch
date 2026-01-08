#!/usr/bin/env bash

# Install Yazi
if ! yay -Qs yazi &> /dev/null; then
  yay -S --noconfirm --needed yazi
else
  echo "yazi already installed."
fi

