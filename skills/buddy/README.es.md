# Buddy Skill — Destila a tu compañero ideal en IA

> *Todo puede ser un compañero.*

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![EvoLink](https://img.shields.io/badge/Powered%20by-EvoLink-blue)](https://evolink.ai?utm_source=github&utm_medium=skill&utm_campaign=buddy)

Proporciona materiales de tu compañero (historial de WeChat, mensajes QQ, capturas de redes sociales, fotos) o simplemente describe a tu compañero ideal — genera un **AI Skill que habla como ellos**.

[EvoLink API](https://evolink.ai?utm_source=github&utm_medium=skill&utm_campaign=buddy)

**Language / Idioma:**
[English](README.md) | [简体中文](README.zh-CN.md) | [日本語](README.ja.md) | [한국어](README.ko.md) | [Español](README.es.md) | [Français](README.fr.md) | [Deutsch](README.de.md) | [Türkçe](README.tr.md) | [Русский](README.ru.md)

## Instalación

```bash
mkdir -p .claude/skills
git clone https://github.com/EvoLinkAI/buddy-skill-for-openclaw .claude/skills/create-buddy
export EVOLINK_API_KEY="your-key-here"
```

Obtén una clave gratis: [evolink.ai/signup](https://evolink.ai/signup?utm_source=github&utm_medium=skill&utm_campaign=buddy)

## Uso

En Claude Code, escribe `/create-buddy`. Responde 3 preguntas, importa datos (o imagina) y listo.

### Comandos

| Comando | Descripción |
|---------|-------------|
| `/create-buddy` | Crear nuevo compañero |
| `/list-buddies` | Listar todos |
| `/{slug}` | Chatear con compañero |
| `/{slug}-vibe` | Modo recuerdos |
| `/update-buddy {slug}` | Añadir memorias |
| `/delete-buddy {slug}` | Eliminar |

## Características

- Múltiples fuentes: WeChat, QQ, capturas, fotos, imaginación pura
- Tipos: compañero de comida, estudio, juegos, gym, viaje y más
- Arquitectura de dos capas: Vibe Memory + Persona
- Evolución: añadir memorias, corregir respuestas, historial de versiones
- Análisis IA: EvoLink API (modelos Claude)

## Enlaces

- [ClawHub](https://clawhub.ai/evolinkai/buddy-skill-creator)
- [EvoLink API](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=buddy)
- [Comunidad](https://discord.com/invite/5mGHfA24kn)

MIT License © [EvoLinkAI](https://github.com/EvoLinkAI)
