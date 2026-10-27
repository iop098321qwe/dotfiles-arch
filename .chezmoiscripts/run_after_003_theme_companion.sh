#!/usr/bin/env bash

set -euo pipefail

# No browser integration is needed on non-Linux or non-Omarchy machines.
[[ $(uname -s) == Linux ]] || exit 0
if ! command -v omarchy >/dev/null 2>&1 && [[ ! -d /usr/share/omarchy ]]; then
  exit 0
fi

# Update this pin intentionally when deploying a new companion version.
revision='fc12e5d7a78ff70becab040fa2eddc69c8eea629'
repository='iop098321qwe/main_page'
cache="${XDG_CACHE_HOME:-$HOME/.cache}/grymm-theme-companion"
source_dir="$cache/$revision"

python3 -c 'import sys; assert sys.version_info >= (3, 11)' || {
  printf '%s\n' 'Theme companion requires Python 3.11 or newer.' >&2
  exit 1
}

if [[ ! -f "$source_dir/.complete" ]]; then
  # The companion repository is private. Reuse Chezmoi's GitHub CLI login;
  # never embed tokens in dotfiles, URLs, or the installed native host.
  gh auth status --hostname github.com >/dev/null 2>&1 || {
    printf '%s\n' 'Theme companion needs gh auth login for GitHub.' >&2
    exit 1
  }
  mkdir -p "$cache"
  temporary=$(mktemp -d "$cache/.download.XXXXXX")
  trap 'rm -rf -- "$temporary"' EXIT
  mkdir -p "$temporary/extension"
  files=(
    install.py native_host.py extension/manifest.json
    extension/background.js extension/content.js
  )
  for file in "${files[@]}"; do
    gh api --hostname github.com \
      -H 'Accept: application/vnd.github.raw+json' \
      "repos/$repository/contents/companion/$file?ref=$revision" \
      > "$temporary/$file"
  done
  printf '%s\n' "$revision" > "$temporary/.complete"
  mv -T -- "$temporary" "$source_dir"
  trap - EXIT
fi

# Idempotent registration repairs removed files on the next apply. Browser
# extension enablement still requires one manual step in each Brave profile.
python3 "$source_dir/install.py" --browser brave-origin --browser brave
