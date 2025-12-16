#!/usr/bin/env bash

# Install hyprdynamicmonitors
if ! yay -Qs hyprdynamicmonitors &> /dev/null; then
  yay -S --noconfirm --needed hyprdynamicmonitors-bin
else
  echo "hyprdynamicmonitors already installed."
fi

