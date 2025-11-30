#!/usr/bin/env bash

# Install nmap
if ! yay -Qs nmap &> /dev/null; then
  yay -S --noconfirm --needed nmap
else
  echo "nmap already installed."
fi

