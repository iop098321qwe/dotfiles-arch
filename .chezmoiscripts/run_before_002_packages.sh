#!/usr/bin/env bash

spin() {
  local title="$1"
  shift

  if [[ -t 2 ]] && command -v gum >/dev/null 2>&1; then
    gum spin --spinner dot --title "$title" -- "$@"
    return
  fi

  printf '%s\n' "$title" >&2
  "$@"
}

packages=(
  7zip
  aria2
  btop
  diffnav
  entr
  ffmpeg
  firefox
  git
  git-delta
  glow
  github-cli
  handbrake
  handbrake-cli
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
  tealdeer
  television
  tmux
  trash-cli
  ttf-jetbrains-mono-nerd
  uv
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
  sesh-bin
  t3code-bin
  ttl-bin
  tmux-plugin-manager
  tuxedo-bin
  vesktop-bin
  zennotes-bin
)

for package in "${packages[@]}"; do
  spin "Installing $package..." omarchy pkg add "$package"
done

for package in "${aur_packages[@]}"; do
  spin "Installing AUR package $package..." omarchy pkg aur add "$package"
done
