# Issues Faced and Solutions

## Issue 1: PowerShell User Creation Failed

### Problem

PowerShell returned:

Directory object not found

### Cause

Incorrect Organizational Unit path specified in the script.

### Solution

Verified OU Distinguished Names using:

```powershell
Get-ADOrganizationalUnit -Filter *
```

Updated the script to reference valid OU paths.

---

## Issue 2: Linux Could Not Discover Domain

### Problem

realm discover failed.

### Cause

DNS configuration pointed to incorrect DNS servers.

### Solution

Configured Linux systems to use the Domain Controller as the primary DNS server.

---

## Issue 3: Kerberos Authentication Failed

### Problem

Linux systems could not authenticate against Active Directory.

### Cause

Time synchronization mismatch between Linux and the Domain Controller.

### Solution

Configured Chrony to synchronize with the Domain Controller.

---

## Issue 4: Domain Join Failed

### Problem

Client systems could not join the domain.

### Cause

DNS and network connectivity issues.

### Solution

Verified:

* DNS Resolution
* Domain Controller Reachability
* Kerberos Ports
* LDAP Ports

before retrying the domain join process.

---

## Issue 5: GPO Changes Not Applying

### Problem

Policy changes were not immediately visible on client systems.

### Cause

Group Policy refresh interval.

### Solution

Forced policy updates using:

```powershell
gpupdate /force
```

---

## Issue 6: Unauthorized Resource Access

### Problem

Users could access resources outside their department.

### Cause

Permissions were assigned directly to users.

### Solution

Implemented RBAC:

User → Group → Resource

using Active Directory Security Groups.

---

## Issue 7: Administrative Elevation Errors

### Problem

"The requested operation requires elevation" appeared during administrative tasks.

### Cause

Administrative actions were executed without elevated privileges.

### Solution

Used administrative credentials and verified Domain Admin membership.

---

## Issue 8: Share Access Inconsistencies

### Problem

Users received unexpected access results.

### Cause

Mismatch between Share Permissions and NTFS Permissions.

### Solution

Reviewed effective permissions and aligned Share and NTFS configurations.

---

## Issue 9: Sysmon Event Visibility

### Problem

Expected security events were not visible.

### Cause

Sysmon installation and configuration validation had not been completed.

### Solution

Verified Sysmon service status and reviewed Sysmon Operational logs in Event Viewer.

---

## Lessons Learned

* DNS is critical to Active Directory functionality.
* Kerberos requires accurate time synchronization.
* RBAC simplifies permission management.
* Group Policies require validation and testing.
* Administrative account separation improves security.
* Documentation is as important as implementation.
* Security monitoring should be planned alongside infrastructure deployment.
