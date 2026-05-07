#!/usr/bin/env bash

# Install fuck
if ! yay -Qs fuck &> /dev/null; then
  omarchy pkg aur add fuck
else
  echo "fuck already installed."
fi

