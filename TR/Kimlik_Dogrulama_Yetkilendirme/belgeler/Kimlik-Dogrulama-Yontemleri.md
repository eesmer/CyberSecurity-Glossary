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
