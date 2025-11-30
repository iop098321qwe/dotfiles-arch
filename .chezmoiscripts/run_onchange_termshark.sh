#!/usr/bin/env bash

# Install termshark
if ! yay -Qs termshark &> /dev/null; then
  yay -S --noconfirm --needed termshark
else
  echo "termshark already installed."
fi

