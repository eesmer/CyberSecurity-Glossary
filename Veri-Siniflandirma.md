# Veri Sınıflandırma

### Tanım
Veri sınıflandırma; bir kurumun sahip olduğu bilgilerin;
- hassasiyet derecesine,
- yasal yükümlülüklerine,
- veri değerine,
- risk düzeyine<br>
<br>
göre kategorilere ayrılması çalışmasıdır.<br>
Amaç, tüm veri türlerinin korunması için uygun güvenlik önlemlerinin uygulanmasını sağlamaktır.<br>

Veri sınıflandırma yalnızca teknik bir süreç değildir. Aynı zamanda **organizasyonel güvenlik politikalarının temelini** oluşturan bir çalışmadır.<br>
Veri sınıflandırması ile;
- Hangi bilginin **kimlerle paylaşılabileceği**,
- Bilginin **nasıl saklanacağı** ve **kimler tarafından erişilebileceği**,
- Hangi verilerin **özel koruma yöntemlerine** tabi olacağı
belirlenir ve erişim, saklama, iletim ve imha süreçleri de bu sınıflara göre düzenlenir.

### Kaynakların Doğru Kullanımı ve Operasyonel Verimlilik
Özellikle büyük organizasyonlarda veri hacmi çok yüksek olduğundan, tüm veriye aynı seviyede güvenlik uygulanamaz.<br>
Bu nedenle sınıflandırma, **kaynakların doğru kullanımı** açısından da kritiktir.<br>

Bazı veri türleri, yalnızca şirket içi süreçlerde kullanılırken; bazıları üçüncü taraflarla veya kamuoyuyla paylaşılabilir.<br>
Yanlış sınıflandırma durumunda, verinin fazla korunması operasyonel yük yaratabilir ve sürdürülebilirlik için buna dikkat edilmelidir.
Ay şekilde verinin yetersiz korunması da ciddi güvenlik ihlallerine yol açabilir ve yine operasyonel verimliliği yönetememenin bir sonucu olarak karşımıza çıkabilir.
Buna göre; sınıflandırma çalışması gerçekçi, uygulanabilir olmalı ve kaynaklar bu sınıflandırmayı işletebilecek şekilde yapılandırılmalıdır.<br>
Özellikle bu noktada yapılan hatalar verilerin korunması veya uygun erişim politikalarının uygulanması konusunda hatalara yol açtığından bu çalışmalar, organizasyonel bir düzenleme yerine bir IT yükü olarak algınabilmektedir.

### Sınıflandırma Seviyeleri
Yaygın sınıflandırma seviyeleri şunlardır;
- **Kritik / Çok Gizli (Top Secret):** Açığa çıkması büyük zarar verir. Örn: Askerî planlar, şifre anahtarları.
- **Gizli (Confidential):** Sadece belirli personel erişebilir. Örn: Müşteri bilgileri, maaş verileri.
- **İç Kullanım (Internal Use Only):** Kurum dışına çıkmaması gereken, hassas olmayan veriler.
- **Genel (Public):** Herkesin erişimine açık. Örn: Web sitesindeki duyurular.

Sınıflandırma süreci, aşağıdaki faktörler göz önünde bulundurularak gerçekleştirilmelidir:
- Verinin kaynağı (kim oluşturdu?)
- İçeriği (ne tür bilgi?)
- Duyarlılığı (kime zarar verebilir?)
- Mevzuat yükümlülükleri (KVKK, GDPR, sektörel regülasyonlar)
- Beklenen zarar (veri sızarsa ne olur?)

Sınıflandırma işlemi; verinin kaynağı, içeriği, değeri, yasal gereksinimleri ve maruz kalabileceği tehditler göz önünde bulundurularak yapılmalıdır.

### Örnek Senaryo
Bir kamu kurumunda çalışanların T.C. Kimlik Numaraları, **Gizli** seviyede sınıflandırılmalıdır.<br>
Bu bilgiler yalnızca belirli sistem kullanıcıları tarafından erişilebilir olmalıdır.<br>
Aynı kurumun yayımladığı eğitim takvimi ise **Genel** düzeydedir ve web sitesinden herkese açıktır.<br>
Bu fark, bilgilerin saklanma, erişim ve imha kurallarını da belirler.

### İlgili Sayfalar
- [Bilgi Güvenliği](giris.md)
- [Gizlilik İlkesi](cia-ucgeni.md#Gizlilik-Confidentiality)
- [Erişim Kontrolü](../04-kimlik-dogrulama/erisim-kontrol.md)
