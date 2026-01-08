#!/usr/bin/env bash

# Install trash-cli
if ! yay -Qs trash-cli &> /dev/null; then
  yay -S --noconfirm --needed trash-cli
else
  echo "trash-cli already installed."
fi

