# Buddy Skill — Destillez votre compagnon idéal en IA

> *Tout peut être un compagnon.*

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![EvoLink](https://img.shields.io/badge/Powered%20by-EvoLink-blue)](https://evolink.ai?utm_source=github&utm_medium=skill&utm_campaign=buddy)

Fournissez les matériaux de votre compagnon (historique WeChat, messages QQ, captures de réseaux sociaux, photos) ou décrivez simplement votre compagnon idéal — générez un **AI Skill qui parle comme eux**.

[EvoLink API](https://evolink.ai?utm_source=github&utm_medium=skill&utm_campaign=buddy)

**Language / Langue :**
[English](README.md) | [简体中文](README.zh-CN.md) | [日本語](README.ja.md) | [한국어](README.ko.md) | [Español](README.es.md) | [Français](README.fr.md) | [Deutsch](README.de.md) | [Türkçe](README.tr.md) | [Русский](README.ru.md)

## Installation

```bash
mkdir -p .claude/skills
git clone https://github.com/EvoLinkAI/buddy-skill-for-openclaw .claude/skills/create-buddy
export EVOLINK_API_KEY="your-key-here"
```

Clé gratuite : [evolink.ai/signup](https://evolink.ai/signup?utm_source=github&utm_medium=skill&utm_campaign=buddy)

## Utilisation

Dans Claude Code, tapez `/create-buddy`. Répondez à 3 questions, importez des données (ou imaginez) et c'est prêt.

### Commandes

| Commande | Description |
|----------|-------------|
| `/create-buddy` | Créer un nouveau compagnon |
| `/list-buddies` | Lister tous |
| `/{slug}` | Discuter avec le compagnon |
| `/{slug}-vibe` | Mode souvenirs |
| `/update-buddy {slug}` | Ajouter des souvenirs |
| `/delete-buddy {slug}` | Supprimer |

## Caractéristiques

- Sources multiples : WeChat, QQ, captures, photos, imagination pure
- Types : compagnon de repas, études, jeux, sport, voyage et plus
- Architecture à deux couches : Vibe Memory + Persona
- Évolution : ajouter des souvenirs, corriger les réponses, historique des versions
- Analyse IA : EvoLink API (modèles Claude)

## Liens

- [ClawHub](https://clawhub.ai/evolinkai/buddy-skill-creator)
- [EvoLink API](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=buddy)
- [Communauté](https://discord.com/invite/5mGHfA24kn)

MIT License © [EvoLinkAI](https://github.com/EvoLinkAI)
