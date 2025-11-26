#!/usr/bin/env bash

# Install install omarchy-theme-hook by imbypass
# if gum confirm "Install omarchy-theme-hook by imbypass?"; then
#   curl -fsSL https://imbypass.github.io/omarchy-theme-hook/install.sh | bash
# fi

if ! yay -Qs theme-hook-update &> /dev/null; then
  curl -fsSL https://imbypass.github.io/omarchy-theme-hook/install.sh | bash
else
  echo "omarchy-theme-hook already installed."
fi

