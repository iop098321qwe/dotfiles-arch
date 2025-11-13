#!/bin/sh

# Install Espanso
if ! yay -Qs espanso &> /dev/null; then
  yay -S --noconfirm --needed espanso-wayland
  espanso service register
  espanso start
else
  echo "espanso already installed."
fi
