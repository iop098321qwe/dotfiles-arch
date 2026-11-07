#!/usr/bin/env bash
set -euo pipefail

[[ $(uname -s) == Linux ]] || exit 0
if ! command -v omarchy >/dev/null 2>&1 && [[ ! -d /usr/share/omarchy ]]; then
  exit 0
fi

export PATH="${OMARCHY_PATH:-/usr/share/omarchy}/bin:/usr/bin:${PATH:-}"
if ! command -v omarchy-theme-color >/dev/null 2>&1; then
  printf '%s\n' 'Skipping Surfingkeys palette: omarchy-theme-color is unavailable.' >&2
  exit 0
fi

# Initialize without changing the desktop theme or enabling browser extensions.
bash "$HOME/.config/omarchy/hooks/theme-set.d/40-surfingkeys.sh"
