#!/usr/bin/env bash

# Install gh dash
if ! yay -Qs gh dash &> /dev/null; then
  gh extension install dlvhdr/gh-dash
else
  echo "gh dash already installed."
fi

