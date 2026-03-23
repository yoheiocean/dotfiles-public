#!/usr/bin/env bash
# TTE screensaver — loops random terminal text effects
# Launched by hypridle in a fullscreen kitty window.
# Press 'q' or Ctrl+C to exit.

set -euo pipefail

EFFECTS=(
    beams
    blackhole
    bouncyballs
    burn
    colorshift
    crumble
    decrypt
    expand
    fireworks
    matrix
    middleout
    overflow
    pour
    rain
    rings
    scattered
    slide
    spotlights
    spray
    swarm
    sweep
    synthgrid
    waves
    wipe
)

ART_FILE=~/dotfiles/scripts/screensaver.txt

# Trap Ctrl+C for clean exit
trap 'exit 0' INT TERM

center_text() {
    local term_cols term_lines art_width art_height pad_left pad_top
    term_cols=$(tput cols)
    term_lines=$(tput lines)
    art_width=$(awk '{ print length }' "$ART_FILE" | sort -rn | head -1)
    art_height=$(wc -l < "$ART_FILE")
    pad_left=$(( (term_cols - art_width) / 2 ))
    pad_top=$(( (term_lines - art_height) / 2 ))
    [ "$pad_left" -lt 0 ] && pad_left=0
    [ "$pad_top" -lt 0 ] && pad_top=0
    printf '\n%.0s' $(seq 1 "$pad_top")
    while IFS= read -r line; do
        printf '%*s%s\n' "$pad_left" '' "$line"
    done < "$ART_FILE"
}

while true; do
    # Pick a random effect
    effect=${EFFECTS[$((RANDOM % ${#EFFECTS[@]}))]}

    # Clear screen, center text, run the effect
    clear
    center_text | tte "$effect" 2>/dev/null || true

    # Brief pause before next cycle
    sleep 2
done
