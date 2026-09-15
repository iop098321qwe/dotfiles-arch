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

tmux_conf="${XDG_CONFIG_HOME:-$HOME/.config}/tmux/tmux.conf"
tpm_root="/usr/share/tmux-plugin-manager"
install_plugins="$tpm_root/bin/install_plugins"

if ! command -v tmux >/dev/null 2>&1; then
  printf 'Tmux plugin setup warning: tmux is not available.\n' >&2
  exit 0
fi

if ! command -v git >/dev/null 2>&1; then
  printf 'Tmux plugin setup warning: git is not available for plugin installation.\n' >&2
  exit 0
fi

if [[ ! -f $tmux_conf ]]; then
  printf 'Tmux plugin setup warning: %s does not exist.\n' "$tmux_conf" >&2
  exit 0
fi

if [[ ! -x $install_plugins ]]; then
  printf 'Tmux plugin setup warning: %s is not available.\n' "$install_plugins" >&2
  exit 0
fi

if ! spin 'Starting tmux server...' tmux start-server; then
  printf 'Tmux plugin setup warning: could not start the tmux server.\n' >&2
  exit 0
fi

if ! spin 'Loading tmux config...' tmux source-file "$tmux_conf"; then
  printf 'Tmux plugin setup warning: could not load %s.\n' "$tmux_conf" >&2
  exit 0
fi

if ! spin 'Installing tmux plugins...' "$install_plugins"; then
  printf 'Tmux plugin setup warning: plugin installation failed.\n' >&2
  exit 0
fi

if ! spin 'Reloading tmux config...' tmux source-file "$tmux_conf"; then
  printf 'Tmux plugin setup warning: plugins were installed, but the tmux config could not be reloaded.\n' >&2
fi
