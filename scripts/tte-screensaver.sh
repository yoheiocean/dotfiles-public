#!/usr/bin/env bash
# TTE screensaver — loops random terminal text effects
# Launched by hypridle in a fullscreen kitty window.
# Press any key to exit.

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

printf '\e[?25l'

cleanup() {
    kill $(jobs -p) 2>/dev/null || true
    printf '\e[?25h'
    exit 0
}
trap cleanup INT TERM EXIT

# Run effect loop in background
(
    while true; do
        effect=${EFFECTS[$((RANDOM % ${#EFFECTS[@]}))]}
        clear
        printf '\e[?25l'
        tte --input-file "$ART_FILE" \
            --canvas-width 0 \
            --canvas-height 0 \
            --anchor-text c \
            --no-restore-cursor \
            --no-eol \
            "$effect" 2>/dev/null || true
        printf '\e[?25l'
        sleep 1
    done
) &

# Foreground: wait for any keypress, then exit
read -rsn1
