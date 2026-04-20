# Slack Assistant — OpenClaw Skill für Claude Code

Slack-API-Integration mit intelligenten KI-Funktionen — Nachrichten senden, Kanäle lesen, Gespräche durchsuchen und Arbeitsbereiche verwalten mit Claude-gestützter Zusammenfassung und Entwurfserstellung. Bereitgestellt von [evolink.ai](https://evolink.ai?utm_source=github&utm_medium=skill&utm_campaign=slack)

[Was ist das?](#was-ist-das) | [Installation](#installation) | [Einrichtung](#einrichtungsanleitung) | [Nutzung](#nutzung) | [EvoLink](https://evolink.ai?utm_source=github&utm_medium=skill&utm_campaign=slack)

**Language / Sprache:**
[English](README.md) | [简体中文](README.zh-CN.md) | [日本語](README.ja.md) | [한국어](README.ko.md) | [Español](README.es.md) | [Français](README.fr.md) | [Deutsch](README.de.md) | [Türkçe](README.tr.md) | [Русский](README.ru.md)

## Was ist das?

Ein [OpenClaw](https://clawhub.ai) Skill, der Claude Code mit Ihrem Slack-Arbeitsbereich verbindet. Sagen Sie Claude einfach, was Sie brauchen:

- „Sende eine Nachricht an #general"
- „Was passiert in #engineering?"
- „Fasse die letzten 50 Nachrichten in #product zusammen"
- „Erstelle einen Antwortentwurf für diesen Thread"

## Installation

### Option 1: ClawHub (Empfohlen)
```bash
npx clawhub install slack-assistant
```

### Option 2: npm
```bash
npx evolinkai-slack-assistant
```

### Option 3: Manuell
```bash
git clone https://github.com/EvoLinkAI/slack-skill-for-openclaw.git
cp -r slack-skill-for-openclaw /path/to/your/skills/slack-assistant/
```

## Einrichtungsanleitung

### 1. Slack-App erstellen

1. Gehen Sie zu [api.slack.com/apps](https://api.slack.com/apps)
2. Klicken Sie auf **Create New App** > **From scratch**
3. Benennen Sie Ihre App und wählen Sie Ihren Arbeitsbereich
4. Gehen Sie zu **OAuth & Permissions** > **Bot Token Scopes**
5. Fügen Sie diese Berechtigungen hinzu:
   - `channels:read`, `channels:write`, `channels:history`, `channels:manage`
   - `chat:write`
   - `files:read`, `files:write`
   - `groups:read`, `groups:write`, `groups:history`
   - `im:read`, `im:write`, `im:history`
   - `mpim:read`, `mpim:write`, `mpim:history`
   - `search:read`
   - `users:read`, `users:read.email`
   - `reactions:read`, `reactions:write`
6. Klicken Sie auf **Install to Workspace** und autorisieren Sie
7. Kopieren Sie das **Bot User OAuth Token** (beginnt mit `xoxb-`)

### 2. Zugangsdaten konfigurieren

```bash
mkdir -p ~/.slack-skill
echo '{"bot_token": "xoxb-your-token-here"}' > ~/.slack-skill/credentials.json
chmod 600 ~/.slack-skill/credentials.json
```

### 3. (Optional) KI-Funktionen aktivieren

```bash
export EVOLINK_API_KEY="your-key-here"
```

Holen Sie sich einen kostenlosen API-Schlüssel auf [evolink.ai/signup](https://evolink.ai/signup?utm_source=github&utm_medium=skill&utm_campaign=slack)

## Nutzung

### Grundoperationen

```bash
bash scripts/slack.sh channels
bash scripts/slack.sh list "#general" 20
bash scripts/slack.sh send "#general" "Hallo Team!"
bash scripts/slack.sh search "Deployment"
bash scripts/slack.sh read CHANNEL_ID 1234567890.123456
bash scripts/slack.sh reply CHANNEL_ID 1234567890.123456 "Danke!"
```

### KI-Funktionen

```bash
bash scripts/slack.sh ai-summary "#engineering" 50
bash scripts/slack.sh ai-reply CHANNEL_ID 1234567890.123456
bash scripts/slack.sh ai-prioritize "#general" 30
```

### Kanalverwaltung

```bash
bash scripts/slack.sh create-channel "new-project" --private
bash scripts/slack.sh invite "#new-project" "@alice"
bash scripts/slack.sh upload "#general" ./report.pdf
```

## Konfiguration

| Variable | Standard | Beschreibung |
|---|---|---|
| `SLACK_SKILL_DIR` | `~/.slack-skill` | Konfigurationsverzeichnis |
| `EVOLINK_API_KEY` | — | API-Schlüssel für KI-Funktionen ([holen](https://evolink.ai/signup?utm_source=github&utm_medium=skill&utm_campaign=slack)) |
| `EVOLINK_MODEL` | `claude-opus-4-6` | KI-Modell ([Docs](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=slack)) |

## Links

- [ClawHub](https://clawhub.ai/EvoLinkAI/slack-assistant)
- [Slack API Referenz](https://api.slack.com/methods)
- [EvoLink API](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=slack)
- [Community](https://discord.com/invite/5mGHfA24kn)
- [Support](mailto:support@evolink.ai)

## Lizenz

MIT
