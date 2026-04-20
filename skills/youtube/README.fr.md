# YouTube Assistant — Transcriptions et Analyse de Videos par IA

> *Regardez plus intelligemment, pas plus longtemps.*

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![EvoLink](https://img.shields.io/badge/Powered%20by-EvoLink-blue)](https://evolink.ai?utm_source=github&utm_medium=skill&utm_campaign=youtube)

Recuperez les transcriptions, metadonnees et informations de chaines YouTube. Resume de contenu, extraction de points cles, analyse comparative de videos et questions sur le contenu — le tout propulse par l'IA.

[EvoLink API](https://evolink.ai?utm_source=github&utm_medium=skill&utm_campaign=youtube)

**Language / Langue :**
[English](README.md) | [简体中文](README.zh-CN.md) | [日本語](README.ja.md) | [한국어](README.ko.md) | [Español](README.es.md) | [Français](README.fr.md) | [Deutsch](README.de.md) | [Türkçe](README.tr.md) | [Русский](README.ru.md)

## Installation

```bash
# Installer yt-dlp (requis)
pip install yt-dlp

# Installer le Skill
mkdir -p .claude/skills
git clone https://github.com/EvoLinkAI/youtube-skill-for-openclaw .claude/skills/youtube-assistant
export EVOLINK_API_KEY="your-key-here"
```

Cle API gratuite : [evolink.ai/signup](https://evolink.ai/signup?utm_source=github&utm_medium=skill&utm_campaign=youtube)

## Utilisation

```bash
# Obtenir la transcription
bash scripts/youtube.sh transcript "https://www.youtube.com/watch?v=VIDEO_ID"

# Obtenir les metadonnees
bash scripts/youtube.sh info "https://www.youtube.com/watch?v=VIDEO_ID"

# Resume IA de la video
bash scripts/youtube.sh ai-summary "https://www.youtube.com/watch?v=VIDEO_ID"
```

### Commandes

| Commande | Description |
|----------|-------------|
| `transcript <URL> [--lang]` | Transcription nettoyee |
| `info <URL>` | Metadonnees de la video |
| `channel <URL> [limit]` | Lister les videos de la chaine |
| `search <query> [limit]` | Rechercher sur YouTube |
| `ai-summary <URL>` | Resume IA de la video |
| `ai-takeaways <URL>` | Points cles et actions |
| `ai-compare <URL1> <URL2>` | Comparer plusieurs videos |
| `ai-ask <URL> <question>` | Poser des questions sur le contenu |

## Caracteristiques

- Extraction de sous-titres de toute video (manuels + auto-generes)
- Metadonnees : titre, duree, vues, likes, description, tags
- Navigation de chaines et recherche YouTube
- IA : resume, extraction de points, comparaison, Q&R
- Support multilingue des sous-titres
- Integration EvoLink API (modeles Claude)

## Liens

- [ClawHub](https://clawhub.ai/evolinkai/youtube-assistant)
- [EvoLink API](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=youtube)
- [Communaute](https://discord.com/invite/5mGHfA24kn)

MIT License © [EvoLinkAI](https://github.com/EvoLinkAI)
