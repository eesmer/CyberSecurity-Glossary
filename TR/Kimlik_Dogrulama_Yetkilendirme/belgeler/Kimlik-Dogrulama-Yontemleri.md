## Kimlik Doğrulama Yöntemleri

---

Kimlik doğrulama, farklı yöntemlerle yapılabilir. Güvenlik seviyesi arttıkça tek bir yöntem yerine çoklu doğrulama yaklaşımları tercih edilmeye başlanmıştır.<br>
Kimlik doğrulama yöntemleri;<br>
Genel olarak kullanıcının *sahip olduğu bilgiye*, *sahip olduğu nesneye* veya *kimliğine özgü fiziksel özellikler*e dayanır.

### 1. Tek Faktörlü Kimlik Doğrulama (SFA – Single Factor Authentication)
Sadece tek bir unsur kullanılır. Genellikle bu unsur bir *şifre* veya *PIN* kodudur.<br>

**Örnek Senaryo**<br>
Kullanıcı Adı + Parola ile sisteme giriş yapmak.

**Dezavantajları:**
- Zayıf şifreler tahmin edilebilir.
- Tek bir varlığın tahmin edilmesi veya elde edilmesi (örneğin parola) suistimal için yeterlidir.

### 2. Çok Faktörlü Kimlik Doğrulama (MFA – Multi-Factor Authentication)
Genellikle 2 veya daha fazla faktör kombinasyonlarla gerçekleştirilir.<br>
Aşağıdaki farktörlerin kombinasyonları kullanılır<br>
- **Bildiği bir şey**: Şifre, PIN
- **Sahip olduğu bir şey**: Telefon, donanım token, akıllı kart
- **Olduğu bir şey**: Biyometrik veri (parmak izi, yüz, retina)

**Örnek Senaryo**<br>
1- Kullanıcı Adı + Şifre<br>
2- Telefon veya Mail ile gelen OTP (örneğin google authenticator kullanımı)

**Avantajları:**
Şifre ele geçirilse bile diğer faktörler güvenliği sağlar.<br>

### 3. Biyometrik Kimlik Doğrulama
Kişiye özgü fiziksel veya davranışsal özelliklerin kullanıldığı doğrulama yöntemidir.

**Yaygın Biyometrik Yöntemler:**
- Parmak izi
- Yüz tanıma
- Retina/iris taraması
- Ses tanıma
- Davranışsal (yazma ritmi, fare hareketi)

**Avantajları:**
- Unutulmaz, taşınmaz
- Kimliğe doğrudan bağlı

**Dezavantajları:**
- Hatalı pozitif/negatif oranı
- Gizlilik kaygıları
- Biyometrik verinin çalınması geri döndürülemez

### 4. Parola (Password) Tabanlı Doğrulama
En yaygın ve klasik doğrulama yöntemidir.

**Güvenliği Etkileyen Unsurlar:**
- Parola karmaşıklığı (büyük/küçük harf, rakam, sembol)
- Parola yenileme sıklığı
- Hashleme algoritmaları (SHA-256, bcrypt)

**Zayıflıklar:**
- Brute force ve dictionary saldırılarına açıktır
- Parola tekrar kullanımı ve paylaşımı risktir

### 5. Donanım Tabanlı Doğrulama

Fiziksel bir cihazın (token, kart) kullanılması esasına dayanır.

**Örneğin:**
- RSA SecurID Token
- Akıllı Kartlar (Smartcard)
- USB tabanlı FIDO2 cihazları (YubiKey)

**Avantajları:**
- Fiziksel erişim gerektiğinden çalınması zor
- Kimlik sahteciliğini azaltır

**Dezavantajları:**
- Cihaz kaybı riski
- Ek maliyet ve yönetim zorluğu
