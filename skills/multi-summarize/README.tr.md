# Multi Summarize — OpenClaw için AI Özetleme Becerisi

Hızlı çoklu format özetleme — bir URL yapıştırın, dosya bırakın, kilit noktaları alın. [EvoLink](https://evolink.ai?utm_source=github&utm_medium=readme&utm_campaign=multi-summarize-skill-for-openclaw?utm_source=github&utm_medium=skill&utm_campaign=summarize) tarafından desteklenmektedir.

 [Nedir](#nedir) •
 [Kurulum](#kurulum) •
 [API Key](#api-key-alma) •
 [Kullanım](#kullanım) •
 [EvoLink](https://evolink.ai?utm_source=github&utm_medium=readme&utm_campaign=multi-summarize-skill-for-openclaw?utm_source=github&utm_medium=skill&utm_campaign=summarize)

 🌐 Languages:
 [English](/EvoLinkAI/multi-summarize-skill-for-openclaw/blob/main/README.md) |
 [简体中文](/EvoLinkAI/multi-summarize-skill-for-openclaw/blob/main/README.zh-CN.md) |
 [日本語](/EvoLinkAI/multi-summarize-skill-for-openclaw/blob/main/README.ja.md) |
 [한국어](/EvoLinkAI/multi-summarize-skill-for-openclaw/blob/main/README.ko.md) |
 [Español](/EvoLinkAI/multi-summarize-skill-for-openclaw/blob/main/README.es.md) |
 [Français](/EvoLinkAI/multi-summarize-skill-for-openclaw/blob/main/README.fr.md) |
 [Deutsch](/EvoLinkAI/multi-summarize-skill-for-openclaw/blob/main/README.de.md) |
 [Türkçe](/EvoLinkAI/multi-summarize-skill-for-openclaw/blob/main/README.tr.md) |
 [Русский](/EvoLinkAI/multi-summarize-skill-for-openclaw/blob/main/README.ru.md)

## Nedir

[EvoLink](https://evolink.ai?utm_source=github&utm_medium=readme&utm_campaign=multi-summarize-skill-for-openclaw?utm_source=github&utm_medium=skill&utm_campaign=summarize) tarafından desteklenen bir [OpenClaw](https://github.com/openclaw/openclaw) becerisi. Tek bir beceri yükleyin ve AI ajanınız URL'ler, PDF'ler, videolar, ses dosyaları, YouTube bağlantıları veya düz metin dahil her türlü içeriği — mevcut en güçlü metin modeli Claude Opus 4.6 kullanarak — özlü ve uygulanabilir kilit noktalara özetleyebilir.

🚀 [API Key Alın →](https://evolink.ai/signup?utm_source=github&utm_medium=readme&utm_campaign=multi-summarize-skill-for-openclaw?utm_source=github&utm_medium=skill&utm_campaign=summarize)

## Kurulum

### Hızlı Kurulum (Önerilen)

```bash
openclaw skills add https://github.com/EvoLinkAI/multi-summarize-skill-for-openclaw
```

Tamam. Beceri ajanınız için hazır.

### ClawHub Üzerinden

```bash
clawhub install multi-summarize
```

### Manuel Kurulum

```bash
git clone https://github.com/EvoLinkAI/multi-summarize-skill-for-openclaw.git
cd multi-summarize-skill-for-openclaw
openclaw skills add .
```

## API Key Alma

1. [Buradan](https://evolink.ai/signup?utm_source=github&utm_medium=readme&utm_campaign=multi-summarize-skill-for-openclaw?utm_source=github&utm_medium=skill&utm_campaign=summarize) kayıt olun
2. Dashboard → API Keys'e gidin
3. Yeni bir Key oluşturun
4. Ortam değişkenini ayarlayın:

```bash
export EVOLINK_API_KEY=your_key_here
```

Veya OpenClaw ajanınıza "EvoLink API key'imi ayarla..." deyin — gerisini o halleder.

## Kullanım

### Desteklenen Formatlar

- **Web URL'leri** — Makaleler, bloglar, dokümantasyon
- **PDF** — Raporlar, makaleler, teknik belgeler
- **Video** — mp4, webm, YouTube bağlantıları
- **Ses** — mp3, wav, m4a, podcast'ler
- **Metin** — Markdown, düz metin, kod dosyaları

### Kullanım Örnekleri

Ajanınızla doğal bir şekilde konuşun:

```
"Bu makaleyi özetle: https://evolink.ai/blog/deepseek-v4-release-window-prep?utm_source=github&utm_medium=readme&utm_campaign=multi-summarize"
"Bu PDF ne hakkında?" (dosya ekleyin)
"Bu YouTube videosunun kilit noktalarını ver: https://youtu.be/..."
"Bu podcast kaydını özetle" (mp3 ekleyin)
"Bu belgenin TL;DR'ını ver"
```

### Script Referansı

Beceri, doğrudan komut satırı kullanımı için `scripts/summarize.sh` içerir:

```bash
# Web makalesini özetle
bash scripts/summarize.sh "https://evolink.ai/blog/deepseek-v4-release-window-prep?utm_source=github&utm_medium=readme&utm_campaign=multi-summarize"

# Yerel PDF'i özetle
bash scripts/summarize.sh "/path/to/report.pdf"

# YouTube videosunu özetle
bash scripts/summarize.sh "https://youtu.be/VIDEO_ID"

# Ses dosyasını özetle
bash scripts/summarize.sh "/path/to/podcast.mp3"

# Özel odakla özetle
bash scripts/summarize.sh "https://evolink.ai/blog/deepseek-v4-release-window-prep?utm_source=github&utm_medium=readme&utm_campaign=multi-summarize" "Yayın zaman çizelgesine odaklan"
```

### Örnek Çıktı

```
## TL;DR
DeepSeek V4, Ocak 2026'dan beri söylentilere konu olmasına rağmen Mart itibarıyla
hâlâ resmi olarak yayınlanmadı. Birden fazla öngörülen yayın penceresi geçti.
Modelin kodlamaya odaklanması ve HumanEval puanlarının %90 olması bekleniyor (doğrulanmamış).

## Kilit Noktalar
- Reuters, Ocak ayında DeepSeek'in Şubat 2026 için kodlama odaklı bir model planladığını bildirdi
- DeepSeek, Şubat ayında bağlam penceresini sessizce 128K'dan 1M token'a genişletti — muhtemelen V4 altyapı testi
- Doğrulanmamış benchmark'lar HumanEval %90, SWE-bench Verified %80+ iddia ediyor
- "V4 Lite" Mart ayında DeepSeek sitesinde göründü ancak resmi olarak hiç doğrulanmadı
- Birden fazla yayın penceresi (Şubat ortası, Ay Yeni Yılı, Mart başı) yayın olmadan geçti

## Önerilen Eylemler
- Resmi duyuruya kadar üretim iş yüklerini taşımayın
- Onaylanmış özellikler için DeepSeek'in resmi kanallarını izleyin
- API entegrasyonunu hazırlayın — EvoLink ilk günden V4'ü destekleyecek
```

## Yapılandırma

Varsayılan model: `claude-opus-4-6` (ek yapılandırma gerekmez).

Farklı bir model kullanmak için:

```bash
export EVOLINK_MODEL="claude-sonnet-4-5-20250929"
```

### Mevcut Modeller

**Claude Serisi** (Anthropic API formatı — `/v1/messages`)
- **claude-opus-4-6** — En yüksek kalite (varsayılan)
- **claude-sonnet-4-6** — En yeni Sonnet, hızlı + güçlü
- **claude-sonnet-4-5-20250929** — Hızlı + uygun maliyetli
- **claude-haiku-4-5-20251001** — Ultra hızlı, hafif görevler

**GPT Serisi** (OpenAI API formatı — `/v1/chat/completions`)
- **gpt-5.4** — OpenAI'ın en yeni amiral gemisi modeli
- **gpt-4o** — Çok modlu, hızlı
- **gpt-4o-mini** — Hafif, uygun maliyetli

**Gemini Serisi** (OpenAI API formatı — `/v1/chat/completions`)
- **gemini-3.1-flash-lite-preview** — Google'ın ultra hızlı hafif modeli
- **gemini-3-flash-preview** — Hızlı, özetleme için ideal

### API Referansı

Tam API dokümantasyonu [burada](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=summarize).

## Dosya Yapısı

```
.
├── README.md              # English
├── README.zh-CN.md        # 简体中文
├── README.ja.md           # 日本語
├── README.ko.md           # 한국어
├── README.es.md           # Español
├── README.fr.md           # Français
├── README.de.md           # Deutsch
├── README.tr.md           # Türkçe
├── README.ru.md           # Русский
├── SKILL.md               # OpenClaw skill definition
├── references/
│   └── api-params.md      # Full API parameter docs
└── scripts/
    └── summarize.sh       # Summarization script
```

## Sorun Giderme

- **`python3: command not found`** — Python 3 yükleyin: `apt install python3` / `brew install python3`
- **`curl: command not found`** — curl yükleyin: `apt install curl` / `brew install curl`
- **`401 Unauthorized`** — [Kontrol panelinde](https://evolink.ai/dashboard?utm_source=github&utm_medium=readme&utm_campaign=multi-summarize-skill-for-openclaw?utm_source=github&utm_medium=skill&utm_campaign=summarize) EVOLINK_API_KEY'i kontrol edin
- **`402 Payment Required`** — [Kontrol panelinden](https://evolink.ai/dashboard?utm_source=github&utm_medium=readme&utm_campaign=multi-summarize-skill-for-openclaw?utm_source=github&utm_medium=skill&utm_campaign=summarize) bakiye yükleyin
- **PDF çıkarma başarısız** — markitdown yükleyin: `pip install markitdown` veya poppler: `apt install poppler-utils`
- **YouTube çıkarma başarısız** — yt-dlp yükleyin: `pip install yt-dlp`
- **Ses transkripsiyonu başarısız** — whisper yükleyin: `pip install openai-whisper`

## Bağlantılar

- [ClawHub](https://clawhub.ai/EvoLinkAI/multi-summarize)
- [API Reference](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=summarize)
- [Community](https://discord.com/invite/5mGHfA24kn)
- [Support](mailto:support@evolink.ai)

## Lisans

MIT
