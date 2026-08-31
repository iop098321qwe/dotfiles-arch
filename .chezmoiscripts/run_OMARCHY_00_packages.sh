#!/usr/bin/env bash

packages=(
  7zip
  btop
  diffnav
  entr
  firefox
  git-delta
  glow
  harper
  intel-media-driver
  moreutils
  ncdu
  nmap
  npm
  openscad
  pandoc-cli
  proton-vpn-gtk-app
  python-curl_cffi
  solaar
  speedtest-cli
  tailscale
  television
  trash-cli
  ttf-jetbrains-mono-nerd
  ueberzugpp
  wireshark-cli
  wireshark-qt
  yazi
  yt-dlp
)

aur_packages=(
  bambustudio-appimage
  betterbird-bin
  blesh-git
  brave-bin
  brave-origin-bin
  gitflow-avh
  lazyssh-bin
  ocx
  opencode-bin
  powershell-bin
  proton-pass-bin
  proton-pass-cli-bin
  sesh-bin
  t3code-bin
  ttl-bin
  vesktop-bin
  zennotes-bin
)

for package in "${packages[@]}"; do
  omarchy pkg add "$package"
done

for package in "${aur_packages[@]}"; do
  omarchy pkg aur add "$package"
done
