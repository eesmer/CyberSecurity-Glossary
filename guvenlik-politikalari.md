# Güvenlik Politikaları
> Bu belge, bilgi güvenliği kapsamında organizasyonlarda uygulanması gereken temel güvenlik politikalarını ve pratik savunma yöntemlerini açıklar.

---

## Tanım
Güvenlik politikaları, bilgi sistemlerinin korunması için kurum tarafından belirlenen ilkeler, kurallar ve prosedürlerdir.
Amaç; sistemin gizlilik, bütünlük ve erişilebilirlik (CIA) ilkelerine uygun şekilde yapılandırılmasını, yönetilmesini ve kullanıcıların da bu kurallar doğrultusunda hareket etmesini sağlamaktır.

---

## Temel Güvenlik Politikaları

> ## 1. En Az Ayrıcalık İlkesi (Least Privilege)
Kullanıcılara, işlerini yapabilmeleri için **yalnızca gerekli olan minimum yetkilerin verilmesi** esas alınır.<br>
Fazla yetki; yetkisiz veri erişimine, sistem hatalarına ve kötü niyetli eylemlere zemin hazırlar ve bu da saldırı uzayı kavramını genişletir.<br>
Ortam, kullanılmayan atanmış yetkilerden doğan kontrol gereksinimi ve riskleri altındadır.<br>
Bu politikayı pratik olarak uygulamak için her ortamın yapılandırmasında aşağıdakiler uygulanmalıdır.

- ### **Yetki Denetimi Yapılması**<br>

Tüm kullanıcı hesapları, sistemdeki yetkileriyle birlikte düzenli olarak incelenmelidir. Kullanıcının iş tanımı değiştiyse, önceki yetkileri kaldırılmalıdır.<br>
Aşağıdaki basit sorgular, yaygın olarak kullanılan Active Directory ortamındaki kullanıcı hesapları için yetki çıktıları verir.<br>
<br>
**Active Directory ortamında kullanıcı hesabının üye olduğu grupları gösteren powershell komutu**<br>
```powershell
Get-ADUser -Identity "kullaniciAdi" -Properties MemberOf | Select-Object -ExpandProperty MemberOf
```
<br>

**Linux makinelerde yerel kullanıcı hesaplarının yetkilerini gösteren bash komutları**<br>
- ###### **Kullanıcı Hesabının Grupları**<br>
```bash
id kullaniciadi
```

- ###### /etc/sudoers Dosyasında Kullanıcı Hesabına Özel Yetki Var mı?
```bash
sudo grep -E "^kullaniciadi|^%.*" /etc/sudoers
```

- ###### Kullanıcı Hesabı SUDO Grubunda mı?

```bash
groups kullaniciadi | grep sudo
```

Bu denetimler ve yaklaşım, gruplar üzerinden veya kullanıcı hesapları üzerinde yetkilendirme yapılan ortamlarda **DAC** ve **RBAC** denetimi için temel bir yaklaşımdır.<br>

> ## 2. Erişim Yönetimi Politikası
Kurumun sistem ve kaynaklarına erişimin düzenlenmesi, bilgi güvenliğinin temel adımlarından biridir.<br>  
Kimlik doğrulama, yetkilendirme, kullanıcı yaşam döngüsü ve çok faktörlü kimlik doğrulama (MFA) gibi mekanizmalar bu politikanın kapsamına girer.<br>

- ### Erişim Yönetimi Politikası Hedefleri
  - Kimlik doğrulama ve yetkilendirme süreçlerinin tanımlanması<br>
  -  Gruplar, roller, şifre politikaları, çok faktörlü kimlik doğrulama (MFA) kullanımı<br>
  - Kullanıcı hesaplarının düzenli olarak gözden geçirilmesi<br>

- ### Kimlik Doğrulama ve Yetkilendirme
  - Kullanıcıların sisteme giriş yaparken güçlü kimlik doğrulama mekanizmaları kullanılmalıdır.<br>
  - **Şifre Politikası:** Minimum uzunluk, karmaşıklık, süreli değişim zorunluluğu uygulanmalıdır.<br>
  - **MFA Kullanımı:** Özellikle yönetici hesaplarında ve dış erişimlerde zorunlu tutulmalıdır.<br>

