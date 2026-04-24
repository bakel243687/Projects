# Project 01 — Pi-hole Network Ad Blocker

> Blocking ads network-wide using a Raspberry Pi 5 as a DNS sinkhole.

---

## Table of Contents

- [Overview](#overview)
- [Hardware & Requirements](#hardware--requirements)
- [Phase 1 — System Preparation](#phase-1--system-preparation)
- [Phase 2 — Setting a Static IP](#phase-2--setting-a-static-ip)
- [Phase 3 — Installing Pi-hole](#phase-3--installing-pi-hole)
- [Phase 4 — Accessing the Dashboard](#phase-4--accessing-the-dashboard)
- [Phase 5 — Configuring the Router](#phase-5--configuring-the-router)
- [How It Works](#how-it-works)
- [Limitations](#limitations)
- [Results](#results)

---

## Overview

Pi-hole is a network-level ad blocker that acts as a DNS sinkhole. Instead of blocking ads on individual devices using browser extensions, Pi-hole intercepts DNS queries at the network level — meaning every device on your network (phones, laptops, smart TVs, IoT devices) gets ad blocking automatically without any additional configuration on each device.

<!-- Add a screenshot of the Pi-hole dashboard here -->

---

## Hardware & Requirements

| Component | Details |
|---|---|
| **Board** | Raspberry Pi 5 |
| **OS** | Raspberry Pi OS Lite (64-bit) |
| **Connection** | WiFi |
| **Storage** | MicroSD card (16GB+) |
| **Access** | SSH from a separate machine |

> **Why Raspberry Pi OS Lite?** No desktop environment means more system resources are dedicated to Pi-hole and DNS resolution. Lite is the ideal choice for headless server projects like this.

---

## Phase 1 — System Preparation

Before installing Pi-hole, update the system to make sure all packages are current.

SSH into your Pi and run:

```bash
sudo apt update && sudo apt upgrade -y
```

Wait for the update to complete before moving on.

<!-- Add a screenshot of the terminal showing a successful update here -->

---

## Phase 2 — Setting a Static IP

Pi-hole needs a permanent IP address on your network. If the Pi's IP changes (via DHCP), your router's DNS setting will point to the wrong address and DNS resolution will break for every device on the network.

First, check your current IP:

```bash
hostname -I
```

Then open the DHCP client config file:

```bash
sudo nano /etc/dhcpcd.conf
```

Scroll to the bottom and add the following block:

```
interface wlan0
static ip_address=***REMOVED***/24
static routers=192.168.0.1
static domain_name_servers=8.8.8.8 8.8.4.4
```

> **Note:** Replace `***REMOVED***` with your Pi's current IP if it differs. Replace `192.168.0.1` with your router's gateway IP if needed. You can confirm it with `ip route | grep default`.

Save the file with **Ctrl + X**, then **Y**, then **Enter**.

Reboot the Pi:

```bash
sudo reboot
```

After rebooting, confirm the static IP held:

```bash
hostname -I
```

It should return `***REMOVED***`.

---

## Phase 3 — Installing Pi-hole

Pi-hole provides a one-line installer that handles everything automatically:

```bash
curl -sSL https://install.pi-hole.net | bash
```

The installer will download dependencies and launch a text-based setup UI. Here are the selections made during the install:

| Prompt | Selection |
|---|---|
| Network interface | `wlan0` |
| Upstream DNS provider | `Google (8.8.8.8)` |
| Block lists | Default (StevenBlack's Unified Hosts List) |
| Install web admin interface | `Yes` |
| Install lighttpd web server | `Yes` |
| Log queries | `Yes` |
| FTL Privacy mode | `Mode 0 — Show Everything` |

> **Why Mode 0?** Since this is a personal home network, showing all query data gives full visibility into what devices are doing on the network. This is also useful for debugging and learning. Privacy modes 1–3 are better suited for shared or public networks.

At the end of the installation, Pi-hole will display the **admin web interface password**. Save this immediately.

<!-- Add a screenshot of the Pi-hole installer completion screen here -->

---

## Phase 4 — Accessing the Dashboard

Verify Pi-hole is running:

```bash
pihole status
```

Expected output:
```
Pi-hole blocking is enabled
DNS service is running
FTL is running
```

Then on any device connected to your network, open a browser and navigate to:

```
http://***REMOVED***/admin
```

Log in with the admin password from the installer.

<!-- Add a screenshot of the Pi-hole admin dashboard here -->

---

## Phase 5 — Configuring the Router

For Pi-hole to cover every device on the network, the router needs to hand out Pi-hole's IP as the DNS server via DHCP.

1. Open a browser and go to your router's admin page (usually `http://192.168.0.1`)
2. Log in with your router admin credentials (often printed on the router)
3. Navigate to **LAN Settings** → **DHCP Server** or **DNS Settings** (varies by router brand)
4. Update the DNS fields:

| Field | Value |
|---|---|
| **Primary DNS** | `***REMOVED***` |
| **Secondary DNS** | *(leave blank)* |

5. Save and reboot the router

> **Why leave Secondary DNS blank?** If a secondary DNS like `8.8.8.8` is set, some devices may fall back to it and bypass Pi-hole entirely. Leaving it blank ensures all DNS traffic routes through Pi-hole.

After the router reboots, all devices that reconnect will automatically use Pi-hole for DNS.

<!-- Add a screenshot of the router DNS settings here -->

---

## How It Works

```
Device on network
      │
      │  "What's the IP for doubleclick.net?"
      ▼
   Pi-hole (***REMOVED***)
      │
      ├── Domain is on blocklist? ──► Return 0.0.0.0 (blocked) ──► No ad loads
      │
      └── Domain is clean? ──► Forward to upstream DNS (8.8.8.8) ──► Normal response
```

Pi-hole works as a **DNS sinkhole**. When a device requests the IP address of a known ad-serving domain, Pi-hole returns a null address instead of the real one — so the ad request never leaves your network.

---

## Limitations

Pi-hole is powerful but not a complete ad-blocking solution on its own. Here's an honest breakdown:

**Pi-hole blocks well:**
- Ads served from third-party ad domains (e.g. `doubleclick.net`, `ads.google.com`)
- Tracking and telemetry scripts
- Ads on smart TVs and IoT devices

**Pi-hole cannot block:**
- **YouTube ads** — served from the same domain as video content
- **Spotify ads** — same reason
- **Facebook/Instagram ads** — deeply embedded in their own platform
- Any ad served directly from the website's own domain (first-party ads)

> **Recommendation:** Pair Pi-hole with **uBlock Origin** in your browser for near-complete ad blocking coverage across all scenarios.

---

## Results

<!-- Add a screenshot of Pi-hole stats after a day or two of running — total queries, domains blocked, percentage blocked -->

| Metric | Value |
|---|---|
| Pi-hole version | *(add after install)* |
| Domains on blocklist | *(visible on dashboard)* |
| Queries blocked (first 24hrs) | *(add after running)* |
| Percentage blocked | *(add after running)* |

---

*Part of my Raspberry Pi Projects series. See the full list in the main README.*
