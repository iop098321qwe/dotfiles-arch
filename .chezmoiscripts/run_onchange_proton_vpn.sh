#!/usr/bin/env bash

# Install Proton VPN
if ! yay -Qs proton-vpn-gtk-app &> /dev/null; then
  yay -S --noconfirm --needed proton-vpn-gtk-app
else
  echo "proton-vpn-gtk-app already installed."
fi

# Install networkmanager
if ! yay -Qs networkmanager &> /dev/null; then
  yay -S --noconfirm --needed networkmanager
  yay -S --noconfirm --needed network-manager-applet
  systemctl enable networkmanager.service
  systemctl start networkmanager.service
else
  echo "networkmanager already installed."
fi
