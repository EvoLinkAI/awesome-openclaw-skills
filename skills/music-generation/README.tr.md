# Evolink Music — OpenClaw için AI Müzik Oluşturma Skill\'i

<p align="center">
  <strong>5 müzik modeli, bir API anahtarı — Suno v4, v4.5, v5. Metinden müziğe, özel sözler, enstrümantal.</strong>
</p>

<p align="center">
  <a href="#bu-nedir">Nedir</a> •
  <a href="#kurulum">Kurulum</a> •
  <a href="#api-key-alma">API Key</a> •
  <a href="#müzik-oluşturma">Oluştur</a> •
  <a href="https://evolink.ai/signup?utm_source=github&utm_medium=readme&utm_campaign=music-generation-skill-for-openclaw">EvoLink</a>
</p>

<p align="center">
  <strong>🌐 Diller:</strong>
  <a href="README.md">English</a> |
  <a href="README.zh-CN.md">简体中文</a> |
  <a href="README.es.md">Español</a> |
  <a href="README.ja.md">日本語</a> |
  <a href="README.ko.md">한국어</a> |
  <a href="README.fr.md">Français</a> |
  <a href="README.de.md">Deutsch</a> |
  <a href="README.tr.md">Türkçe</a> |
  <a href="README.zh-TW.md">繁體中文</a>
</p>

---

## Bu nedir?

[EvoLink](https://evolink.ai?utm_source=github&utm_medium=readme&utm_campaign=music-generation) tarafından desteklenen bir [OpenClaw](https://github.com/openclaw/openclaw) skill\'i. Bir skill yükleyin ve AI ajanınız bir müzik stüdyosuna dönüşsün — şarkılar, enstrümantaller ve özel besteler oluşturmak için **5 Suno modeli**, hepsi tek bir API üzerinden.

| Skill | Açıklama | Modeller |
|-------|----------|----------|
| **Evolink Music** | Metinden müziğe, özel sözler, enstrümantal, vokal kontrolü | Suno v4, v4.5, v4.5plus, v4.5all, v5 |

📚 **Tam Rehber**: Stil, tür, atmosfer ve yapı üzerinde tam kontrol ile müzik oluşturma.

---

## Kurulum

### Hızlı Kurulum (Önerilen)

```bash
openclaw skills add https://github.com/EvoLinkAI/music-generation-skill-for-openclaw
```

Hepsi bu! Skill artık ajanınızda kullanılabilir.

### Manuel Kurulum

```bash
git clone https://github.com/EvoLinkAI/music-generation-skill-for-openclaw.git
cd music-generation-skill-for-openclaw
openclaw skills add .
```

---

## API Key Alma

1. [evolink.ai](https://evolink.ai/signup?utm_source=github&utm_medium=readme&utm_campaign=music-generation-skill-for-openclaw)utm_medium=readme[evolink.ai](https://evolink.ai/signup?utm_source=github&utm_medium=readme&utm_campaign=music-generation-skill-for-openclaw)utm_campaign=music-generation-skill-for-openclaw)\'de kaydolun
2. Dashboard → API Keys\'e gidin
3. Yeni bir API anahtarı oluşturun
4. Ortam değişkeninizde yapılandırın:

```bash
export EVOLINK_API_KEY=your_key_here
```

---

## Müzik Oluşturma

### Kullanılabilir Modeller

| Model | Açıklama | Kullanım Durumları |
|-------|----------|-------------------|
| **suno-v4** | Kararlı sürüm, hızlı oluşturma | Pop, elektronik, rock |
| **suno-v4.5** | Daha yüksek kalite, daha fazla detay | Profesyonel prodüksiyon |
| **suno-v4.5plus** | Maksimum kalite, premium ses | Ticari yayınlar |
| **suno-v4.5all** | Tam çok yönlülük | Tüm türler |
| **suno-v5** | En son sürüm, gelişmiş özellikler | Yaratıcı deneyler |

### Özellikler

- **5 model** farklı yeteneklerle
- **Stil kontrolü** — tür, atmosfer, tempo, yoğunluk
- **Özel sözler** — kendiniz yazın veya AI\'ın oluşturmasına izin verin
- **Enstrümantal mod** — vokalsiz müzik
- **Vokal kontrolü** — ses tipini ve aralığını ayarlayın

### Kullanım Örnekleri

Ajanınızla konuşun:

> "Akustik gitarla yaz hakkında neşeli bir pop şarkısı oluştur"

> "Rahatlatıcı bir atmosferle caz enstrümantal müziği oluştur, 3 dakika"

> "Yolculuklar hakkında özel sözleri olan bir rock şarkısı yaz"

---

## Sorun Giderme

| Sorun | Çözüm |
|-------|-------|
| `401 Unauthorized` | `EVOLINK_API_KEY`\'nizi [evolink.ai/dashboard](https://evolink.ai/dashboard?utm_source=github&utm_medium=readme&utm_campaign=music-generation)\'da kontrol edin |
| `402 Payment Required` | [evolink.ai/dashboard](https://evolink.ai/dashboard?utm_source=github&utm_medium=readme&utm_campaign=music-generation)\'da kredi ekleyin |
| `429 Rate Limited` | Çok fazla istek — biraz bekleyin |

---

## Lisans

MIT

---

<p align="center">
  Powered by <a href="https://evolink.ai/signup?utm_source=github&utm_medium=readme&utm_campaign=music-generation-skill-for-openclaw"><strong>EvoLink</strong></a> — Unified AI API Gateway
</p>
