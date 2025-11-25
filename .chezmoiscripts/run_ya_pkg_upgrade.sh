#!/bin/sh

# Upgrade ya packages
if yay -Qs yazi &> /dev/null; then
  ya pkg install && ya pkg upgrade
else
  echo "yazi is not installed."
fi

