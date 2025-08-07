## Kimlik Doğrulama Yöntemleri

---

Kimlik doğrulama, farklı yöntemlerle yapılabilir. Güvenlik seviyesi arttıkça tek bir yöntem yerine çoklu doğrulama yaklaşımları tercih edilmeye başlanmıştır.<br>
Kimlik doğrulama yöntemleri;<br>
Genel olarak kullanıcının *sahip olduğu bilgiye*, *sahip olduğu nesneye* veya *kimliğine özgü fiziksel özellikler*e dayanır.

### 1. Tek Faktörlü Kimlik Doğrulama (SFA – Single Factor Authentication)
Sadece tek bir unsur kullanılır. Genellikle bu unsur bir *şifre* veya *PIN* kodudur.<br>
**Örnek Senaryo**<br>
Kullanıcı Adı + Parola ile sisteme giriş yapmak.

**Dezavantajları**<br>
Zayıf şifreler tahmin edilebilir.<br>
Tek bir varlığın tahmin edilmesi veya elde edilmesi (örneğin parola) suistimal için yeterlidir.<br>

## 2. Çok Faktörlü Kimlik Doğrulama (MFA – Multi-Factor Authentication)
Genellikle 2 veya daha fazla faktör kombinasyonlarla gerçekleştirilir.<br>
Aşağıdaki farktörlerin kombinasyonları kullanılır<br>
- **Bildiği bir şey**: Şifre, PIN
- **Sahip olduğu bir şey**: Telefon, donanım token, akıllı kart
- **Olduğu bir şey**: Biyometrik veri (parmak izi, yüz, retina)
