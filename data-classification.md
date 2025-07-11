# Data Classification
> This document explains the processes and levels of data classification within the context of information security.<br>

---

### Definition
Data classification is the method of analyzing an organization's information assets and separating them based on risk levels and appropriate protection needs.<br>
It helps determine:
- the sensitivity of the data,
- legal obligations,
- value of the information,
- and associated risks

The goal is to apply suitable protection measures to every type of data.<br><br>
Data classification is not only a technical task. It also forms the **foundation of organizational security policies**.<br>

Through data classification, an organization determines:<br>
- **Who can access which data**
- **How and where it should be stored**
- **What kind of protection methods must apply**

These factors affect access, storage, transmission, and disposal procedures.

### Efficient Use of Resources and Operational Sustainability
In large organizations where the volume of data is high, applying the same level of security to all data is not feasible.<br>
That’s why classification is critical for **efficient use of resources**.<br>

Some data is used only within internal operations, while some can be shared with third parties or publicly.<br>
If classification is done incorrectly, overprotecting some data may create unnecessary operational overhead.
Likewise, under-protection of sensitive data may lead to serious security breaches and indicate poor risk/resource alignment.<br>
Therefore, classification must be **realistic and feasible**, aligned with both technical and administrative capabilities.<br>
When done poorly, it’s often perceived not as an organizational strategy but as an IT burden.

### Classification Levels
Common classification levels include:
- **Critical / Top Secret:** Exposure would cause major damage. (e.g., military plans, encryption keys)
- **Confidential:** Only specific personnel can access. (e.g., employee records, customer data)
- **Internal Use Only:** Not intended for external sharing, but not highly sensitive.
- **Public:** Open to everyone. (e.g., public announcements, published schedules)

Factors that affect classification:
- Who created the data?
- What kind of content does it have?
- Who might be harmed if leaked?
- Legal obligations (KVKK, GDPR, sectoral regulations)
- Potential impact if breached

### Example Scenario
A government agency classifies employees' national ID numbers as **Confidential**.<br>
Only authorized system users should be able to access this information.<br>
On the other hand, its training schedule is **Public** and can be shared via the institution’s website.<br>
This distinction determines the rules for storage, access, and disposal.

### Related Pages
- [Information Security](giris.md)
- [Confidentiality Principle](cia-triad.md#Confidentiality)
- [Access Control](../04-authentication/access-control.md)
