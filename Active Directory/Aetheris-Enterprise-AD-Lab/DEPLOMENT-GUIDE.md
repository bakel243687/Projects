# Aetheris Enterprise Active Directory Security Lab

## Complete Deployment Guide

---

# Project Overview

This guide documents the complete deployment of an enterprise-style Active Directory security lab environment using Oracle VirtualBox.

The purpose of this project is to simulate a real-world enterprise environment for learning:

* Active Directory Administration
* Identity and Access Management (IAM)
* Windows Server Administration
* Linux Integration
* Group Policy Management
* Security Monitoring
* Role-Based Access Control (RBAC)

---

# Lab Architecture

```text
Internet
    │
    │
Host Machine
    │
VirtualBox
    │
 ┌─────────────┬─────────────┬─────────────┐
 │             │             │
DC01         WS01        Ubuntu01        WS02
Windows      Windows      Ubuntu        Windows
Server       11 pro        Linux         11 pro
 │
 │
aetheris.local
```

---

# Hardware Requirements

Recommended:

| Resource   | Minimum        |
| ---------- | -------------- |
| RAM        | 16 GB          |
| CPU        | 4 Cores        |
| Storage    | 100 GB         |
| VirtualBox | Latest Version |

---

# Software Requirements

## Windows Server ISO

Recommended:

* Windows Server 2022

---

## Windows Workstation ISO

Recommended:

* Windows 10 Pro
  or
* Windows 11 Pro

---

## Linux ISO

Recommended:

* Ubuntu Server 24.04 LTS

---

# Phase 1: VirtualBox Configuration

---

## Install VirtualBox

Download and install VirtualBox.

After installation:

Verify:

```text
VirtualBox Manager Opens Successfully
```

---

# Configure Networking

Open:

```text
Tools
→ Network Manager
```

## Initial Network Design

The initial lab deployment used a Bridged Adapter configuration for all virtual machines.

Configuration:

```text
Adapter 1:
Bridged Adapter
```

### Problem Encountered

The Bridged Adapter configuration resulted in several networking issues, including:

* Unreliable internet access
* Host network dependency
* Difficulty maintaining consistent connectivity
* Inconsistent communication between lab systems
* DHCP assignment variations depending on the physical network

Because the lab environment required both internet access and isolated communication between domain systems, the Bridged Adapter approach was abandoned.

---

## Final Network Design

A dual-adapter design was implemented for all virtual machines.

Each virtual machine uses:

## Adapter 1

```text
Attached To: NAT
```

Purpose:

* Internet Access
* Software Downloads
* Windows Updates
* Linux Package Installation
* Tool Installation

---

## Adapter 2

```text
Attached To: Internal Network
```

Network Name:

```text
AetherisLab
```

Purpose:

* Domain Communication
* DNS Queries
* Active Directory Authentication
* Kerberos Traffic
* LDAP Communication
* File Sharing

---

# Virtual Machine Network Configuration

## DC01

Adapter 1:

```text
NAT
```

Adapter 2:

```text
Internal Network (AetherisLab)
```

Static IP:

```text
192.168.10.10
```

Subnet:

```text
255.255.255.0
```

DNS:

```text
127.0.0.1
```

---

## WS01

Adapter 1:

```text
NAT
```

Adapter 2:

```text
Internal Network (AetherisLab)
```

Static IP:

```text
192.168.10.20
```

Subnet:

```text
255.255.255.0
```

Gateway:

```text
192.168.10.10
```

DNS:

```text
192.168.10.10
```

---

## Ubuntu01

Adapter 1:

```text
NAT
```

Adapter 2:

```text
Internal Network (AetherisLab)
```

Static IP:

```text
192.168.10.30
```

Subnet:

```text
255.255.255.0
```

DNS:

```text
192.168.10.10
```

---

# Benefits of the Dual Adapter Design

The dual-adapter architecture provides:

* Internet connectivity through NAT
* Isolated enterprise network simulation
* Reliable Active Directory communication
* Consistent DNS resolution
* Easier troubleshooting
* Improved lab realism


---

# Create Domain Controller VM

## Virtual Machine Settings

Name:

```text
DC01
```

Operating System:

```text
Windows Server 2022
```

Resources:

```text
RAM: 4096 MB
CPU: 2 vCPU
Disk: 60 GB
```

Network Adapter:

```text
Adapter 1:
Host-Only Adapter
```

---

# Install Windows Server

Boot from ISO.

Follow installation wizard.

Select:

```text
Windows Server Standard Desktop Experience
```

Complete installation.

---

# Initial Server Configuration

Rename computer:

```powershell
Rename-Computer -NewName "DC01" -Restart
```

---

# Configure Static IP

Open:

```text
Network Connections
```

Configure:

```text
IP Address: 192.168.10.10
Subnet Mask: 255.255.255.0
Gateway: 192.168.10.1
Preferred DNS: 127.0.0.1
```

Verify:

```powershell
ipconfig /all
```

---

# Install Active Directory Domain Services

Open:

```text
Server Manager
→ Add Roles and Features
```

Install:

```text
Active Directory Domain Services
DNS Server
```

---

# Promote Server to Domain Controller

Select:

```text
Promote this server to a domain controller
```

Choose:

```text
Add a new forest
```

Domain Name:

```text
aetheris.local
```

Configure:

```text
Directory Services Restore Mode Password
```

Complete installation.

Server will reboot.

---

# Verify Domain Controller

Verify:

```powershell
hostname
```

Expected:

```text
DC01
```

Verify domain:

```powershell
echo %USERDOMAIN%
```

Expected:

```text
AETHERIS
```

---

# Phase 2: Active Directory Structure

---

# Create Organizational Units

Open:

```text
Active Directory Users and Computers
```

Create:

```text
Users
Computers
Groups
Service Accounts
```

---

# Create Department OUs

Under Users:

```text
IT
HR
Finance
Operations
Management
```

Result:

```text
Users
├── IT
├── HR
├── Finance
├── Operations
└── Management
```

---

# Create Computer OUs

Under Computers:

```text
Workstations
Servers
```

---

# Phase 3: User Creation

Create administrative accounts:

```text
itadmin01
itadmin01-admin
breakglass-admin
```

---

# Create Department Users

IT:

```text
ituser01
ituser02
ituser03
```

HR:

```text
hruser01
hruser02
hruser03
```

Finance:

```text
finuser01
finuser02
finuser03
```

Operations:

```text
opuser01
opuser02
opuser03
```

Management:

```text
ceo01
cfo01
coo01
```

---

# Phase 4: Group Creation

Create Security Groups:

```text
GG_IT
GG_HR
GG_FINANCE
GG_OPERATIONS
GG_MANAGEMENT
```

Settings:

```text
Scope: Global
Type: Security
```

---

# Administrative Groups

Create:

```text
GG_IT_ADMIN
GG_WORKSTATION_ADMINS
```

---

# Service Account Group

Create:

```text
GG_SERVICE_ACCOUNTS
```

---

# Phase 5: Service Accounts

Create:

```text
svc_backup
svc_monitoring
svc_print
```

Configure:

```text
Password Never Expires
User Cannot Change Password
```

---

# Phase 6: Security Hardening

---

# Password Policy

Configure:

```text
Minimum Length: 12
Complexity Enabled
Password History: 24
Maximum Age: 90 Days
```

---

# Account Lockout Policy

Configure:

```text
Threshold: 5
Duration: 15 Minutes
Reset Counter: 15 Minutes
```

---

# Login Banner

Create security notice:

```text
AUTHORIZED ACCESS ONLY

This system is monitored and recorded.
Unauthorized access is prohibited.
```

---

# Phase 7: RBAC Implementation

Create shared folders:

```text
C:\Shares
```

Create:

```text
IT
HR
Finance
Operations
Management
```

---

# Create Share Groups

```text
GG_IT_SHARE
GG_HR_SHARE
GG_FINANCE_SHARE
GG_OPERATIONS_SHARE
GG_MANAGEMENT_SHARE
```

Assign permissions through groups only.

Model:

```text
User
 ↓
Group
 ↓
Resource
```

---

# Phase 8: Windows Workstation Deployment

Create VM:

```text
WS01
```

Resources:

```text
RAM: 4096 MB
CPU: 2 vCPU
Disk: 40 GB
```

Install:

```text
Windows 10 Pro
```

or

```text
Windows 11 Pro
```

---

# Configure Networking

IP:

```text
192.168.10.20
```

DNS:

```text
192.168.10.10
```

---

# Join Domain

Join:

```text
aetheris.local
```

Authenticate using:

```text
AETHERIS\itadmin01-admin
```

Restart.

Move workstation to:

```text
Computers
└── Workstations
```

---

# Phase 9: Administrative Tools

Install:

* RSAT
* PowerShell 7
* Windows Terminal
* Sysinternals Suite
* Wireshark
* VS Code

---

# Phase 10: Sysmon Deployment

Install Sysmon on:

```text
DC01
WS01
```

Verify:

```text
Applications and Services Logs
└── Microsoft
    └── Windows
        └── Sysmon
```

---

# Phase 11: Linux Domain Integration

Create VM:

```text
Ubuntu01
```

Resources:

```text
RAM: 2048 MB
CPU: 2 vCPU
Disk: 25 GB
```

Configure:

```text
Hostname: ubuntu01
IP: 192.168.10.30
DNS: 192.168.10.10
```

Install:

```bash
sudo apt install realmd sssd adcli oddjob krb5-user
```

Join domain:

```bash
sudo realm join aetheris.local -U itadmin01-admin
```

Verify:

```bash
realm list
```

---

# Phase 12: Security Event Validation

Generate and analyze:

| Event ID | Description             |
| -------- | ----------------------- |
| 4624     | Successful Login        |
| 4625     | Failed Login            |
| 4720     | User Created            |
| 4724     | Password Reset          |
| 4728     | Group Membership Change |

---

# Phase 13: Future Enhancements

Planned improvements:

* Wazuh SIEM
* Centralized Logging
* Detection Rules
* Threat Hunting
* Incident Response Scenarios
* Purple Team Exercises

---

# Project Outcome

This project successfully demonstrates:

* Active Directory Administration
* RBAC Implementation
* Identity and Access Management
* Windows Security Hardening
* Linux Integration
* Security Monitoring Fundamentals

The lab provides a foundation for SOC Analyst, Blue Team, IAM, and Systems Administration career paths.
