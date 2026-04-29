#!/usr/bin/env bash

readonly HOSTNAME_VALUE="$(chezmoi execute-template '{{ .chezmoi.hostname }}')"
readonly SOURCE_DIR="$(chezmoi source-path)"
readonly TEMPLATE_DIR="${SOURCE_DIR}/.chezmoitemplates/hypr/monitors"
readonly HOST_TEMPLATE_FILE="${TEMPLATE_DIR}/${HOSTNAME_VALUE}.conf"
readonly LIVE_MONITORS_FILE="${HOME}/.config/hypr/monitors.conf"

case "${HOSTNAME_VALUE}" in
  "")
    printf 'ERROR: chezmoi hostname is empty. Cannot bootstrap monitors.conf.\n' >&2
    exit 1
    ;;
esac

mkdir -p "${TEMPLATE_DIR}"

case -f "${HOST_TEMPLATE_FILE}" in
  true)
    printf 'Hyprland monitors bootstrap skipped; host file already exists:\n  %s\n' "${HOST_TEMPLATE_FILE}"
    exit 0
    ;;
esac

case -f "${LIVE_MONITORS_FILE}" in
  true)
    cp -- "${LIVE_MONITORS_FILE}" "${HOST_TEMPLATE_FILE}"
    printf 'Hyprland monitors bootstrap created host file:\n  %s\n' "${HOST_TEMPLATE_FILE}"
    ;;
  false)
    cat > "${HOST_TEMPLATE_FILE}" <<EOF
# Hyprland monitors.conf for ${HOSTNAME_VALUE}
#
# This file was created automatically because no live monitors.conf existed at:
#   ${LIVE_MONITORS_FILE}
#
# Replace this placeholder with the correct Hyprland monitor configuration.
#
# Minimal fallback example:
# monitor=,preferred,auto,1
EOF

    printf 'Hyprland monitors bootstrap created placeholder host file:\n  %s\n' "${HOST_TEMPLATE_FILE}"
    ;;
esac
