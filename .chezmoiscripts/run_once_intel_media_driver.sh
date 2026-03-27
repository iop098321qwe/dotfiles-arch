#!/usr/bin/env bash

# Install Intel Media Driver
yay -S --noconfirm --needed intel-media-driver

if ! yay -Qs intel-media-driver &> /dev/null; then
  yay -S --noconfirm --needed intel-media-driver
else
  echo "intel-media-driver already installed."
fi
