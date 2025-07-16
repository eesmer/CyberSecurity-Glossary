# Security Policies
> This document explains the core security policies that should be implemented in organizations within the scope of information security, along with practical defense strategies.

---

## Definition
Security policies are the principles, rules, and procedures defined by an organization to protect its information systems.
The goal is to ensure that systems are designed and managed in accordance with the principles of confidentiality, integrity, and availability (CIA), and that users operate within these defined rules.

---

## Core Security Policies

> ## 1. Least Privilege Principle
Users must be granted **only the minimum permissions necessary** to perform their job functions.
Excessive privileges can lead to unauthorized data access, system errors, and malicious activity - all of which expand the potential attack surface.
An environment with unused or overly broad permissions increases the need for oversight and introduces unnecessary risks.
To implement this policy effectively, the following practices should be applied during environment setup and configuration:

- ### **Permission Audits**

All user accounts should be reviewed regularly along with the permissions they hold in the system.  
If a user's job role has changed, any previously granted privileges must be revoked.  
The following basic queries can be used to retrieve permission information for user accounts in commonly used Active Directory environments.

> ###### PowerShell command to list the groups a user is a member of (Active Directory):
```powershell
Get-ADUser -Identity "username" -Properties MemberOf | Select-Object -ExpandProperty MemberOf
```

> ###### Bash commands to check local user permissions on Linux systems:
- ###### List user’s groups
```bash
id username
```

- ###### Check for user-specific entries in /etc/sudoers
```bash
grep -E "^username|^%.*" /etc/sudoers
```

- ###### Check if user is in the sudo group
```bash
groups username | grep sudo
```

These audits form a basic approach for controlling access in environments that use either DAC (Discretionary Access Control) or RBAC (Role-Based Access Control) through user or group-level authorizations.

> ## 2. Access Management Policy
Regulating access to an organization’s systems and resources is one of the core components of information security.  
Mechanisms such as authentication, authorization, user lifecycle management, and multi-factor authentication (MFA) fall under the scope of this policy.

- ### Objectives of the Access Management Policy
  - Define authentication and authorization processes  
  - Use of groups, roles, password policies, and multi-factor authentication (MFA)  
  - Perform regular reviews of user accounts  

- ### Authentication and Authorization
  - Strong authentication mechanisms should be enforced when users access the system.  
  - **Password Policy:** Minimum length, complexity, and mandatory periodic changes should be applied.  
  - **Use of MFA:** Should be mandatory, especially for administrator accounts and remote access scenarios.

**Configuration Examples for Linux Systems**

- ###### Password Policy Settings - /etc/login.defs
```bash
PASS_MAX_DAYS   90    # Password must be changed every 90 days
PASS_MIN_DAYS   1     # Password can be changed again after at least 1 day
PASS_MIN_LEN    12    # Minimum password length
PASS_WARN_AGE   7     # Warn the user 7 days before password expiration
```
This configuration file sets default password policies for accounts created with commands like useradd.<br>
The parameters above define the default behavior applied to new users.<br>

- ###### Password Complexity - /etc/security/pwquality.conf (pam_pwquality.so)
```bash
minlen = 12             # Minimum password length
dcredit = -1            # Require at least 1 digit
ucredit = -1            # Require at least 1 uppercase letter
lcredit = -1            # Require at least 1 lowercase letter
ocredit = -1            # Require at least 1 special character
retry = 3               # Allow 3 attempts before aborting
```

This module should be integrated as follows:<br>
- On Debian-based systems: /etc/pam.d/common-password
- On RHEL-based systems: /etc/pam.d/system-auth

```bash
password requisite pam_pwquality.so retry=3
```

- ###### Failed Login Attempt Limiting – /etc/security/faillock.conf
```bash
deny = 5                # Lock after 5 failed login attempts
unlock_time = 600       # Automatically unlock after 10 minutes
fail_interval = 900     # 5 failed attempts within 15 minutes triggers lock
```

After configuring faillock.conf, the pam_faillock.so module must be added to /etc/pam.d/common-auth as follows<br>
```bash
auth required pam_faillock.so preauth silent audit
auth [default=die] pam_faillock.so authfail audit
```
To activate and test the configuration<br>
```bash
faillock --user username
```
When run with --user, the faillock command applies the lock mechanism to the specified user based on the settings defined in faillock.conf.
This enforces account lockout after multiple failed login attempts.

- ###### Enabling faillock for All Local User Accounts
```bash
#!/bin/bash

echo "Faillock Check..."

for user in $(awk -F: '$3 >= 1000 && $3 < 65534 {print $1}' /etc/passwd); do
    faillock --user "$user" | grep -q "no access" && \
        echo "[$user] : No failed login attempts yet (being monitored)" || \
        echo "[$user] : Restrictions applied or past attempts detected"
done
```

The script above works for all local user accounts if the faillock PAM module is enabled and the faillock.conf file is properly configured.
It ensures that faillock monitoring and account lockout settings are active for every local user on the system.

