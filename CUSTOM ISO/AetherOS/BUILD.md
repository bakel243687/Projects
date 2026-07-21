# Building ÆtherOS

This document contains the complete engineering journey of building ÆtherOS from a standard Debian installation into a lightweight headless operating system.

Instead of only documenting what worked, this file also documents the mistakes, issues encountered and the solutions used. The goal is to make the project reproducible while also serving as my engineering notes.

---

# Stage 1 — Choosing the Base

Originally, Ubuntu was considered because of familiarity.

Later, the decision was made to move completely to Debian.

Reason:
- Cleaner base
- Easier remastering
- Less unnecessary packages
- Better for learning distribution engineering

Current Base:
- Debian Trixie

---

# Stage 2 — Disk Usage Analysis

Before removing anything, I needed to understand where the storage was actually being used.

Tools Used

- du
- ncdu

Large directories discovered

```
/usr                ~3.9GB
/usr/lib            ~1.9GB
/usr/share          ~1.4GB
```

Further analysis showed:

```
/usr/lib/x86_64-linux-gnu
```

was consuming approximately

```
1.4GB
```

Inside `/usr/share` the major consumers were:

- locale
- help
- ibus
- doc

---

## Lesson Learned

Never start deleting files randomly.

Always identify the largest consumers first before deciding what can safely be removed.

---

# Stage 3 — Package Cleanup

The initial plan was to remove GUI-related software first.

Target packages included:

- Desktop environments
- Browsers
- Multimedia software
- Input methods
- Printing services

After package removal:

```
apt autoremove --purge
```

was used to remove unnecessary dependencies.

---

# Stage 4 — Branding Attempt

Initially I wanted to customize:

- Plymouth Splash
- GRUB
- Wallpaper
- Distro Name
- Shell Prompt

The Plymouth customization turned out to be more troublesome than expected.

Problems encountered:

- Splash only displayed a black screen.
- Theme loaded but images failed.
- Testing inside the VM was inconsistent.

Decision:

Postpone graphical branding.

Move completely to a headless build first.

---

# Stage 5 — Repository Issues

While modifying repositories and cleaning packages, APT eventually stopped functioning correctly.

Problem:

Repository signature verification failed.

Later another issue appeared.

Package versions became inconsistent.

Example:

- openssh-server
- openssh-client

were pulling packages from different Debian releases.

Root Cause:

Mixed package versions during the transition to Debian Trixie.

Solution:

- Verify repository configuration
- Repair broken dependencies
- Complete upgrade so the entire system uses the same release

---

# Stage 6 — Headless Direction

After spending time on Plymouth and desktop customization, I decided to completely change direction.

The project became:

ÆtherOS Headless Edition

Goals:

- Smaller footprint
- Faster boot
- Lower RAM usage
- Easier maintenance
- Better platform for cybersecurity

Instead of building a desktop distribution first, the focus became building a terminal-first operating system.

---

# Stage 7 — Identity

Instead of graphical branding, the operating system now focuses on terminal identity.

Current customization:

- MOTD
- Shell Prompt
- Hostname

Future additions:

- Fastfetch
- Custom CLI
- Tool Launcher

---

# Stage 8 — ISO Generation

The project now moves toward generating a reproducible ISO using Debian live-build.

Tools:

- live-build
- debootstrap
- squashfs-tools
- xorriso

The objective is to produce a lightweight bootable operating system that can later evolve into multiple editions.

---

# Issues Encountered

## Large installation size

Cause

Standard Debian installation includes many packages not required for a minimal operating system.

Solution

Analyze storage usage before removing packages.

---

## Plymouth splash failed

Cause

Theme configuration and testing inside the VM.

Solution

Move graphical branding to a later development stage.

---

## Repository signature verification

Cause

Repository and package inconsistencies.

Solution

Repair package manager before continuing optimization.

---

## Mixed package versions

Cause

Partial migration between Debian releases.

Solution

Ensure the entire system uses packages from a single release.

---

## Feature Creep

At one point the project started focusing more on appearance than engineering.

Solution

Return to the original objective:

Build the operating system first.

Everything else comes later.

---

# Current Status

[x] Debian Trixie Base

[x] Headless Environment

[x] Package Optimization

[x] MOTD Customization

[ ] Build Environment Preparation

[ ] Service Hardening
 
[ ] Custom CLI Toolkit

[ ] ISO Generation

[ ] Version 1.0

---

This project is still under active development.

Every stage is documented not only to track progress but also to understand the engineering decisions behind the system.
