# Güvenlik Politikaları
> Bu belge, bilgi güvenliği kapsamında organizasyonlarda uygulanması gereken temel güvenlik politikalarını ve pratik savunma yöntemlerini açıklar.

---

## Tanım
Güvenlik politikaları, bilgi sistemlerinin korunması için kurum tarafından belirlenen ilkeler, kurallar ve prosedürlerdir.
Amaç; sistemin gizlilik, bütünlük ve erişilebilirlik (CIA) ilkelerine uygun şekilde yapılandırılmasını, yönetilmesini ve kullanıcıların da bu kurallar doğrultusunda hareket etmesini sağlamaktır.

---

## Temel Güvenlik Politikaları

### 1. En Az Ayrıcalık İlkesi (Least Privilege)
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
Bu, özellikle Active Directory ortamlarında genel olarak gruplar üzerinden yetkilendirme yapıldığı için **DAC** ve **RBAC** denetimi için temel bir yaklaşımdır.<br>
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
