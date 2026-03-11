# Tripwire File Integrity Monitoring Lab

---

This lab demonstrates the practical implementation of the **Integrity** concept described in the glossary.

**Reference document:**
- for TR [Bütünlük](https://github.com/eesmer/CyberSecurity-Glossary/blob/main/TR/Bilgi_Guvenligi/belgeler/butunluk.md)
- for ENG [Integrity](https://github.com/eesmer/CyberSecurity-Glossary/blob/main/TR/Bilgi_Guvenligi/belgeler/butunluk.md)

**File Integrity Monitoring (FIM)** is a technique used to detect changes in files and directories by comparing their current state with a previously recorded baseline.
The purpose of this lab is to observe how **File Integrity Monitoring (FIM)** works on a real Linux system by using the [**Tripwire**](https://packages.debian.org/trixie/tripwire) tool on Debian. Rather than only explaining the concept, this lab shows how a system baseline can be created and how unauthorized file modifications can be detected.

---

### Lab Environment
This lab was performed on a minimal Debian system.

Example environment:
- OS: Debian GNU/Linux
- Tool: Tripwire (from Debian repo)
- Privileges: root

The lab can be reproduced on any standard Debian installation.

---

### Setup and Use

The test environment is set up using the [tripwire-installer](https://github.com/eesmer/CyberSecurity-Glossary/blob/main/LABS/information-security/integrity/tripwire/tripwire-installer.sh) script.
