#!/bin/sh

# Install espanso-wayland
if ! yay -Qs espanso-wayland &> /dev/null; then
  yay -S --noconfirm --needed espanso-wayland
fi