**Linux makinelerde Yapılandırma Örnekleri**<br>
- ###### Şifre Politikası Ayarları - /etc/login.defs
```bash
PASS_MAX_DAYS   90    # Şifre 90 günde bir değiştirilmeli
PASS_MIN_DAYS   1     # Şifre değişikliği minimum 1 gün sonra tekrar yapılabilir
PASS_MIN_LEN    12    # Minimum şifre uzunluğu
PASS_WARN_AGE   7     # Şifre bitmeden 7 gün önce uyar
```
Bu yapılandırma dosyası, sistemde useradd gibi komutlarla oluşturulan hesaplara varsayılan şifre politikalarını uygular.<br>
Varsayılan ayarlar aşağıdaki yapılandırma satırlarıyla oluşturulur.<br>
- ###### Şifre Karmaşıklığı Ayarları - /etc/security/pwquality.conf (pam_pwquality.so)
```bash
minlen = 12             # Minimum şifre uzunluğu
dcredit = -1            # En az 1 rakam zorunlu
ucredit = -1            # En az 1 büyük harf zorunlu
lcredit = -1            # En az 1 küçük harf zorunlu
ocredit = -1            # En az 1 özel karakter zorunlu
retry = 3               # Kullanıcı 3 kere yanlış girerse işlem iptal olur
```
Bu modül;<br>
Debian ve türevi dağıtımlarda; /etc/pam.d/common-password<br>
RHEL ve türevi dağıtımlarda;   /etc/pam.d/system-auth<br>
dosyalarına aşağıdaki şekilde eklenmelidir.
```bash
password requisite pam_pwquality.so retry=3
```
- ###### Başarısız Giriş Denemesi Kısıtlaması - /etc/security/faillock.conf
```bash
deny = 5                # 5 başarısız denemeden sonra kilitlenir
unlock_time = 600       # 10 dakika sonra otomatik açılır
fail_interval = 900     # 15 dakika içinde 5 hatalı deneme sayılır
```
faillock.conf yapılandrıması sonrasında pam_faillock.so modülü /etc/pam.d/common-auth içinde aşağıdaki gibi dahil edilmelidir.
```bash
auth required pam_faillock.so preauth silent audit
auth [default=die] pam_faillock.so authfail audit
```
Ayarları kullanmak ve test için;<br>
```bash
faillock --user kullaniciadi
```
faillock komutunda --user ile eklenen KullanıcıHesabı için faillock.conf içindeki yapılandırmalar aktif olur.<br>
Böylece başarısız girişler için lock mekanizması ilgili kullanıcı hesabı için devereye girer.<br>

- ###### Tüm Yerel Kullanıcı Hesapları için faillock ayarının aktif edilmesi
```bash
#!/bin/bash

echo "Faillock Check..."

for user in $(awk -F: '$3 >= 1000 && $3 < 65534 {print $1}' /etc/passwd); do
    faillock --user "$user" | grep -q "no access" && \
        echo "[$user] : Henüz başarısız giriş kaydı yok (aktif izleniyor)" || \
        echo "[$user] : Kısıtlama uygulanmış veya deneme geçmişi var"
done
```
Yukarıdaki script,<br>
faillock PAM modülü aktif edilmesi ve faillock.conf yapılandırmasının yapılmış olması durumunda sistemdeki tüm yerel kullanıcılar için çalışır.
Script, faillock.conf yapılandırmasını tüm yerel kullanıcı hesaplarında aktif eder.<br>

- ###### Kısıtlanmış Kullanıcı Hesaplarını Listelemek
```bash
#!/bin/bash

echo "Faillock Check..."
faillock --reset --dry-run 2>/dev/null | grep -B1 'currently locked' | grep '^user'
```
Yukarıdaki script ile faillock mekanizmasının çalıştığı kullanıcı hesapları listelenir.<br>

> ## 3. Güncelleme Politikası ve Yama Yönetimi
Sistem ve uygulama güvenliğinin sağlanmasında **güncellemelerin zamanında uygulanması** kritik rol oynar.<br>
Güncellenmeyen sistemler, bilinen zafiyetler üzerinden hedef alınabilir ve bu saldırı senaryolarında kolaylık sağlar.<br>
Sistemlerin yazılım ve sistemsel olarak güncel tutulmaması önemli bir ihmaldir. Buna göre; belli bir aralık ve takvim içinde kalmak kaydıyla güncelleme çalışmaları planlanmalıdır.<br>

