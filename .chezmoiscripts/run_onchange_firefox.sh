#!/usr/bin/env bash

# Install Firefox
if ! yay -Qs firefox &> /dev/null; then
  yay -S --noconfirm --needed firefox
else
  echo "firefox already installed."
fi

