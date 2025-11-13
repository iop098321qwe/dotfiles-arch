#!/bin/sh

# Install Betterbird
if ! yay -Qs betterbird &> /dev/null; then
  yay -S --noconfirm --needed betterbird-bin
else
  echo "betterbird already installed."
fi

