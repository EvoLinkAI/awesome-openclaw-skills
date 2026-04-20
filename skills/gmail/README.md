# Gmail Assistant — AI Email Skill for OpenClaw

Gmail API integration with AI-powered summarization, smart reply drafting, and inbox prioritization. Powered by [evolink.ai](https://evolink.ai?utm_source=github&utm_medium=skill&utm_campaign=gmail)

[What Is This?](#what-is-this) | [Install](#installation) | [Setup](#setup-guide) | [Usage](#usage) | [EvoLink](https://evolink.ai?utm_source=github&utm_medium=skill&utm_campaign=gmail)

**Language / 语言:**
[English](README.md) | [简体中文](README.zh-CN.md) | [日本語](README.ja.md) | [한국어](README.ko.md) | [Español](README.es.md) | [Français](README.fr.md) | [Deutsch](README.de.md) | [Türkçe](README.tr.md) | [Русский](README.ru.md)

## What Is This?

Gmail Assistant is an OpenClaw skill that connects your Gmail account to your AI agent. It provides full Gmail API access — read, send, search, label, archive — plus AI-powered features like inbox summarization, smart reply drafting, and email prioritization using Claude via EvoLink.

**Core Gmail operations work without any API key.** AI features (summarize, draft, prioritize) require an optional EvoLink API key.

[Get your free EvoLink API key](https://evolink.ai/signup?utm_source=github&utm_medium=skill&utm_campaign=gmail)

## Installation

### Quick Install

```bash
openclaw skills add https://github.com/EvoLinkAI/gmail-skill-for-openclaw
```

### Via ClawHub

```bash
npx clawhub install evolinkai/gmail
```

### Manual Install

```bash
git clone https://github.com/EvoLinkAI/gmail-skill-for-openclaw.git
cd gmail-skill-for-openclaw
```

## Setup Guide

### Step 1: Create Google OAuth Credentials

1. Go to [Google Cloud Console](https://console.cloud.google.com/)
2. Create a new project (or select existing)
3. Enable the **Gmail API**: APIs & Services > Library > search "Gmail API" > Enable
4. Configure OAuth consent screen: APIs & Services > OAuth consent screen > External > fill required fields
5. Create OAuth credentials: APIs & Services > Credentials > Create Credentials > OAuth client ID > **Desktop app**
6. Download the `credentials.json` file

### Step 2: Configure

```bash
mkdir -p ~/.gmail-skill
cp credentials.json ~/.gmail-skill/credentials.json
bash scripts/gmail-auth.sh setup
```

### Step 3: Authorize

```bash
bash scripts/gmail-auth.sh login
```

This opens a browser for Google OAuth consent. Tokens are stored locally at `~/.gmail-skill/token.json`.

### Step 4: Set EvoLink API Key (Optional — for AI features)

```bash
export EVOLINK_API_KEY="your-key-here"
```

[Get your API key](https://evolink.ai/signup?utm_source=github&utm_medium=skill&utm_campaign=gmail)

## Usage

### Core Commands

```bash
# List recent emails
bash scripts/gmail.sh list

# List with filter
bash scripts/gmail.sh list --query "is:unread" --max 20

# Read a specific email
bash scripts/gmail.sh read MESSAGE_ID

# Send an email
bash scripts/gmail.sh send "to@example.com" "Meeting tomorrow" "Hi, can we meet at 3pm?"

# Reply to an email
bash scripts/gmail.sh reply MESSAGE_ID "Thanks, I'll be there."

# Search emails
bash scripts/gmail.sh search "from:boss@company.com has:attachment"

# List labels
bash scripts/gmail.sh labels

# Add/remove label
bash scripts/gmail.sh label MESSAGE_ID +STARRED
bash scripts/gmail.sh label MESSAGE_ID -UNREAD

# Star / Archive / Trash
bash scripts/gmail.sh star MESSAGE_ID
bash scripts/gmail.sh archive MESSAGE_ID
bash scripts/gmail.sh trash MESSAGE_ID

# View full thread
bash scripts/gmail.sh thread THREAD_ID

# Account info
bash scripts/gmail.sh profile
```

### AI Commands (requires EVOLINK_API_KEY)

```bash
# Summarize unread emails
bash scripts/gmail.sh ai-summary

# Summarize with custom query
bash scripts/gmail.sh ai-summary --query "from:team@company.com after:2026/04/01" --max 15

# Draft an AI reply
bash scripts/gmail.sh ai-reply MESSAGE_ID "Politely decline and suggest next week"

# Prioritize inbox
bash scripts/gmail.sh ai-prioritize --max 30
```

### Example Output

```
Inbox Summary (5 unread emails):

1. [URGENT] Project deadline moved — from: manager@company.com
   The Q2 product launch deadline has been moved from April 15 to April 10.
   Action needed: Update sprint plan by tomorrow EOD.

2. Invoice #4521 — from: billing@vendor.com
   Monthly SaaS subscription invoice for $299. Due April 15.
   Action needed: Approve or forward to finance.

3. Team lunch Friday — from: hr@company.com
   Team building lunch at 12:30 PM Friday. RSVP requested.
   Action needed: Reply with attendance.

4. Newsletter: AI Weekly — from: newsletter@aiweekly.com
   Low priority. Weekly AI news roundup.
   Action needed: None.

5. GitHub notification — from: notifications@github.com
   PR #247 merged to main. CI passed.
   Action needed: None.
```

## Configuration

| Variable | Default | Required | Description |
|---|---|---|---|
| `credentials.json` | — | Yes (core) | Google OAuth client credentials. See [Setup Guide](#setup-guide) |
| `EVOLINK_API_KEY` | — | Optional (AI) | Your EvoLink API key for AI features. [Get one free](https://evolink.ai/signup?utm_source=github&utm_medium=skill&utm_campaign=gmail) |
| `EVOLINK_MODEL` | `claude-opus-4-6` | No | Model for AI processing. Switch to any model supported by the [EvoLink API](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=gmail) |
| `GMAIL_SKILL_DIR` | `~/.gmail-skill` | No | Custom path for credential and token storage |

Required binaries: `python3`, `curl`

## Gmail Query Syntax

- `is:unread` — Unread messages
- `is:starred` — Starred messages
- `from:user@example.com` — From specific sender
- `to:user@example.com` — To specific recipient
- `subject:keyword` — Subject contains keyword
- `after:2026/01/01` — After date
- `before:2026/12/31` — Before date
- `has:attachment` — Has attachments
- `label:work` — Has specific label

## File Structure

```
.
├── README.md               # English (main)
├── README.zh-CN.md         # 简体中文
├── README.ja.md            # 日本語
├── README.ko.md            # 한국어
├── README.es.md            # Español
├── README.fr.md            # Français
├── README.de.md            # Deutsch
├── README.tr.md            # Türkçe
├── README.ru.md            # Русский
├── SKILL.md                # OpenClaw skill definition
├── _meta.json              # Skill metadata
├── LICENSE                 # MIT License
├── references/
│   └── api-params.md       # Gmail API parameter reference
└── scripts/
    ├── gmail-auth.sh       # OAuth authentication manager
    └── gmail.sh            # Gmail operations + AI features
```

## Troubleshooting

- **"Not authenticated"** — Run `bash scripts/gmail-auth.sh login` to authorize
- **"credentials.json not found"** — Download OAuth credentials from Google Cloud Console and place at `~/.gmail-skill/credentials.json`
- **"Token refresh failed"** — Your refresh token may have expired. Run `bash scripts/gmail-auth.sh login` again
- **"Set EVOLINK_API_KEY"** — AI features require an EvoLink API key. Core Gmail operations work without it
- **"Error 403: access_denied"** — Make sure Gmail API is enabled in your Google Cloud project and OAuth consent screen is configured
- **Token security** — Tokens are stored with `chmod 600` permissions. Only your user account can read them

## Links

- [ClawHub](https://clawhub.ai/EvoLinkAI/gmail-assistant)
- [API Reference](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=gmail)
- [Community](https://discord.com/invite/5mGHfA24kn)
- [Support](mailto:support@evolink.ai)

## License

MIT — see [LICENSE](LICENSE) for details.
