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

yazi_packages=(
	"yazi-rs/plugins:full-border"
	"yazi-rs/plugins:smart-filter"
	"yazi-rs/plugins:smart-paste"
	"yazi-rs/plugins:diff"
	"yazi-rs/plugins:chmod"
	"yazi-rs/plugins:toggle-pane"
	"ciarandg/cd-git-root"
	"Lil-Dank/lazygit"
	"boydaihungst/restore"
	"yazi-rs/plugins:smart-enter"
	"Rolv-Apneseth/bypass"
	"Rolv-Apneseth/starship"
	"yazi-rs/plugins:vcs-files"
	"TD-Sky/sudo"
	"uhs-robert/recycle-bin"
	"MasouShizuka/close-and-restore-tab"
	"AminurAlam/yazi-plugins:nextension"
	"ettom/openscad"
	"lmnek/pandoc"
	"Jormala/relative-motions"
	"UnleashedFurai/office"
	"matt-dong-123/base16"
	"yazi-rs/plugins:mount"
)

for yazi_package in "${yazi_packages[@]}"; do
	run "Adding Yazi package: $yazi_package" ya pkg add "$yazi_package"
done
