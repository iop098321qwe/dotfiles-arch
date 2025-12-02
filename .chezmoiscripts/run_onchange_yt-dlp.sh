#!/usr/bin/env bash

# Install yt-dlp
if ! yay -Qs yt-dlp &> /dev/null; then
  yay -S --noconfirm --needed yt-dlp
else
  echo "yt-dlp already installed."
fi