- ### Güncelleme Politikası Hedefleri
  - İşletim sistemi, uygulama ve servislerin düzenli güncellenmesi
  - Kritik yamaların gecikmeden uygulanması
  - Otomatik güncelleme yapılamayan sistemlerin izlenmesi
  - Yama süreci tamamlanamayan sistemler için geçici koruma yöntemlerinin (virtual patching) devreye alınması

- ###### Windows Ortamında Powershell Yama Takibi için sorgu
```powershell
# Son 30 gün içinde kurulan güncellemeleri listeler
Get-HotFix | Where-Object {$_.InstalledOn -gt (Get-Date).AddDays(-30)} |
Select-Object Description, InstalledOn
```
Yukarıdaki script makine üzerinden elle yapılacak bir kontrol için örnektir.<br>
Organizasyonlarda WSUS veya SCCM gibi araçlarla merkezi yama yönetimi uygulanmalıdır.

- ###### Linux makinelerde Güncelleme Kontrolleri
Debian ve türevi dağıtımlarda;<br>
```bash
apt list --upgradable
```
RHEL ve türevi dağıtımlarda;<br>
```bash
yum check-update
```

Yukarıdaki komutlarla sistem güncellemeleri denetlenir. Bu denetleme ve kontrollerin sürdürülebilir olması için merkezi/uzaktan yapılması önemlidir.<br>
Paket yöneticileri (apt, yum, dnf) üzerinden yapılan güncellemeler hem sistem güvenliğini hem de kararlılığı direkt etkiler.<br>
Kritik sistemlerde kontrollü güncelleme otomatik güncelleme yerine tercih edilmelidir.<br>

- ### Virtual Patching
Bazı durumlarda sistem güncellemeleri hemen uygulanamaz.<br>
Özellikle Linux sunucu ortamlarında, kullanılan dağıtım ve uygulama çeşitliliği nedeniyle pratik ve tutarlı bir güncelleme senaryosu oluşturmak zorlaşır.<br>
Windows ortamlarında OS güncellemeleri daha bütüncül olsa da, üzerinde çalışan servis veya uygulamaların güncellenmesi ayrıca planlanır.<br>
Bu durum, sistemin tamamı için güncelleme yapmayı engeller.<br>
Yani;<br>
- OS güncellenebilir ama **uygulama** üretici tarafından henüz desteklenmeyebilir
- Uygulama yamalanabilir ama yeni sürüm OS ile uyumsuz olabilir

Sağlıklı bir güncelleme süreci için; OS ve uygulama katmanlarının birbirine takvim ve sürüm açısından uyumlu olması gerekir. Ancak bu yalnızca üretici planlamasıyla değil kurumun kendi yazılım geliştirme ve sistem yönetim disipliniyle sağlanabilir. Özellikle uygulama güncellemeleri, çoğu zaman geliştirme planına bağımlıdır.<br>
Bu da OS, APP ve ilgili yamaların ortak bir takvimde yürütülememesine neden olur.<br>
Sonuç olarak;<br>
- Regülasyonlara uyum zedelenir
- Zafiyetler kapatılamaz
- Güvenlik açıkları artar

Bu gibi durumlar için ortamda model ve tasarımı değiştiren alternatif çözümler uygulanmalıdır.<br>
Buna göre örnek Önlemler aşağıdakiler olabilir;<br>
- Güncellenemeyen sistemin önüne firewall (WAF, IPS) yerleştirmek
- Yazılımsal firewall kuralları ve erişim kısıtlamaları tanımlamak
- Sistemi DMZ ortamına taşıyarak izolasyon sağlamak
- Hizmet dışı portları tamamen kapatmak
- Açık kalan portta, yamalanamayan uygulamaya karşı tüm olasılıkları analiz etmek



