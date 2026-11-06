#!/usr/bin/env bash
set -euo pipefail

source_pane="${1:?Expected the originating tmux pane ID}"
session_id="$(tmux display-message -p -t "$source_pane" '#{session_id}')"
directory="$HOME/Documents/grymms_grimoires/10000_work/14000_daily_summaries/2026"

# Serialize lookup and creation, including rapid repeated keypresses.
lock_directory="${XDG_RUNTIME_DIR:-/tmp}"
exec 9>"$lock_directory/tmux-daily-summaries-${UID}.lock"
flock 9

while IFS= read -r pane_id; do
    # The marker survives navigation inside Yazi; closed panes disappear.
    state="$(
        tmux display-message -p -t "$pane_id" \
            '#{@daily-summaries}:#{pane_dead}' 2>/dev/null
    )" || continue
    [[ "$state" == "1:0" ]] || continue

    tmux select-window -t "$pane_id"
    tmux select-pane -t "$pane_id"
    exit 0
done < <(tmux list-panes -s -t "$session_id" -F '#{pane_id}')

pane_id="$(tmux new-window -d -P -F '#{pane_id}' \
    -t "${session_id}:" -c "$directory" 'yazi')"
tmux set-option -p -t "$pane_id" @daily-summaries 1
tmux select-window -t "$pane_id"
tmux select-pane -t "$pane_id"
