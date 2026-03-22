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

### 1.1 Hash Functions
Hash functions (e.g., SHA-256) generate a fixed-length digest from a dataset.
Properties:
- Deterministic
- One-way
- Collision resistant

### 1.2 Message Authentication Code (MAC)
MAC is a combination of hash + secret key. <br>

With this:
- Has the data been modified?
- Is the data really from the expected source?
can be answered.
If the hash value of a file changes, its content has changed.
However, hash alone does not provide authentication; it only provides change detection.

### 1.3 Digital Signature
Digital signature provides both integrity and non-repudiation.

Example use cases:
- Software package signatures
- Update mechanisms
- TLS certificates

### 1.4 Checksum vs Cryptographic Hash
Checksum algorithms (e.g., CRC32):
- Designed for error detection
- Not for security purposes

Cryptographic hash:
- Resistant to intentional manipulation

This distinction is critical in security design.

## 2. Factors That Threaten Integrity
Integrity can be broken not only by attackers but also by operational errors.

### 2.1 Intentional Manipulation
- Rootkit installation
- System file modification
- Log manipulation
- Web application defacement

### 2.2 Accidental Corruption
- Disk errors
- Misconfiguration
- Human error

### 2.3 Malware
- Ransomware
- Backdoor
- Unauthorized configuration changes

## 3. Integrity Controls
Controls used to ensure integrity can be divided into two main groups:

### 3.1 Preventive Controls
- Access control mechanisms
- File permissions
- Immutable flag (chattr +i)
- Version control systems

### 3.2 Detective Controls
- Log monitoring
- File Integrity Monitoring (FIM)
- Package signature verification
- Configuration drift detection

## 4. File Integrity Monitoring (FIM)
File Integrity Monitoring (FIM) is a method of detecting changes by comparing files and directories on a system with a predefined reference state (baseline).

Core principles of FIM: <br>
**1.** Creating a baseline <br>
**2.** Periodic comparison <br> 
**3.** Reporting <br>
**4.** Change management <br>

FIM systems generally use mechanisms such as: <br>
- Hash comparison
- File metadata control
- Permission change control
- Ownership change control

## 5. Integrity and Change Management
Integrity monitoring must work together with change management.

Otherwise: <br>
- Planned updates generate “alerts”
- Noise increases
- Security teams become insensitive to alerts

A healthy model:

**1.** Change request (change ticket)
**2.** Planned implementation <br>
**3.** FIM check <br>
**4.** Report analysis <br>
**5.** Baseline update if necessary <br>

## 6. Example Scenario
Example: Modification of ``/usr/sbin/sshd`` file on a Linux server. <br>

Possible scenarios:
- Package update
- Unauthorized binary modification
- Backdoor placement

**Important:** Without integrity control, this change may not be detected.

## 7. Practical Study
Implementation of this concept on Debian: <br>
LABS -> Information Security -> Integrity -> Tripwire [link to be added]

This lab study includes:
- Baseline creation
- Policy definition
- Periodic checks
- Report generation
- JSON/Markdown output
- Hardening recommendations
