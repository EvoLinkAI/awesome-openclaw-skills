🌐 [English](README.md) | [日本語](README.ja.md) | [한국어](README.ko.md) | [简体中文](README.zh-CN.md) | [Français](README.fr.md) | [Deutsch](README.de.md) | [Русский](README.ru.md) | [हिन्दी](README.hi.md) | Türkçe

# Web Search Assistant

**EvoLink API kullanarak yapay zeka destekli web araması**

Powered by [Evolink.ai](https://evolink.ai?utm_source=github&utm_medium=skill&utm_campaign=web-search)

Web'de arama yapın ve başlıklar, URL'ler ve açıklamalarla temiz, biçimlendirilmiş sonuçlar alın.

## 🚀 Hızlı Başlangıç

```bash
bash scripts/search.sh "AI coding assistants 2026"
bash scripts/search.sh "quantum computing breakthroughs" 20
```

## 🔑 Yapılandırma

EvoLink API anahtarınızı ayarlayın:

```bash
export EVOLINK_API_KEY="your-evolink-api-key-here"
```

👉 [Ücretsiz API anahtarı alın](https://evolink.ai/signup?utm_source=github&utm_medium=skill&utm_campaign=web-search)

## 📖 Kullanım

### Temel Arama

```bash
bash scripts/search.sh "arama sorgusu"
```

İlk 10 sonucu döndürür.

### Sonuçları Sınırla

```bash
bash scripts/search.sh "arama sorgusu" 20
```

Maksimum sonuç sayısını belirtin.

## 🔒 Güvenlik

**Kimlik Bilgileri ve Ağ**

EvoLink API'sini çağırmak için `EVOLINK_API_KEY` gereklidir. Arama sorgularınız işlenmek üzere `api.evolink.ai`'ye gönderilir. EvoLink, web aramasını dahili olarak işler ve biçimlendirilmiş sonuçları döndürür.

**Dosya Erişimi**

Bu beceri herhangi bir dosya okumaz veya yazmaz.

**Ağ Erişimi**

Bu beceri şu adrese ağ istekleri yapar:
- **EvoLink API** (`api.evolink.ai`) - web araması yapmak için

Tüm ağ çağrıları curl aracılığıyla yapılır ve betik kaynak kodunda denetlenebilir.

**Kalıcılık ve Ayrıcalıklar**

Bu beceri diğer becerileri veya sistem ayarlarını değiştirmez. Yükseltilmiş veya kalıcı ayrıcalıklar istenmez.

## 📄 Lisans

MIT

## 🔗 Bağlantılar

- [ClawHub](https://clawhub.ai/evolinkai/web-research)
- [API Referansı](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=web-search)
- [Topluluk](https://discord.com/invite/5mGHfA24kn)
- [Destek](mailto:support@evolink.ai)
