#!/usr/bin/env bash
set -euo pipefail

source_pane="${1:?Expected the originating tmux pane ID}"

session_id="$(tmux display-message -p -t "$source_pane" '#{session_id}')"
directory="$(tmux display-message -p -t "$source_pane" '#{pane_current_path}')"

# Serialize requests so rapid repeated keypresses do not create duplicates.
lock_directory="${XDG_RUNTIME_DIR:-/tmp}"
exec 9>"$lock_directory/tmux-tuxedo-${UID}.lock"
flock 9

while IFS= read -r pane_id; do
    # A pane may disappear between listing and inspection.
    command="$(
        tmux display-message -p -t "$pane_id" \
            '#{pane_current_command}' 2>/dev/null
    )" || continue

    [[ "$command" == "tuxedo" ]] || continue

    pane_directory="$(
        tmux display-message -p -t "$pane_id" \
            '#{pane_current_path}' 2>/dev/null
    )" || continue

    [[ "$pane_directory" == "$directory" ]] || continue

    tmux select-window -t "$pane_id"
    tmux select-pane -t "$pane_id"
    exit 0
done < <(tmux list-panes -s -t "$session_id" -F '#{pane_id}')

tmux new-window -t "${session_id}:" -c "$directory" "tuxedo"
