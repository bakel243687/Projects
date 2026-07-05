# Detection Matrix

## Overview

This document describes the security detections implemented within the Aetheris Enterprise Active Directory Lab. Each detection maps Windows Security and Sysmon events to potential attacker behavior and provides guidance for monitoring and triage.

---

| Detection | Event ID | Log Source | MITRE ATT&CK | Severity | Typical Analyst Action |
|------------|---------:|------------|--------------|----------|------------------------|
| Successful Logon | 4624 | Windows Security | T1078 - Valid Accounts | Low | Verify expected user and workstation |
| Failed Logon | 4625 | Windows Security | T1110 - Brute Force | Medium | Check for repeated failures and source |
| User Enabled | 4722 | Windows Security | T1098 - Account Manipulation | Medium | Confirm change request |
| User Disabled | 4725 | Windows Security | T1098 - Account Manipulation | Medium | Verify administrative action |
| User Added to Security Group | 4728 | Windows Security | T1098 - Account Manipulation | High | Review whether elevated privileges were intended |
| Process Creation | Sysmon 1 | Sysmon | T1059 - Command and Scripting Interpreter | High | Inspect command line and parent process |
| Network Connection | Sysmon 3 | Sysmon | T1071 - Application Layer Protocol | Medium | Review destination and initiating process |
| File Creation | Sysmon 11 | Sysmon | T1105 - Ingress Tool Transfer | Medium | Investigate newly created executable or script |
