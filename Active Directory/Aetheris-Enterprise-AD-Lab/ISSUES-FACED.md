# Issues Faced During Project Development

## Active Directory User Creation Failures

While automating user creation through PowerShell, user creation attempts failed due to incorrect Organizational Unit paths and directory object resolution errors.

---

## DNS Resolution Problems

Domain resources could not initially be resolved from client systems due to incorrect DNS configuration.

---

## Linux Domain Join Failures

Ubuntu systems experienced issues discovering and joining the Active Directory domain.

---

## Kerberos Authentication Errors

Kerberos authentication failed due to time synchronization differences between Linux and the Domain Controller.

---

## Group Policy Application Delays

Changes made to Group Policy Objects were not immediately reflected on client systems.

---

## Permission Assignment Challenges

Initial permission assignments were performed directly on users before transitioning to a group-based RBAC model.

---

## Domain Administrator Elevation Issues

Administrative actions occasionally generated elevation prompts and authentication errors due to account formatting and privilege assignment challenges.

---

## Share and NTFS Permission Conflicts

File access testing revealed differences between Share Permissions and NTFS Permissions, requiring adjustments to effective permissions.

---

## Endpoint Monitoring Deployment Challenges

Sysmon deployment required additional configuration and verification to ensure event generation and logging.

---

## Documentation and Architecture Planning

Maintaining consistency between the implemented environment and project documentation required continuous updates and validation.
