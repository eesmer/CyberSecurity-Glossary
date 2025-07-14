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
Erişim Yönetimi operasyonel olarak aşağıdaki yapılandırmaları gerektirir;<br>
**i-** Kimlik doğrulama ve yetkilendirme süreçlerinin tanımlanması<br>
**ii-** Gruplar, roller, şifre politikaları, çok faktörlü kimlik doğrulama (MFA) kullanımı<br>
**iii-** Kullanıcı hesaplarının düzenli olarak gözden geçirilmesi<br>

- ### **Kimlik Doğrulama ve Yetkilendirme**<br>
  Kullanıcıların sisteme giriş yaparken güçlü kimlik doğrulama mekanizmaları kullanılmalıdır.<br>
  **Şifre Politikası:** Minimum uzunluk, karmaşıklık, süreli değişim zorunluluğu uygulanmalıdır.<br>
  **MFA Kullanımı:** Özellikle yönetici hesaplarında ve dış erişimlerde zorunlu tutulmalıdır.<br>

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
