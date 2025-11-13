#!/bin/sh

# Install Flameshot
if ! yay -Qs flameshot &> /dev/null; then
  yay -S --noconfirm --needed flameshot
else
  echo "flameshot already installed."
fi

