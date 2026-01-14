#!/usr/bin/env bash

CRON_FILE="$HOME/.config/cron/crontab.current"

# Must exist
if [[ ! -f "$CRON_FILE" ]]; then
  echo "Error: $CRON_FILE does not exist."
  exit 1
fi

# Must not be empty
if [[ ! -s "$CRON_FILE" ]]; then
  echo "Error: $CRON_FILE is empty. Refusing to apply."
  exit 1
fi

# Must be syntactically valid
if ! crontab -T "$CRON_FILE" >/dev/null 2>&1; then
  echo "Error: $CRON_FILE contains invalid cron syntax."
  exit 1
fi

# Only now does human confirmation matter
if gum confirm "Apply validated crontab from $CRON_FILE?"; then
  crontab "$CRON_FILE"
  echo "Crontab successfully updated."
else
  echo "Crontab update canceled."
fi
