# Progress

## Done

- **Base Hyprland session** — hyprland, kitty, mesa, intel-media-driver, xdg-desktop-portal-hyprland
- **Hyprland config** — monitor, input, gaps, borders, edge resize, keybinds (SUPER+Return terminal, SUPER+W close, SUPER+Q close all in workspace, SUPER+Space launcher, F11 fullscreen, SUPER+H/J/K/L and arrow keys focus, SUPER+/-/= resize, workspaces 1-5, floating)
- **Authentication agent** — polkit-gnome (exec-once in hyprland.conf)
- **File manager** — yazi (terminal-based, opens in kitty)
- **Notification daemon** — mako (exec-once in hyprland.conf, 10s auto-dismiss)
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
