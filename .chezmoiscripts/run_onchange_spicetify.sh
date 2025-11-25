#!/bin/sh

# Install spicetify
if ! yay -Qs spicetify &> /dev/null; then
  yay -S --noconfirm --needed spicetify-cli
else
  echo "spicetify already installed."
fi

