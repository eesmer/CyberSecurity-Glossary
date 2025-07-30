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
Sistem kaynaklarına erişim izinleri; rol ataması, izinler (permissions) ve Erişim Kontrol Listeleri (ACL – Access Control List) gibi yöntemlerle sağlanır.<br>
Yetkilendirme işlemi, kimlik doğrulaması başarılı olduktan sonra devreye girer.<br>
Kimliğin tanımlanması ve doğrulanması bu sürecin temelidir. Ancak yetkilendirme doğrudan sistem yönetimi, konfigürasyon ve erişim kontrol politikalarıyla da ilişkilidir.<br>
Bu sebeple;<br>
- Yetkilendirme süreçleri hata yapmaya daha açıktır.
- Karmaşık sistemlerde sürekli bakım ve denetim gerektirir.
- Politikalara uygun şekilde yapılandırılmadığında, güvenlik açıkları doğar.

Yetkilendirme, sistemler üzerinde sıkı şekilde kontrol edilmeli ve kurumsal erişim politikaları ile uyumlu bir şekilde yürütülmelidir. Özellikle büyük ölçekteki ortamlarda (örneğin AD/RBAC kullanılan yapılar) otomatikleştirilmiş erişim denetimleri ve periyodik yetki gözden geçirmeleri kritik önemdedir.<br>

**Örnek temel senaryo** <br>
Kullanıcı, kimliği doğrulanmış olarak sisteme dahil olur veya bağlanır.<br>
Sistemde "admin" rolüne sahipse, sistem ayarlarını değiştirebilir. "read-only" yetkisi varsa yalnızca görüntüleyebilir.



