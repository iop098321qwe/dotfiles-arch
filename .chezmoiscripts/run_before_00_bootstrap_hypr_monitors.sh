#!/usr/bin/env bash

require_command() {
  local command_name="$1"

  case "$(command -v "${command_name}" 2>/dev/null || true)" in
    "")
      printf 'ERROR: Required command not found: %s\n' "${command_name}" >&2
      exit 1
      ;;
  esac
}

get_chezmoi_hostname() {
  chezmoi execute-template '{{ .chezmoi.hostname }}'
}

get_chezmoi_source_dir() {
  chezmoi source-path
}

bootstrap_hypr_monitors() {
  local hostname_value
  local source_dir
  local template_dir
  local host_template_file
  local live_monitors_file

  hostname_value="$(get_chezmoi_hostname)"
  source_dir="$(get_chezmoi_source_dir)"

  case "${hostname_value}" in
    "")
      printf 'ERROR: chezmoi hostname is empty. Cannot bootstrap monitors.conf.\n' >&2
      exit 1
      ;;
  esac

  case "${source_dir}" in
    "")
      printf 'ERROR: chezmoi source directory is empty. Cannot bootstrap monitors.conf.\n' >&2
      exit 1
      ;;
  esac

  template_dir="${source_dir}/.chezmoitemplates/hypr/monitors"
  host_template_file="${template_dir}/${hostname_value}.conf"
  live_monitors_file="${HOME}/.config/hypr/monitors.conf"

  mkdir -p -- "${template_dir}"

  case -f "${host_template_file}" in
    true)
      printf 'Hyprland monitors bootstrap skipped; host file already exists:\n  %s\n' "${host_template_file}"
      return 0
      ;;
  esac

  case -f "${live_monitors_file}" in
    true)
      cp -- "${live_monitors_file}" "${host_template_file}"

      printf 'Hyprland monitors bootstrap created host file:\n  %s\n' "${host_template_file}"
      ;;
    false)
      cat > "${host_template_file}" <<EOF
# Hyprland monitors.conf for ${hostname_value}
#
# This file was created automatically because no live monitors.conf existed at:
#   ${live_monitors_file}
#
# Replace this placeholder with the correct Hyprland monitor configuration.
#
# Minimal fallback example:
# monitor=,preferred,auto,1
EOF

      printf 'Hyprland monitors bootstrap created placeholder host file:\n  %s\n' "${host_template_file}"
      ;;
  esac
}

main() {
  require_command chezmoi
  bootstrap_hypr_monitors
}

main "$@"