- ###### Listing Locked User Accounts
```bash
#!/bin/bash

echo "Faillock Check..."
faillock --reset --dry-run 2>/dev/null | grep -B1 'currently locked' | grep '^user'
```
The script above lists user accounts for which the faillock mechanism is currently active. It shows accounts that are currently locked due to failed login attempts.

> ## 3. Update Policy and Patch Management
Timely application of updates plays a critical role in ensuring the security of systems and applications.<br>
Outdated systems are vulnerable to known exploits and may become easy targets in real-world attack scenarios.<br>
Neglecting to keep software and operating systems up to date is a significant security oversight.<br>
Therefore, update processes should be planned and executed on a defined schedule and within regular maintenance windows.<br>

- ### Objectives of the Update Policy
  - Regular updates for the operating system, applications, and services  
  - Timely application of critical security patches  
  - Monitoring of systems that do not support automatic updates  
  - Activation of temporary protection mechanisms (virtual patching) for systems where the patching process cannot be completed

- ###### PowerShell Query for Patch Status on Windows
```powershell
# Lists updates installed within the last 30 days
Get-HotFix | Where-Object {$_.InstalledOn -gt (Get-Date).AddDays(-30)} |
Select-Object Description, InstalledOn
```
The script above provides a basic example for manual inspection on a local machine. In enterprise environments, centralized patch management should be implemented using tools such as WSUS or SCCM.

- ###### Update Checks on Linux Systems
For Debian-based distributions<br>
```bash
apt list --upgradable
```

For RHEL-based distributions<br>
```bash
yum check-update
```
System updates can be checked using the commands above.  
To ensure sustainability, these checks should ideally be performed **centrally or remotely**.
Updates applied through package managers (such as `apt`, `yum`, or `dnf`) have a **direct impact on both system security and stability**.  
In critical systems, **controlled and manual updates** are often preferred over fully automated updates.

- ### Virtual Patching
In some cases, system updates cannot be applied immediately.  
This is especially true in Linux server environments, where the diversity of distributions and applications makes it difficult to implement a practical and consistent update strategy.  
While OS-level updates in Windows environments tend to be more unified, updates for services or applications running on top of the OS must still be planned separately.  
This often prevents end-to-end updates from being applied.

In practice:
- The **OS** might be patchable, but the **application** may not yet be supported by the vendor.
- The **application** might be ready for patching, but it could be incompatible with a newer OS version.

A successful patching process requires that both OS and application layers align in terms of version compatibility and release schedules.  
However, this alignment depends not only on vendors, but also on the organization’s own software development and system management practices.  
Application patching is often tied to development cycles, making synchronized updates across OS, application, and patching layers unrealistic.

As a result:
- Regulatory compliance suffers  
- Vulnerabilities remain unpatched  
- Exposure to security threats increases

In such cases, **alternative models or architectural changes** should be implemented. Examples include:

- Placing a firewall (WAF or IPS) in front of the unpatched system  
- Defining strict software firewall rules and access control  
- Moving the system into a DMZ to enforce network isolation  
- Closing all unused ports completely  
- Analyzing all possible threats against the service still exposed via open ports

In some cases, system updates cannot be applied immediately.  
In Linux server environments, both distribution diversity and application heterogeneity often prevent the development of a unified and practical update strategy.

Similarly, while Windows systems do not suffer from distribution fragmentation, they still present a different challenge:  
**Operating system updates and application/service updates are managed separately**.  
This separation creates difficulties when trying to apply full-stack updates.

In order to perform a comprehensive and synchronized patching process:
- OS-level and application-level updates must align in terms of **vendor support**  
- Published patches must be compatible in both **version** and **release timeline**

Unfortunately, this alignment depends not only on the vendor’s roadmap, but also on the organization’s internal **software development and maintenance discipline**.  
Application patches, in particular, are often tied to development cycles and are therefore delayed or decoupled from OS-level updates.

This disconnect becomes one of the **biggest obstacles** in meeting security requirements and complying with industry regulations.  
A structured and disciplined update lifecycle is essential — including planning, testing, deployment, and fallback strategies.

However, if any of these factors cannot be satisfied in practice, the environment must be protected using **compensating controls or architectural alternatives**.

Examples include:
- Placing a firewall (WAF, IPS) in front of the system that cannot be updated  
- Applying local software firewall rules and strict access restrictions  
- Isolating the system into a DMZ environment  
- Closing all ports except those strictly required for service delivery  
- Thoroughly analyzing every possible exposure on the remaining open service port

**Note:**  
In exceptional situations, administrative control and workaround strategies may be necessary. For example:

- Some packages may need to be **frozen** due to compatibility risks  
- This can prevent a **critical service** from being updated automatically without vendor approval or proper testing

On Linux systems, the following command can be used:
```bash
apt-mark hold package-name
```

The apt-mark hold command locks the specified package, preventing it from being updated.<br>
<br>

