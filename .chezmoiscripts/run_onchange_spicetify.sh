#!/bin/sh

# Install spicetify
if ! yay -Qs spicetify &> /dev/null; then
  yay -S --noconfirm --needed spicetify-cli
  sudo chmod a+wr /opt/spotify
  sudo chmod a+wr /opt/spotify/Apps -R
  spicetify
  spicetify backup apply enable-devtools
  spicetify update
else
  echo "spicetify already installed."
fi

