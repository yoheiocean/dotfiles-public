# fcitx5 — Japanese Input on Hyprland

## How it works

fcitx5 provides Japanese input (Mozc) under Hyprland. It integrates with
waybar via a custom `ime` module (EN/あ indicator with click-to-toggle),
so the default fcitx5 tray icons are redundant and must be suppressed.

## The dbus race condition (fresh install)

On a fresh Arch install, fcitx5 starts itself *before* Hyprland's
`exec-once` lines run. Here's the sequence:

1. Hyprland reads `env = XMODIFIERS,@im=fcitx` and sets the env var.
2. Any app (or Hyprland itself) that checks XMODIFIERS triggers a dbus
   activation of `org.fcitx.Fcitx5`.
3. dbus launches a bare `fcitx5` with no flags — this happens *before*
   `exec-once` lines are processed.
4. The bare instance loads all addons (including the tray icon) and, if
   no profile exists yet, writes a default profile (English-only, no Mozc).

This means:
- If `~/.config/fcitx5/profile` doesn't exist when dbus activates fcitx5,
  you lose the Mozc input method.
- The `--disable notificationitem` flag on `exec-once` never gets a chance
  to run because fcitx5 is already active, and a second instance exits
  immediately (unless `--replace` is used).

## Solution (two-part)

### Part 1: Pre-copy configs in setup.sh (before first login)

```bash
mkdir -p "$HOME/.config/fcitx5/conf"
cp "$DOTFILES/fcitx5/profile" "$HOME/.config/fcitx5/profile"
cp "$DOTFILES/fcitx5/config" "$HOME/.config/fcitx5/config"
cp "$DOTFILES/fcitx5/conf/notificationitem.conf" "$HOME/.config/fcitx5/conf/notificationitem.conf"
```

This ensures that when dbus auto-activates fcitx5, it finds our profile
(with Mozc configured) already in place and doesn't overwrite it with
defaults.

Note: fcitx5 configs are **copied, not symlinked**. fcitx5 overwrites its
own config files at runtime (e.g., when you change input methods via the
GUI). A symlink would cause fcitx5 to overwrite the dotfiles source.

### Part 2: Replace the dbus instance via exec-once (in hyprland.conf)

```
exec-once = fcitx5 -d -r --disable notificationitem
```

- `-d` — daemonize
- `-r` (`--replace`) — **critical** — takes over from the already-running
  dbus-activated instance instead of exiting silently
- `--disable notificationitem` — prevents the tray icon addon from loading

This replaces the bare dbus-launched instance with one that has the tray
addon disabled.

### Why notificationitem.conf alone doesn't work

We also ship `conf/notificationitem.conf` with `Enabled=False`. In theory
this should disable the addon via config. In practice, it does not
reliably suppress the tray icon — tested multiple times across fresh
installs and reboots. The `--disable` CLI flag is the only method that
consistently works.

The config file is kept as a belt-and-suspenders measure but should not be
relied upon as the sole mechanism.

## Why configs are copied, not symlinked

fcitx5 rewrites its own config files at runtime. If we symlinked
`~/.config/fcitx5/` to `~/dotfiles/fcitx5/`, then:
- Any runtime change by fcitx5 would modify the git-tracked source files
- The git repo would show constant dirty diffs

Instead, `setup.sh` copies the files. To update the dotfiles source after
making changes via fcitx5's GUI, manually copy back:

```bash
cp ~/.config/fcitx5/profile ~/dotfiles/fcitx5/profile
```

## Files

| File                         | Purpose                                    |
|------------------------------|--------------------------------------------|
| `profile`                    | Input method list (keyboard-us + mozc)     |
| `config`                     | Global hotkey config                       |
| `conf/notificationitem.conf` | Addon config to disable tray (unreliable)  |

## Troubleshooting

**Tray icons reappear after reboot:**
Check that `exec-once = fcitx5 -d -r --disable notificationitem` is in
`hypr/hyprland.conf`. The `-r` flag is essential — without it, the
exec-once instance exits silently because dbus already started one.

**Mozc missing after fresh install:**
Check that `setup.sh` ran before the first Hyprland login. The profile
must be in `~/.config/fcitx5/profile` before dbus activates fcitx5.

**fcitx5-remote not working:**
fcitx5 must be running inside the Hyprland session with access to the
session dbus. Killing and restarting fcitx5 from an external TTY (without
Hyprland env vars) will break the dbus connection. Restart from within
Hyprland: `fcitx5 -d -r --disable notificationitem`.
