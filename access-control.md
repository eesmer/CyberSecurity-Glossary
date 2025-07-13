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

### 3- RBAC (Role-Based Access Control)
RBAC is a model where access is granted to **roles**, not directly to individual users.
Users inherit permissions based on their assigned roles or groups.

This approach is widely used in medium and large-scale organizations for ease of management and clarity.

#### Example – Active Directory Group-Based Access
- Groups like `HR_Admin` or `HR_ReadOnly` are defined.
- Permissions on shared folders are granted to these groups.
- `user1` is in `HR_ReadOnly` → read-only
- `user2` is in `HR_Admin` → read/write/delete

Users receive access based on group membership → RBAC.

#### Example – SUDO with Roles in Linux
```bash
%developers ALL=(ALL) NOPASSWD: /usr/bin/systemctl restart myapp
```

- Any user in the `developers` group can restart the service.
- This role-based privilege avoids direct root access.

---

## Conclusion and Evaluation
If a user can grant others access to a resource they control, that is **DAC**.
DAC can become complex at scale. Combining DAC with **RBAC** (via centrally managed groups/roles) improves maintainability.

In domain environments, AD users typically gain access through group memberships → this is **RBAC**.
Admins assigning permissions to groups = DAC. When users inherit access through their roles = RBAC.
-> The combination = **DAC + RBAC**, which is today’s most common model.

**Summary:**
- Permissions by admins/owners -> DAC
- Access via groups/roles -> RBAC

**MAC**, while offering the strongest theoretical control, is rarely used in standard enterprise environments.
It requires label-based classifications and rigid policy definitions, making it suitable for:
- Government
- Military
- Critical systems

It is too rigid for dynamic corporate environments where user flexibility is necessary.
