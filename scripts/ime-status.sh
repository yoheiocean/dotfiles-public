#!/usr/bin/env bash
# IME status for waybar — outputs JSON with current input method.

state=$(fcitx5-remote 2>/dev/null)

if [[ "$state" == "2" ]]; then
    echo '{"text": "あ", "tooltip": "Japanese (Mozc)", "class": "japanese"}'
else
    echo '{"text": "EN", "tooltip": "English", "class": "english"}'
fi
