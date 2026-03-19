# Integrity
> Integrity is ensuring the correctness, consistency, and protection of information from unauthorized modification

---

This concept is defined within the CIA Triad, which is one of the fundamental principles of information security
(see: [CIA Triad](https://github.com/eesmer/CyberSecurity-Glossary/blob/main/EN/Information_Security/docs/cia-triad.md))

In the context of CIA, integrity means:
- Data must be correct
- Data must be complete
- Data must not be changed in an unauthorized way
- Changes must be traceable

However, integrity is not only a theoretical principle; it is a security property ensured by technical, cryptographic, and operational mechanisms.
This document aims to explain integrity by moving from conceptual level to technical level.

---

## 1. What is Integrity Technically?
In technical terms, integrity is the ability to verify whether a data object (file, database record, network packet, configuration file, etc.) has been changed after it was created.
This verification is generally done using cryptographic methods:
