#!/usr/bin/env bash

# Upgrade cbc modules
if gum confirm "Would you like to update cbc modules?"; then
  if command -v cbc &> /dev/null; then
    cbc pkg update
  else
    echo "cbc is not installed."
  fi
else
  echo "Skipping cbc modules update."
fi
