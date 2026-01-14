#!/usr/bin/env bash
set -euo pipefail

TARGET="$HOME/.config/cron/crontab.current"
HASH="$HOME/.config/cron/crontab.hash"

tmp="$(mktemp)"

# Export the real crontab
crontab -l > "$tmp" || true

# Calculate its hash
new_hash="$(sha256sum "$tmp" | awk '{print $1}')"

# Load previous hash
old_hash="$(cat "$HASH" 2>/dev/null || echo "")"

# If changed, overwrite the canonical file
if [[ "$new_hash" != "$old_hash" ]]; then
    mv "$tmp" "$TARGET"
    echo "$new_hash" > "$HASH"
else
    rm "$tmp"
fi

