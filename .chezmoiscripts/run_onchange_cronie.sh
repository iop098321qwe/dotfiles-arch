#!/usr/bin/env bash

# Install cronie
if ! yay -Qs cronie &> /dev/null; then
  yay -S --noconfirm --needed cronie
  sudo systemctl enable --now cronie.service   
else
  echo "cronie already installed."
fi

