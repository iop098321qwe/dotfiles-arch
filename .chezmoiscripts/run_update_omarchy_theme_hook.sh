#!/usr/bin/env bash

update=false
# Update omarchy-theme-hook by imbypass
if gum confirm "Update omarchy-theme-hook?"; then
  update=true
else
  update=false
fi

if [ $update == true ]; then
  echo "Commencing theme-hook-update update."
  theme-hook-update
else
  echo "Skipping theme-hook-update update."
fi
