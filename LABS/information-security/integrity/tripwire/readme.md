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
  
    This command;
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
  

### Tripwire Configuration
##### /etc/tripwire
- **$HOSTNAME-local.key and site.key** Keys used in policy/config and database operations
- **tw.cfg ve twcfg.txt** Plain text and active/signed configuration files
- **tw.pol** Policy file. This file is used for policy definition.
- **twpol.txt** Encoded active policy used by Tripwire

### Other Useful Commands
- Deletes reports older than 30 days <br>
  `find /var/lib/tripwire/report -type f -name "*.twr" -mtime +30 -delete`
- Tripwire reports can be filtered to focus only on modified files <br>
  `twprint --print-report --twrfile /var/lib/tripwire/report/$REPORT_NAME.twr | grep -E "Modified"`
- Prints the most recent report to the file <br>
`LATEST_REPORT="$(ls -1t /var/lib/tripwire/report/*.twr | head -n1)"` <br>
`twprint --print-report --twrfile "$LATEST_REPORT" > tripwire-report.txt`
