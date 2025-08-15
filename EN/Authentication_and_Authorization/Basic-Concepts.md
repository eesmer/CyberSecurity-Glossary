## Basic Concepts

---

Identity, Authentication, Authorization & Accounting (AAA)
### 1) Identity — “Who is this?”

An identity is how a person, device, or service is named so we can tell it apart from others.<br>
**Examples:** a username, email address, UUID, IP or MAC address.

**Important:** identity alone is just a claim (“I am alice@example.loc”). It becomes trustworthy only after authentication proves it.

### 2) Authentication — “Prove it”
Authentication is the process of proving that an identity really belongs to you.

Common factor types:
- Something you know (a PIN or password)
- Something you have (a smart card, hardware token, phone)
- Something you are (fingerprint, face)

**Basic example:**
User types USER1 as the username.
If the system knows that identity and the user enters the correct password (or passes MFA), authentication succeeds.
