#!/usr/bin/env bash

# Install gh license
if ! yay -Qs gh license &> /dev/null; then
  gh extension install Shresht7/gh-license
else
  echo "gh license already installed."
fi

