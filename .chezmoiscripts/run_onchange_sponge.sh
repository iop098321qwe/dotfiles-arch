#!/bin/sh

# Install Sponge
if ! yay -Qs sponge &> /dev/null; then
  yay -S --noconfirm --needed sponge
else
  echo "sponge already installed."
fi

