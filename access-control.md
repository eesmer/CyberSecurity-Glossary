# Access Control
> This document explains the concept of access control within the context of information security and describes common models and practical implementations.

---

## Definition
Access control refers to the set of rules and mechanisms that determine **who can access which information systems, resources, or data, when, how, and to what extent**.
Its main goal is to ensure that only authorized users access defined resources and to prevent unauthorized access.

Access control directly supports the **confidentiality** principle of information security.
It is also critical for resource efficiency, monitoring, and accountability.

---

## Types of Access Control
Different organizational structures and needs lead to the use of various access control models.

### 1- DAC (Discretionary Access Control)
This is a user-based model. *The resource owner decides who is allowed access.*
It is flexible but lacks centralized management. Typically seen in small to medium environments.

#### Example – Windows File Server or SMB Share
- A user creates a folder named `Paylasim`.
- They open “Sharing” → “Permissions” and assign access.
-> The user (resource owner) sets permissions. This is DAC.

#### Example – Linux with chmod
- A user sets `chmod 700` on a file in their home directory.
- Only the file owner has read/write/execute rights.
-> The permission is set by the user themselves. This is DAC.

In both examples, authorized users can create or manage subfolders or files and assign permissions to others.
This model suits small teams or organizations. However, since it lacks centralized control, regular audits are essential.

---

### 2- MAC (Mandatory Access Control)
MAC is a centrally governed access model.
Even if a user has apparent permissions, access is blocked if they don't meet label or classification rules.

This model is used in **high-security environments** such as military systems, government agencies, and critical infrastructure.

#### Example – SELinux (Security-Enhanced Linux)
SELinux is a MAC system integrated into the Linux kernel (used in RHEL-based systems).
Every **process** and **file** is labeled, and access decisions depend on these labels.

**Label structure:**
```bash
system_u:object_r:httpd_sys_content_t:s0
```

- Labels define user identity, object type, and security level.
- Only services with matching types (e.g., `httpd_t`) can access related paths (e.g., `/var/www/html`).

**Check status with:**
```bash
ls -Z /var/www/html
getenforce
```
Policies are configured via `semanage fcontext` and related directories.

#### Example - AppArmor
AppArmor is another MAC system, used mainly in Ubuntu and Debian systems.
It is profile-based and easier to configure than SELinux.

- Profiles are located under `/etc/apparmor.d/`.
- For example, you can limit what `/usr/sbin/cupsd` can access using its AppArmor profile.

#### Example - Active Directory + Classification (Windows Information Protection)
Using **Windows Information Protection** or **Microsoft Purview**, MAC-like classification can be enforced.

- A document is tagged “Finance – Confidential”.
- Only members of the "Finance" group can open the file.
- Even if others receive the file, they cannot view its content.
- Labels are centrally enforced and cannot be overridden by users.

**Note:** This requires Azure AD and cloud services. It’s not achievable with a standalone AD + File Server.

MAC offers strict policy enforcement but lacks flexibility.
Misconfiguration can lead to service disruption. Testing in permissive/audit mode is recommended.

---
