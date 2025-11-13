#!/bin/sh

# Install Atuin
if ! yay -Qs atuin &> /dev/null; then
  yay -S --noconfirm --needed atuin
else
  echo "atuin already installed."
fi

