# YouTube Assistant — Transcripciones y Analisis de Videos con IA

> *Mira mas inteligente, no mas largo.*

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![EvoLink](https://img.shields.io/badge/Powered%20by-EvoLink-blue)](https://evolink.ai?utm_source=github&utm_medium=skill&utm_campaign=youtube)

Obtiene transcripciones, metadatos e informacion de canales de YouTube. Resumen de contenido, extraccion de puntos clave, analisis comparativo de videos y preguntas sobre videos — todo impulsado por IA.

[EvoLink API](https://evolink.ai?utm_source=github&utm_medium=skill&utm_campaign=youtube)

**Language / Idioma:**
[English](README.md) | [简体中文](README.zh-CN.md) | [日本語](README.ja.md) | [한국어](README.ko.md) | [Español](README.es.md) | [Français](README.fr.md) | [Deutsch](README.de.md) | [Türkçe](README.tr.md) | [Русский](README.ru.md)

## Instalacion

```bash
# Instalar yt-dlp (requerido)
pip install yt-dlp

# Instalar Skill
mkdir -p .claude/skills
git clone https://github.com/EvoLinkAI/youtube-skill-for-openclaw .claude/skills/youtube-assistant
export EVOLINK_API_KEY="your-key-here"
```

Clave API gratis: [evolink.ai/signup](https://evolink.ai/signup?utm_source=github&utm_medium=skill&utm_campaign=youtube)

## Uso

```bash
# Obtener transcripcion del video
bash scripts/youtube.sh transcript "https://www.youtube.com/watch?v=VIDEO_ID"

# Obtener metadatos del video
bash scripts/youtube.sh info "https://www.youtube.com/watch?v=VIDEO_ID"

# Resumen IA del video
bash scripts/youtube.sh ai-summary "https://www.youtube.com/watch?v=VIDEO_ID"
```

### Comandos

| Comando | Descripcion |
|---------|-------------|
| `transcript <URL> [--lang]` | Transcripcion limpia del video |
| `info <URL>` | Metadatos del video |
| `channel <URL> [limit]` | Listar videos del canal |
| `search <query> [limit]` | Buscar en YouTube |
| `ai-summary <URL>` | Resumen IA del video |
| `ai-takeaways <URL>` | Puntos clave y acciones |
| `ai-compare <URL1> <URL2>` | Comparar multiples videos |
| `ai-ask <URL> <question>` | Preguntar sobre el contenido |

## Caracteristicas

- Extraccion de subtitulos de cualquier video (manuales + autogenerados)
- Metadatos: titulo, duracion, vistas, likes, descripcion, etiquetas
- Navegacion de canales y busqueda en YouTube
- IA: resumen, extraccion de puntos, comparacion, Q&A
- Soporte multilingue de subtitulos
- Integracion EvoLink API (modelos Claude)

## Enlaces

- [ClawHub](https://clawhub.ai/evolinkai/youtube-assistant)
- [EvoLink API](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=youtube)
- [Comunidad](https://discord.com/invite/5mGHfA24kn)

MIT License © [EvoLinkAI](https://github.com/EvoLinkAI)
