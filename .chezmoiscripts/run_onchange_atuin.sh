#!/bin/sh

# Install Atuin
if ! yay -Qs atuin &> /dev/null; then
  curl --proto '=https' --tlsv1.2 -LsSf https://setup.atuin.sh | sh
else
  echo "atuin already installed."
fi

