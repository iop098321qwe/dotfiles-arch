#!/usr/bin/env bash

set -euo pipefail

readonly SPICETIFY_THEME_DIR="$HOME/.config/spicetify/Themes/omarchy"
readonly SPICETIFY_COLOR_FILE="$SPICETIFY_THEME_DIR/color.ini"
readonly SPICETIFY_STATE_DIR="${SPICETIFY_STATE:-${XDG_STATE_HOME:-$HOME/.local/state}/spicetify}"
readonly SPICETIFY_BACKUP_DIR="$SPICETIFY_STATE_DIR/Backup"
readonly SPOTIFY_PREFS="$HOME/.config/spotify/prefs"
readonly QUATTRO_COLORS_FILE="$HOME/.local/state/omarchy/current/theme/colors.toml"
# TODO(Omarchy Quattro): Remove this fallback after all managed hosts run v4+.
readonly LEGACY_COLORS_FILE="$HOME/.config/omarchy/current/theme/colors.toml"

if ! command -v spicetify >/dev/null 2>&1; then
  exit 0
fi

if [[ ! -f "$SPOTIFY_PREFS" ]]; then
  exit 0
fi

if [[ -f "$QUATTRO_COLORS_FILE" ]]; then
  colors_file="$QUATTRO_COLORS_FILE"
elif [[ -f "$LEGACY_COLORS_FILE" ]]; then
  colors_file="$LEGACY_COLORS_FILE"
else
  printf 'Spicetify theme skipped: Omarchy colors.toml was not found.\n' >&2
  exit 0
fi

read_legacy_color() {
  local key="$1"

  awk -F= -v key="$key" '
    /^[[:space:]]*#/ { next }
    {
      name = $1
      gsub(/[[:space:]]/, "", name)
      if (name == key && match($0, /#[[:xdigit:]]{6}/)) {
        print substr($0, RSTART, RLENGTH)
        exit
      }
    }
  ' "$colors_file"
}

normalize_color() {
  local value="$1"

  if [[ $value =~ ^#?([[:xdigit:]]{6})([[:xdigit:]]{2})?$ ]]; then
    printf '%s\n' "${BASH_REMATCH[1],,}"
    return 0
  fi

  return 1
}

find_color() {
  local key value normalized

  for key in "$@"; do
    if command -v omarchy-theme-color >/dev/null 2>&1; then
      value=$(omarchy-theme-color --file "$colors_file" "$key" 2>/dev/null || true)
      if normalized=$(normalize_color "$value"); then
        printf '%s\n' "$normalized"
        return 0
      fi
    fi

    value=$(read_legacy_color "$key")
    if normalized=$(normalize_color "$value"); then
      printf '%s\n' "$normalized"
      return 0
    fi
  done

  return 1
}

resolve_color() {
  local default="$1"
  local value
  shift

  if value=$(find_color "$@"); then
    printf '%s\n' "$value"
  else
    printf '%s\n' "$default"
  fi
}

spotify_prefs_version() {
  awk -F'"' '$1 == "app.last-launched-version=" { print $2; exit }' "$SPOTIFY_PREFS"
}

backup_config_value() {
  local key="$1"
  local config_file

  config_file=$(spicetify -c)
  awk -F= -v key="$key" '
    $0 == "[Backup]" { in_backup = 1; next }
    /^\[/ { in_backup = 0 }
    in_backup {
      name = $1
      gsub(/[[:space:]]/, "", name)
      if (name == key) {
        value = $2
        gsub(/[[:space:]]/, "", value)
        print value
        exit
      }
    }
  ' "$config_file"
}

primary_background=$(resolve_color 121212 background color0)
primary_foreground=$(resolve_color ffffff foreground color7)
normal_black=$(resolve_color "$primary_background" color0 background)
bright_black=$(resolve_color "$primary_background" color8 color0 background)
normal_white=$(resolve_color "$primary_foreground" color7 foreground)
bright_white=$(resolve_color "$primary_foreground" color15 foreground color7)
normal_red=$(resolve_color e22134 red color1)
normal_green=$(resolve_color 1ed760 green color2 accent color4)

mkdir -p "$SPICETIFY_THEME_DIR"
temporary_color_file=$(mktemp)
trap 'rm -f "$temporary_color_file"' EXIT

cat >"$temporary_color_file" <<EOF
[base]
main                = $primary_background
player              = $primary_background
card                = $primary_background
main-elevated       = $primary_background
sidebar             = $primary_background
shadow              = $primary_background
notification        = $bright_black
button-disabled     = $bright_black
misc                = $normal_white
selected-row        = $normal_white
button              = $normal_white
highlight           = $bright_white
highlight-elevated  = $normal_black
tab-active          = $bright_black
notification-error  = $normal_red
button-active       = $normal_green
subtext             = $normal_white
text                = $primary_foreground
EOF

if ! cmp -s "$temporary_color_file" "$SPICETIFY_COLOR_FILE"; then
  mv "$temporary_color_file" "$SPICETIFY_COLOR_FILE"
fi

spicetify config \
  current_theme omarchy \
  color_scheme base \
  replace_colors 1 \
  inject_css 1 >/dev/null

if [[ ${OMARCHY_SPICETIFY_SKIP_APPLY:-0} == 1 ]]; then
  exit 0
fi

if ! command -v spotify >/dev/null 2>&1; then
  exit 0
fi

spotify_version=$(spotify --version | awk '{ print $3 }' | tr -d ',')
prefs_version=$(spotify_prefs_version)
spicetify_version=$(NO_COLOR=1 spicetify --version)
backup_spotify_version=$(backup_config_value version)
backup_spicetify_version=$(backup_config_value with)

if [[ $prefs_version != "$spotify_version" ||
  $backup_spotify_version != "$spotify_version" ||
  $backup_spicetify_version != "$spicetify_version" ||
  -z $(find "$SPICETIFY_BACKUP_DIR" -maxdepth 1 -type f -name '*.spa' -print -quit 2>/dev/null) ]]; then
  printf 'Spicetify theme apply skipped: run chezmoi apply to refresh the Spotify backup.\n' >&2
  exit 0
fi

if pgrep -x spotify >/dev/null 2>&1; then
  spicetify apply
else
  spicetify -n apply
fi
