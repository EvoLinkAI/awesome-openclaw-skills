---
name: Gmail Assistant
description: Gmail API integration with smart AI features — read, send, search, and manage emails with Claude-powered summarization and drafting. Powered by evolink.ai
---

# Gmail Assistant

Read, send, search, and manage Gmail with AI-powered features. Summarize inbox, draft replies, and manage labels — all from your terminal.

Powered by [Evolink.ai](https://evolink.ai?utm_source=clawhub&utm_medium=skill&utm_campaign=gmail)

## When to Use

- User says "check my email", "read my inbox", "any new emails?"
- User wants to send or reply to an email
- User asks to search emails by sender, subject, or date
- User says "summarize my unread emails" or "what's important in my inbox?"
- User wants to draft a professional reply using AI
- User needs to manage labels, star, archive, or trash messages

## Quick Start

### 1. Set up Google OAuth credentials

```bash
# First time only — create OAuth credentials
bash scripts/gmail-auth.sh setup

# Authorize your Gmail account
bash scripts/gmail-auth.sh login
```

### 2. Set your EvoLink API key (for AI features)

```bash
export EVOLINK_API_KEY="your-key-here"
```

### 3. Use Gmail

```bash
# List recent emails
bash scripts/gmail.sh list

# Read a specific email
bash scripts/gmail.sh read MESSAGE_ID

# Send an email
bash scripts/gmail.sh send "to@example.com" "Subject" "Body text"

# Search emails
bash scripts/gmail.sh search "from:boss@company.com is:unread"

# AI: Summarize unread emails
bash scripts/gmail.sh ai-summary

# AI: Draft a reply
bash scripts/gmail.sh ai-reply MESSAGE_ID "Please decline politely"
```

## Capabilities

- **List messages** — View recent inbox, filter by label or query
- **Read messages** — Get full message content with headers
- **Send messages** — Compose and send new emails
- **Reply** — Reply to existing threads
- **Search** — Gmail query syntax (from, to, subject, date, has:attachment)
- **Labels** — List, apply, and remove labels
- **Star / Archive / Trash** — Quick message management
- **Threads** — View full conversation threads
- **AI Summary** — Summarize unread or recent emails using Claude via EvoLink
- **AI Draft** — Generate professional reply drafts with AI assistance
- **AI Prioritize** — Rank emails by importance and urgency

## Example

User: "Summarize my unread emails from today"

```bash
bash scripts/gmail.sh ai-summary --query "is:unread after:2026/04/02"
```

Output:

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

## Setup Guide

### Step 1: Create Google Cloud OAuth Credentials

1. Go to [Google Cloud Console](https://console.cloud.google.com/)
2. Create a new project (or select existing)
3. Enable the **Gmail API**: APIs & Services > Library > search "Gmail API" > Enable
4. Create OAuth credentials: APIs & Services > Credentials > Create Credentials > OAuth client ID
5. Application type: **Desktop app**
6. Download the `credentials.json` file

### Step 2: Configure the Skill

```bash
# Place credentials file
mkdir -p ~/.gmail-skill
cp credentials.json ~/.gmail-skill/credentials.json

# Run first-time setup
bash scripts/gmail-auth.sh setup
```

### Step 3: Authorize

```bash
bash scripts/gmail-auth.sh login
```

This opens a browser window for Google OAuth consent. After authorization, tokens are stored locally at `~/.gmail-skill/token.json`.

## Configuration

| Variable | Default | Required | Description |
|---|---|---|---|
| `credentials.json` | — | Yes (core) | Google OAuth client credentials file at `~/.gmail-skill/credentials.json`. [Setup Guide](#setup-guide) |
| `EVOLINK_API_KEY` | — | Optional (AI) | Your EvoLink API key for AI features. [Get one free](https://evolink.ai/signup?utm_source=clawhub&utm_medium=skill&utm_campaign=gmail) |
| `EVOLINK_MODEL` | `claude-opus-4-6` | No | Model for AI processing. Switch to any model supported by the [EvoLink API](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=clawhub&utm_medium=skill&utm_campaign=gmail) |
| `GMAIL_SKILL_DIR` | `~/.gmail-skill` | No | Custom path for credential and token storage |

Required binaries: `python3`, `curl`

## Gmail Query Syntax

Use these operators with `search` and `ai-summary`:

- `is:unread` — Unread messages
- `is:starred` — Starred messages
- `from:user@example.com` — From specific sender
- `to:user@example.com` — To specific recipient
- `subject:keyword` — Subject contains keyword
- `after:2026/01/01` — After date
- `before:2026/12/31` — Before date
- `has:attachment` — Has attachments
- `label:work` — Has specific label
- `in:inbox` — In inbox

## Security

**Important: Data Consent for AI Features**

AI commands (`ai-summary`, `ai-reply`, `ai-prioritize`) transmit email content (subject, sender, body) to `api.evolink.ai` for processing by Claude. By setting `EVOLINK_API_KEY` and using these commands, you explicitly consent to this transmission. Data is not stored after the response is returned. If you handle sensitive or confidential emails, review [EvoLink's privacy policy](https://evolink.ai/privacy?utm_source=clawhub&utm_medium=skill&utm_campaign=gmail) before using AI features. Core Gmail operations (read, send, search, label) never transmit email content to any third party.

**Credentials & Storage**

Google OAuth credentials (`credentials.json`) and tokens (`token.json`) are stored locally at `~/.gmail-skill/`. Tokens are never transmitted to any third party. The skill accesses Gmail only through Google's official OAuth 2.0 flow and Gmail API endpoints (`gmail.googleapis.com`).

**AI Features (Optional)**

When AI features are used (summarize, draft, prioritize), email content is sent to `api.evolink.ai` for processing by Claude. Data is discarded after the response is returned. No email data is stored by EvoLink. Review [EvoLink's privacy policy](https://evolink.ai/privacy?utm_source=clawhub&utm_medium=skill&utm_campaign=gmail) before using AI features with sensitive emails.

`EVOLINK_API_KEY` is only required for AI features. Core Gmail operations (read, send, search, label) work without it.

**File Access Controls**

This skill only reads/writes within `~/.gmail-skill/` for credential and token storage. No other filesystem access is performed.

**Required binaries:** `python3`, `curl`

**Network Access**

- `gmail.googleapis.com` — Gmail API (core operations)
- `oauth2.googleapis.com` — OAuth token management
- `accounts.google.com` — OAuth consent flow
- `api.evolink.ai` — AI features only (optional)

**Persistence & Privilege**

This skill does not modify other skills or system settings. No elevated or persistent privileges are requested. OAuth tokens can be revoked at any time via `bash scripts/gmail-auth.sh revoke` or from [Google Account Settings](https://myaccount.google.com/permissions).

## Links

- [GitHub](https://github.com/EvoLinkAI/gmail-skill-for-openclaw)
- [API Reference](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=clawhub&utm_medium=skill&utm_campaign=gmail)
- [Community](https://discord.com/invite/5mGHfA24kn)
- [Support](mailto:support@evolink.ai)
