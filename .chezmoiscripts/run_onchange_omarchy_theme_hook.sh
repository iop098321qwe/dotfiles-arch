#!/usr/bin/env bash

# Install install omarchy-theme-hook by imbypass
if ! command -v theme-hook-update >/dev/null 2>&1; then
  curl -fsSL https://imbypass.github.io/omarchy-theme-hook/install.sh | bash
else
  echo "omarchy-theme-hook already installed."
fi
