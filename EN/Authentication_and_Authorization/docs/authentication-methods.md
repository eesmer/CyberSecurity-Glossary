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

> ## 8. Passwordless Authentication

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

Passwordless systems generally use asymmetric cryptography:
- A private key is generated on the user’s device.
- The public key is registered on the server.
- During login, the server generates a challenge.
- The device signs the challenge using the private key.
- The server verifies the signature using the public key.
- The private key never leaves the device.

## Technologies Used
- ### FIDO2
FIDO2 is an open authentication standard developed by the [FIDO Alliance](https://en.wikipedia.org/wiki/FIDO_Alliance), designed to eliminate the need for passwords.

#### FIDO2 consists of two main components:
    - WebAuthn (browser-side API standard)
    - CTAP2 (Client to Authenticator Protocol)

#### Challenge / Nonce
    - During authentication, the server generates a cryptographically secure, one-time random value (challenge/nonce).
    - The client signs this value with the private key, and the server verifies it with the public key.
    - The private key is stored on the user’s device or hardware key.
    - The public key is registered on the server.
#### Key Features:
    - Resistant to phishing (due to origin binding)
    - Protected against replay attacks
    - Generates separate keys per service (no credential reuse)

- ### WebAuthn (Web Authentication API)
WebAuthn is a browser API standardized by W3C and represents the web component of FIDO2. It manages the cryptographic authentication process between the browser and the server.

#### Technically:
    - The browser communicates with an authenticator (platform or roaming).
    - It manages public key credential creation and verification.
    - It enforces origin validation (a credential generated for example.com cannot be used on another domain).
Unlike REST or traditional form-based login, WebAuthn is based on a challenge-response model.

- ### Passkeys
Passkeys are a modern authentication method based on FIDO2/WebAuthn and are supported by Apple, Google, and Microsoft.

    - Generates an asymmetric key pair.
    - The private key is stored in the device’s secure area (Secure Enclave / TPM).
    - The public key is stored on the service side.

#### What Makes Passkeys Different:
    - Simplifies user experience.
    - Allows access to the private key via biometrics or device lock instead of passwords.
    - Can be synchronized via iCloud Keychain or Google Password Manager.

**Note:** Passkeys are essentially passwordless FIDO2 credentials.

- ### YubiKey and Similar Hardware Security Keys
Devices such as YubiKey function as “roaming authenticators.”

    - Connect via USB / NFC / Lightning.
    - The private key never leaves the device.
    - Keys are generated and stored inside a secure element within the hardware.

#### Supported Protocols:
    - FIDO2 / WebAuthn
    - U2F
    - PIV (Smart Card)
    - OTP
    - OpenPGP
#### Advantages:
    - Device-based physical authentication
    - Strong phishing resistance
    - Key extraction is practically infeasible

- ### Windows Hello / Apple Face ID-Based Systems
These belong to the “platform authenticator” category, meaning the authenticator is directly integrated into the operating system.

    - Private key → stored inside TPM (Windows) or Secure Enclave (Apple).
    - User verification → performed via biometric sensor or device PIN.
    - Biometric data is never transmitted to the server.

#### Windows Hello
    - Generates TPM-based keys.
    - Integrates with Active Directory / Azure AD.
    - Works with Kerberos and FIDO2.
#### Apple Face ID / Touch ID
    - Generates keys inside Secure Enclave.
    - WebAuthn compatible.
    - Supports passkey synchronization via iCloud.

#### Comparison Table
| Technology              | Core Architecture       | Key Storage          | Phishing Resistance |
| ----------------------- | ----------------------- | -------------------- | ------------------- |
| FIDO2                   | Asymmetric cryptography | Device / Hardware    | High                |
| WebAuthn                | Browser API             | Device               | High                |
| Passkeys                | FIDO2 credential model  | Secure Enclave / TPM | High                |
| YubiKey                 | Hardware token          | Secure Element       | Very High           |
| Windows Hello / Face ID | Platform authenticator  | TPM / Secure Enclave | High                |

#### References
- FIDO Alliance: https://en.wikipedia.org/wiki/FIDO_Alliance
- W3C: https://en.wikipedia.org/wiki/World_Wide_Web_Consortium

> ## 9. Certificate-Based Authentication
Certificate-based authentication is a method where a user, device, or service proves its identity through a digital certificate.
This method is built upon a Public Key Infrastructure (PKI) architecture and uses asymmetric cryptography for verification.
Instead of a password, a private key and a corresponding X.509 digital certificate signed by a Certificate Authority (CA) are used.

#### Certificate-Based Authentication Relies On:
     - Private Key (stored on user/device side)
     - Public Key (contained within the certificate)
     - X.509 Certificate
     - Certificate Chain (trust chain)
     - Certificate Authority (CA)

#### Authentication Flow (Example: mTLS)
     - The client connects to the server.
     - The server requests a client certificate.
     - The client sends its certificate.
     The server:
      - Verifies whether the certificate is signed by a trusted CA.
      - Checks certificate validity dates.
      - Checks revocation status via CRL/OCSP.
     - The client proves possession of the private key through a cryptographic signature.
     - If validation succeeds, authentication is completed. 

