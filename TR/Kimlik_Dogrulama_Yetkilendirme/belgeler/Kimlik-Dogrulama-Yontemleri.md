## Kimlik Doğrulama Yöntemleri

---

Kimlik doğrulama, farklı yöntemlerle yapılabilir.<br>
Güvenlik seviyesi arttıkça tek bir yöntem yerine çoklu doğrulama yaklaşımları tercih edilmeye başlanmıştır.<br>
Kimlik doğrulama yöntemleri;<br>
Genel olarak kullanıcının *sahip olduğu bilgiye*, *sahip olduğu nesneye* veya *kimliğine özgü fiziksel özellikler*e dayanır.<br>
<br>
Kimlik doğrulama yöntemlerinin seçimi, sistemin güvenlik ihtiyaçları ve kullanım senaryosuna göre yapılmalıdır.<br>
Tek faktörlü yöntemler kolaylık sağlar ama güvenlik zaafı yaratabilir.<br>
Çok faktörlü kimlik doğrulama (MFA) ise bugün artık güvenlikte altın standart olarak kabul edilir.<br>
Kurumsal yapılarda hem güvenlik politikaları hem de kullanıcı deneyimi gözetilerek hibrit modeller tercih edilmelidir.<br>

> ## 1. Tek Faktörlü Kimlik Doğrulama (SFA – Single Factor Authentication)
Sadece tek bir unsur kullanılır. Genellikle bu unsur bir *şifre* veya *PIN* kodudur.<br>

**Örnek Senaryo**<br>
Kullanıcı Adı + Parola ile sisteme giriş yapmak.

**Dezavantajları:**
- Zayıf şifreler tahmin edilebilir.
- Tek bir varlığın tahmin edilmesi veya elde edilmesi (örneğin parola) suistimal için yeterlidir.

> ## 2. Çok Faktörlü Kimlik Doğrulama (MFA – Multi-Factor Authentication)
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

> ## 3. Biyometrik Kimlik Doğrulama
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

> ## 4. Parola (Password) Tabanlı Doğrulama
En yaygın ve klasik doğrulama yöntemidir.

**Güvenliği Etkileyen Unsurlar:**
- Parola karmaşıklığı (büyük/küçük harf, rakam, sembol)
- Parola yenileme sıklığı
- Hashleme algoritmaları (SHA-256, bcrypt)

**Zayıflıklar:**
- Brute force ve dictionary saldırılarına açıktır
- Parola tekrar kullanımı ve paylaşımı risktir

> ## 5. Donanım Tabanlı Doğrulama

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

> ## 6. Zaman Tabanlı Doğrulama (OTP / TOTP / HOTP)
Zamana ya da sayaca bağlı tek kullanımlık şifre (One-Time Password) üretir.<br>
Genellikle bir mobil uygulama (Google Authenticator, FreeOTP) kullanılır.

- **HOTP:** Sayaç tabanlı
- **TOTP:** Zaman tabanlı

**Örnek:**<br>
30 saniyede bir değişen 6 haneli kod üretimi

> ## 7. Sosyal/Kolay Kimlik Doğrulama (Social Login / Federated Identity)

Dış kimlik sağlayıcılarıyla (Google, Facebook, GitHub) giriş yapılmasını sağlar.<br>
SSO ve kimlik federasyonu kapsamında değerlendirilebilir.<br>

**Avantajları:**
- Kullanıcı dostu deneyim
- Hesap entegrasyonu kolaylığı

**Riskler:**
- Kimlik sağlayıcısına tam güven gerekir
- Hesap ele geçirilirse tüm sistemler etkilenir

**Yöntemler ve Değerlendirmeleri**<br>
- **Parola**<br> Kullanım kolaylığı yüksektir ve ek gereksinimleri yoktur. Fakat günümüz güvenlik gereksinimlerine uygunluğu düşüktür.<br>
- **MFA**<br> Günümüzde neredeyse tüm erişimlerde seçilen yöntemdir.<br>
  Kullanım kolaylığı erişim için en az bir katman daha eklediği için orta seviyededir. Çünkü parola veya token iletimi için erişim sağlanması gereken bir
  uygulama veya araç/donanım gerektirir.<br>
