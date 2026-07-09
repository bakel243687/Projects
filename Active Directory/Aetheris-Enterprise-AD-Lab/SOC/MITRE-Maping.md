
---

# Document 2: MITRE-Mapping.md

```markdown
# MITRE ATT&CK Mapping

This document maps observed Windows and Sysmon events to MITRE ATT&CK techniques.

---

## Initial Access

No detections implemented yet.

Future:

- Phishing simulations
- Remote Desktop abuse

---

## Persistence

### Account Manipulation

Technique:

T1098

Detection:

- Event 4722
- Event 4725
- Event 4728

---

## Execution

Technique:

T1059

Detection:

Sysmon Event 1

Examples:

- PowerShell
- cmd.exe
- net.exe

---


## Discovery

Technique:

T1087

Commands:

net user
Get-ADUser

Technique:

T1069

Commands:

net group
Get-ADGroup

Technique:

T1016

Commands:

ipconfig
hostname

---

## Credential Access

Future:

- Credential dumping simulations
- LSASS monitoring

---

## Lateral Movement

Future:

- PsExec
- Remote PowerShell
- SMB authentication

---

## Command and Control

Technique:

T1071

Detection:

Sysmon Event 3

Monitor:

- DNS
- HTTP
- HTTPS

---

## Impact

Future:

- File encryption simulation
- Mass file deletion
