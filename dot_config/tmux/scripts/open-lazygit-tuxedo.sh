#!/usr/bin/env bash
set -euo pipefail

source_pane="${1:?Expected the originating tmux pane ID}"
script_directory="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
session_id="$(tmux display-message -p -t "$source_pane" '#{session_id}')"

# Keep the two launchers and the final focus change together on repeated presses.
lock_directory="${XDG_RUNTIME_DIR:-/tmp}"
exec 8>"$lock_directory/tmux-lazygit-tuxedo-${UID}.lock"
flock 8

# Preserve focus when invoked from either application.
source_command="$(
    tmux display-message -p -t "$source_pane" '#{pane_current_command}'
)"

# The plugin reads the active pane to preserve its origin/editor integration.
tmux select-window -t "$source_pane"
tmux select-pane -t "$source_pane"
bash "$script_directory/../plugins/tmux-neolazygit/scripts/open-lazygit.sh"
lazygit_window="$(
    tmux show-options -t "$session_id" -qv '@neolazygit-window-id'
)"
lazygit_pane="$(
    tmux display-message -p -t "$lazygit_window" '#{pane_id}'
)"

# Pass the original pane so Tuxedo uses the directory where Y was pressed.
bash "$script_directory/open-tuxedo.sh" "$source_pane"

case "$source_command" in
    lazygit|tuxedo) focus_pane="$source_pane" ;;
    *) focus_pane="$lazygit_pane" ;;
esac

tmux select-window -t "$focus_pane"
tmux select-pane -t "$focus_pane"
