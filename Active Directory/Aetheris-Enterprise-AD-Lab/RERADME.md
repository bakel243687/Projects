# Aetheris Enterprise Active Directory Security Lab

## Overview

This project documents the design, deployment, and security hardening of a simulated enterprise Active Directory environment. The objective was to gain practical experience in Windows Server administration, Identity and Access Management (IAM), Group Policy Management, Active Directory security, Linux domain integration, and Security Operations Center (SOC) readiness.

The lab simulates a small enterprise environment known as **Aetheris**, consisting of:

* Active Directory Domain Services (AD DS)
* DNS Services
* Organizational Unit (OU) Design
* User and Group Management
* Role-Based Access Control (RBAC)
* Group Policy Objects (GPOs)
* Service Account Management
* Windows Workstation Integration
* Linux Domain Integration
* Endpoint Monitoring with Sysmon
* Security Event Analysis

---

# Objectives

The objectives of this project were to:

* Deploy and configure an Active Directory Domain Controller.
* Implement enterprise-style Organizational Unit structures.
* Create and manage users, groups, and service accounts.
* Implement Role-Based Access Control (RBAC).
* Configure and enforce Group Policy security settings.
* Join Windows and Linux systems to the domain.
* Deploy endpoint monitoring tools.
* Generate and analyze security-related events.
* Prepare the environment for future SIEM integration.

---

# Lab Environment

## Domain Controller

| Component        | Details        |
| ---------------- | -------------- |
| Hostname         | DC01           |
| Operating System | Windows Server |
| Domain           | aetheris.local |
| Roles            | AD DS, DNS     |

---

## Windows Workstation

| Component        | Details            |
| ---------------- | ------------------ |
| Hostname         | WS01               |
| Operating System | Windows 10/11 Pro  |
| Purpose          | Domain Workstation |

---

## Linux Host

| Component        | Details             |
| ---------------- | ------------------- |
| Hostname         | Ubuntu01            |
| Operating System | Ubuntu              |
| Purpose          | Linux Domain Member |

---

# Active Directory Structure

```text
aetheris.local
│
├── Users
│   ├── IT
│   ├── HR
│   ├── Finance
│   ├── Operations
│   └── Management
│
├── Computers
│   ├── Workstations
│   └── Servers
│
├── Groups
│
└── Service Accounts
```

---

# User Management

Departmental users were created and organized into dedicated Organizational Units.

Departments include:

* IT
* HR
* Finance
* Operations
* Management

Administrative accounts were separated from standard user accounts following the principle of least privilege.

Examples:

* itadmin01
* itadmin01-admin
* breakglass-admin

---

# Security Groups

Security groups were created to implement Role-Based Access Control.

Examples:

* GG_IT
* GG_HR
* GG_FINANCE
* GG_OPERATIONS
* GG_MANAGEMENT

Additional groups were created for:

* File Share Permissions
* Administrative Delegation
* Service Account Management

---

# Service Accounts

Dedicated service accounts were implemented to support enterprise-style administration.

Examples:

* svc_backup
* svc_monitoring
* svc_print

Security controls applied:

* Password Never Expires
* Restricted permissions
* Group-based management

---

# Password Security

The following domain security policies were configured:

* Minimum Password Length: 12
* Password Complexity: Enabled
* Password History: 24
* Maximum Password Age: 90 Days

Account Lockout Policy:

* Threshold: 5 Failed Attempts
* Lockout Duration: 15 Minutes
* Counter Reset: 15 Minutes

---

# Role-Based Access Control (RBAC)

Departmental resources were protected through Active Directory security groups and NTFS permissions.

Implementation model:

User → Security Group → Resource

This approach follows enterprise best practices by avoiding direct permission assignment to users.

---

# Group Policy Management

The following security controls were implemented through Group Policy Objects:

## Security Policies

* Password Policies
* Account Lockout Policies

## Auditing Policies

* Logon Events
* Account Management Events
* Group Membership Changes
* Policy Changes

## Security Notice

A login banner was configured to display authorized-use warnings.

---

# Windows Domain Integration

The workstation (WS01) was successfully joined to the Active Directory domain.

Validation included:

* Domain Authentication
* Group Policy Application
* User Login Testing

---

# Linux Domain Integration

Ubuntu was integrated into Active Directory using:

* Realmd
* SSSD
* Kerberos
* ADCLI

Domain users were successfully authenticated against Active Directory.

---

# Sysmon Deployment

Sysmon was deployed to improve endpoint visibility.

Monitoring capabilities include:

* Process Creation
* Network Connections
* File Creation Events

Example Event IDs:

* Event ID 1 – Process Creation
* Event ID 3 – Network Connection
* Event ID 11 – File Creation

---

# Security Event Analysis

The following Active Directory security events were generated and analyzed:

| Event ID | Description         |
| -------- | ------------------- |
| 4624     | Successful Login    |
| 4625     | Failed Login        |
| 4720     | User Created        |
| 4724     | Password Reset      |
| 4728     | User Added to Group |

---

# Skills Demonstrated

## Active Directory Administration

* User Management
* Group Management
* OU Design
* Delegation

## Identity and Access Management

* RBAC
* Group-Based Authorization
* Least Privilege

## Windows Security

* GPO Configuration
* Audit Policies
* Account Security

## Linux Administration

* Active Directory Integration
* Kerberos Authentication
* SSSD Configuration

## Security Monitoring

* Sysmon Deployment
* Event Analysis
* Endpoint Visibility

---

# Future Improvements

* Wazuh Deployment
* Centralized Log Collection
* Detection Engineering
* Threat Hunting
* Security Automation
* Incident Response Workflows

---

# Conclusion

This project provided hands-on experience in enterprise identity management, access control, Windows administration, Linux integration, and security monitoring. The environment serves as a foundation for future SOC, IAM, and Blue Team projects while simulating real-world Active Directory operations.
