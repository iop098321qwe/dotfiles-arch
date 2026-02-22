#!/usr/bin/env bash

# Update omarchy-theme-hook by imbypass
if gum confirm "Update omarchy-theme-hook?"; then
  echo "Commencing theme-hook-update update."
  thctl update
else
  echo "Skipping theme-hook-update update."
fi
