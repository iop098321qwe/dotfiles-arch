#!/usr/bin/env bash

# Install openscad
if ! yay -Qs openscad &> /dev/null; then
  yay -S --noconfirm --needed openscad
else
  echo "openscad already installed."
fi

