#!/bin/sh

# Install Yazi
if ! yay -Qs yazi &> /dev/null; then
  yay -S --noconfirm --needed yazi-bin
else
  echo "yazi already installed."
fi

