#!/bin/sh

# Install Vesktop
if ! yay -Qs vesktop &> /dev/null; then
  yay -S --noconfirm --needed vesktop-bin
else
  echo "vesktop already installed."
fi
