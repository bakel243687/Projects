# Raspberry Pi Active Directory Domain Controller (Samba AD)


## Project Overview

This project documents the design and implementation of a **functional Active Directory Domain Controller** using **Samba AD on a Raspberry Pi**, integrated into a VLAN-segmented enterprise network. The goal is to build a realistic, security-aware lab suitable for learning, testing, and demonstrating Active Directory administration, authentication workflows, and future pentesting or SIEM detection scenarios.

The Domain Controller provides **DNS, Kerberos, LDAP, and authentication services**, closely mirroring a Windows-based AD environment.

---

## Purpose of This Lab

This project is designed for:

* Active Directory learning and administration
* Cybersecurity and pentesting practice
* SIEM detection engineering
* Portfolio demonstration of real-world IAM skills

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

```sudo apt install samba Kerberos winbind dns-util```

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

Created an **Organizational Unit (OU)** hierarchy to reflect an enterprise environment:

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

This phase of the project focused on:

Creating Organizational Units (OUs)

Creating domain users

Creating security groups

Creating service accounts

Assigning group memberships

Joining a Windows 11 Pro machine to the domain

Validating Kerberos authentication

Applying baseline security policy


---

### Organizational Unit Structure

A minimal and scalable OU structure was implemented for a small-scale business:

DC=lab,DC=local
│
├── OU=Users
│   ├── OU=Staff
│   └── OU=Admins
│
├── OU=Computers
│
└── OU=ServiceAccounts

OU Creation Commands
```
samba-tool ou create "OU=Users,DC=lab,DC=local"
samba-tool ou create "OU=Staff,OU=Users,DC=lab,DC=local"
samba-tool ou create "OU=Admins,OU=Users,DC=lab,DC=local"
samba-tool ou create "OU=Computers,DC=lab,DC=local"
samba-tool ou create "OU=ServiceAccounts,DC=lab,DC=local"
```

---

### Creating Domain Users

Domain users were created and placed inside the appropriate OU.

Example: Create Staff User

samba-tool user create john.doe Password@123 \
  --given-name=John \
  --surname=Doe \
  --userou="OU=Staff,OU=Users"

Example: Create IT Admin User

samba-tool user create it.admin StrongPass@123 \
  --given-name=IT \
  --surname=Admin \
  --userou="OU=Admins,OU=Users"


---

### Creating Security Groups

Security groups were created to manage access control via group-based permissions.

Create Groups

samba-tool group add Sales
samba-tool group add IT
samba-tool group add HR

Add Users to Groups

samba-tool group addmembers Sales john.doe
samba-tool group addmembers IT it.admin

Verify Group Membership

samba-tool group listmembers Sales


---

### Creating Service Accounts

Service accounts are used for applications or services requiring domain authentication.

Create Service Account

samba-tool user create svc-backup SecureSvcPass@123 \
  --userou="OU=ServiceAccounts,DC=lab,DC=local"

Optional: Prevent interactive logon (recommended later via GPO).

Service accounts are isolated in a dedicated OU to allow targeted security policies.


---

### Joining Windows 11 Pro to the Domain

Pre-Join Requirements:

Windows version: Windows 11 Pro

DNS manually set to Domain Controller IP

Network connectivity confirmed

Time synchronized


DNS Configuration

Set preferred DNS to:

192.168.100.10

This is critical for domain resolution.

Testing Domain resolution

In the command prompt, ```ping lab.local```


---

Domain Join Process

1. Open System Properties


2. Click Change


3. Select Domain


4. Enter:



lab.local

5. Authenticate with:



Administrator

6. Restart the machine




---

### Resolving Domain Join Conflict

Encountered Error:

> Access is denied
Existing computer account already present



Resolution:

Check Existing Computer Objects

samba-tool computer list

Delete Stale Computer Object

samba-tool computer delete DESKTOP-N5VMDE6

Then retry domain join.


---

### Logging in as Domain Users

After successful join:

At login screen:

LAB\john.doe

or

john.doe@lab.local

On first login:

User profile is created

Kerberos ticket is issued

Group memberships applied



---

### Verifying Kerberos Authentication

On Windows client:

klist

Expected output includes:

krbtgt/LAB.LOCAL

This confirms:

Domain trust established

Kerberos functioning

Secure authentication in place



---

### Applying Baseline Security GPO

Download the RSAT: Group Policy add-on through Window Settings > System > Optional Features

Using RSAT (on admin workstation):

1. Open:

gpmc.msc


2. Create new GPO:

Baseline-Security


3. Link to domain



Password Policy Configured

Path:

Computer Configuration
→ Policies
→ Windows Settings
→ Security Settings
→ Account Policies
→ Password Policy

Configured:

Minimum password length: 12

Password complexity: Enabled

Account lockout threshold: 5 attempts



---

### Validation

On Windows client:

gpupdate /force

Test:

Failed logon attempts

Weak password rejection


On Domain Controller, monitor logs for:

Event ID 4624 – Successful logon

Event ID 4625 – Failed logon

Event ID 4768 – Kerberos TGT request

Event ID 4740 – Account lockout



---

12. Current Lab State

At this stage, the lab includes:

* Functional Samba Active Directory Domain

* Structured OU design

* Group-based access control

* Service account isolation

* Windows client domain integration

* Kerberos authentication validation

* Baseline security policy enforcement





---

Next progression: controlled file share permissions or centralized log monitoring integration.

---

## Problem Faced

Enountered an issue with the Raspberry Pi not booting up. The device shows sign of life before turning back off. I decided to inspect the internal hardware. I powered down the system and checked the power source as well as the the router (MiFi) being used, I discovered the power supply cable for the Raspberry Pi was faulty and the router (MiFi) was low on battery. I immediately arranged for a new power supply cable and ensured full charge of the router (MiFi) This action improved system stability, confirming that my reasoning was on the right track.

Immediately after the previously resolved issue, another one came up 
```Cannot find KDC for realm "LAB.LOCAL" while getting initial credentials```
At first, I was clueless and it sent me into researching and browsing until something hit me and I went back to reinstall the Samba AD and I realized that I had made a mistake in the Name of the Kerberos server for the realm and also the Administrative server too. Once I resolved this, I got the service working smoothly. Now, I can go on with Adding clients 

Throughout the troubleshooting process, my approach was systematic. I identified symptoms, formed logical assumptions, tested one solution at a time, and observed the results before moving forward. Instead of rushing to conclusions, I treated each error as information guiding me toward the solution. This experience reinforced the importance of patience, careful analysis, and methodical problem-solving when dealing with computer system errors.

Faced issues with creating Organizational Units which was due to the repitition of the Domain Controller which was not necessary. An example of the mistake made below
```
sudo samba-tool user create it.admin "somethingsimple" \
  --given-name=IT \
  --surname=Administrator \
  --userou="OU=Admins,OU=Users,DC=lab,DC=local"
```
Meanwhile, I was to do the below
```
sudo samba-tool user create it.admin "somethingsimple" \
  --given-name=IT \
  --surname=Administrator \
  --userou="OU=Admins,OU=Users"
```
I didn't realize until I read the error message I got from the failed attempt which had a repitition of the ```DC=lab, DC=local```

Discovered overheating of the Raspberry Pi during use which is not normal. I found out the fans was not running. I went to the config file fire the device using the below command
```nano /boot/firmware/config.txt```

In the config.txt file, I was able to turn on the fan and maintain a steady temperature of 40°C

---

## Status

**Active — foundational domain services completed.**
