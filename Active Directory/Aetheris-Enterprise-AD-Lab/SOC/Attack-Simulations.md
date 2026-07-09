# Attack Simulations

The following activities simulate common attacker behavior in a controlled lab environment.

---

## Authentication

### Failed Logon

Objective

Generate Event 4625.

Commands

Attempt multiple incorrect passwords.

Expected Result

Security Event 4625 generated.

---

## Account Manipulation

Objective

Generate Event 4728.

Procedure

Add a test user to GG_IT.

Expected Result

Security Event 4728.

---

## Process Execution

Objective

Generate Sysmon Event 1.

Commands

cmd.exe

powershell.exe

notepad.exe

Expected Result

Sysmon records process creation.

---

## Network Activity

Objective

Generate Sysmon Event 3.

Commands

ping

nslookup

Expected Result

Outbound connection logged.

---

## File Creation

Objective

Generate Sysmon Event 11.

Procedure

Create test files.

Expected Result

File creation recorded by Sysmon.
