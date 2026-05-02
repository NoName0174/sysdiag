# sysdiag

A btop-style terminal UI for diagnosing Arch-based Linux systems. Runs entirely in your terminal using Python's built-in `curses` library — no extra dependencies.

![language](https://img.shields.io/badge/language-python3-blue) ![distro](https://img.shields.io/badge/distro-arch%20%2F%20cachyos-teal)

## Features

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

## Dependencies

| Package | Purpose |
|---|---|
| `python3` | runtime (stdlib only) |
| `smartmontools` | SMART health queries (requires root) |
| `ldns` | DNS timing via drill |
| `iptables` | firewall rule count (requires root) |
| `pacman-contrib` | checkupdates |

Install all at once:

```bash
sudo pacman -S smartmontools ldns pacman-contrib
```

## Install

```bash
cp sysdiag ~/.local/bin/sysdiag
chmod +x ~/.local/bin/sysdiag
```

Make sure `~/.local/bin` is in your `$PATH`.

## Usage

```bash
sysdiag
```

You will be prompted for your sudo password once on launch. This is used for SMART queries and firewall rules. Credentials are cached for the session.

Press `q` or `Escape` to quit.

## Theming (optional)

By default sysdiag renders in black and white. To set an accent color, create the config file with any 6-character hex value (no `#` prefix):

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
- Fan speeds via thinkpad_acpi: `sudo modprobe thinkpad_acpi fan_control=1`
- DNS timing requires `drill` from the `ldns` package
