# Progress

## Done

- **Base Hyprland session** — hyprland, kitty, mesa, intel-media-driver, xdg-desktop-portal-hyprland
- **Hyprland config** — monitor, input, gaps, borders, keybinds (SUPER+Return for kitty, SUPER+Q close, SUPER+H/J/K/L focus, workspaces 1-5, fullscreen, floating)
- **Authentication agent** — polkit-gnome (exec-once in hyprland.conf)
- **File manager** — thunar
- **Notification daemon** — mako (exec-once in hyprland.conf)
- **Clipboard** — wl-clipboard
- **Editor** — neovim
- **Auto-start Hyprland** — bash/.bash_profile launches Hyprland on TTY1
- **Helper script** — `untracked.sh` shows packages installed but not tracked in packages.sh

## Not Yet Installed

Everything above is in `packages.sh` but hasn't been installed yet. Run `bash packages.sh` to install. Symlinks also need `bash setup.sh` (remove existing `~/.bash_profile` first).

## Future Ideas

- Display manager (replace TTY auto-start)
- Status bar (waybar)
- App launcher (wofi/rofi)
- Wallpaper
- Neovim config
