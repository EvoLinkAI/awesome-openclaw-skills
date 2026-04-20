# Gmail Assistant — OpenClaw için Yapay Zeka E-posta Becerisi

Gmail API entegrasyonu; yapay zeka destekli ozetleme, akilli yanit taslagi olusturma ve gelen kutusu onceliklendirme ozellikleri. [evolink.ai](https://evolink.ai?utm_source=github&utm_medium=skill&utm_campaign=gmail) tarafindan desteklenmektedir.

[Bu Nedir?](#bu-nedir) | [Kurulum](#kurulum) | [Kurulum Rehberi](#kurulum-rehberi) | [Kullanim](#kullanim) | [EvoLink](https://evolink.ai?utm_source=github&utm_medium=skill&utm_campaign=gmail)

**Language / Dil:**
[English](README.md) | [简体中文](README.zh-CN.md) | [日本語](README.ja.md) | [한국어](README.ko.md) | [Español](README.es.md) | [Français](README.fr.md) | [Deutsch](README.de.md) | [Türkçe](README.tr.md) | [Русский](README.ru.md)

## Bu Nedir?

Gmail Assistant, Gmail hesabinizi yapay zeka ajaniniza baglayan bir OpenClaw becerisidir. Tam Gmail API erisimi saglar — okuma, gonderme, arama, etiketleme, arsivleme — ayrica EvoLink uzerinden Claude kullanan yapay zeka destekli ozellikler sunar: gelen kutusu ozetleme, akilli yanit taslagi ve e-posta onceliklendirme.

**Temel Gmail islemleri herhangi bir API anahtari gerektirmez.** Yapay zeka ozellikleri (ozetleme, taslak, onceliklendirme) istege bagli bir EvoLink API anahtari gerektirir.

[Ucretsiz EvoLink API anahtarinizi alin](https://evolink.ai/signup?utm_source=github&utm_medium=skill&utm_campaign=gmail)

## Kurulum

### Hizli Kurulum

```bash
openclaw skills add https://github.com/EvoLinkAI/gmail-skill-for-openclaw
```

### ClawHub Uzerinden

```bash
npx clawhub install evolinkai/gmail
```

### Manuel Kurulum

```bash
git clone https://github.com/EvoLinkAI/gmail-skill-for-openclaw.git
cd gmail-skill-for-openclaw
```

## Kurulum Rehberi

### Adim 1: Google OAuth Kimlik Bilgilerini Olusturma

1. [Google Cloud Console](https://console.cloud.google.com/) adresine gidin
2. Yeni bir proje olusturun (veya mevcut birini secin)
3. **Gmail API**'yi etkinlestirin: APIs & Services > Library > "Gmail API" arayip > Enable
4. OAuth onay ekranini yapilandirin: APIs & Services > OAuth consent screen > External > gerekli alanlari doldurun
5. OAuth kimlik bilgilerini olusturun: APIs & Services > Credentials > Create Credentials > OAuth client ID > **Desktop app**
6. `credentials.json` dosyasini indirin

### Adim 2: Yapilandirma

```bash
mkdir -p ~/.gmail-skill
cp credentials.json ~/.gmail-skill/credentials.json
bash scripts/gmail-auth.sh setup
```

### Adim 3: Yetkilendirme

```bash
bash scripts/gmail-auth.sh login
```

Bu komut, Google OAuth onay icin bir tarayici penceresi acar. Token'lar yerel olarak `~/.gmail-skill/token.json` konumunda saklanir.

### Adim 4: EvoLink API Anahtarini Ayarlama (Istege Bagli — yapay zeka ozellikleri icin)

```bash
export EVOLINK_API_KEY="your-key-here"
```

[API anahtarinizi alin](https://evolink.ai/signup?utm_source=github&utm_medium=skill&utm_campaign=gmail)

## Kullanim

### Temel Komutlar

```bash
# Son e-postalari listele
bash scripts/gmail.sh list

# Filtreyle listele
bash scripts/gmail.sh list --query "is:unread" --max 20

# Belirli bir e-postayi oku
bash scripts/gmail.sh read MESSAGE_ID

# E-posta gonder
bash scripts/gmail.sh send "to@example.com" "Yarin toplanti" "Merhaba, saat 15:00'te gorusebilir miyiz?"

# E-postaya yanit ver
bash scripts/gmail.sh reply MESSAGE_ID "Tesekkurler, orada olacagim."

# E-posta ara
bash scripts/gmail.sh search "from:boss@company.com has:attachment"

# Etiketleri listele
bash scripts/gmail.sh labels

# Etiket ekle/kaldir
bash scripts/gmail.sh label MESSAGE_ID +STARRED
bash scripts/gmail.sh label MESSAGE_ID -UNREAD

# Yildizla / Arsivle / Cop Kutusuna Tasi
bash scripts/gmail.sh star MESSAGE_ID
bash scripts/gmail.sh archive MESSAGE_ID
bash scripts/gmail.sh trash MESSAGE_ID

# Tam konusma zincirini goruntule
bash scripts/gmail.sh thread THREAD_ID

# Hesap bilgileri
bash scripts/gmail.sh profile
```

### Yapay Zeka Komutlari (EVOLINK_API_KEY gerektirir)

```bash
# Okunmamis e-postalari ozetle
bash scripts/gmail.sh ai-summary

# Ozel sorguyla ozetle
bash scripts/gmail.sh ai-summary --query "from:team@company.com after:2026/04/01" --max 15

# Yapay zeka ile yanit taslagi olustur
bash scripts/gmail.sh ai-reply MESSAGE_ID "Kibarca reddet ve gelecek haftayi oner"

# Gelen kutusunu onceliklendir
bash scripts/gmail.sh ai-prioritize --max 30
```

### Ornek Cikti

```
Gelen Kutusu Ozeti (5 okunmamis e-posta):

1. [ACIL] Proje teslim tarihi degisti — gonderen: manager@company.com
   2. ceyrek urun lansman tarihi 15 Nisan'dan 10 Nisan'a tasinmistir.
   Gerekli islem: Sprint planini yarin is gunu sonuna kadar guncelleyin.

2. Fatura #4521 — gonderen: billing@vendor.com
   Aylik SaaS abonelik faturasi, 299$. Son odeme tarihi: 15 Nisan.
   Gerekli islem: Onaylayin veya finans birimine iletin.

3. Cuma takim yemegi — gonderen: hr@company.com
   Cuma gunu saat 12:30'da takim olusturma yemegi. Katilim bildirimi istenmektedir.
   Gerekli islem: Katilim durumunuzu bildirin.

4. Bulten: AI Weekly — gonderen: newsletter@aiweekly.com
   Dusuk oncelikli. Haftalik yapay zeka haber ozeti.
   Gerekli islem: Yok.

5. GitHub bildirimi — gonderen: notifications@github.com
   PR #247 main dalina birlestirildi. CI basarili.
   Gerekli islem: Yok.
```

## Yapilandirma

Gerekli programlar: `python3`, `curl`

| Degisken | Varsayilan | Gerekli | Aciklama |
|----------|-----------|---------|----------|
| `credentials.json` | — | Evet (temel) | Google OAuth kimlik bilgileri — [kurulum rehberine](#kurulum-rehberi) bakin |
| `EVOLINK_API_KEY` | — | Istege bagli (YZ) | EvoLink API anahtari — [buradan kaydolun](https://evolink.ai/signup?utm_source=github&utm_medium=skill&utm_campaign=gmail) |
| `EVOLINK_MODEL` | `claude-opus-4-6` | Hayir | YZ modeli — [EvoLink API belgelerine](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=gmail) bakin |
| `GMAIL_SKILL_DIR` | `~/.gmail-skill` | Hayir | Ozel kimlik bilgisi depolama yolu |

## Gmail Sorgu Sozdizimi

- `is:unread` — Okunmamis mesajlar
- `is:starred` — Yildizli mesajlar
- `from:user@example.com` — Belirli gonderenden
- `to:user@example.com` — Belirli aliciya
- `subject:keyword` — Konu anahtar kelime icerir
- `after:2026/01/01` — Tarihten sonra
- `before:2026/12/31` — Tarihten once
- `has:attachment` — Eki olan
- `label:work` — Belirli etikete sahip

## Dosya Yapisi

```
.
├── README.md               # English (ana dosya)
├── README.zh-CN.md         # 简体中文
├── README.ja.md            # 日本語
├── README.ko.md            # 한국어
├── README.es.md            # Español
├── README.fr.md            # Français
├── README.de.md            # Deutsch
├── README.tr.md            # Türkçe
├── README.ru.md            # Русский
├── SKILL.md                # OpenClaw beceri tanimi
├── _meta.json              # Beceri meta verileri
├── LICENSE                 # MIT Lisansi
├── references/
│   └── api-params.md       # Gmail API parametre referansi
└── scripts/
    ├── gmail-auth.sh       # OAuth kimlik dogrulama yoneticisi
    └── gmail.sh            # Gmail islemleri + yapay zeka ozellikleri
```

## Sorun Giderme

- **"Not authenticated"** — Yetkilendirmek icin `bash scripts/gmail-auth.sh login` komutunu calistirin
- **"credentials.json not found"** — Google Cloud Console'dan OAuth kimlik bilgilerini indirin ve `~/.gmail-skill/credentials.json` konumuna yerlestin
- **"Token refresh failed"** — Yenileme token'iniz suresi dolmus olabilir. `bash scripts/gmail-auth.sh login` komutunu tekrar calistirin
- **"Set EVOLINK_API_KEY"** — Yapay zeka ozellikleri bir EvoLink API anahtari gerektirir. Temel Gmail islemleri anahtarsiz calisir
- **"Error 403: access_denied"** — Google Cloud projenizde Gmail API'nin etkin oldugunu ve OAuth onay ekraninin yapilandirildigini kontrol edin
- **Token guvenligi** — Token'lar `chmod 600` izinleriyle saklanir. Yalnizca sizin kullanici hesabiniz bunlari okuyabilir

## Baglantilar

- [ClawHub](https://clawhub.ai/EvoLinkAI/gmail-assistant)
- [API Referansi](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=gmail)
- [Topluluk](https://discord.com/invite/5mGHfA24kn)
- [Destek](mailto:support@evolink.ai)

## Lisans

MIT — ayrintilar icin [LICENSE](LICENSE) dosyasina bakin.
