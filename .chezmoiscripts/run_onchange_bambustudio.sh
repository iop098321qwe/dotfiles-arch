#!/usr/bin/env bash

# Install bambustudio
if ! yay -Qs bambustudio &> /dev/null; then
  yay -S --noconfirm --needed bambustudio-appimage
else
  echo "bambustudio already installed."
fi

