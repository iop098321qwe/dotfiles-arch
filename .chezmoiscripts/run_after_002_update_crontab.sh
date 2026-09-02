#!/usr/bin/env bash

CRON_FILE="$HOME/.config/cron/crontab.current"

log_info()  { printf '%s\n' "$*"; }
log_warn()  { printf 'Warning: %s\n' "$*" >&2; }
log_error() { printf 'Error: %s\n' "$*" >&2; }

# Must exist
if [[ ! -f "$CRON_FILE" ]]; then
  echo "Error: $CRON_FILE does not exist."
  exit 0
fi

# Must not be empty
if [[ ! -s "$CRON_FILE" ]]; then
  echo "Error: $CRON_FILE is empty. Refusing to apply."
  exit 0
fi

# Must be syntactically valid
if ! crontab -T "$CRON_FILE" >/dev/null 2>&1; then
  echo "Error: $CRON_FILE contains invalid cron syntax."
  exit 0
fi

# Only now does human confirmation matter
if gum confirm "Apply validated crontab?"; then
  crontab "$CRON_FILE"
  echo "Crontab successfully updated."
else
  echo "Crontab update canceled."
fi
