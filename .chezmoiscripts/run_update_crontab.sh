#!/usr/bin/env bash

if gum confirm "Update crontob?"; then
  crontab ~/.config/cron/crontab.current
  echo "Crontab updated."
else
  echo "Crontab update canceled."
fi
