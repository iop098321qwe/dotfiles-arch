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
else
  echo "networkmanager already installed."
fi

systemctl enable networkmanager.service
systemctl start networkmanager.service

# Install network-manager-applet
if ! yay -Qs network-manager-applet &> /dev/null; then
  yay -S --noconfirm --needed network-manager-applet
else
  echo "network-manager-applet already installed."
fi
