# Slack Assistant — OpenClaw Skill for Claude Code

Slack API integration with smart AI features — send messages, read channels, search conversations, and manage workspaces with Claude-powered summarization and drafting. Powered by [evolink.ai](https://evolink.ai?utm_source=github&utm_medium=skill&utm_campaign=slack)

[What Is This?](#what-is-this) | [Install](#installation) | [Setup](#setup-guide) | [Usage](#usage) | [EvoLink](https://evolink.ai?utm_source=github&utm_medium=skill&utm_campaign=slack)

**Language / 语言:**
[English](README.md) | [简体中文](README.zh-CN.md) | [日本語](README.ja.md) | [한국어](README.ko.md) | [Español](README.es.md) | [Français](README.fr.md) | [Deutsch](README.de.md) | [Türkçe](README.tr.md) | [Русский](README.ru.md)

## What Is This?

An [OpenClaw](https://clawhub.ai) skill that connects Claude Code to your Slack workspace. Just tell Claude what you need:

- "Send a message to #general"
- "What's happening in #engineering?"
- "Summarize the last 50 messages in #product"
- "Draft a reply to that thread"

## Installation

### Option 1: ClawHub (Recommended)
```bash
npx clawhub install slack-assistant
```

### Option 2: npm
```bash
npx evolinkai-slack-assistant
```

### Option 3: Manual
```bash
git clone https://github.com/EvoLinkAI/slack-skill-for-openclaw.git
cp -r slack-skill-for-openclaw /path/to/your/skills/slack-assistant/
```

## Setup Guide

### 1. Create a Slack App

1. Go to [api.slack.com/apps](https://api.slack.com/apps)
2. Click **Create New App** > **From scratch**
3. Name your app and select your workspace
4. Go to **OAuth & Permissions** > **Bot Token Scopes**
5. Add these scopes:
   - `channels:read`, `channels:write`, `channels:history`, `channels:manage`
   - `chat:write`
   - `files:read`, `files:write`
   - `groups:read`, `groups:write`, `groups:history`
   - `im:read`, `im:write`, `im:history`
   - `mpim:read`, `mpim:write`, `mpim:history`
   - `search:read`
   - `users:read`, `users:read.email`
   - `reactions:read`, `reactions:write`
6. Click **Install to Workspace** and authorize
7. Copy the **Bot User OAuth Token** (starts with `xoxb-`)

### 2. Configure Credentials

```bash
# Create config directory
mkdir -p ~/.slack-skill

# Save your bot token
echo '{"bot_token": "xoxb-your-token-here"}' > ~/.slack-skill/credentials.json
chmod 600 ~/.slack-skill/credentials.json
```

### 3. (Optional) Enable AI Features

```bash
export EVOLINK_API_KEY="your-key-here"
```

Get a free API key at [evolink.ai/signup](https://evolink.ai/signup?utm_source=github&utm_medium=skill&utm_campaign=slack)

## Usage

### Core Operations

```bash
# List channels
bash scripts/slack.sh channels

# List recent messages
bash scripts/slack.sh list "#general" 20

# Send a message
bash scripts/slack.sh send "#general" "Hello team!"
bash scripts/slack.sh send "@alice" "Hey, quick question..."

# Search messages
bash scripts/slack.sh search "deployment"

# View a thread
bash scripts/slack.sh read CHANNEL_ID 1234567890.123456

# Reply in a thread
bash scripts/slack.sh reply CHANNEL_ID 1234567890.123456 "Thanks!"
```

### AI Features

```bash
# Summarize channel activity
bash scripts/slack.sh ai-summary "#engineering" 50

# Draft a reply
bash scripts/slack.sh ai-reply CHANNEL_ID 1234567890.123456

# Prioritize messages by importance
bash scripts/slack.sh ai-prioritize "#general" 30
```

### Channel Management

```bash
# Create a channel
bash scripts/slack.sh create-channel "new-project" --private

# Invite a user
bash scripts/slack.sh invite "#new-project" "@alice"

# Upload a file
bash scripts/slack.sh upload "#general" ./report.pdf
```

## Configuration

| Variable | Default | Description |
|---|---|---|
| `SLACK_SKILL_DIR` | `~/.slack-skill` | Config directory |
| `EVOLINK_API_KEY` | — | API key for AI features ([get one](https://evolink.ai/signup?utm_source=github&utm_medium=skill&utm_campaign=slack)) |
| `EVOLINK_MODEL` | `claude-opus-4-6` | AI model ([docs](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=slack)) |

## Links

- [ClawHub](https://clawhub.ai/EvoLinkAI/slack-assistant)
- [Slack API Reference](https://api.slack.com/methods)
- [EvoLink API](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=slack)
- [Community](https://discord.com/invite/5mGHfA24kn)
- [Support](mailto:support@evolink.ai)

## License

MIT
