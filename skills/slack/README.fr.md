# Slack Assistant — Skill OpenClaw pour Claude Code

Intégration de l'API Slack avec des fonctionnalités IA intelligentes — envoyez des messages, lisez les canaux, recherchez des conversations et gérez vos espaces de travail avec des résumés et des brouillons propulsés par Claude. Développé par [evolink.ai](https://evolink.ai?utm_source=github&utm_medium=skill&utm_campaign=slack)

[Qu'est-ce que c'est ?](#quest-ce-que-cest) | [Installation](#installation) | [Configuration](#guide-de-configuration) | [Utilisation](#utilisation) | [EvoLink](https://evolink.ai?utm_source=github&utm_medium=skill&utm_campaign=slack)

**Language / Langue :**
[English](README.md) | [简体中文](README.zh-CN.md) | [日本語](README.ja.md) | [한국어](README.ko.md) | [Español](README.es.md) | [Français](README.fr.md) | [Deutsch](README.de.md) | [Türkçe](README.tr.md) | [Русский](README.ru.md)

## Qu'est-ce que c'est ?

Un skill [OpenClaw](https://clawhub.ai) qui connecte Claude Code à votre espace de travail Slack. Dites simplement à Claude ce dont vous avez besoin :

- « Envoie un message sur #general »
- « Que se passe-t-il dans #engineering ? »
- « Résume les 50 derniers messages de #product »
- « Rédige une réponse à ce fil »

## Installation

### Option 1 : ClawHub (Recommandé)
```bash
npx clawhub install slack-assistant
```

### Option 2 : npm
```bash
npx evolinkai-slack-assistant
```

### Option 3 : Manuel
```bash
git clone https://github.com/EvoLinkAI/slack-skill-for-openclaw.git
cp -r slack-skill-for-openclaw /path/to/your/skills/slack-assistant/
```

## Guide de Configuration

### 1. Créer une application Slack

1. Allez sur [api.slack.com/apps](https://api.slack.com/apps)
2. Cliquez sur **Create New App** > **From scratch**
3. Nommez votre application et sélectionnez votre espace de travail
4. Allez dans **OAuth & Permissions** > **Bot Token Scopes**
5. Ajoutez ces portées :
   - `channels:read`, `channels:write`, `channels:history`, `channels:manage`
   - `chat:write`
   - `files:read`, `files:write`
   - `groups:read`, `groups:write`, `groups:history`
   - `im:read`, `im:write`, `im:history`
   - `mpim:read`, `mpim:write`, `mpim:history`
   - `search:read`
   - `users:read`, `users:read.email`
   - `reactions:read`, `reactions:write`
6. Cliquez sur **Install to Workspace** et autorisez
7. Copiez le **Bot User OAuth Token** (commence par `xoxb-`)

### 2. Configurer les identifiants

```bash
mkdir -p ~/.slack-skill
echo '{"bot_token": "xoxb-your-token-here"}' > ~/.slack-skill/credentials.json
chmod 600 ~/.slack-skill/credentials.json
```

### 3. (Optionnel) Activer les fonctionnalités IA

```bash
export EVOLINK_API_KEY="your-key-here"
```

Obtenez une clé API gratuite sur [evolink.ai/signup](https://evolink.ai/signup?utm_source=github&utm_medium=skill&utm_campaign=slack)

## Utilisation

### Opérations de base

```bash
bash scripts/slack.sh channels
bash scripts/slack.sh list "#general" 20
bash scripts/slack.sh send "#general" "Bonjour l'équipe !"
bash scripts/slack.sh search "déploiement"
bash scripts/slack.sh read CHANNEL_ID 1234567890.123456
bash scripts/slack.sh reply CHANNEL_ID 1234567890.123456 "Merci !"
```

### Fonctionnalités IA

```bash
bash scripts/slack.sh ai-summary "#engineering" 50
bash scripts/slack.sh ai-reply CHANNEL_ID 1234567890.123456
bash scripts/slack.sh ai-prioritize "#general" 30
```

### Gestion des canaux

```bash
bash scripts/slack.sh create-channel "new-project" --private
bash scripts/slack.sh invite "#new-project" "@alice"
bash scripts/slack.sh upload "#general" ./report.pdf
```

## Configuration

| Variable | Par défaut | Description |
|---|---|---|
| `SLACK_SKILL_DIR` | `~/.slack-skill` | Répertoire de configuration |
| `EVOLINK_API_KEY` | — | Clé API pour les fonctionnalités IA ([obtenir](https://evolink.ai/signup?utm_source=github&utm_medium=skill&utm_campaign=slack)) |
| `EVOLINK_MODEL` | `claude-opus-4-6` | Modèle IA ([docs](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=slack)) |

## Liens

- [ClawHub](https://clawhub.ai/EvoLinkAI/slack-assistant)
- [Référence API Slack](https://api.slack.com/methods)
- [EvoLink API](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=slack)
- [Communauté](https://discord.com/invite/5mGHfA24kn)
- [Support](mailto:support@evolink.ai)

## Licence

MIT
