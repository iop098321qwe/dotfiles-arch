#!/usr/bin/env bash

update=false
# Update omarchy-theme-hook by imbypass
if gum confirm "Update omarchy-theme-hook?"; then
  update=true
else
  update=false
fi

if [ $update == true ]; then
  echo "theme-hook-update updating..."
  theme-hook-update
else
  echo "theme-hook-update not updated."
fi
