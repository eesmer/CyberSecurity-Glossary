# CIA Üçlüsü (Gizlilik, Bütünlük, Erişilebilirlik)
> Bu belge, bilgi güvenliği kapsamında Gizlilik, Bütünlük ve Erişilebilirlik (CIA Üçlüsü) ilkelerini açıklar.

---

## Tanım
CIA Üçlüsü; bilgi güvenliğinin temelini oluşturan üç ana ilkeden oluşur;
- **Gizlilik (Confidentiality)**
- **Bütünlük (Integrity)**
- **Erişilebilirlik (Availability)**

Bu üç ilke, bilgilerin yetkisiz erişimden korunmasını, doğruluğunun korunmasını ve ihtiyaç duyulduğunda erişilebilir olmasını sağlar.<br>
Tüm bilgi güvenliği politikaları, sistemleri ve kontrolleri direkt ya da dolaylı olarak bu üç temel prensibi sağlamaya yöneliktir.

## Gizlilik (Confidentiality)
Gizlilik ilkesi, bilginin yalnızca yetkili kişiler tarafından erişilebilir olmasını ifade eder.  
Amaç; yetkisiz kişilerin verilere ulaşmasını, görüntülemesini, kopyalamasını veya aktarmasını engellemektir.

**Gizliliği sağlamaya yönelik önlemler:**
- Kimlik doğrulama (MFA, şifreler, kartlar)
- Erişim kontrol listeleri (ACL)
- Şifreleme (örn: AES)
- Güvenli iletim protokolleri (VPN, HTTPS)

## Bütünlük (Integrity)
Bütünlük, bilginin doğruluğunun ve tutarlılığının korunmasıdır.  
Bilginin yetkisiz kişilerce değiştirilmemesi, bozulmaması ve üzerinde izinsiz oynama yapılmaması için uygulanan önlemlerdir.

**Bütünlüğü sağlamaya yönelik önlemler:**
- Hash algoritmaları (örn: SHA-256)
- Dijital imza
- Dosya bütünlük kontrolleri
- Yetkilendirme politikaları
