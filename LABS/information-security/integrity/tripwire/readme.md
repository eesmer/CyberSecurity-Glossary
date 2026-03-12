# Tripwire File Integrity Monitoring Lab

---

This lab demonstrates the practical implementation of the **Integrity** concept described in the glossary.

**Reference document:**
- for TR [Bütünlük](https://github.com/eesmer/CyberSecurity-Glossary/blob/main/TR/Bilgi_Guvenligi/belgeler/butunluk.md)
- for ENG [Integrity](https://github.com/eesmer/CyberSecurity-Glossary/blob/main/TR/Bilgi_Guvenligi/belgeler/butunluk.md)

**File Integrity Monitoring (FIM)** is a technique used to detect changes in files and directories by comparing their current state with a previously recorded baseline.
The purpose of this lab is to observe how **File Integrity Monitoring (FIM)** works on a real Linux system by using the [**Tripwire**](https://packages.debian.org/trixie/tripwire) tool on Debian. Rather than only explaining the concept, this lab shows how a system baseline can be created and how unauthorized file modifications can be detected.

---

## Lab Environment
This lab was performed on a minimal Debian system.

Example environment:
- OS: Debian GNU/Linux
- Tool: Tripwire (from Debian repo)
- Privileges: root

The lab can be reproduced on any standard Debian installation.

---

## Setup and Use
### Tripwire Installer

The test environment is set up using the [tripwire-installer](https://github.com/eesmer/CyberSecurity-Glossary/blob/main/LABS/information-security/integrity/tripwire/tripwire-installer.sh) script.

tripwire-installer;
- Performs installation in the test environment.
- Creates a baseline using `tripwire --init` This is the first post-installation process that takes a snapshot of the system.
- Performs integrity checks using `tripwire --check` and saves the report output to the **“/var/lib/tripwire/report/”** directory.

**The report can be read using the command:** `twprint --print-report --twrfile /var/lib/tripwire/report/$REPORT_NAME.twr`

#### Typical Workflow
  In a typical Tripwire workflow these tools are used as follows;
  - Configure policy using `twadmin`
  - Initialize the database using `tripwire --init`
  - Perform integrity checks using `tripwire --check`
  - Analyze reports using `twprint`

### Tripwire Report
**Important sections in the report** <br>
Under the Rule Summary heading;
**The values for System binaries** and **Critical configuration files** are important.
- **Total objects scanned:** Shows how many files were checked.
- **Total violations found:** Shows how many changes were found.
- **Added:** “/etc/newfile.conf”
Indicates a new file added during the check that was not present when the baseline was created.
- **Removed:** “/usr/bin/oldbinary”
Indicates a file that was present when the baseline was created but is not present during the check (deleted/removed). (This result may be critical and should be investigated.)
- **Modified:** “/etc/ssh/sshd_config”
Indicates files whose hash value has changed. <br>
Change -> May be due to an upgrade process. <br>
Change -> May have been made by an admin process. <br>
Change -> May be due to malware or a rootkit. <br>

### Tripwire Tools
- **twadmin** <br>
  `twadmin` is the administrative utility used to manage Tripwire configuration, policy files and cryptographic keys.
  Tripwire does not use the plain text policy file (twpol.txt) directly. Instead, the policy must be signed and converted into an active policy file. <br>
  This process is performed with twadmin. <br>
  
  **Creating a signed policy file** <br>
  `twadmin --create-polfile --site-keyfile /etc/tripwire/site.key /etc/tripwire/twpol.txt`
  
    twadmin command;
    - reads the plain text policy file
    - signs it using the site key
    - generates the active policy file used by Tripwire
  
- **twprint** <br>
  `twprint` is used to display Tripwire databases and reports in a readable format. <br>
  Tripwire reports are stored in a binary .twr format. <br>
  They must be converted to a human-readable format before analysis. <br>
  This is the main purpose of twprint. <br>
  
  **Printing Report** <br>
  `twprint --print-report --twrfile /var/lib/tripwire/report/$REPORT_NAME.twr`

    twprint command displays;
    - rule summary
    - modified files
    - added objects
    - removed objects
    - detailed file integrity information

### Tripwire Policy Configuration
Tripwire's behavior is determined by the policy file. <br>
This file defines which files and directories on the system will be monitored and which attributes will be compared. <br>

**Tripwire Directory:** `/etc/tripwire` <br>
**Tripwire policy file:** `/etc/tripwire/twpol.txt` <br>
This file is a plaintext configuration file. <br>
Tripwire does not use this file directly. It is first signed and converted into an active policy file. <br>
**Active policy file:** `/etc/tripwire/tw.pol` <br>

Tripwire policy file typically consists of the following sections;
- Variables
- Rule definitions
- Directories and files to monitor
- Exclusions (stop points)

This structure allows you to define which areas of the system will be monitored and which areas will be ignored.

#### Policy Masks
Tripwire can check not only the file's contents but also many of its properties

| Property | Desc.             |
| -------- | ----------------- |
| p        | file permissions  |
| i        | inode number      |
| n        | link count        |
| u        | owner             |
| g        | group             |
| s        | file size         |
| m        | modification time |
| c        | change time       |
| a        | access time       |
| C        | SHA checksum      |
| M        | MD5 checksum      |

Tripwire provides some ready-made masks;

| Mask        | Desc.                            |
| ----------- | -------------------------------- |
| `ReadOnly`  | Files that should not be changed |
| `Dynamic`   | Files that change frequently     |
| `Growing`   | log files                        |
| `IgnoreAll` | Completely ignore                |

#### Example Policy
The following example policy provides a simple, optimized structure

Objectives;
- Monitor critical system files
- Exclude directories that generate noise
- Make reports readable

**Critical System Binaries** <br>
```
(
  rulename = "Critical System Binaries",
  severity = 100
)
{
  /bin        -> $(ReadOnly);
  /sbin       -> $(ReadOnly);
  /usr/bin    -> $(ReadOnly);
  /usr/sbin   -> $(ReadOnly);
}
```
The above rule system monitors binary files <br>

Changes in these directories usually mean;
- package update
- malicious software
- malware or rootkit

**Critical Configuration Files** <br>
```
(
  rulename = "Critical configuration",
  severity = 90
)
{
  /etc -> $(ReadOnly);

  !/etc/mtab;
  !/etc/resolv.conf;
  !/etc/adjtime;
}
```

The `/etc` directory is the center of system configuration. <br>
However, some files are excluded because they change dynamically.

**Boot Files** <br>
```
(
  rulename = "Boot configuration",
  severity = 95
)
{
  /boot -> $(ReadOnly);
}
```
Changes to boot files are a critical situation <br>
For example;
- kernel change
- bootkit
- unauthorized kernel module

#### Excluding Noisy Directories
Some directories constantly change and are not suitable for integrity monitoring. <br>
These are called stop points. <br>
```
!/proc;
!/sys;
!/tmp;
!/run;
!/var/log;
```
is used in this form <br>

#### Applying Policy Changes
After making changes to twpol.txt, the policy must be re-signed. <br>
```
tripwire --update-policy /etc/tripwire/twpol.txt
```

---

#### Other Useful Commands
- Deletes reports older than 30 days <br>
  `find /var/lib/tripwire/report -type f -name "*.twr" -mtime +30 -delete`
- Tripwire reports can be filtered to focus only on modified files <br>
  `twprint --print-report --twrfile /var/lib/tripwire/report/$REPORT_NAME.twr | grep -E "Modified"`
- Prints the most recent report to the file <br>
`LATEST_REPORT="$(ls -1t /var/lib/tripwire/report/*.twr | head -n1)"` <br>
`twprint --print-report --twrfile "$LATEST_REPORT" > tripwire-report.txt`
