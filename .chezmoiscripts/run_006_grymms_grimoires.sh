#!/usr/bin/env bash

set -euo pipefail

repo_name='grymms_grimoires'
repo_dir="$HOME/Documents/$repo_name"
branches=(main develop)

warn() {
  printf 'Grymms Grimoires setup warning: %s\n' "$*" >&2
}

fail() {
  printf 'Grymms Grimoires setup error: %s\n' "$*" >&2
  exit 1
}

spin() {
  local title="$1"
  shift

  if [[ -t 2 ]] && command -v gum >/dev/null 2>&1; then
    gum spin --spinner dot --title "$title" -- "$@"
    return
  fi

  printf '%s\n' "$title" >&2
  "$@"
}

ensure_branch() {
  local branch="$1"

  spin "Fetching $repo_name $branch..." \
    git -C "$repo_dir" fetch origin "$branch"

  if git -C "$repo_dir" show-ref --verify --quiet "refs/heads/$branch"; then
    spin "Updating $repo_name $branch tracking..." \
      git -C "$repo_dir" branch --set-upstream-to="origin/$branch" "$branch"
    return
  fi

  spin "Creating $repo_name $branch branch..." \
    git -C "$repo_dir" branch --track "$branch" "origin/$branch"
}

ensure_branches() {
  local branch

  for branch in "${branches[@]}"; do
    ensure_branch "$branch"
  done
}

command -v gh >/dev/null 2>&1 || \
  fail 'gh is required to clone the repository.'

command -v git >/dev/null 2>&1 || \
  fail 'git is required to configure repository branches.'

if ! gh auth status --hostname github.com >/dev/null 2>&1; then
  fail 'GitHub authentication is required before cloning the repository.'
fi

if [[ -e $repo_dir ]]; then
  if [[ -d $repo_dir/.git ]]; then
    ensure_branches
  else
    warn "$repo_dir already exists and is not a Git repository; skipping."
  fi

  exit 0
fi

mkdir -p "$HOME/Documents"
spin "Cloning $repo_name..." gh repo clone "$repo_name" "$repo_dir"
ensure_branches
