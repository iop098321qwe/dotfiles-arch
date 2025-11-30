#!/usr/bin/env bash

# Install wireshark
if ! yay -Qs wireshark &> /dev/null; then
  yay -S --noconfirm --needed wireshark-qt
else
  echo "wireshark already installed."
fi

