#!/usr/bin/env bash

# Install Atuin
if ! yay -Qs atuin &> /dev/null; then
  curl --proto '=https' --tlsv1.2 -LsSf https://setup.atuin.sh | sh
else
  echo "atuin already installed."
fi

if ! yay -Qs blesh &> /dev/null; then
  yay -S --noconfirm --needed blesh-git
else
  echo "blesh already installed."
fi
