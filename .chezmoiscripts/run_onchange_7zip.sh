#!/usr/bin/env bash

# Install install 7zip
if ! command -v 7z >/dev/null 2>&1; then
  yay -S --noconfirm --needed 7zip
else
  echo "7zip already installed."
fi
