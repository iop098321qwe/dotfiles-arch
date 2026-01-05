#!/usr/bin/env bash

# Install tailscale
if ! yay -Qs tailscale &> /dev/null; then
  curl -fsSL https://tailscale.com/install.sh | sh
  sudo tailscale up
else
  echo "tailscale already installed."
fi