- **Biyometrik**<br> Kullanım kolaylığı ve günümüz güvenlik gereksinimlerine uygunluğu yüksektir. Fakat bir altyapı ve donanım gereksinimi vardır.<br>
- **Token/Kart**<br> Kullanım kolaylığı araç veya kart ve uygulanması için donanım gereksinimi sebebiyle düşük olarak değerlendirilebilir.
    Fakat güvenlik gereksinimlerini sağlama kriterine göre değerlendirmesi yüksektir.<br>
- **TOTP**<br> Mobil uygulama üzerinden kullanılır ve günümüz güvenlik gereksinimlerine uygundur.<br>

> ## 8. Şifresiz Kimlik Doğrulama (Passwordless Authentication)

Şifresiz kimlik doğrulama, kullanıcının sisteme erişim sağlamak için geleneksel parola kullanmadığı kimlik doğrulama yaklaşımıdır.
Bu modelde doğrulama genellikle;
- Kriptografik anahtar çiftleri
- Donanım tabanlı güvenlik anahtarları
- Biyometrik doğrulama
- Push bildirim onayları
üzerinden gerçekleştirilir.

Temel amaç; parolaların oluşturduğu riskleri ortadan kaldırmaktır.

**Neden Passwordless?**<br>
<br>
Parolalar;
- Tahmin edilebilir
- Tekrar kullanılabilir
- Phishing saldırılarına açıktır
- Veri sızıntılarında topluca ele geçirilebilir
- Passwordless mimariler bu riskleri azaltmayı hedefler

Passwordless sistemler genellikle asimetrik kriptografi kullanır;
- Kullanıcı cihazında bir özel anahtar (private key) oluşturulur.
- Açık anahtar (public key) sunucuya kaydedilir.
- Giriş sırasında sunucu bir challenge üretir.
- Cihaz, challenge’ı private key ile imzalar.
- Sunucu public key ile doğrular.
- Özel anahtar cihazdan çıkmaz.

**Kullanılan Teknolojiler**<br>
- **FIDO2**<br>
FIDO2, [FIDO Alliance](https://en.wikipedia.org/wiki/FIDO_Alliance) tarafından geliştirilen ve parola kullanımını ortadan kaldırmayı hedefleyen açık kimlik doğrulama standardıdır.<br>
FIDO2 iki ana bileşenden oluşur:
   - WebAuthn (tarayıcı tarafı API standardı)
   - CTAP2 (Client to Authenticator Protocol)

     Kimlik doğrulama sırasında sunucu, her oturum için kriptografik olarak güvenli ve tek kullanımlık bir rastgele veri (challenge/nonce) üretir.
     İstemci bu veriyi private key ile imzalar ve sunucu public key ile doğrular.
   - Private key Kullanıcının cihazında veya donanım anahtarında saklanır.
   - Public  key Sunucuya kayıt edilir.
     
     **Önemli özellikleri:**
   - Phishing’e karşı dirençlidir (origin binding sayesinde)
   - Replay saldırılarına karşı korumalıdır
   - Her servis için ayrı anahtar üretir (credential reuse yoktur)

- **WebAuthn (Web Authentication API)** <br>
WebAuthn, [W3C](https://en.wikipedia.org/wiki/World_Wide_Web_Consortium) tarafından standartlaştırılmış bir tarayıcı API’sidir ve FIDO2’nin web tarafındaki bileşenidir.<br>
Tarayıcı ile sunucu arasında kriptografik kimlik doğrulama sürecini yönetir.<br>
Teknik olarak;<br>
  - Tarayıcı, authenticator (platform veya roaming) ile iletişim kurar.
  - Public key credential oluşturma ve doğrulama işlemlerini yönetir.
  - Origin kontrolü yapar (example.com için üretilen credential başka domain’de çalışmaz).
  
  WebAuthn, REST veya klasik form-based login’den farklı olarak challenge-response modeline dayanır.

  **References**<br>
  - FIDO Alliance: https://en.wikipedia.org/wiki/FIDO_Alliance
  - W3C: https://en.wikipedia.org/wiki/World_Wide_Web_Consortium

> ## 9. Sertifika Tabanlı Kimlik Doğrulama (Certificate‑Based Authentication)
