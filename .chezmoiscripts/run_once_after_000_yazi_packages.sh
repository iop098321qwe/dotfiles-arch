#!/usr/bin/env bash

spin() {
	local title="$1"
	shift

	if [[ -t 2 ]] && command -v gum >/dev/null 2>&1; then
		gum spin --show-error --spinner dot --title "$title" -- "$@"
		return
	fi

	printf '%s\n' "$title" >&2
	"$@"
}

run() {
	local title="$1"
	shift

	printf 'Running: %s\n' "$*" >&2
	spin "$title" "$@"
	local status=$?

	if (( status != 0 )); then
		printf 'Yazi package command failed with exit status %d: %s\n' \
			"$status" "$*" >&2
		exit "$status"
	fi
}

yazi_config_dir="${XDG_CONFIG_HOME:-$HOME/.config}/yazi"
yazi_package_file="$yazi_config_dir/package.toml"
yazi_package_seed="$(chezmoi source-path)/.chezmoitemplates/yazi/package.toml"

if [[ ! -e "$yazi_package_file" ]]; then
	if [[ ! -r "$yazi_package_seed" ]]; then
		printf 'Yazi package seed is missing or unreadable: %s\n' \
			"$yazi_package_seed" >&2
		exit 1
	fi

	mkdir -p "$yazi_config_dir"
	status=$?
	if (( status != 0 )); then
		printf 'Failed to create Yazi config directory with exit status %d: %s\n' \
			"$status" "$yazi_config_dir" >&2
		exit "$status"
	fi

	cp "$yazi_package_seed" "$yazi_package_file"
	status=$?
	if (( status != 0 )); then
		printf 'Failed to seed Yazi package manifest with exit status %d: %s\n' \
			"$status" "$yazi_package_file" >&2
		exit "$status"
	fi

	printf 'Seeded Yazi package manifest: %s\n' "$yazi_package_file" >&2
fi

run 'Installing Yazi packages...' ya pkg install

run 'Upgrading Yazi packages...' ya pkg upgrade
