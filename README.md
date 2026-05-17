# sysdiag

A system diagnostic & repair TUI for Arch-based Linux systems. Two modes:

- **Default** — problem detection menu (iwctl-style) with inline fix overlays
- **`--monitor`** — live dashboard (btop-like) with CPU, memory, disks, network, processes, temperatures

![language](https://img.shields.io/badge/language-python3-blue) ![distro](https://img.shields.io/badge/distro-arch%20%2F%20cachyos-teal)

## Modes

### Default mode (repair tool)

Scans for system problems and presents them as a numbered, selectable list:

- SMART health, CPU/GPU temperatures, EDAC memory errors
- Battery wear, failed systemd units, zombie processes, OOM kills
- Journal size, disk capacity, DNS latency, SSH auth failures, long uptime

Press **↑↓** to navigate, **Enter** to inspect a problem, then **y** to execute the suggested fix or **n / ESC** to cancel. Number keys **1–9** jump directly to fixable items. Press **q** or **ESC** to quit.

```fish
sysdiag             # scan real system
sysdiag --test      # demo mode with 12 simulated problems
```

### Monitor mode (`--monitor`)

All panels are visible at once and refresh every 2 seconds in the background:

- **CPU** — aggregate usage, per-core percentages, iowait, frequency, context switches, interrupts
- **Memory** — usage, swap, dirty pages, writeback pressure, hugepages, edac error detection
- **Temperatures & Fans** — all thermal zones and hwmon sensors, color-coded by severity
- **GPU & Storage** — integrated/nvidia GPU usage, SMART health per drive
- **Processes** — top 5 by CPU, zombie count, OOM kill events
- **Systemd & Journal** — failed units, last 4 journal errors
- **Network** — interface, IP, gateway, ping latency, DNS timing, open ports, firewall rules, dmesg warnings
- **Security** — SUID binary count, SSH failures, pending updates, last logins
- **Partitions** — all disks and partitions with filesystem, mountpoints, size, used, and available space

```fish
sysdiag --monitor
```

## Dependencies

| Package | Purpose |
|---|---|
| `smartmontools` | smartctl (NVMe/SSD health) |
| `ldns` | drill (DNS timing) |
| `iptables` | firewall rule count |
| `pacman-contrib` | checkupdates |

All required Python modules are in the stdlib (curses, threading, json, etc.).

Install system deps:

```bash
sudo pacman -S smartmontools ldns pacman-contrib
```

## Install

```bash
cp sysdiag ~/.local/bin/sysdiag
chmod +x ~/.local/bin/sysdiag
```

Make sure `~/.local/bin` is in your `$PATH`. If you use fish:

```fish
fish_add_path ~/.local/bin
```

You will be prompted for your sudo password once on launch. This is used for SMART queries and firewall rules. Credentials are cached for the session.

Press `q` or `Escape` to quit.

## Theming (optional)

Create `~/.config/sysdiag/accent` with a 6-character hex value (no `#`):

```bash
mkdir -p ~/.config/sysdiag
echo "e8730a" > ~/.config/sysdiag/accent
```

### Automatic theme switching

Write to `~/.config/sysdiag/accent` from any wallpaper or theme daemon to have sysdiag follow your desktop theme:

```bash
echo "cc0000" > ~/.config/sysdiag/accent
```

## Notes

- SMART and firewall queries require elevated privileges. sysdiag prompts for sudo once on launch and caches credentials for the session
- DNS timing requires `drill` from the `ldns` package
- Monitor mode runs without sudo (no external commands needed for display)
