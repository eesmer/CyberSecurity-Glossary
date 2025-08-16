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
