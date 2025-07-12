# Erişim Kontrolü
> Bu belge, bilgi güvenliği kapsamında erişim kontrolü kavramını ve kullanılan yöntemleri açıklar.

---

## Tanım

Erişim kontrolü; bilgi sistemlerine, kaynaklara ve verilere **kimin, ne zaman, nasıl ve ne düzeyde erişebileceğini** belirleyen kurallar ve mekanizmalar bütünüdür.
Temel amacı, yalnızca yetkili kullanıcıların tanımlı kaynaklara erişimini sağlamak ve yetkisiz erişimi önlemektir.

Erişim kontrolü bilgi güvenliğinin **gizlilik** ilkesini doğrudan destekler.
Ancak aynı zamanda sistem kaynaklarının verimli kullanımı, izleme ve hesap verebilirlik açısından da kritik öneme sahiptir.

---

## Erişim Kontrol Türleri
Farklı organizasyonel yapılar ve ihtiyaçlara göre aşağıdaki erişim kontrol modelleri yaygın olarak kullanılır.

### DAC (Discretionary Access Control)
Kullanıcı tabanlı bir modeldir. *Kaynağın sahibi, kimlerin erişebileceğine kendisi karar verir.*<br>
Esnektir ama merkezi yönetim zayıftır. Genelde küçük/orta ölçekli sistemlerde görülür.<br>

**Örnek 1 – Windows File Server veya SMB Paylaşımı:**
- Bir kullanıcı, kendi klasöründe Paylasim adında bir klasör oluşturur.
- Sağ tıklama yapıp “Sharing” → “Permissions” sekmesinden kimin erişebileceğini belirler.
Yani dosya sahibi erişim yetkisini belirliyor. Bu, DAC erişim kontrol türüdür.

**Örnek 2 – Linux sistemde chmod:**
- Kullanıcı, kendi home dizinindeki dosyaya chmod 700 ile yetkilendirme verir.
- Böylece sadece dosya sahibi okuma/yazma/çalıştırma iznine sahip olur.
Yani yetkiyi belirleyen kullanıcının kendisidir. Bu, DAC erişim kontrol türüdür.

Bu örneklerden de anlaşılacağı üzere sistemdeki kaynağa erişim yetkisi olan hesaplar, yetkilendirildikleri alanda (FileServer paylaşımı veya Linux sistemdeki kendi home dizin) yeni dizin ve dosyalar oluşturup veya mevcut dizin veya dosyalara başka hesaplar için yetkilendirmeler yaparlar.<br>
Bu metod, küçük organizasyonlar için uygulanmalıdır. Erişim yapılandırmaları, merkezi olarak yönetilmediğinden yetkilendirme ayarlarının kontrolü ve denetimi periyodik olarak yapılmalıdır.<br>

### MAC (Mandatory Access Control)
MAC modeli, erişim haklarının sistem veya politika tarafından merkezi olarak belirlendiği, kullanıcının inisiyatifinin olmadığı bir erişim kontrol yöntemidir.<br>
Kullanıcının yetkisi olsa bile tanımlanmış sınıflandırmalara (etiket, seviye, kategori) uymuyorsa erişim engellenir.<br>
Bu model, özellikle **gizlilik seviyesi yüksek ortamlarda** örneğin askerî sistemler, kamu kurumları ve kritik altyapılar gibi alanlarda tercih edilir.<br>

**Örnek - SELinux (Security-Enhanced Linux)**
SELinux, Linux çekirdeğine entegre edilmiş bir MAC uygulamasıdır. (RHEL tabanlı sistemlerde bulunur.)
Her süreç (process) ve her dosya bir **etiket (label)** ile tanımlanır. Erişimler bu etiketlere göre sağlanır.<br>

