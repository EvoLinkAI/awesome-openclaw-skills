# YouTube Assistant — Transkripte und Videoanalyse mit KI

> *Schlauer schauen, nicht langer.*

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![EvoLink](https://img.shields.io/badge/Powered%20by-EvoLink-blue)](https://evolink.ai?utm_source=github&utm_medium=skill&utm_campaign=youtube)

YouTube-Video-Transkripte, Metadaten und Kanalinformationen abrufen. KI-gestutzte Inhaltszusammenfassung, Kernpunkte-Extraktion, Multi-Video-Vergleich und Video-Q&A.

[EvoLink API](https://evolink.ai?utm_source=github&utm_medium=skill&utm_campaign=youtube)

**Language / Sprache:**
[English](README.md) | [简体中文](README.zh-CN.md) | [日本語](README.ja.md) | [한국어](README.ko.md) | [Español](README.es.md) | [Français](README.fr.md) | [Deutsch](README.de.md) | [Türkçe](README.tr.md) | [Русский](README.ru.md)

## Installation

```bash
# yt-dlp installieren (erforderlich)
pip install yt-dlp

# Skill installieren
mkdir -p .claude/skills
git clone https://github.com/EvoLinkAI/youtube-skill-for-openclaw .claude/skills/youtube-assistant
export EVOLINK_API_KEY="your-key-here"
```

Kostenloser API-Schlussel: [evolink.ai/signup](https://evolink.ai/signup?utm_source=github&utm_medium=skill&utm_campaign=youtube)

## Nutzung

```bash
# Video-Transkript abrufen
bash scripts/youtube.sh transcript "https://www.youtube.com/watch?v=VIDEO_ID"

# Video-Metadaten abrufen
bash scripts/youtube.sh info "https://www.youtube.com/watch?v=VIDEO_ID"

# KI-Videozusammenfassung
bash scripts/youtube.sh ai-summary "https://www.youtube.com/watch?v=VIDEO_ID"
```

### Befehle

| Befehl | Beschreibung |
|--------|-------------|
| `transcript <URL> [--lang]` | Bereinigtes Video-Transkript |
| `info <URL>` | Video-Metadaten |
| `channel <URL> [limit]` | Kanal-Videos auflisten |
| `search <query> [limit]` | YouTube durchsuchen |
| `ai-summary <URL>` | KI-Videozusammenfassung |
| `ai-takeaways <URL>` | Kernpunkte und Aktionen |
| `ai-compare <URL1> <URL2>` | Mehrere Videos vergleichen |
| `ai-ask <URL> <question>` | Fragen zum Videoinhalt |

## Funktionen

- Untertitel-Extraktion aus jedem Video (manuell + automatisch generiert)
- Metadaten: Titel, Dauer, Aufrufe, Likes, Beschreibung, Tags
- Kanal-Browsing und YouTube-Suche
- KI: Zusammenfassung, Punkteextraktion, Videovergleich, Q&A
- Mehrsprachige Untertitel-Unterstutzung
- EvoLink API Integration (Claude-Modelle)

## Links

- [ClawHub](https://clawhub.ai/evolinkai/youtube-assistant)
- [EvoLink API](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=youtube)
- [Community](https://discord.com/invite/5mGHfA24kn)

MIT License © [EvoLinkAI](https://github.com/EvoLinkAI)
