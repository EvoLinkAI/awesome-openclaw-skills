---
name: Slack Assistant
description: Slack API integration with smart AI features — send messages, read channels, search conversations, and manage workspaces with Claude-powered summarization and drafting. Powered by evolink.ai
---

# Slack Assistant

Send messages, read channels, search conversations, and manage your Slack workspace with AI-powered features. Summarize channels, draft replies, and prioritize important messages — all from your terminal.

Powered by [Evolink.ai](https://evolink.ai?utm_source=clawhub&utm_medium=skill&utm_campaign=slack)

## When to Use

- User says "send a Slack message", "post to #channel"
- User wants to read channel history or search messages
- User asks "what's happening in #general?" or "any important Slack messages?"
- User says "summarize #channel" or "what did I miss in Slack?"
- User wants to draft a professional Slack reply using AI
- User needs to create channels, invite members, or manage workspace

## Quick Start

### 1. Set up Slack OAuth credentials

```bash
# First time only — create Slack app and get credentials
bash scripts/slack-auth.sh setup

# Authorize your Slack workspace
bash scripts/slack-auth.sh login
```

### 2. Set your EvoLink API key (for AI features)

```bash
export EVOLINK_API_KEY="your-key-here"
```

### 3. Use Slack

```bash
# List recent messages in a channel
bash scripts/slack.sh list "#general"

# Send a message
bash scripts/slack.sh send "#general" "Hello team!"

# Search messages
bash scripts/slack.sh search "project update"
```

## Capabilities

### Core Operations
- **Send messages** — Post to channels or DMs with text, markdown, or blocks
- **Read channels** — Fetch message history from any channel
- **Search** — Find messages by keyword, user, or date range
- **Manage channels** — Create, archive, invite/remove members
- **File operations** — Upload and download files

### AI Features (Optional)
Requires `EVOLINK_API_KEY`. [Get one free](https://evolink.ai/signup?utm_source=clawhub&utm_medium=skill&utm_campaign=slack)

- **ai-summary** — Summarize channel activity with key points
- **ai-reply** — Generate professional reply suggestions
- **ai-prioritize** — Rank messages by importance

## Commands

### Basic Operations

```bash
# List channels
bash scripts/slack.sh channels

# List recent messages (default: 10)
bash scripts/slack.sh list "#channel-name" [limit]

# Send message
bash scripts/slack.sh send "#channel" "Message text"
bash scripts/slack.sh send "@username" "Direct message"

# Search messages
bash scripts/slack.sh search "keyword" [--channel "#name"] [--from "@user"]

# Get message details
bash scripts/slack.sh read CHANNEL_ID TIMESTAMP
```

### AI Operations

```bash
# Summarize channel (last 50 messages)
bash scripts/slack.sh ai-summary "#channel-name" [limit]

# Generate reply suggestion
bash scripts/slack.sh ai-reply CHANNEL_ID TIMESTAMP

# Prioritize messages by importance
bash scripts/slack.sh ai-prioritize "#channel-name" [limit]
```

### Channel Management

```bash
# Create channel
bash scripts/slack.sh create-channel "channel-name" [--private]

# Invite user to channel
bash scripts/slack.sh invite "#channel" "@user"

# Archive channel
bash scripts/slack.sh archive "#channel"
```

## Example

User: "Summarize what happened in #engineering today"

```bash
bash scripts/slack.sh ai-summary "#engineering" 30
```

Output:
```
📊 Channel Summary: #engineering (30 messages)

Key Topics:
• Database migration completed successfully (5 messages)
• New API endpoint deployed to staging (3 messages)
• Code review requested for PR #234 (2 messages)

Action Items:
• @alice to review performance metrics
• @bob needs approval on deployment plan

Sentiment: Positive, productive discussions
```

## Configuration

| Variable | Default | Required | Description |
|---|---|---|---|
| `SLACK_SKILL_DIR` | `~/.slack-skill` | No | Directory for credentials and cache |
| `EVOLINK_API_KEY` | — | Optional (AI) | Your EvoLink API key for AI features. [Get one free](https://evolink.ai/signup?utm_source=clawhub&utm_medium=skill&utm_campaign=slack) |
| `EVOLINK_MODEL` | `claude-opus-4-6` | No | Model for AI processing. [EvoLink API](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=clawhub&utm_medium=skill&utm_campaign=slack) |

Required binaries: `python3`, `curl`

## Security

**Important: Data Consent for AI Features**

AI commands (`ai-summary`, `ai-reply`, `ai-prioritize`) transmit message content, sender names, and channel information to `api.evolink.ai` for processing by Claude. By setting `EVOLINK_API_KEY` and using these commands, you explicitly consent to this transmission. Data is not stored after the response is returned. Core Slack operations never transmit data to any third party.

**Network Access**

- `api.slack.com` — All Slack API operations
- `slack.com` — OAuth authorization flow
- `api.evolink.ai` — AI features only (optional)

**Persistence & Privilege**

This skill stores OAuth tokens in `~/.slack-skill/token.json` (mode 600). No elevated or persistent privileges are requested.

## Links

- [GitHub](https://github.com/EvoLinkAI/slack-skill-for-openclaw)
- [Slack API Reference](https://api.slack.com/methods)
- [EvoLink API](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=clawhub&utm_medium=skill&utm_campaign=slack)
- [Community](https://discord.com/invite/5mGHfA24kn)
- [Support](mailto:support@evolink.ai)
