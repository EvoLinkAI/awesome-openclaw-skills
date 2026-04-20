# Slack Assistant — Skill OpenClaw para Claude Code

Integración con la API de Slack con funciones de IA inteligentes — envía mensajes, lee canales, busca conversaciones y gestiona espacios de trabajo con resúmenes y borradores impulsados por Claude. Desarrollado por [evolink.ai](https://evolink.ai?utm_source=github&utm_medium=skill&utm_campaign=slack)

[¿Qué es esto?](#qué-es-esto) | [Instalación](#instalación) | [Configuración](#guía-de-configuración) | [Uso](#uso) | [EvoLink](https://evolink.ai?utm_source=github&utm_medium=skill&utm_campaign=slack)

**Language / Idioma:**
[English](README.md) | [简体中文](README.zh-CN.md) | [日本語](README.ja.md) | [한국어](README.ko.md) | [Español](README.es.md) | [Français](README.fr.md) | [Deutsch](README.de.md) | [Türkçe](README.tr.md) | [Русский](README.ru.md)

## ¿Qué es esto?

Un skill de [OpenClaw](https://clawhub.ai) que conecta Claude Code a tu espacio de trabajo de Slack. Solo dile a Claude lo que necesitas:

- "Envía un mensaje a #general"
- "¿Qué está pasando en #engineering?"
- "Resume los últimos 50 mensajes de #product"
- "Redacta una respuesta a ese hilo"

## Instalación

### Opción 1: ClawHub (Recomendado)
```bash
npx clawhub install slack-assistant
```

### Opción 2: npm
```bash
npx evolinkai-slack-assistant
```

### Opción 3: Manual
```bash
git clone https://github.com/EvoLinkAI/slack-skill-for-openclaw.git
cp -r slack-skill-for-openclaw /path/to/your/skills/slack-assistant/
```

## Guía de Configuración

### 1. Crear una aplicación de Slack

1. Ve a [api.slack.com/apps](https://api.slack.com/apps)
2. Haz clic en **Create New App** > **From scratch**
3. Nombra tu aplicación y selecciona tu espacio de trabajo
4. Ve a **OAuth & Permissions** > **Bot Token Scopes**
5. Añade estos permisos:
   - `channels:read`, `channels:write`, `channels:history`, `channels:manage`
   - `chat:write`
   - `files:read`, `files:write`
   - `groups:read`, `groups:write`, `groups:history`
   - `im:read`, `im:write`, `im:history`
   - `mpim:read`, `mpim:write`, `mpim:history`
   - `search:read`
   - `users:read`, `users:read.email`
   - `reactions:read`, `reactions:write`
6. Haz clic en **Install to Workspace** y autoriza
7. Copia el **Bot User OAuth Token** (empieza con `xoxb-`)

### 2. Configurar credenciales

```bash
mkdir -p ~/.slack-skill
echo '{"bot_token": "xoxb-your-token-here"}' > ~/.slack-skill/credentials.json
chmod 600 ~/.slack-skill/credentials.json
```

### 3. (Opcional) Activar funciones de IA

```bash
export EVOLINK_API_KEY="your-key-here"
```

Obtén una clave API gratuita en [evolink.ai/signup](https://evolink.ai/signup?utm_source=github&utm_medium=skill&utm_campaign=slack)

## Uso

### Operaciones básicas

```bash
bash scripts/slack.sh channels
bash scripts/slack.sh list "#general" 20
bash scripts/slack.sh send "#general" "¡Hola equipo!"
bash scripts/slack.sh search "despliegue"
bash scripts/slack.sh read CHANNEL_ID 1234567890.123456
bash scripts/slack.sh reply CHANNEL_ID 1234567890.123456 "¡Gracias!"
```

### Funciones de IA

```bash
bash scripts/slack.sh ai-summary "#engineering" 50
bash scripts/slack.sh ai-reply CHANNEL_ID 1234567890.123456
bash scripts/slack.sh ai-prioritize "#general" 30
```

### Gestión de canales

```bash
bash scripts/slack.sh create-channel "new-project" --private
bash scripts/slack.sh invite "#new-project" "@alice"
bash scripts/slack.sh upload "#general" ./report.pdf
```

## Configuración

| Variable | Predeterminado | Descripción |
|---|---|---|
| `SLACK_SKILL_DIR` | `~/.slack-skill` | Directorio de configuración |
| `EVOLINK_API_KEY` | — | Clave API para funciones de IA ([obtener](https://evolink.ai/signup?utm_source=github&utm_medium=skill&utm_campaign=slack)) |
| `EVOLINK_MODEL` | `claude-opus-4-6` | Modelo de IA ([docs](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=slack)) |

## Enlaces

- [ClawHub](https://clawhub.ai/EvoLinkAI/slack-assistant)
- [Referencia API de Slack](https://api.slack.com/methods)
- [EvoLink API](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=slack)
- [Comunidad](https://discord.com/invite/5mGHfA24kn)
- [Soporte](mailto:support@evolink.ai)

## Licencia

MIT
