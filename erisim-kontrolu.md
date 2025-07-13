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

#### # Örnek - Windows File Server veya SMB Paylaşımı
- Bir kullanıcı, kendi klasöründe Paylasim adında bir klasör oluşturur.
- Sağ tıklama yapıp “Sharing” → “Permissions” sekmesinden kimin erişebileceğini belirler.
Yani dosya sahibi erişim yetkisini belirliyor. Bu, DAC erişim kontrol türüdür.

#### # Örnek - Linux sistemde chmod
- Kullanıcı, kendi home dizinindeki dosyaya chmod 700 ile yetkilendirme verir.
- Böylece sadece dosya sahibi okuma/yazma/çalıştırma iznine sahip olur.
Yani yetkiyi belirleyen kullanıcının kendisidir. Bu, DAC erişim kontrol türüdür.

Bu örneklerden de anlaşılacağı üzere sistemdeki kaynağa erişim yetkisi olan hesaplar, yetkilendirildikleri alanda (FileServer paylaşımı veya Linux sistemdeki kendi home dizin) yeni dizin ve dosyalar oluşturup veya mevcut dizin veya dosyalara başka hesaplar için yetkilendirmeler yaparlar.<br>
Bu metod, küçük organizasyonlar için uygulanmalıdır. Erişim yapılandırmaları, merkezi olarak yönetilmediğinden yetkilendirme ayarlarının kontrolü ve denetimi periyodik olarak yapılmalıdır.<br>

### MAC (Mandatory Access Control)
MAC modeli, erişim haklarının sistem veya politika tarafından merkezi olarak belirlendiği, kullanıcının inisiyatifinin olmadığı bir erişim kontrol yöntemidir.<br>
Kullanıcının yetkisi olsa bile tanımlanmış sınıflandırmalara (etiket, seviye, kategori) uymuyorsa erişim engellenir.<br>
Bu model, özellikle **gizlilik seviyesi yüksek ortamlarda** örneğin askerî sistemler, kamu kurumları ve kritik altyapılar gibi alanlarda tercih edilir.<br>

#### # Örnek - SELinux (Security-Enhanced Linux)
SELinux, Linux çekirdeğine entegre edilmiş bir MAC uygulamasıdır. <br>
(RHEL tabanlı sistemlerde bulunur.) <br>
Her **süreç (process)** ve her dosya bir **etiket (label)** ile tanımlanır. Erişimler bu etiketlere göre sağlanır.<br>

**SELinux Yapılandırma** <br>
- system_u -> Kullanıcı Kimliği <br>
- object_r -> Type <br>
- s0 -> Güvenlik Seviyesi / Security Level <br>

```bash
system_u:object_r:httpd_sys_content_t:s0
```
- Kurallar */etc/selinux/targeted/contexts/* ve **semanage fcontext** ile tanımlanır. <br>
*/var/www/html* dizinine sadece *httpd_t* tipinde çalışan **Apache** servisinin erişmesine izin verilir.

```
ls -Z /var/www/html
getenforce  # Enforcing / Permissive / Disabled
```

#### # Örnek - AppArmor
AppArmor, Ubuntu ve Debian tabanlı sistemlerde yaygın olarak kullanılan bir diğer MAC uygulamasıdır.<br>
Profil tabanlı çalışır ve her uygulama için bir profil yapılandırması sağlar.<br>
<br>
**AppArmor Yapılandırma**<br>
- /etc/apparmor.d/ altında profiller bulunur
- Örneğin /usr/sbin/cupsd yazıcısı için AppArmor profilinde yalnızca belirli dosyalara erişim tanımlanabilir.

<br>

#### # Örnek - Active Directory + Classification (Windows Information Protection)
Active Directory ortamlarında, özellikle Windows Information Protection (WIP) ve Microsoft Purview (eski adıyla AIP) kullanılarak MAC benzeri bir kontrol sağlanabilir.<br>
- Bir Word belgesi, "Finance – Confidential" etiketi ile sınıflandırılır.
- Yalnızca “Finance” güvenlik grubunda yer alan kullanıcılar bu belgeyi açabilir.
- Grup dışında yer alan kişiler, belgeyi açsa bile içeriği göremez (gizlilik koruması).
- Erişim kuralları etikete göre merkezi olarak tanımlanır, kullanıcılar değiştiremez.
