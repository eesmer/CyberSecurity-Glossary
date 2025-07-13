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
