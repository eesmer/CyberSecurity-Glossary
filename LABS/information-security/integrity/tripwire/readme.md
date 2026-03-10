# Tripwire File Integrity Monitoring Lab

---

This lab demonstrates the practical implementation of the **Integrity** concept described in the glossary.

**Reference document:**
- for TR [Bütünlük](https://github.com/eesmer/CyberSecurity-Glossary/blob/main/TR/Bilgi_Guvenligi/belgeler/butunluk.md)
- for ENG [Integrity](https://github.com/eesmer/CyberSecurity-Glossary/blob/main/TR/Bilgi_Guvenligi/belgeler/butunluk.md)

The purpose of this lab is to observe how **File Integrity Monitoring (FIM)** works on a real Linux system by using the [**Tripwire**](https://packages.debian.org/trixie/tripwire) tool on Debian. Rather than only explaining the concept, this lab shows how a system baseline can be created and how unauthorized file modifications can be detected.

---

### What is File Integrity Monitoring (FIM)?
File Integrity Monitoring (FIM) is a technique used to detect changes in files and directories by comparing their current state with a previously recorded baseline.

A typical FIM workflow consists of:
1. Creating a baseline of the system
2. Monitoring files and directories
3. Detecting changes
4. Generating reports
5. Updating the baseline when legitimate changes occur

FIM is commonly used to detect:
- unauthorized system modifications
- malware or rootkits
- configuration drift
- suspicious changes in critical binaries

Tripwire is one of the classic tools used to implement this approach.

---

# Lab Environment
This lab was performed on a minimal Debian system.
