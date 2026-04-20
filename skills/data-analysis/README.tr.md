🌐 [English](README.md) | [日本語](README.ja.md) | [한국어](README.ko.md) | [Français](README.fr.md) | [Deutsch](README.de.md) | [Русский](README.ru.md) | [हिन्दी](README.hi.md) | [Türkçe](README.tr.md) | [中文](README.zh.md)

# Veri Analizi Asistanı

**EvoLink API kullanarak yapay zeka destekli veri analizi**

[Evolink.ai](https://evolink.ai?utm_source=github&utm_medium=skill&utm_campaign=data-analysis) tarafından desteklenmektedir

CSV, Excel ve JSON dosyalarını karar odaklı metodoloji ve istatistiksel titizlikle analiz edin.

## 🚀 Hızlı Başlangıç

```bash
bash scripts/analyze.sh sales_data.csv "En önemli gelir faktörleri nelerdir?"
```

## 🔑 Yapılandırma

API anahtarınızı ayarlayın:

```bash
export EVOLINK_API_KEY="your-key"
```

👉 [Ücretsiz API anahtarı alın](https://evolink.ai/signup?utm_source=github&utm_medium=skill&utm_campaign=data-analysis)

## 📖 Kullanım

### Temel Analiz

```bash
bash scripts/analyze.sh <dosya_yolu> "<analiz_sorusu>"
```

**Desteklenen formatlar:**
- CSV (`.csv`)
- Excel (`.xlsx`, `.xls`)
- JSON (`.json`)

### Örnek Sorular

```bash
# Trend analizi
bash scripts/analyze.sh sales.csv "Aylık gelir trendi nedir?"

# Karşılaştırma
bash scripts/analyze.sh experiment.csv "A varyantı B'den önemli ölçüde daha iyi mi?"

# Segmentasyon
bash scripts/analyze.sh users.csv "Hangi kullanıcı segmentleri en yüksek elde tutmaya sahip?"

# Anomali tespiti
bash scripts/analyze.sh metrics.csv "Son 30 günde olağandışı desenler var mı?"
```

## ⚙️ Yapılandırma

| Değişken | Varsayılan | Gerekli | Açıklama |
|---|---|---|---|
| `EVOLINK_API_KEY` | — | Evet | Evolink API anahtarınız. [Ücretsiz edinin →](https://evolink.ai/signup?utm_source=github&utm_medium=skill&utm_campaign=data-analysis) |
| `EVOLINK_MODEL` | `[REDACTED]` | Hayır | Analiz için model. [Evolink API](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=data-analysis) tarafından desteklenen herhangi bir modele geçin |
| `DATA_ANALYSIS_SAFE_DIR` | `$HOME/.openclaw/workspace` | Hayır | Yerel dosya erişimi için izin verilen dizin |

Gerekli ikili dosyalar: `curl`, `jq`, `python3`, `file`.

## 🎯 Temel İlke

**Karar olmadan analiz sadece aritmetiktir.**

Bu beceri şunları vurgular:
- Karar odaklı metodoloji
- İstatistiksel titizlik (örneklem büyüklüğü, güven aralıkları, etki büyüklüğü)
- Net çıktı standartları (önce içgörü, ölçülmüş belirsizlik)
- Açık sınırlamalar ve uyarılar

## 📊 Ne Yapar

1. **Veri dosyanızı okur** (CSV/Excel/JSON)
2. **EvoLink API'ye gönderir** analiz sorunuzla birlikte
3. **Yapılandırılmış içgörüler döndürür**:
   - Temel bulgular
   - İstatistiksel güven
   - Uyarılar ve sınırlamalar
   - Önerilen sonraki adımlar

## 🔒 Güvenlik

**Kimlik Bilgileri ve Ağ**

EvoLink API'yi çağırmak için `EVOLINK_API_KEY` gerektirir. Veri dosyası içeriğiniz ve analiz sorunuz işlenmek üzere `api.evolink.ai`'ye gönderilir. EvoLink verileri işler ve analiz sonuçlarını döndürür. İşlemden sonra hiçbir veri saklanmaz.

**Dosya Erişimi**

Belirtilen veri dosyasını yerel dosya sisteminizden okur. Dosyalar `DATA_ANALYSIS_SAFE_DIR` içinde olmalıdır (varsayılan: `$HOME/.openclaw/workspace`). Betik dosya yollarını doğrular ve güvenlik için sembolik bağlantıları reddeder.

Dosya yolları `realpath -e` ile çözülür (dosyanın var olmasını gerektirir, tüm sembolik bağlantıları çözer). Sembolik bağlantı girişleri açıkça reddedilir.

Hassas dosyalar ada göre kara listeye alınmıştır: `.env*`, `*.key`, `*.pem`, `*.p12`, `*.pfx`, `id_rsa*`, `authorized_keys`, `config.json`, `.bash_history`, `.ssh`, `shadow`, `passwd`.

**Dosya Boyutu Sınırı**: Veri dosyaları için maksimum 50MB.

**MIME Doğrulaması**: Yalnızca `text/csv`, `text/plain`, `application/json`, `application/vnd.ms-excel`, `application/vnd.openxmlformats-officedocument.spreadsheetml.sheet` kabul edilir.

**Ağ Erişimi**

- **EvoLink API** (`api.evolink.ai`) - Veri gönderir ve analiz alır

Tüm ağ çağrıları curl kullanır ve betik kaynağında denetlenebilir.

**Kalıcılık ve Ayrıcalık**

Bu beceri diğer becerileri veya sistem ayarlarını değiştirmez. Yükseltilmiş veya kalıcı izinler talep etmez.

## 📄 Lisans

MIT

## 🔗 Bağlantılar

- [API Referansı](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=data-analysis)
- [Topluluk](https://discord.com/invite/5mGHfA24kn)
- [Destek](mailto:support@evolink.ai)
- [API Anahtarı Alın](https://evolink.ai/signup?utm_source=github&utm_medium=skill&utm_campaign=data-analysis) — Ücretsiz kayıt

[Evolink.ai](https://evolink.ai?utm_source=github&utm_medium=skill&utm_campaign=data-analysis) tarafından desteklenmektedir
