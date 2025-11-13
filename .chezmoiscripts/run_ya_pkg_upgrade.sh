#!/bin/sh

# Upgrade ya packages
if yay -Qs yazi &> /dev/null; then
  ya pkg upgrade || ya pkg install
else
  echo "yazi is not installed."
fi

