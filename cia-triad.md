# CIA Triad (Confidentiality, Integrity, Availability)
> This document explains the three core principles of information security: Confidentiality, Integrity, and Availability.

---

## Definition
The CIA Triad consists of three core principles that form the basis of all information security measures:
- **Confidentiality**
- **Integrity**
- **Availability**

Together, these principles ensure that information is protected from unauthorized access, remains accurate and trustworthy, and is accessible when needed.<br>
All security policies, systems, and controls-directly or indirectly-aim to uphold these three principles.

## Confidentiality
Confidentiality means that only authorized individuals can access specific data.
The goal is to prevent unauthorized users from viewing, copying, transferring, or tampering with data.

**Measures to ensure confidentiality:**
- Authentication (MFA, passwords, access cards)
- Access control lists (ACLs)
- Encryption (e.g., AES)
- Secure transmission protocols (VPN, HTTPS)

## Integrity
Integrity refers to the accuracy and consistency of data.<br>
The goal is to prevent data from being changed, corrupted, or tampered with without proper authorization.

**Measures to ensure integrity:**
- Hashing algorithms (e.g., SHA-256)
- Digital signatures
- File integrity monitoring
- Authorization policies

## Availability
Availability ensures that authorized individuals can access data whenever it’s needed.<br>
System crashes, outages, or attacks like DoS may violate this principle.

**Measures to ensure availability:**
- Redundancy (failover systems, clusters)
- Backup strategies
- Power backups (UPS)
- DoS/DDoS protection

### Example Scenario
Consider a hospital's patient information system:

- Only authorized doctors can access patient records. (**Confidentiality**)
- Prescriptions and diagnoses must remain unchanged. (**Integrity**)
- Emergency room staff must have immediate access to the system. (**Availability**)

If any of these principles are violated, both patient safety and institutional reputation are at risk.

---

### Related Pages

- [Information Security](giris.md)
- [Data Classification](data-classification.md)
- [Access Control](../04-authentication/access-control.md)
