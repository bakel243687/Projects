# 02-BUILD-PROCESS.md

# Android Security Lab with Waydroid

## Project Build Process

---

# Introduction

This document captures the complete engineering process involved in building an Android Security Lab using Waydroid on Kali Linux. Rather than serving as another installation guide, it documents the reasoning behind each decision, the challenges encountered during deployment, the troubleshooting process, and the final solutions that resulted in a fully functional Android testing environment.

Every project has its own learning curve, and this one was no exception. While the final setup appears straightforward, reaching that point required understanding how Waydroid interacts with Linux display servers, Android networking, ADB, and proxy configurations.

Instead of documenting only the successful commands, this journal records the entire process—including the mistakes, failed assumptions, and lessons learned along the way.

---

# Project Goal

The objective of this project was to build a lightweight Android environment capable of supporting future Android application security assessments without relying on a physical Android device.

The lab needed to satisfy several requirements:

* Run natively on Kali Linux.
* Integrate seamlessly with existing penetration testing tools.
* Support Android Debug Bridge (ADB).
* Allow interception of application traffic using Burp Suite.
* Consume fewer resources than a traditional Android emulator.
* Be reusable for future Android security projects.

The scope of this project ends once the Android environment is fully operational and capable of communicating with Burp Suite. Static analysis, APK reverse engineering, Frida instrumentation, and malware analysis are intentionally left for future repositories that will build upon this foundation.

---

# Choosing the Android Platform

Several Android virtualization options were considered before beginning the build.

These included:

* Android Studio Emulator
* Genymotion
* Physical Android devices
* Waydroid

Android Studio provides excellent debugging capabilities but requires considerably more system resources than necessary for a dedicated penetration testing environment.

Genymotion is feature-rich but introduces licensing limitations and does not integrate with Linux as naturally as Waydroid.

A physical Android device provides the most realistic testing environment but requires rooting for many security-related tasks and introduces hardware dependency into the workflow.

Waydroid was ultimately selected because it offers:

* Native Linux integration.
* Excellent performance.
* Low resource consumption.
* Fast startup times.
* Straightforward ADB connectivity.
* A containerized Android environment that is easy to rebuild.

These characteristics made it the most suitable platform for building a reusable mobile application security lab.

---

# Initial Environment

The project was built using the following environment:

| Component           | Value                        |
| ------------------- | ---------------------------- |
| Operating System    | Kali Linux                   |
| Desktop Environment | KDE Plasma                   |
| Display Protocol    | Wayland                      |
| Android Platform    | Waydroid                     |
| Android Version     | Android 13                   |
| Proxy Tool          | Burp Suite Community Edition |
| Device Management   | Android Debug Bridge (ADB)   |

---

# Phase 1 — Installing Waydroid

With the planning complete, the first step was installing Waydroid from the Kali repositories.

The package lists were updated before installation.

```bash
sudo apt update
```

This command synchronizes the local package index with the configured repositories to ensure the latest package information is available.

Waydroid was then installed.

```bash
sudo apt install waydroid
```

This installs the Waydroid runtime, management utilities, and required dependencies.

Once installation completed, the Android system image was initialized.

```bash
sudo waydroid init
```

During initialization, Waydroid downloads the Android filesystem and prepares the container environment that will later host Android.

After initialization, the container service was started.

```bash
sudo systemctl start waydroid-container
```

This launches the Linux container responsible for running Android.

Finally, an Android session was started.

```bash
waydroid session start
```

At this point, everything appeared to be functioning correctly.

The installation completed without errors.

Unfortunately, this was only the beginning.

---

# Challenge 1 — Wayland Socket Error

Attempting to launch the Android interface immediately resulted in the following error:

```text
WAYLAND_DISPLAY is not set, defaulting to "wayland-0"

Wayland socket '/run/user/1000/wayland-0' doesn't exist; are you running a Wayland compositor?
```

At first glance, the error appeared to originate from Waydroid itself.

Since the installation had completed successfully, it was reasonable to assume that something had gone wrong during initialization.

However, the container itself was healthy.

The issue was somewhere else.

---

# Investigation

The error referenced a missing Wayland socket.

This immediately suggested that the Android container was expecting a Wayland compositor that simply did not exist.

To verify the current display session, the following command was executed.

```bash
echo $XDG_SESSION_TYPE
```

Instead of returning:

```text
wayland
```

the output indicated that the desktop session was running under X11.

Waydroid depends on a Wayland compositor for rendering its graphical interface. Since X11 does not provide a Wayland socket, the Android interface could never start successfully regardless of whether the container itself was functioning.

This explained why the installation appeared correct while the graphical interface continued to fail.

---

# Solution

The desktop environment needed to run under Wayland instead of X11.

Rather than attempting to modify Waydroid, the focus shifted to identifying why the host operating system was not providing a Wayland session.

The remainder of the project therefore moved away from Android itself and toward investigating the Linux desktop environment.

---

# Why This Solution Worked

Waydroid is not a traditional virtual machine. Instead, it relies on Linux container technology and renders Android applications directly through the host's graphical stack.

Because of this design, Waydroid expects the host operating system to provide an active Wayland compositor.

Once a valid Wayland session is available, the required socket is created automatically and Waydroid can render Android without modification.

The problem therefore was never the Android container—it was the graphical environment on the host operating system.

This distinction became one of the most important lessons learned during the entire project.

---
