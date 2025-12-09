#!/usr/bin/env bash

# Install harper
if ! yay -Qs harper &> /dev/null; then
  yay -S --noconfirm --needed harper
else
  echo "harper already installed."
fi