**Example:** apt-mark hold nginx<br>

This action blocks uncontrolled updates but it does not resolve the underlying vulnerability.<br>
In such cases, external protection mechanisms such as WAF, IPS, or strict port filtering should be applied until the package can be safely updated. The hold command is not a security mechanism on its own, but it can serve as an administrative control technique when immediate patching is not feasible.<br>

> ## 4. Vulnerability and Risk Management

Risk management is the process of **identifying, measuring, and addressing** the threats and vulnerabilities that may affect an organization's information systems.  
This process is not limited to technical scanning results — it also includes aspects such as **business continuity, regulatory compliance, and resource allocation**.

- ### Objectives of the Risk Management Policy
  - Vulnerability Identification  
    - Automated Scans  
    - Manual Assessments  
  - Risk Analysis  
  - Risk Prioritization  
  - Risk Response Strategies

- ###### Vulnerability Identification
Organizations should perform both **automated and manual vulnerability scans** at the system and application levels.

- ###### Automated Scans
  - Open-source tools: OpenVAS, Nikto, Nmap  
  - Commercial tools: Nessus, Qualys, Nexpose

- ###### Manual Scans
  - Configuration reviews  
  - Port and service validation  
  - Custom security testing scenarios

Automated scan results should be validated through manual verification in order to identify true findings and manage the false positive rate effectively.

- ###### Risk Analysis

For each identified vulnerability, the following factors should be assessed:

- **Impact**: What is the potential damage? (e.g., data loss, unauthorized access, service disruption)  
- **Likelihood**: How likely is it that this vulnerability will be exploited?  
- **Asset Value**: Which system is affected? How critical is it?

Based on these three factors, the risk level can be calculated
```
Risk = Asset Value × Impact × Likelihood
```
These values are typically classified by organizations using either numerical scores or qualitative levels (e.g., low / medium / high).  
Various tools and applications are available to assist in determining these values during the risk assessment process.  
To ensure realistic and accurate results, tool-assisted findings should be evaluated carefully, and appropriate response scenarios should be defined accordingly.

- ###### Risk Prioritization

Not all risks can be addressed at the same time.  
Therefore, risks identified through analysis should be **classified and scheduled according to their importance**.

For example:
- High-risk issues on critical systems -> Priority resolution  
- Low-impact but widespread issues -> Batch remediation  
- Risks on isolated/internal systems -> Monitor and address in due time  

- ###### Risk Response Strategies

One or more of the following strategies can be applied for each risk:

- **Mitigate**<br>
Apply patches, restrict access, use firewalls, implement segmentation.
- **Accept**<br>
Accept the risk if the business impact is tolerable and the mitigation is too costly or complex.
- **Transfer**<br>
Transfer the risk through insurance, outsourcing, or shifting responsibility to a vendor.
- **Avoid**<br>
Eliminate the risk entirely by discontinuing the risky service or system.

The chosen response strategy should be part of a structured implementation plan.

## Example Scenario and Action Plan

Suppose a legacy application server in the organization is found to have a high-risk PHP vulnerability:

- The application cannot be updated because third-party vendor support has ended  
- The system is not publicly exposed, but it is accessible from within the internal network

Based on this context, a risk assessment is conducted.

Following the assessment, the response plan might include:

- **Mitigation**<br>
Restrict access to the server to specific internal IP addresses  
- **Acceptance**<br>
Temporarily accept the vulnerability as-is  
- **Transfer**<br>
Plan to migrate the application to a SaaS model in the future, shifting responsibility to the service provider

## Example Basic Commands

- ###### Start a scan with OpenVAS
```bash
gvm-cli --gmp-username admin --gmp-password pass socket --xml "<create_target><name>ServerA</name><hosts>192.168.1.10</hosts></create_target>"
```

- ###### Quick port scan with Nmap
```bash
nmap -T4 -F 192.168.1.10
```

> ## 5. Logging and Monitoring Policy

**Logging** is the process of recording events, user activities, service behavior, and security states within systems each with a timestamp.
**Monitoring** refers to the real-time or scheduled analysis of these logs, system behaviors, and security indicators.

Together, these two pillars form the foundation for processes such as **attack detection, anomaly analysis, user activity tracking, and incident response**

- ### Objectives of the Logging and Monitoring Policy
  - **Early detection of abnormal behavior** in systems and applications  
  - Making user activity **observable** and **auditable**  
  - Supporting **forensic investigation and evidence collection** in case of security incidents  
  - Meeting legal and regulatory requirements (e.g., KVKK, ISO 27001, GDPR)

- ###### What Logs Should Be Collected?
  - **Authentication logs**: Successful and failed login attempts (SSH, RDP, MFA)  
  - **Privilege escalation**: Commands like `sudo`, `runas`, `su`  
  - **Service events**: Web server access errors, database errors  
  - **Network events**: Firewall logs, connection attempts  
  - **File system access**: Access to or changes in critical directories  
  - **Software installation/removal activities**
