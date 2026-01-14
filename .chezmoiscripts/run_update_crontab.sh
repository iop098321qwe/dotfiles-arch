#!/usr/bin/env bash

if gum confirm "Update crontab?"; then
  crontab ~/.config/cron/crontab.current
  echo "Crontab updated."
else
  echo "Crontab update canceled."
fi
