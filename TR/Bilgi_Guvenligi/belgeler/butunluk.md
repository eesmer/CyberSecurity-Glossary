# Bütünlük (Integrity)

## 1. Kavramsal Çerçeve
Bütünlük (Integrity), bilginin doğruluğunun, tutarlılığının ve yetkisiz değişikliklerden korunmasının sağlanmasıdır. 
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

## 2. Teknik Olarak Bütünlük Nedir?
Teknik anlamda bütünlük, bir veri nesnesinin (dosya, veri tabanı kaydı, ağ paketi, konfigürasyon dosyası vb.) oluşturulduğu andaki durumunun sonradan değişip değişmediğinin doğrulanabilmesidir.

Bu doğrulama genellikle kriptografik yöntemlerle yapılır:
### 2.1 Hash Fonksiyonları
Hash fonksiyonları (örn. SHA-256), bir veri kümesinden sabit uzunlukta bir özet (digest) üretir.

Özellikleri:
- Deterministik
- Tek yönlü
- Çarpışmaya dayanıklı (collision resistant)

---

### 2.2 Message Authentication Code (MAC)
MAC, hash + gizli anahtar kombinasyonudur. 

Bu sayede:
- Veri değiştirilmiş mi?
- Veri gerçekten beklenen kaynaktan mı?

sorularına cevap verilebilir.

Bir dosyanın hash değeri değişmişse, içeriği değişmiştir.
Ancak hash tek başına kimlik doğrulama sağlamaz; sadece değişiklik tespiti sağlar.

---

### 2.3 Dijital İmza (Digital Signature)
Dijital imza, hem bütünlük hem de inkâr edilemezlik (non-repudiation) sağlar.

Örnek kullanım alanları:
- Yazılım paket imzaları
- Güncelleme mekanizmaları
- TLS sertifikaları

---

### 2.4 Checksum vs Kriptografik Hash
Checksum algoritmaları (örn. CRC32):
- Hata tespiti için tasarlanmıştır
- Güvenlik amaçlı değildir

Kriptografik hash:
- Kasıtlı manipülasyonlara karşı dayanıklıdır
Bu ayrım özellikle güvenlik tasarımında kritiktir.
