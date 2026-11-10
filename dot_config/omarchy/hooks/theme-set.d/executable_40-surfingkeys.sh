#!/usr/bin/env bash
set -euo pipefail

# Omarchy 4.5 invokes hooks after committing the palette to local state.
# Use Arch's Node rather than a shell-initialized version-manager shim.
export PATH="${OMARCHY_PATH:-/usr/share/omarchy}/bin:/usr/bin:${PATH:-}"
state_dir="${XDG_STATE_HOME:-$HOME/.local/state}/omarchy"
mkdir -p "$state_dir"
log_file="$state_dir/surfingkeys-theme.log"

if timeout --kill-after=2s 10s /usr/bin/node \
  "$HOME/.config/surfingkeys/omarchy-theme.cjs" publish \
  >"$log_file" 2>&1; then
  printf 'Published palette for %s at %s\n' \
    "${1:-current theme}" "$(date --iso-8601=seconds)" >>"$log_file"
else
  status=$?
  printf 'Surfingkeys theme hook failed (%s); see %s\n' \
    "$status" "$log_file" >&2
  exit "$status"
fi
