#!/usr/bin/env bash

set -euo pipefail

pane=${1:?Missing tmux pane ID}
client=${2:?Missing tmux client name}
palette="$HOME/.local/state/omarchy/current/theme/colors.toml"

# Read fresh colors for every popup; no tmux restart or theme hook is needed.
background=default
foreground=default
accent=blue
if [[ -f $palette ]] && command -v omarchy-theme-color >/dev/null 2>&1; then
  while IFS=$'\t' read -r key color; do
    [[ $color =~ ^#[[:xdigit:]]{6}$ ]] || continue
    case "$key" in
      background) background=$color ;;
      foreground) foreground=$color ;;
      accent) accent=$color ;;
    esac
  done < <(omarchy-theme-color --file "$palette" --all)
fi

directory=$(tmux display-message -p -t "$pane" '#{pane_current_path}')
exec tmux display-popup -E -c "$client" -t "$pane" -w 80% -h 70% \
  -d "$directory" -T 'Sesh' -b rounded \
  -s "bg=$background,fg=$foreground" \
  -S "bg=$background,fg=$accent" \
  tv sesh