Bazı durumlarda sistem güncellemeleri hemen uygulanamaz. Özellikle Linux sunucu ortamlarında gerek uygulama gerekse de dağıtım çeşitliliği pratik bir güncelleme senaryosunun işletilmesini engeller.<br>
<br>
Aynı şekilde Windows ortamlarında da OS seviyesinde yapılacak işler, Linux ortamlarındaki gibi dağıtım çeşitliğinden dolayı karmaşık olmasa da üzerindeki servis ve uygulamaların güncellenmesi ayrıca yapılmaktadır. Bu da Windows OS'nin güncellenmesini veya üzerinde çalıştırdığı servis veya uygulamanın güncellenmesini engellemektedir. Hepsini kapsayan bir güncelleme yapmak için;<br>
OS güncellemesi ile uygulamanın güncellemesi yani üretici bağımlılığının aynı seviyede kalması gereklidir. En başından yayınlanmış güncellemelerin OS ve APP olarak birarada çalışan sistemlerin birbirine takvim uyumluluğu sağlaması gereklidir. Bu operasyon sadece bu faktöre de bağlı değildir.<br>
<br>
Özellikle uygulama güncellemeleri bir yazılım geliştirme/güncelleme planını da gerektirdiğinden esnetilebilmekte veya OS, APP ve APP tarafının yamalanması süreçleri ortak takvimde yürütülememektedir.
Bu durum, ortamların güvenlik gereksinimlerini karşılama ve regülasyon uyumluluğunu sağlama konusuna en büyük engeldir.<br>
Planlı ve disiplinli bir güncelleme/geliştirme süreci yürütülmesini gerekli kılar.<br>
Tüm bunlara rağmen yukarıdaki faktörlerden birinin sağlanamaması durumunda ortamlar için model ve tasarımı değiştirien çözümler uygulanmalıdır.<br>
<br>
Örneğin;<br>
- Güncellenemeyen bir sistemin önüne FW koymak
- Sistem üzerinden yazılımsal FW kuralları ve erişim kısıtlamaları uygulamak
- Sistemleri DMZ ortamına almak
- Sistemin hizmet verdiği port dışındaki tüm portları kapatmak
- Sistemin hizmet verdiği port üzerinde güncelleme yapılamadığından doğan tüm olasılıkları gözden geçirmek

**Not:** İstisnai durumlarda da olsa idaresel bir yönetim ve çözüm üretme amacıyla;<br>
- Uyumsuzluk riski olan paketlerin sabitlenmesi gerekebilir<br>
ve bu da
- Kritik bir servisin, üretici onayı veya test olmadan otomatik güncellenmesini engellemek ile sağlanabilir.
Bunun için Linux sistemlerde;
```bash
apt-mark hold package-name
```
komutu kullanılır. **apt-mark hold"" komutu parametre aldığı paketi güncelleme işlemi için lock eder.<br>
**Örneğin:** *apt-mark hold nginx*
Bu işlem, kontrolsüz güncellemeyi engeller. Ancak zafiyeti çözmez.<br>
Böyle durumlarda paket güncellenene kadar WAF, IPS, port sınırlama gibi dış koruma önlemlerinin uygulanması gerekir.<br>
Böyle bir konuda **hold** komutu doğrudan bir güvenlik mekanizması değil, fakat idari bir kontrol tekniği olarak kullanılabilir.<br>

> ## 4. Güvenlik Açığı ve Risk Yönetimi
Risk yönetimi, bir kurumun bilgi sistemlerinde karşılaşabileceği tehdit ve zafiyetlerin etkilerini analiz ederek bu riskleri **tanımlama, ölçme ve yönetme** çalışmasıdır.<br>
Bu çalışma ve çalışma süreci, sadece teknik tarama sonuçlarından ibaret değildir. Aynı zamanda **iş sürekliliği, düzenleyici uyumluluk ve kaynak yönetimi** gibi unsurları da kapsar.<br>

- ### Risk Yönetimi Politikası Hedefleri
  - Zafiyet Tespiti
    - Otomatik Taramalar
    - Manuel Taramalar
  - Risk Analizi
  - Risk Önceliklendirme
  - Risk Yanıt Stratejileri

- ###### Zafiyet Tespiti
  Kurum, sistem ve uygulama düzeyinde **otomatik ve manuel zafiyet taramaları** gerçekleştirmelidir.<br>
  - ###### Otomatik Taramalar
    - Açık kaynak: OpenVAS, Nikto, Nmap
    - Ticari: Nessus, Qualys, Nexpose
  - ###### Manuel Taramalar
    - Yapılandırmaların incelenmesi
    - Port ve servis doğrulamaları
    - Güvenlik testleri senaryoları

