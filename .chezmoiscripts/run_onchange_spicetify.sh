#!/bin/sh

# Check if Spotify is installed
if command -v spotify >/dev/null 2>&1; then
  # Spotify found, now check if Spicetify is installed
  if ! command -v spicetify >/dev/null 2>&1; then
    yay -S --noconfirm --needed spicetify-cli

    sudo chmod a+wr /opt/spotify
    sudo chmod a+wr /opt/spotify/Apps -R

    spicetify
    spicetify backup apply enable-devtools
    spicetify update
  else
    echo "spicetify already installed."
  fi
else
  echo "Spotify is not installed. Skipping Spicetify setup."
fi
