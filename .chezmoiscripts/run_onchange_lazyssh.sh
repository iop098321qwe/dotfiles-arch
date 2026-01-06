#!/usr/bin/env bash

# Install lazyssh
if ! yay -Qs lazyssh &> /dev/null; then
  yay -S --noconfirm --needed lazyssh
else
  echo "lazyssh already installed."
fi

