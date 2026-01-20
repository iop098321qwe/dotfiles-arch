#!/usr/bin/env bash

# Install rustdesk-bin
if ! yay -Qs rustdesk-bin &> /dev/null; then
  yay -S --noconfirm --needed rustdesk-bin
else
  echo "rustdesk already installed."
fi

