# Buddy Skill — İdeal Arkadaşınızı Yapay Zekaya Damıtın

> *Her şey bir arkadaş olabilir.*

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![EvoLink](https://img.shields.io/badge/Powered%20by-EvoLink-blue)](https://evolink.ai?utm_source=github&utm_medium=skill&utm_campaign=buddy)

Arkadaşınızın materyallerini sağlayın (WeChat geçmişi, QQ mesajları, sosyal medya ekran görüntüleri, fotoğraflar) veya ideal arkadaşınızı tanımlayın — **onlar gibi konuşan bir AI Skill** oluşturun.

[EvoLink API](https://evolink.ai?utm_source=github&utm_medium=skill&utm_campaign=buddy)

**Language / Dil:**
[English](README.md) | [简体中文](README.zh-CN.md) | [日本語](README.ja.md) | [한국어](README.ko.md) | [Español](README.es.md) | [Français](README.fr.md) | [Deutsch](README.de.md) | [Türkçe](README.tr.md) | [Русский](README.ru.md)

## Kurulum

```bash
mkdir -p .claude/skills
git clone https://github.com/EvoLinkAI/buddy-skill-for-openclaw .claude/skills/create-buddy
export EVOLINK_API_KEY="your-key-here"
```

Ücretsiz anahtar: [evolink.ai/signup](https://evolink.ai/signup?utm_source=github&utm_medium=skill&utm_campaign=buddy)

## Kullanım

Claude Code'da `/create-buddy` yazın. 3 soruyu yanıtlayın, veri içe aktarın (veya hayal edin) ve hazır.

### Komutlar

| Komut | Açıklama |
|-------|----------|
| `/create-buddy` | Yeni arkadaş oluştur |
| `/list-buddies` | Tümünü listele |
| `/{slug}` | Arkadaşla sohbet |
| `/{slug}-vibe` | Anı modu |
| `/update-buddy {slug}` | Anı ekle |
| `/delete-buddy {slug}` | Sil |

## Özellikler

- Çoklu kaynak: WeChat, QQ, ekran görüntüleri, fotoğraflar, saf hayal gücü
- Türler: yemek arkadaşı, çalışma arkadaşı, oyun arkadaşı, spor arkadaşı ve daha fazlası
- İki katmanlı mimari: Vibe Memory + Persona
- Evrim: anı ekleme, yanıt düzeltme, sürüm geçmişi
- Yapay zeka analizi: EvoLink API (Claude modelleri)

## Bağlantılar

- [ClawHub](https://clawhub.ai/evolinkai/buddy-skill-creator)
- [EvoLink API](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=buddy)
- [Topluluk](https://discord.com/invite/5mGHfA24kn)

MIT License © [EvoLinkAI](https://github.com/EvoLinkAI)
