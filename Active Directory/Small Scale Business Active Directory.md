# Raspberry Pi Active Directory Domain Controller (Samba AD)

# What to do
During the course of working on the system, I encountered several errors that affected both performance and stability. At first, the system showed signs of inconsistency such as freezing, slow response times, and occasional failure to boot properly. These symptoms suggested that the problem might not be a single fault but a combination of hardware and software issues.

My initial thought process was to avoid assumptions and focus on observation. I paid close attention to when the errors occurred and what actions triggered them. This helped me narrow the issue down to internal components rather than external devices. I suspected memory-related problems because the system behavior was unpredictable and did not point clearly to one application or process.

After considering this, I decided to inspect the internal hardware. I powered down the system and checked the power source as well as the the router (MiFi) being used, I discovered the power supply cable for the Raspberry Pi was faulty and the router (MiFi) was low on battery. I immediately arranged for a new power supply cable and ensured full charge of the router (MiFi) This action improved system stability, confirming that my reasoning was on the right track.

Immediately after the previously resolved issue, another one came up 
```Cannot find KDC for realm "LAB.LOCAL" while getting initial credentials```
At first, I was clueless and it sent me into researching and browsing until something hit me and I went back to reinstall the Samba AD and I realized that I had made a mistake in the Name of the Kerberos server for the realm and also the Administrative server too. Once I resolved this, I got the service working smoothly. Now, I can go on with Adding clients 

Throughout the troubleshooting process, my approach was systematic. I identified symptoms, formed logical assumptions, tested one solution at a time, and observed the results before moving forward. Instead of rushing to conclusions, I treated each error as information guiding me toward the solution. This experience reinforced the importance of patience, careful analysis, and methodical problem-solving when dealing with computer system errors.

## Project Overview

This project documents the design and implementation of a **functional Active Directory Domain Controller** using **Samba AD on a Raspberry Pi**, integrated into a VLAN-segmented enterprise network. The goal is to build a realistic, security-aware lab suitable for learning, testing, and demonstrating Active Directory administration, authentication workflows, and future pentesting or SIEM detection scenarios.

The Domain Controller provides **DNS, Kerberos, LDAP, and authentication services**, closely mirroring a Windows-based AD environment.

---

## Architecture Summary

* **Domain Name:** `LAB.LOCAL`
* **Domain Controller Hostname:** `dc1.lab.local`
* **Platform:** Raspberry Pi (Linux)
* **Directory Service:** Samba Active Directory
* **DNS Backend:** Samba Internal DNS
* **Network Role:** Centralized identity and authentication authority

---

## Network & Identity Foundations

### Static Network Configuration

* Configured a **static IP address** on `wlan0`
* Ensured consistent addressing for DNS, Kerberos, and LDAP services
* Verified network reachability from other hosts

### Hostname Configuration

* Set a permanent hostname (`dc1`)
* Updated `/etc/hosts` to bind hostname to static IP
* Ensured hostname stability prior to AD provisioning

### Time Synchronization

* Enabled and configured NTP using `systemd-timesyncd`
* Set correct timezone
* Verified clock synchronization (critical for Kerberos)

---

## Active Directory Installation

### Installed Required Packages

* Samba
* Kerberos (krb5-user)
* Winbind
* DNS utilities

### Disabled Conflicting Services

* Stopped and disabled `smbd`, `nmbd`, and standalone `winbind`
* Enabled `samba-ad-dc` service

---

## Domain Provisioning

The Active Directory domain was provisioned using:

* **Realm:** `LAB.LOCAL`
* **NetBIOS Name:** `LAB`
* **Server Role:** Domain Controller
* **DNS:** Samba Internal DNS
* **RFC2307:** Enabled (for Unix/Linux interoperability)

Samba generated and deployed:

* Internal DNS zone
* Kerberos configuration
* SYSVOL and directory database

The generated Kerberos configuration was copied to `/etc/krb5.conf` for system-wide use.

---

## DNS & Kerberos Validation

### DNS Configuration

* Configured the Domain Controller to use **itself (`127.0.0.1`) as DNS**
* Verified A and SRV records for:

  * `_ldap._tcp.lab.local`
  * `_kerberos._tcp.lab.local`

### Kerberos Validation

* Successfully obtained Kerberos tickets using `kinit administrator`
* Verified tickets with `klist`
* Confirmed KDC discovery via DNS

---

## Organizational Structure

Created a realistic **Organizational Unit (OU)** hierarchy to reflect an enterprise environment:

```
LAB.LOCAL
 └── Corp
     ├── Users
     │   ├── Sales
     │   ├── IT
     │   └── Management
     ├── Computers
     │   ├── Workstations
     │   └── Servers
     └── ServiceAccounts
```

This structure supports:

* Group Policy application
* Delegation of administrative rights
* Realistic attack and defense scenarios

---

## Current Capabilities

At this stage, the Domain Controller can:

* Resolve internal DNS queries
* Issue Kerberos tickets
* Authenticate users and services
* Support domain joins
* Serve as a foundation for GPOs, logging, and security testing

---

## Planned Next Steps

* Create domain users, groups, and service accounts
* Join Windows and Linux clients to the domain
* Apply Group Policy Objects (GPOs)
* Introduce intentional misconfigurations for pentesting
* Integrate logging with a SIEM platform
* Simulate real-world AD attack paths and detections

---

## Purpose of This Lab

This project is designed for:

* Active Directory learning and administration
* Cybersecurity and pentesting practice
* SIEM detection engineering
* Portfolio demonstration of real-world IAM skills

---

## Status

**Active — foundational domain services completed.**
