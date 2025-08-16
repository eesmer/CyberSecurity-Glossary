## Basic Concepts

---

Identity, Authentication, Authorization & Accounting (AAA)
### 1) Identity - “Who is this?”

An identity is how a person, device, or service is named so we can tell it apart from others.<br>
**Examples:** a username, email address, UUID, IP or MAC address.

**Important:** identity alone is just a claim (“I am alice@example.loc”). It becomes trustworthy only after authentication proves it.

### 2) Authentication - “Prove it”
Authentication is the process of proving that an identity really belongs to you.

Common factor types:
- Something you know (a PIN or password)
- Something you have (a smart card, hardware token, phone)
- Something you are (fingerprint, face)

**Basic example:**
User types USER1 as the username.
If the system knows that identity and the user enters the correct password (or passes MFA), authentication succeeds.

### 3) Authorization - “What are you allowed to do?”

Authorization decides what a successfully authenticated identity can access and how.
This is typically managed with roles, permissions, and access control lists (ACLs).

Key points:
- Authorization starts after authentication.
- It depends on configuration and policy (e.g., RBAC in large environments like Active Directory).
- It is easier to misconfigure than authentication and needs ongoing care: reviews, cleanups, and policy checks.

**Basic example:**
After login, a user with the *admin role* can change system settings; a *read-only* user can only view.

### AuthN vs. AuthZ - quick contrast

- **Authentication (AuthN)**: Are you really who you say you are?
Login checks, MFA prompts.
- **Authorization (AuthZ)**: Given who you are, what can you do?
Roles, permissions, ACLs.

**Analogy:** Showing your ID at a building entrance is authentication.
Which floors/rooms your badge opens is authorization.

4) Accounting — “What happened?”
In security, Accounting (often called audit & logging) tracks who did what, when, and from where so actions are traceable and reviewable.

Typical records:
- **SSH access logs**: which user, from which IP, login/logout times
- **Web server logs**: which page was accessed, status codes, errors
- **Database audit logs**: which queries ran and by whom
- **Directory service logs (e.g., AD)**: group changes, password resets, object deletes

Why it matters:
- Enables incident investigation and compliance reporting
- Supports accountability and continuous improvement
- Turns user actions into evidence you can analyze later
