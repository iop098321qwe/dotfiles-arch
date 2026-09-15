#!/usr/bin/env bash

default_pass_vault='Personal'

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
  tmux
  ttf-jetbrains-mono-nerd
  wireshark-cli
  wireshark-qt
  yazi
  yt-dlp
)

aur_packages=(
  bambustudio-appimage
  betterbird-bin
  blesh-git
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
  tmux-plugin-manager
  tuxedo
  vesktop-bin
  zennotes-bin
)

for package in "${packages[@]}"; do
  omarchy pkg add "$package"
done

for package in "${aur_packages[@]}"; do
  omarchy pkg aur add "$package"
done

if ! command -v pass-cli >/dev/null 2>&1; then
  printf 'Error: Proton Pass CLI is not available after package install.\n' >&2
  exit 1
fi

if ! pass-cli info >/dev/null 2>&1; then
  if [[ ! -t 0 ]]; then
    printf 'Error: Proton Pass authentication requires an interactive terminal.\n' >&2
    exit 1
  fi

  printf '\nProton Pass authentication is required.\n\n'
  pass-cli login --interactive
fi

if ! pass-cli info >/dev/null 2>&1; then
  printf 'Error: Proton Pass authentication failed.\n' >&2
  exit 1
fi

if ! pass-cli settings set default-vault \
  --vault-name "$default_pass_vault" >/dev/null; then
  printf 'Error: could not set Proton Pass default vault to Personal.\n' >&2
  exit 1
fi
