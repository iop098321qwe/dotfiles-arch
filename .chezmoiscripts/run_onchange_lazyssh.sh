#!/usr/bin/env bash

# Install pandoc
if ! yay -Qs pandoc &> /dev/null; then
  yay -S --noconfirm --needed pandoc-cli
else
  echo "pandoc already installed."
fi

