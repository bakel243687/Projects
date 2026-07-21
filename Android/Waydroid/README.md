# Android Security Lab with Waydroid

> A lightweight Android application security lab built on **Kali Linux KDE (Wayland)** using **Waydroid**, **ADB**, and **Burp Suite** for mobile application testing.

---

# Overview

Not only does Modern mobile application security requires an environment that is fast, lightweight, and integrates seamlessly with existing security tooling, that's how I like my work environment. While physical Android devices and traditional emulators remain valid options, they often introduce additional hardware requirements, performance overhead, or maintenance challenges.

This project documents the process of building a complete Android testing environment using **Waydroid** on **Kali Linux KDE (Wayland)**.

The goal was to create a reusable Android lab capable of supporting Android application testing while integrating with commonly used penetration testing tools such as Burp Suite and Android Debug Bridge (ADB).

This repository documents the installation process, configuration steps, challenges encountered during deployment, and the solutions used to build a fully functional Android security lab.

---

# Project Objectives

The primary objectives of this project are:

* Build a lightweight Android testing environment
* Learn the deployment and configuration of Waydroid
* Integrate Android with Kali Linux
* Configure Android Debug Bridge (ADB)
* Configure Burp Suite for traffic interception
* Create a reusable Android security laboratory
* Document the complete build process for future reference

---

# Features

Current capabilities include:

* Android 13 running through Waydroid
* KDE Plasma (Wayland) compatibility
* ADB connectivity
* Burp Suite proxy integration
* Phone mode display configuration
* Screen orientation management
* Android resolution customization
* Complete installation documentation
* Detailed troubleshooting guide

---

# Technologies Used

## Operating System

* Kali Linux

## Desktop Environment

* KDE Plasma (Wayland)

## Android Platform

* Waydroid
* Android 13

## Security Tools

* Android Debug Bridge (ADB)
* Burp Suite Community Edition

---

# Why Waydroid?

Several Android virtualization solutions were considered before selecting Waydroid.

These include:

* Android Studio Emulator
* Genymotion
* Physical Android devices

Waydroid was selected because it offers:

* Excellent Linux integration
* Native performance
* Lower resource consumption than traditional emulators
* Direct ADB support
* Fast startup times
* Easy integration with penetration testing tools
* A lightweight environment suitable for repeated testing

---

# Lab Architecture

```text
                           Internet
                               │
                               │
                        Burp Suite Proxy
                               │
                               │
                    Kali Linux KDE (Wayland)
                               │
          ┌────────────────────┴────────────────────┐
          │                                         │
          │                                     ADB │
          │                                         │
          ▼                                         ▼
                    Waydroid (Android 13)
                               │
                               │
                      Android Applications
```

---

# Repository Structure

```
android-security-lab-waydroid/
│
├── README.md
├── 01-INSTALLATION.md
├── 02-BUILD-PROCESS.md
├── 03-TROUBLESHOOTING.md
│
├── assets/
    ├── screenshots/
    ├── diagrams/
    └── images
```

---

# Prerequisites

Before beginning, ensure the following requirements are met:

* Kali Linux
* KDE Plasma running on Wayland
* Internet connectivity
* Administrative (sudo) privileges
* Basic Linux command-line knowledge

---

# Quick Start

## 1. Install Waydroid

Install the Waydroid package from the Kali repositories.

```bash
sudo apt update
sudo apt install waydroid
```

---

## 2. Initialize Waydroid

Download and configure the Android system image.

```bash
sudo waydroid init
```

---

## 3. Start the Waydroid Container

Launch the Android container service.

```bash
sudo systemctl start waydroid
sudo systemctl enable waydroid
```

---

## 4. Start an Android Session

Create a running Android session.

```bash
waydroid session start
```

---

## 5. Launch the Android Interface

Open the Android graphical environment.

```bash
waydroid show-full-ui
```

---

## 6. Verify ADB Connectivity

Confirm that Android Debug Bridge can communicate with Waydroid.

```bash
adb devices
```

---

# Documentation

Detailed documentation is provided throughout the repository.

| File                    | Description                                       |
| ----------------------- | ------------------------------------------------- |
| `README.md`             | Project overview                                  |
| `01-INSTALLATION.md`    | Complete installation and configuration guide     |
| `02-BUILD-PROCESS.md`   | Detailed project build log and deployment process |
| `03-TROUBLESHOOTING.md` | Common issues and their solutions                 |

---

# Challenges Encountered

Throughout this project several issues were encountered and resolved, including:

* Wayland socket errors
* X11 compatibility limitations
* Desktop environment migration
* ADB connectivity
* Scrcpy audio compatibility
* Display configuration
* Android orientation
* Burp Suite proxy configuration

Each issue and its corresponding solution is documented within the project.

---

# Current Project Scope

This repository focuses solely on building and configuring the Android security laboratory.

Topics such as:

* Static application analysis
* Dynamic analysis
* Reverse engineering
* APK modification
* Malware analysis
* Frida instrumentation

are intentionally excluded and will be covered in future projects built on top of this lab.

---

# Lessons Learned

Building this lab provided practical experience with:

* Wayland-based Android virtualization
* Desktop environment compatibility
* Android networking
* Android Debug Bridge
* Proxy configuration
* Linux containerized Android environments
* Troubleshooting Waydroid deployments

More importantly, the project reinforced the value of understanding the underlying technologies rather than simply following installation commands.

---

# Future Improvements

Planned enhancements include:

* Android Static Analysis Lab
* Frida Dynamic Instrumentation Lab
* APK Reverse Engineering Lab
* Mobile API Security Testing
* SSL Pinning Research
* Android Malware Analysis Lab
* OWASP MSTG Practice Environment

These will be developed as separate projects to keep this repository focused on the Android lab itself.
I don't really know if I would be the one to delve into this projects though

---

# Screenshots

The `assets/screenshots` directory contains screenshots demonstrating:

* Waydroid installation
* Android interface
* ADB connectivity
* Burp Suite integration
* Phone mode configuration

---

# References

* Waydroid Documentation
* Android Debug Bridge Documentation
* Burp Suite Documentation
* Kali Linux Documentation
* KDE Plasma Documentation

---

# Author

**RD7**

Cybersecurity Researcher | Penetration Tester | Mobile Security Enthusiast

This repository serves as the foundation for future Android application security research and mobile penetration testing projects.
