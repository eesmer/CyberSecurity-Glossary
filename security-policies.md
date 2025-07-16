# Security Policies
> This document explains the core security policies that should be implemented in organizations within the scope of information security, along with practical defense strategies.

---

## Definition
Security policies are the principles, rules, and procedures defined by an organization to protect its information systems.
The goal is to ensure that systems are designed and managed in accordance with the principles of confidentiality, integrity, and availability (CIA), and that users operate within these defined rules.

---

## Core Security Policies

> ## 1. Least Privilege Principle
Users must be granted **only the minimum permissions necessary** to perform their job functions.
Excessive privileges can lead to unauthorized data access, system errors, and malicious activity - all of which expand the potential attack surface.
An environment with unused or overly broad permissions increases the need for oversight and introduces unnecessary risks.
To implement this policy effectively, the following practices should be applied during environment setup and configuration:

- ### **Permission Audits**

All user accounts should be reviewed regularly along with the permissions they hold in the system.  
If a user's job role has changed, any previously granted privileges must be revoked.  
The following basic queries can be used to retrieve permission information for user accounts in commonly used Active Directory environments.

> ###### PowerShell command to list the groups a user is a member of (Active Directory):
```powershell
Get-ADUser -Identity "username" -Properties MemberOf | Select-Object -ExpandProperty MemberOf
```

> ###### Bash commands to check local user permissions on Linux systems:
- ###### List user’s groups
```bash
id username
```

- ###### Check for user-specific entries in /etc/sudoers
```bash
grep -E "^username|^%.*" /etc/sudoers
```

- ###### Check if user is in the sudo group
```bash
groups username | grep sudo
```

These audits form a basic approach for controlling access in environments that use either DAC (Discretionary Access Control) or RBAC (Role-Based Access Control) through user or group-level authorizations.

> ## 2. Access Management Policy
Regulating access to an organization’s systems and resources is one of the core components of information security.  
Mechanisms such as authentication, authorization, user lifecycle management, and multi-factor authentication (MFA) fall under the scope of this policy.

- ### Objectives of the Access Management Policy
  - Define authentication and authorization processes  
  - Use of groups, roles, password policies, and multi-factor authentication (MFA)  
  - Perform regular reviews of user accounts  

- ### Authentication and Authorization
  - Strong authentication mechanisms should be enforced when users access the system.  
  - **Password Policy:** Minimum length, complexity, and mandatory periodic changes should be applied.  
  - **Use of MFA:** Should be mandatory, especially for administrator accounts and remote access scenarios.
