#!/usr/bin/env bash

# Update omarchy-theme-hook by imbypass
if gum confirm "Update omarchy-theme-hook?"; then
  echo "Commencing theme-hook-update update."
  if command -v thctl >/dev/null 2>&1; then
    thctl update
  else
    echo "thctl not found; skipping theme-hook update."
  fi
else
  echo "Skipping theme-hook-update update."
fi

exit 0
