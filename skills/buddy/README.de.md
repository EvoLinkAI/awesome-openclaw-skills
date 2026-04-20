# Buddy Skill — Destilliere deinen idealen Kumpel in KI

> *Alles kann ein Kumpel sein.*

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![EvoLink](https://img.shields.io/badge/Powered%20by-EvoLink-blue)](https://evolink.ai?utm_source=github&utm_medium=skill&utm_campaign=buddy)

Liefere Materialien über deinen Kumpel (WeChat-Verlauf, QQ-Nachrichten, Social-Media-Screenshots, Fotos) oder beschreibe einfach deinen Traumkumpel — generiere ein **AI Skill, das wie sie spricht**.

[EvoLink API](https://evolink.ai?utm_source=github&utm_medium=skill&utm_campaign=buddy)

**Language / Sprache:**
[English](README.md) | [简体中文](README.zh-CN.md) | [日本語](README.ja.md) | [한국어](README.ko.md) | [Español](README.es.md) | [Français](README.fr.md) | [Deutsch](README.de.md) | [Türkçe](README.tr.md) | [Русский](README.ru.md)

## Installation

```bash
mkdir -p .claude/skills
git clone https://github.com/EvoLinkAI/buddy-skill-for-openclaw .claude/skills/create-buddy
export EVOLINK_API_KEY="your-key-here"
```

Kostenloser Schlüssel: [evolink.ai/signup](https://evolink.ai/signup?utm_source=github&utm_medium=skill&utm_campaign=buddy)

## Nutzung

In Claude Code `/create-buddy` eingeben. 3 Fragen beantworten, Daten importieren (oder vorstellen) und fertig.

### Befehle

| Befehl | Beschreibung |
|--------|-------------|
| `/create-buddy` | Neuen Kumpel erstellen |
| `/list-buddies` | Alle auflisten |
| `/{slug}` | Mit Kumpel chatten |
| `/{slug}-vibe` | Erinnerungsmodus |
| `/update-buddy {slug}` | Erinnerungen hinzufügen |
| `/delete-buddy {slug}` | Löschen |

## Funktionen

- Mehrere Quellen: WeChat, QQ, Screenshots, Fotos, reine Vorstellung
- Typen: Essenskumpel, Lernkumpel, Spielkumpel, Sportkumpel und mehr
- Zwei-Schichten-Architektur: Vibe Memory + Persona
- Evolution: Erinnerungen hinzufügen, Antworten korrigieren, Versionsverlauf
- KI-Analyse: EvoLink API (Claude-Modelle)

## Links

- [ClawHub](https://clawhub.ai/evolinkai/buddy-skill-creator)
- [EvoLink API](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=buddy)
- [Community](https://discord.com/invite/5mGHfA24kn)

MIT License © [EvoLinkAI](https://github.com/EvoLinkAI)
