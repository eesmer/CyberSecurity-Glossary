### Authentication Methods

---

Authentication can be performed using different methods. As security requirements increase, relying on just one method is usually not enough.
So, systems often use multiple authentication factors together.<br>

Authentication methods generally rely on one or more of the following:
- Something the user knows (e.g., a password or PIN)
- Something the user has (e.g., a device or a security token)
- Something the user is (e.g., biometric data like a fingerprint)

> ## 1. Single-Factor Authentication (SFA)
This method uses only one element, usually a password or PIN.

**Example scenario:**<br>
A user logs in with a username + password.

**Disadvantages:**<br>
Weak passwords can be guessed.
If someone steals or guesses the password, they can access the system easily.

> ## 2. Multi-Factor Authentication (MFA)
This method combines two or more authentication factors from different categories.

**Typical factor types:**
- Something you know: Password or PIN
- Something you have: Phone, hardware token, smart card
- Something you are: Biometric data (fingerprint, face, retina scan)

**Example scenario:**<br>
The user enters their username and password
Then, they enter a code sent to their phone or use an authenticator app

**Advantages:**<br>
Even if the password is stolen, other factors help keep the system secure.
Adds an extra layer of protection.

> ## 3. Biometric Authentication
Biometric authentication uses a person’s unique physical or behavioral traits to verify their identity.

Common Biometric Methods:
- Fingerprint recognition
- Facial recognition
- Retina/Iris scanning
- Voice recognition
- Behavioral patterns (e.g., typing rhythm, mouse movement)

**Advantages:**
- Cannot be forgotten or lost
- Tied directly to the individual’s identity

**Disadvantages:**
- May produce false positives or false negatives
- Raises privacy concerns
If stolen, biometric data cannot be changed like passwords

> ## 4. Password-Based Authentication

This is the most common and traditional authentication method.

**Security Factors That Matter:**
- Password complexity (use of uppercase/lowercase letters, numbers, symbols)
- Password change frequency
- Use of secure hashing algorithms (e.g., SHA-256, bcrypt)

**Disadvantages:**
- Vulnerable to brute-force and dictionary attacks
- Password reuse and sharing increase security risks

> ## 5. Hardware-Based Authentication
This method relies on using a physical device (like a token or smart card) for authentication.

Examples include:
- RSA SecurID tokens
- Smart cards
- USB-based FIDO2 devices (e.g., YubiKey)

**Advantages:**
- Harder to steal because physical access is required
- Helps reduce identity fraud

**Disadvantages:**
- Risk of device loss or theft
- Additional cost and complexity for management

> ## 6. Time-Based Authentication (OTP / TOTP / HOTP)

This method generates a one-time password (OTP) based on either time or a counter.<br>
It is commonly used with mobile apps like Google Authenticator or FreeOTP.<br>

- **HOTP (HMAC-based One-Time Password):** Counter-based
- **TOTP (Time-based One-Time Password):** Time-based

**Example:**<br>
A 6-digit code that changes every 30 seconds

> ## 7. Social / Easy Login (Social Login / Federated Identity)

This method allows users to log in using external identity providers such as Google, Facebook, or GitHub.<br>
It is often part of SSO (Single Sign-On) or identity federation systems.<br>

**Advantages:**
- User-friendly experience
- Easy integration with existing accounts

**Disadvantages:**
- Requires full trust in the identity provider
- If the main account is compromised, all linked services can be affected

#### Methods and Evaluations

- ##### Password
Easy to use and requires no additional components. However, it has low suitability for modern security requirements.

- ##### Biometric Authentication
High usability and strong alignment with modern security requirements. However, it requires supporting infrastructure and compatible hardware.

- ##### Token / Smart Card
Usability may be considered low due to the requirement for a physical device and supporting hardware. However, from a security compliance perspective, it provides strong assurance.

- ##### MFA (Multi-Factor Authentication)
Currently the preferred method for most access scenarios. Usability is moderate because it adds at least one additional verification layer. It requires access to an application, hardware token, or similar device to complete authentication.

- ##### TOTP (Time-Based One-Time Password)
Used via mobile applications and aligns well with modern security requirements.

> ## Passwordless Authentication

Passwordless authentication is an authentication approach where users access systems without using traditional passwords.
In this model, verification is typically performed through:
- Cryptographic key pairs
- Hardware-based security keys
- Biometric verification
- Push notification approvals

The primary goal is to eliminate risks associated with passwords.

##### Why Passwordless?
Passwords are:
- Predictable
- Reusable
- Vulnerable to phishing attacks
- Susceptible to mass compromise during data breaches

Passwordless architectures aim to reduce these risks.