Otomatik tarama çıktıları, manuel doğrulama ile kontrol edilerek gerçek bulgular tespit edilir ve False Positive oranı yönetilebilir.<br>

- ###### Risk Analizi
  Tespit edilen her zafiyetin;<br>
  - **Etkisi (Impact)**: Ne kadarlık bir zarara yol açar? (veri kaybı, erişim, hizmet kesintisi)
  - **Olasılığı (Likelihood)**: Bu zafiyetin istismar edilme ihtimali nedir?
  - **Varlık Değeri (Asset Value)**: Hangi sistem etkileniyor? Kritikliği nedir?
Bu üç maddeden yola çıkılarak risk seviyesi belirlenir.<br>
```
Risk = Varlık Değeri x Etki x Olasılık
```
Buradaki değerler, kurumlara özel olarak sayısal veya dereceli (düşük/orta/yüksek) olarak sınıflandırılır.<br>
Bu çalışmalar için uygulamalardan yararlanılarak bu değerleri berlirlemek için araçlar da kullanılmaktadır.<br>
Gerçekçi ve doğru çözüm için uygulama destekli sonuçlar değerlendirilmeli ve uygun senaryolar belirlenmelidir.<br>

- ###### Risk Önceliklendirme
  Tüm riskler aynı anda çözülemez. Bu nedenle analiz sonucunda çıkan riskler, **önem sırasına göre** sınıflandırılıp ve planlanmalıdır.<br>
  Buna göre;
  - Kritik sistemlerdeki yüksek riskler -> Öncelikli
  - Düşük etkili ama yaygın riskler -> Toplu iyileştirme
  - Dışa kapalı sistemlerdeki riskler -> İzlenerek zamanlı çözüm <br>
olarak planlanabilir.<br>

- ###### Risk Yanıt Stratejileri
  Her risk için aşağıdaki stratejilerden biri veya birkaçı uygulanabilir.
  
  - **Azaltma (Mitigate):**
  Yamalar, erişim sınırlamaları, güvenlik duvarı, segmentasyon
  - **Kabul Etme (Accept):**
  İş açısından risk göze alınabilir düzeydeyse ve gideri maliyetli/karmaşıksa
  - **Transfer Etme (Transfer):**
  Riskin sigorta, dış kaynak (outsourcing) veya tedarikçiye devri
  - **Kaçınma (Avoid):**
  Riskli hizmetin/sistemin tamamen terk edilmesi

olarak uygulama planı belirlenir.<br>

## Örnek Senaryo ve Uygulama Planı
Kurumda çalışan eski bir uygulama sunucusunda yüksek riskli bir PHP zafiyeti tespit edildiğinde;
- Uygulama güncellenemiyor çünkü 3. parti sağlayıcı desteği bitmiş durumda
- Sistem dışa açık değil ancak iç erişim mümkün
Yukarıdakilere göre risk değerlendirmesi yapılır.

Risk değerlendirmesi sonrası;
  - **Mitigation:** Sunucuyu sadece belirli IP’lerden erişilebilir yapmak
  - **Accept:** Zafiyetin şimdilik kabul edilmesi
  - **Transfer:** Gelecekte SaaS modele geçilerek bu uygulamanın sorumluluğunun sağlayıcıya bırakılması
<br>
olarak uygulama planı yapılabilir.<br>

## Örnek Temel Komutlar
#### OpenVAS tarama başlatma:
```bash
gvm-cli --gmp-username admin --gmp-password pass socket --xml "<create_target><name>ServerA</name><hosts>192.168.1.10</hosts></create_target>"
```

#### Nmap hızlı port tarama:
```bash
nmap -T4 -F 192.168.1.10
```

> ## 5. Loglama ve Monitoring Politikası
Loglama; sistemlerdeki olayların, kullanıcı işlemlerinin, servis hareketlerinin ve güvenlik durumlarının zaman damgalı olarak kaydedilmesi işlemidir. Monitoring ise bu logların, sistem davranışlarının ve güvenlik göstergelerinin anlık veya periyodik olarak analiz edilmesi sürecidir.<br>
Bu iki yapı taşı, saldırı tespiti, anomali analizi, kullanıcı etkinliği izleme ve olay müdahalesi gibi birçok sürecin temelini oluşturur.<br>

