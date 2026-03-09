# Bütünlük (Integrity)
> Bütünlük (Integrity), bilginin doğruluğunun, tutarlılığının ve yetkisiz değişikliklerden korunmasının sağlanmasıdır. 

---

Bu kavram bilgi güvenliğinin temel prensiplerinden biri olan CIA Üçlüsü içerisinde tanımlanmıştır 
(bkz.[CIA Üçgeni](https://github.com/eesmer/CyberSecurity-Glossary/blob/main/TR/Bilgi_Guvenligi/belgeler/cia-ucgeni.md))

CIA bağlamında bütünlük;

- Verinin doğru olması
- Eksiksiz olması
- Yetkisiz şekilde değiştirilmemesi
- Değişikliklerin izlenebilir olması

anlamına gelir.

Ancak bütünlük yalnızca teorik bir prensip değil; teknik, kriptografik ve operasyonel mekanizmalarla sağlanan bir güvenlik özelliğidir.
Bu belge, bütünlüğü kavramsal seviyeden teknik seviyeye taşıyarak detaylandırmayı amaçlar.

---

## 1. Teknik Olarak Bütünlük Nedir?
Teknik anlamda bütünlük, bir veri nesnesinin (dosya, veri tabanı kaydı, ağ paketi, konfigürasyon dosyası vb.) oluşturulduğu andaki durumunun sonradan değişip değişmediğinin doğrulanabilmesidir.

Bu doğrulama genellikle kriptografik yöntemlerle yapılır:
### 1.1 Hash Fonksiyonları
Hash fonksiyonları (örn. SHA-256), bir veri kümesinden sabit uzunlukta bir özet (digest) üretir.

Özellikleri:
- Deterministik
- Tek yönlü
- Çarpışmaya dayanıklı (collision resistant)

---

### 1.2 Message Authentication Code (MAC)
MAC, hash + gizli anahtar kombinasyonudur. 

Bu sayede:
- Veri değiştirilmiş mi?
- Veri gerçekten beklenen kaynaktan mı?

sorularına cevap verilebilir.

Bir dosyanın hash değeri değişmişse, içeriği değişmiştir.
Ancak hash tek başına kimlik doğrulama sağlamaz; sadece değişiklik tespiti sağlar.

---

### 1.3 Dijital İmza (Digital Signature)
Dijital imza, hem bütünlük hem de inkâr edilemezlik (non-repudiation) sağlar.

Örnek kullanım alanları:
- Yazılım paket imzaları
- Güncelleme mekanizmaları
- TLS sertifikaları

---

### 1.4 Checksum vs Kriptografik Hash
Checksum algoritmaları (örn. CRC32):
- Hata tespiti için tasarlanmıştır
- Güvenlik amaçlı değildir

Kriptografik hash:
- Kasıtlı manipülasyonlara karşı dayanıklıdır
Bu ayrım özellikle güvenlik tasarımında kritiktir.

---

## 2. Bütünlüğü Tehdit Eden Faktörler
Bütünlük yalnızca saldırgan kaynaklı değil, operasyonel hatalar nedeniyle de bozulabilir.

### 2.1 Kasıtlı Müdahale
- Rootkit yerleştirme
- Sistem dosyası değiştirme
- Log manipülasyonu
- Web uygulaması defacement

### 2.2 Kazara Bozulma
- Disk hataları
- Yanlış konfigürasyon
- İnsan hatası

### 2.3 Zararlı Yazılımlar
- Ransomware
- Backdoor
- Yetkisiz konfigürasyon değişiklikleri

---

## 3. Bütünlük Kontrolleri
Bütünlüğü sağlamak için kullanılan kontroller iki ana gruba ayrılabilir:

### 3.1 Önleyici Kontroller
- Erişim kontrol mekanizmaları
- Dosya izinleri
- Immutable flag (chattr +i)
- Versiyon kontrol sistemleri

### 3.2 Tespit Edici Kontroller (Detective Controls)
- Log izleme
- Dosya bütünlük izleme (File Integrity Monitoring - FIM)
- Paket imza doğrulama
- Konfigürasyon drift tespiti

---

## 4. File Integrity Monitoring (FIM)
File Integrity Monitoring (FIM), sistem üzerindeki dosya ve dizinlerin önceden belirlenmiş bir referans durum (baseline) ile karşılaştırılarak 
değişikliklerin tespit edilmesi yöntemidir.

FIM’in temel prensipleri:
1. Baseline oluşturma
2. Periyodik karşılaştırma
3. Raporlama
4. Değişiklik yönetimi (change management)

FIM sistemleri genellikle:
- Hash karşılaştırması
- Dosya metadata kontrolü
- İzin değişikliği kontrolü
- Sahiplik değişikliği kontrolü

gibi mekanizmalar kullanır.

---

## 5. Bütünlük ve Değişiklik Yönetimi
Bütünlük denetimi, değişiklik yönetimi ile birlikte çalışmalıdır.

Aksi takdirde:
- Planlı güncellemeler "alarm" üretir
- Gürültü artar
- Güvenlik ekipleri alarmlara karşı duyarsızlaşır

Sağlıklı bir model:
1. Değişiklik talebi (change ticket)
2. Planlı uygulama
3. FIM kontrolü
4. Rapor analizi
5. Gerekirse baseline güncelleme

şeklinde ilerler.

---

## 6. Örnek Senaryo
Örnek: Bir Linux sunucuda `/usr/sbin/sshd` dosyasının değiştirilmesi.

Olası senaryolar:
- Paket güncellemesi
- Yetkisiz binary değiştirme
- Backdoor yerleştirme

**Önemli:** Bütünlük kontrolü olmadan bu değişiklik tespit edilemeyebilir.

## 7. Uygulamalı Çalışma
Bu kavramın Debian üzerinde uygulanışı:
`LABS -> Information Security -> Integrity -> Tripwire` [link eklenecek] <br>
başlığı altında hazırlanan uygulamalı çalışma incelenmelidir.

Bu lab çalışması:
- Baseline oluşturma
- Politika tanımlama
- Periyodik kontrol
- Rapor üretimi
- JSON/Markdown çıktısı alma
- Hardening önerileri

gibi pratik uygulamaları içerir.

---

## 8. Modern Yaklaşımlar
Günümüzde bütünlük yalnızca dosya seviyesinde değil:

- Container image signing
- Supply chain security
- SBOM doğrulama
- Infrastructure as Code drift detection
- GitOps bütünlüğü

gibi alanlara da genişlemiştir.

Dolayısıyla bütünlük kontrolü yalnızca bir dosya kontrolü değil; modern sistem mimarilerinin temel güvenlik bileşenidir.

---

## 10. Sonuç
Bütünlük (Integrity), bilgi güvenliğinin en kritik prensiplerinden biridir.

Teknik olarak:
- Hash ve imza mekanizmaları
- FIM sistemleri
- Change management süreçleri

ile sağlanır.
