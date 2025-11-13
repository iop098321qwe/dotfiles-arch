#!/bin/sh

# Install Proton VPN
if ! yay -Qs proton-vpn-gtk-app &> /dev/null; then
  yay -S --noconfirm --needed proton-vpn-gtk-app
else
  echo "proton-vpn-gtk-app already installed."
fi