- ### Log ve Monitoring Politikası Hedefleri
  - Sistem ve uygulamalardaki **anormal davranışların erken tespiti**
  - Kullanıcı etkinliklerinin **gözlemlenebilir** ve **denetlenebilir** hale gelmesi
  - Güvenlik ihlallerinde **kanıt ve adli analiz** desteği
  - Yasal ve düzenleyici gerekliliklerin (KVKK, ISO 27001, GDPR) karşılanması

- ###### Hangi Log'lar Toplanmalı?
  - **Kimlik doğrulama:** Başarılı ve başarısız oturum açma girişimleri (SSH, RDP, MFA)
  - **Yetki yükseltme:** sudo, runas, su komutları
  - **Servis olayları:** Web sunucusu erişim hataları, DB hataları
  - **Ağ olayları:** Firewall logları, bağlantı girişimleri
  - **Dosya sistem erişimi:** Kritik dizinlere erişim veya değişiklikler
  - **Yazılım kurulum/silme işlemleri**

- ###### Logların Merkezi Toplanması
  - Dağıtık sistemlerde log bütünlüğü sağlanır
  - Tek bir merkezden analiz, arşivleme ve korelasyon yapılabilir
  - Sistemler arası ilişki kurulabilir (örneğin: birden fazla sunucuda aynı IP üzerinden gelen saldırı)
    
  - ###### **Kullanılabiliecek araçlar;**
    - **Linux:** rsyslog, syslog-ng, journalbeat -> Logstash -> Elasticsearch
    - **Windows:** Event Forwarding + WEF/Winlogbeat
    - **Merkezi Analiz:** Graylog, ELK (Elasticsearch-Logstash-Kibana), Wazuh, Splunk

- ###### İzleme ve Alarm Üretimi
  Log toplamak tek başına yeterli değildir.
  Bu logların analiz edilerek şüpheli durumların **otomatik olarak fark edilmesi** gerekir.<br>
  
  **SIEM sistemleri** bu amaçla kullanılır:
  - Logları toplar, filtreler, normalize eder
  - Anomali algılama kuralları uygular
  - Kritik durumlar için alarm ve bildirim üretir
  - Güvenlik olaylarını ilişkilendirerek görünürlük sağlar

  - ###### Örnek SIEM Kuralı Senaryosu
    **Senaryo:**
    Bir kullanıcı, 5 dakika içinde 10 farklı kaynaktan başarısız oturum açma denemesi yapıyor.

    **SIEM kuralı:**
    ```pseudocode
    if login_failed from >5 unique IP within 5 minutes
    then alert "Brute-force attempt suspected"
    ```
- ### logrotate
Her uygulama veya servisin, detaylı log kayıtları alınmalı ve sistemin kaynak kullanımı ile çalışma durumu sürekli olarak izlenmelidir.<br>
Ancak burada **önemli bir denge** kurmak gereklidir. Detaylı log kayıtları **disk alanını hızla tüketebilir** ve izlenen servisin sağlığına dolaylı zarar verebilir.<br>

Bu nedenle;<br>
  - **logrotate** ayarları mutlaka yapılandırılmalı
    - Otomatik uyarı sistemleri (**mail, SMS, webhook** vb.) devreye alınmalıdır
Aksi halde;<br>
  - Servis sorunsuz çalışsa bile, log dosyalarının şişmesi nedeniyle durabilir
    - Monitor edilen kaynaklardaki sorunlar bildirim sistemi olmadığı için fark edilmeden ilerleyebilir
   <br>
Sonuç olarak; log ve monitoring çalışmaları sadece veri toplamak değil, toplanan veriyi okuyabilir, sınıflandırabilir ve bildirim mekanizmalarıyla servisi sürdürebilir hale getirmektir.
Bu yaklaşımın her sistemde planlı şekilde uygulanması gerekir.<br>

## Örnek Temel Kontrol Komutları
- ###### Linux – auth.log içinde başarısız oturum açma sayısı
```bash
grep "Failed password" /var/log/auth.log | wc -l
```
- ###### Windows – PowerShell ile oturum olaylarını sorgulama
```powershell
Get-WinEvent -LogName Security -FilterXPath "*[System[(EventID=4625)]]"
```
