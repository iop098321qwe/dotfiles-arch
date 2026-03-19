#!/usr/bin/env bash

# Install speedtest
if ! yay -Qs speedtest &> /dev/null; then
  yay -S --noconfirm --needed speedtest-cli
else
  echo "speedtest already installed."
fi

