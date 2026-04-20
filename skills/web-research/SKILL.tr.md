---
name: web-research
description: EvoLink API üzerinden web araması. Başlıklar, URL'ler ve açıklamalarla temiz, biçimlendirilmiş sonuçlar döndürür. Powered by evolink.ai
metadata: {"clawdbot":{"emoji":"🔍","requires":{"bins":["bash","curl","jq"],"env":["EVOLINK_API_KEY"]},"primaryEnv":"EVOLINK_API_KEY"}}
---

# Web Search Assistant

EvoLink API kullanarak web araması. Başlıklar, URL'ler ve açıklamalarla temiz, biçimlendirilmiş sonuçlar döndürür.

Powered by [Evolink.ai](https://evolink.ai?utm_source=clawhub&utm_medium=skill&utm_campaign=web-search)

## Ne Zaman Kullanılır

Kullanıcılar aşağıdakileri talep ettiğinde bu beceriyi kullanın:
- Bilgi veya kaynaklar için web aramaları
- Güncel veya son bilgileri çevrimiçi bulma
- Güncel web verileri gerektiren araştırma
- Web kaynaklarını kullanarak gerçek kontrolü veya doğrulama
- Bir konu hakkında URL'ler ve kaynaklar toplama

## Arama

```bash
{baseDir}/scripts/search.sh "sorgu"
{baseDir}/scripts/search.sh "sorgu" 20
```

## Seçenekler

- `<query>`: Arama sorgusu
- `<max_results>`: Sonuç sayısı (varsayılan: 10)

## Yapılandırma

EvoLink API anahtarınızı ayarlayın:

```bash
export EVOLINK_API_KEY="your-evolink-api-key-here"
```

👉 [Ücretsiz API anahtarı alın](https://evolink.ai/signup?utm_source=clawhub&utm_medium=skill&utm_campaign=web-search)

## Örnek

```bash
bash scripts/search.sh "Claude Opus 4 features"
```

Çıktı:
```
🔍 Arama: Claude Opus 4 features

📄 Claude Opus 4: New Features and Capabilities
🔗 https://example.com/opus-4
📝 Comprehensive guide to Claude Opus 4's new features...

📄 What's New in Claude Opus 4
🔗 https://example.com/whats-new
📝 Latest updates and improvements in Claude Opus 4...
```

## Güvenlik

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

## Bağlantılar

- [ClawHub](https://clawhub.ai/evolinkai/web-research)
- [API Referansı](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=clawhub&utm_medium=skill&utm_campaign=web-search)
- [Topluluk](https://discord.com/invite/5mGHfA24kn)
- [Destek](mailto:support@evolink.ai)
