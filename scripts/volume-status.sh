#!/usr/bin/env bash
# Outputs volume info as JSON for waybar custom module

vol=$(wpctl get-volume @DEFAULT_AUDIO_SINK@)
pct=$(echo "$vol" | awk '{printf "%d", $2 * 100}')
muted=$(echo "$vol" | grep -c MUTED)

if [ "$muted" -eq 1 ]; then
    icon="󰝟"
    text="$icon muted"
    bar=$(printf '▯%.0s' $(seq 1 20))
    tooltip="<span color='#928374'>$bar</span>  muted"
else
    if [ "$pct" -lt 33 ]; then
        icon="󰕿"
    elif [ "$pct" -lt 66 ]; then
        icon="󰖀"
    else
        icon="󰕾"
    fi
    text="$icon $pct%"
    filled=$((pct / 5))
    empty=$((20 - filled))
    bar_filled=""
    bar_empty=""
    [ "$filled" -gt 0 ] && bar_filled=$(printf '▮%.0s' $(seq 1 $filled))
    [ "$empty" -gt 0 ] && bar_empty=$(printf '▯%.0s' $(seq 1 $empty))
    tooltip="<span color='#99c6ca'>$bar_filled</span>$bar_empty  $pct%"
fi

printf '{"text": "%s", "tooltip": "%s", "class": "%s"}\n' \
    "$text" "$tooltip" "$([ "$muted" -eq 1 ] && echo muted || echo "")"
