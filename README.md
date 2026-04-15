# sysdiag

A full system diagnostic CLI for Arch-based Linux systems running Hypr. 

## Features

- **CPU** — aggregate usage, per-core breakdown, iowait, context switches, interrupts
- **Memory** — usage, dirty pages, writeback pressure, hugepages, edac error check
- **Temperatures** — all thermal zones + hwmon sensors
- **Fans** — hwmon fan inputs
- **GPU** — nvidia (via nvidia-smi) or integrated AMD/Intel (via sysfs)
- **Storage** — SMART health per drive (NVMe, SATA)
- **Processes** — top 5 by CPU, zombie count, OOM kill events
- **Systemd** — failed/degraded units, last 5 journal errors
- **Dmesg** — warnings and above since boot
- **Network** — interface, IP, gateway, ping latency, DNS timing, open ports, firewall rules
- **Security** — last logins, SSH failures, SUID binary count, pending updates

## Dependencies

| Package | Purpose |
|---|---|
| `fish` | shell |
| `procps` | ps, /proc reading |
| `iproute2` | ip, ss |
| `systemd` | systemctl, journalctl |
| `smartmontools` | smartctl (NVMe/SSD health) |
| `ldns` | drill (DNS timing) |
| `iptables` | firewall rule count |
| `pacman-contrib` | checkupdates |

Install all at once:

```bash
sudo pacman -S smartmontools ldns pacman-contrib
```

## Install

```fish
cd ~/Downloads
cp sysdiag ~/.local/bin/sysdiag
chmod +x ~/.local/bin/sysdiag
```

Make sure `~/.local/bin` is in your `$PATH`.

## Usage

```fish
sysdiag        # one-shot diagnostic
sysdiag -w     # watch mode, refreshes every 10s
```


