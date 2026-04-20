# YouTube Assistant — Yapay Zeka ile Video Transkript ve Analiz

> *Daha akillica izle, daha uzun degil.*

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![EvoLink](https://img.shields.io/badge/Powered%20by-EvoLink-blue)](https://evolink.ai?utm_source=github&utm_medium=skill&utm_campaign=youtube)

YouTube video altyazilari, meta verileri ve kanal bilgilerini alin. Yapay zeka destekli icerik ozeti, kilit nokta cikarimi, coklu video karsilastirma ve video soru-cevap.

[EvoLink API](https://evolink.ai?utm_source=github&utm_medium=skill&utm_campaign=youtube)

**Language / Dil:**
[English](README.md) | [简体中文](README.zh-CN.md) | [日本語](README.ja.md) | [한국어](README.ko.md) | [Español](README.es.md) | [Français](README.fr.md) | [Deutsch](README.de.md) | [Türkçe](README.tr.md) | [Русский](README.ru.md)

## Kurulum

```bash
# yt-dlp yukle (gerekli)
pip install yt-dlp

# Skill'i yukle
mkdir -p .claude/skills
git clone https://github.com/EvoLinkAI/youtube-skill-for-openclaw .claude/skills/youtube-assistant
export EVOLINK_API_KEY="your-key-here"
```

Ucretsiz API anahtari: [evolink.ai/signup](https://evolink.ai/signup?utm_source=github&utm_medium=skill&utm_campaign=youtube)

## Kullanim

```bash
# Video transkript al
bash scripts/youtube.sh transcript "https://www.youtube.com/watch?v=VIDEO_ID"

# Video meta verileri al
bash scripts/youtube.sh info "https://www.youtube.com/watch?v=VIDEO_ID"

# Yapay zeka video ozeti
bash scripts/youtube.sh ai-summary "https://www.youtube.com/watch?v=VIDEO_ID"
```

### Komutlar

| Komut | Aciklama |
|-------|----------|
| `transcript <URL> [--lang]` | Temizlenmis video transkripti |
| `info <URL>` | Video meta verileri |
| `channel <URL> [limit]` | Kanal videolarini listele |
| `search <query> [limit]` | YouTube'da ara |
| `ai-summary <URL>` | Yapay zeka video ozeti |
| `ai-takeaways <URL>` | Kilit noktalar ve eylemler |
| `ai-compare <URL1> <URL2>` | Birden fazla video karsilastir |
| `ai-ask <URL> <question>` | Video icerigi hakkinda soru sor |

## Ozellikler

- Her videodan altyazi cikarimi (manuel + otomatik olusturulan)
- Meta veriler: baslik, sure, goruntulenme, begeni, aciklama, etiketler
- Kanal gezinme ve YouTube arama
- Yapay zeka: ozet, nokta cikarimi, video karsilastirma, S&C
- Cok dilli altyazi destegi
- EvoLink API entegrasyonu (Claude modelleri)

## Baglantilar

- [ClawHub](https://clawhub.ai/evolinkai/youtube-assistant)
- [EvoLink API](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=youtube)
- [Topluluk](https://discord.com/invite/5mGHfA24kn)

MIT License © [EvoLinkAI](https://github.com/EvoLinkAI)
