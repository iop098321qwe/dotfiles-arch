#!/usr/bin/env bash

# Install btop
if ! yay -Qs btop &> /dev/null; then
  omarchy pkg aur add fuck
else
  echo "btop already installed."
fi

