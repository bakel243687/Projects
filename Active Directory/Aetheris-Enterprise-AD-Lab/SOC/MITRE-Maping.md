
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
