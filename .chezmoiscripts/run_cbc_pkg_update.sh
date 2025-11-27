#!/usr/bin/env bash

# Upgrade cbc modules
if gum confirm "Would you like to update cbc modules?"; then
  cbc pkg update
else
  echo "Skipping cbc modules update."
fi
