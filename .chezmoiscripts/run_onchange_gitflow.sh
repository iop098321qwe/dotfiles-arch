#!/bin/sh

# Install Git Flow
if ! yay -Qs git-flow &> /dev/null; then
  yay -S --noconfirm --needed gitflow-avh
else
  echo "git flow already installed."
fi

