# Tripwire File Integrity Monitoring Lab

---

This lab demonstrates the practical implementation of the **Integrity** concept described in the glossary.

**Reference document:**
- TR [Bütünlük](https://github.com/eesmer/CyberSecurity-Glossary/blob/main/TR/Bilgi_Guvenligi/belgeler/butunluk.md)
- EN [Integrity](https://github.com/eesmer/CyberSecurity-Glossary/blob/main/EN/Information_Security/docs/integrity.md)

**File Integrity Monitoring (FIM)** is a technique used to detect changes in files and directories by comparing their current state with a previously recorded baseline.
The purpose of this lab is to observe how **File Integrity Monitoring (FIM)** works on a real Linux system by using the [**Tripwire**](https://packages.debian.org/trixie/tripwire) tool on Debian. Rather than only explaining the concept, this lab shows how a system baseline can be created and how unauthorized file modifications can be detected.

---

#### Scripts
- [tripwire-installer.sh](https://github.com/eesmer/CyberSecurity-Glossary/blob/main/LABS/information-security/integrity/tripwire/tripwire-installer.sh)
- [tripwire-apply-policy.sh](https://github.com/eesmer/CyberSecurity-Glossary/blob/main/LABS/information-security/integrity/tripwire/tripwire-apply-policy.sh)

``bash tripwire-installer.sh``

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

The test environment is set up using the [tripwire-installer.sh](https://github.com/eesmer/CyberSecurity-Glossary/blob/main/LABS/information-security/integrity/tripwire/tripwire-installer.sh) script.

```bash
bash tripwire-installer.sh
```
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

#### Policy File Structure
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
```bash
tripwire --update-policy /etc/tripwire/twpol.txt
```
#### Rebuilding the Database
When the policy is changed, the Tripwire database must be rebuilt. <br>
```bash
tripwire --init
```
This process creates a new baseline according to the new policy.

### Applying the Example Policy
The following helper script writes the example Tripwire policy used in this lab,
updates the active signed policy, and rebuilds the Tripwire database.

[tripwire-apply-policy.sh](https://github.com/eesmer/CyberSecurity-Glossary/blob/main/LABS/information-security/integrity/tripwire/tripwire-apply-policy.sh)

```bash
bash scripts/apply-policy.sh
```
---

#### Other Useful Commands
- **Deletes reports older than 30 days**
  ```bash
  find /var/lib/tripwire/report -type f -name "*.twr" -mtime +30 -delete
  ```
  
- **Tripwire reports can be filtered to focus only on modified files**
  ```bash
  twprint --print-report --twrfile /var/lib/tripwire/report/$REPORT_NAME.twr | grep -E "Modified"

  LATEST=$(ls -1t /var/lib/tripwire/report/*.twr | head -n1) && echo ".:: Modified Object and Files ::."
  twprint --print-report --twrfile "$LATEST" | grep "Modified object name:" | sed 's/Modified object name: //'
  ```
  **Note:** Seeing *Modified* in Tripwire reports does not always mean an attack. <br>
  There may be reasons for this:
  - system update
  - package installation
  - configuration change
  - log rotation
  Therefore, Tripwire is classified as a *detective control*.
  
- **Prints the most recent report to the file**
```bash
LATEST_REPORT="$(ls -1t /var/lib/tripwire/report/*.twr | head -n1)"
`twprint --print-report --twrfile "$LATEST_REPORT" > tripwire-report.txt
```
---

### Tripwire Report Analysis
Tripwire integrity checks may report file modifications.
However, not every modification indicates a security incident.

Changes detected by Tripwire may be caused by:
- system updates
- package installations
- configuration changes
- scheduled maintenance
- malicious activity

For this reason, Tripwire reports must always be interpreted in context.

#### Step 1 - Identify the Modified Object
First extract the modified files:
```bash
LATEST=$(ls -1t /var/lib/tripwire/report/*.twr | head -n1)
twprint --print-report --twrfile "$LATEST" \
| grep "Modified object name:" \
| sed 's/Modified object name: //'
```
**Example output:** <br>
/etc/ssh/sshd_config <br>
/usr/bin/sudo <br>
/etc/passwd <br>

This list identifies which objects changed compared to the baseline.

#### Step 2 - Determine the File Category
The first analytical step is to determine what type of file was modified.

| Category            | Example                | Risk           |
| ------------------- | ---------------------- | -------------- |
| System binaries     | `/usr/bin/sudo`        | High           |
| Configuration files | `/etc/ssh/sshd_config` | Medium         |
| User data           | `/home/user/file`      | Low            |
| Logs                | `/var/log/syslog`      | Usually normal |

#### Step 3 - Check System Package Changes
Many Tripwire alerts are caused by legitimate package updates.
Check whether the file belongs to a Debian package:
```bash
dpkg -S /usr/bin/sudo
```
Example:
sudo: /usr/bin/sudo

Then check when the package was last upgraded:
```bash
grep sudo /var/log/dpkg.log
```
If the change matches a package upgrade, the change is probably not a problem.

#### Step 4 - Verify File Integrity with Package Manager
Debian can verify package files.
debsums -s sudo

If the file checksum differs from the package checksum, this may indicate tampering.

#### Step 5 - Check File Metadata
Tripwire detects several attributes such as:
- owner
- permissions
- modification time
- checksum
Investigate the file manually:
```bash
ls -l /usr/bin/sudo
stat /usr/bin/sudo
```
Unexpected owner or permission changes may indicate compromise.

#### Step 6 - Compare File Hash
Compute a hash manually:
```bash
sha256sum /usr/bin/sudo
```
Then compare with a trusted system or package repository.

#### Step 7 - Investigate System Context
Modified file should always be evaluated together with system events.
Check logs:
```bash
journalctl -xe
```
Check login history:
```bash
last
```
Check running processes:
```bash
ps aux
```
#### Step 8 - Identify Indicators of Compromise
Certain modifications are particularly suspicious:
- changes to system binaries
- unexpected setuid binaries
- unauthorized changes in /etc/passwd
- modified SSH configuration
- altered boot files

These cases may indicate:
- privilege escalation
- rootkit installation
- persistence mechanisms

### Example Analysis
Tripwire reports:
```
Modified object name: /etc/ssh/sshd_config
```
Possible explanations:
| Scenario                         | Explanation |
| -------------------------------- | ----------- |
| Admin configuration change       | normal      |
| package upgrade                  | normal      |
| attacker enabling password login | suspicious  |

Further analysis would include:
```bash
grep PasswordAuthentication /etc/ssh/sshd_config
```
#### Security Insight
Tripwire is a detective security control. <br>
It does not prevent attacks, but it provides evidence of system changes.

When used together with:
- system logs
- package verification
- configuration auditing

Tripwire becomes a powerful tool for incident investigation.

### Conclusion
This lab demonstrated how File Integrity Monitoring works in practice.

The following concepts were covered:
- integrity monitoring
- Tripwire installation
- policy configuration
- baseline generation
- automated checks
- report analysis

Tripwire allows administrators to detect unexpected modifications on critical system files and supports incident response investigations.

---

## References

##### Tripwire Documentation
- https://github.com/Tripwire/tripwire-open-source

##### Debian Man Pages
- https://manpages.debian.org/tripwire
- https://manpages.debian.org/tripwire/tripwire.8.en.html
- https://manpages.debian.org/tripwire/twadmin.8.en.html
- https://manpages.debian.org/tripwire/twprint.8.en.html
- https://manpages.debian.org/tripwire/twpolicy.4.en.html

##### File Integrity Monitoring Concepts
- NIST SP 800-53 – Security and Privacy Controls for Information Systems <br>
https://csrc.nist.gov/publications/detail/sp/800-53/rev-5/final
- CIS Critical Security Controls – Integrity Monitoring <br>
https://www.cisecurity.org/controls

##### Debian System Administration Resources
- Debian Administrator's Handbook <br>
https://debian-handbook.info/
- Debian Package Management documentation <br>
https://www.debian.org/doc/manuals/debian-reference/
