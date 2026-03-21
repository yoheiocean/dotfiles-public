#!/usr/bin/env bash
# Show explicitly installed packages not tracked in packages.sh.
# Run: bash untracked.sh

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

pacman -Qqet | sort > /tmp/installed.txt
grep -oP '^\s+\K\S+' "$SCRIPT_DIR/packages.sh" | sort > /tmp/tracked.txt
comm -23 /tmp/installed.txt /tmp/tracked.txt
