### Authentication Methods

---

Authentication can be performed using different methods. As security requirements increase, relying on just one method is usually not enough.
So, systems often use multiple authentication factors together.<br>

Authentication methods generally rely on one or more of the following:
- Something the user knows (e.g., a password or PIN)
- Something the user has (e.g., a device or a security token)
- Something the user is (e.g., biometric data like a fingerprint)

### 1. Single-Factor Authentication (SFA)
This method uses only one element, usually a password or PIN.

**Example scenario:**<br>
A user logs in with a username + password.

**Disadvantages:**<br>
Weak passwords can be guessed.
If someone steals or guesses the password, they can access the system easily.

### 2. Multi-Factor Authentication (MFA)
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

### 3. Biometric Authentication
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

### 4. Password-Based Authentication

This is the most common and traditional authentication method.

**Security Factors That Matter:**
- Password complexity (use of uppercase/lowercase letters, numbers, symbols)
- Password change frequency
- Use of secure hashing algorithms (e.g., SHA-256, bcrypt)

**Disadvantages:**
- Vulnerable to brute-force and dictionary attacks
- Password reuse and sharing increase security risks
