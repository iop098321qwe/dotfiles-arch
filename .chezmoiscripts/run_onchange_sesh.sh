#!/usr/bin/env bash

# Install sesh
if ! yay -Qs sesh &> /dev/null; then
  yay -S --noconfirm --needed sesh-bin
else
  echo "sesh already installed."
fi

