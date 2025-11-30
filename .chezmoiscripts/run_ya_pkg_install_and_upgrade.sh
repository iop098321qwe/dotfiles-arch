#!/usr/bin/env bash

# Update Spicetify
if command -v spotify >/dev/null 2>&1; then
  if command -v spicetify >/dev/null 2>&1; then
    if gum confirm "Would you like to update Spicetify?"; then
      spicetify
      spicetify backup apply enable-devtools
      spicetify update
    else
      echo "Skipping Spicetify update."
    fi
  else
    echo "Spicetify is not installed."
  fi
else
  echo "Spotify is not installed."
fi
