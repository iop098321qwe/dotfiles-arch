#!/usr/bin/env bash

gum style \
	--border rounded \
	--border-foreground 2 \
	--foreground 2 \
	--padding "1 2" \
	--margin "1 0" \
	"Chezmoi application complete."

if gum confirm "Reboot now to ensure all settings are in place?"; then
	systemctl reboot
else
	gum style --foreground 3 "Reboot skipped."
fi
