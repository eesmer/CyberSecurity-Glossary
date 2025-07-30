### 1. Kimlik (Identity)
Kimlik, bir kullanıcının, cihazın ya da sistemin kendisini tanıttığı ve diğerlerinden ayırt edilebildiği özellikler bütünüdür.<br>
**Örnek:** KullanıcıAdı, E-Posta Adresi, UUID, IP Adresi, MAC adresi, vb.<br>

Kimlik, bir varlığın benzersiz olarak tanınmasını sağlar.<br>
Kimlik, sadece beyana dayanır. Doğruluk, ancak kimlik doğrulama ile sağlanır. Yani kimlik bir tanımlamadır fakat kimlik doğrulama ile garanti edilir, kanıtlanır.<br>

### 2. Kimlik Doğrulama (Authentication)
Kimlik Doğrulama, bir kullanıcının iddia ettiği kimliğin gerçekten o kişiye ait olduğunu kanıtlama sürecidir.<br>
Kimlik doğrulama faktörleri olarak ifade edilen kavramları vardır;
- Bildiği birşey (Pin, şifre)
- Sahip olduğu birşey (akıllı kart, token, telefon)
- Olduğu birşey (parmak izi, yüzü)

**Örnek temel senaryo:**<br>
Kullanıcı USER1 kullanıcı adını girer.<br>
Sistem kendinde kayıtlı olan bir kimliği kabul eder.<br>
Kullanıcı, doğru şifreyi girerse "kimlik doğrulama" başarılı olur.<br>

### 3. Yetkilendirme (Authorization)
Yetkilendirme, doğrulanmış bir kimliğe sahip kullanıcının hangi kaynaklara, ne ölçüde erişebileceğinin yönetimidir.<br>
Sistem kaynaklarına erişim izni, rol ataması, izin (permission) ve ACL (Access Control List) gibi yöntemlerle yönetilir. Yetkilendirme işlemleri kimlik doğrulandıktan sonra gerçekleştirilir.<br>
<br>
Kimlik tanımının kaydı ve kimlik doğrulama mekanizmalarının desteği bu iki kavramın doğru şekilde yönetilmesi için yardımcıdır.<br>
Oysa; Yetkilendirme, sistem yönetimi ve yapılandırma ağırlıklı çalışmaların içinde olduğunda hata payı ve bakım gereksinimi çok yüksektir. Yetkilendirme, sistemler üzerinde sıkı şekilde kontrol edilmeli ve politika uygunluğu sağlanmalıdır.<br>

**Örnek temel senaryo** <br>
Kullanıcı, kimliği doğrulanmış olarak sisteme dahil olur veya bağlanır.<br>
Sistemde "admin" rolüne sahipse, sistem ayarlarını değiştirebilir. "read-only" yetkisi varsa yalnızca görüntüleyebilir.
