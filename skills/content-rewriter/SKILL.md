---
name: Content Rewriter
description: Rewrite and optimize content for 8+ platforms with AI-powered tone adjustment, batch conversion, quality scoring, and translation. Powered by evolink.ai
version: 1.0.0
homepage: https://github.com/EvoLinkAI/content-rewriter-skill-for-openclaw
metadata: {"openclaw":{"homepage":"https://github.com/EvoLinkAI/content-rewriter-skill-for-openclaw","requires":{"bins":["python3","curl"],"env":["EVOLINK_API_KEY"]},"primaryEnv":"EVOLINK_API_KEY"}}
---

# Content Rewriter

Rewrite and optimize content for 8+ platforms with AI-powered tone adjustment, batch conversion, quality scoring, and translation — all from your terminal.

Powered by [Evolink.ai](https://evolink.ai?utm_source=clawhub&utm_medium=skill&utm_campaign=rewriter)

## When to Use

- User says "rewrite this for Twitter" or "make this a LinkedIn post"
- User wants to adapt content for a specific platform
- User says "make this more professional" or "change the tone"
- User wants to batch-convert content for multiple platforms at once
- User asks "how good is this content?" or "score this"
- User wants to translate content to another language

## Quick Start

### 1. Set your EvoLink API key

    export EVOLINK_API_KEY="your-key-here"

Get a free key: [evolink.ai/signup](https://evolink.ai/signup?utm_source=clawhub&utm_medium=skill&utm_campaign=rewriter)

### 2. Rewrite content

    bash scripts/rewriter.sh rewrite mypost.txt --platform twitter

    bash scripts/rewriter.sh rewrite mypost.txt --platform linkedin --tone professional

### 3. Batch rewrite for multiple platforms

    bash scripts/rewriter.sh batch mypost.txt --platforms twitter,linkedin,blog

## Capabilities

### Supported Platforms

| Platform | Char Limit | Style |
|----------|-----------|-------|
| `twitter` | 280 | Punchy hooks, hashtags, thread-ready |
| `linkedin` | 3000 | Professional storytelling, CTA |
| `blog` | Unlimited | SEO-optimized, H2/H3 structure |
| `email` | ~300 words | Scannable, clear subject line |
| `medium` | Unlimited | Narrative-driven, first-person |
| `reddit` | Unlimited | Honest tone, TL;DR, community-friendly |
| `producthunt` | ~500 words | Problem-solution, emoji bullets |
| `wechat` | ~1500 chars | Chinese, short paragraphs, mobile-first |

### Supported Tones

`professional` `casual` `humorous` `inspirational` `educational` `persuasive` `technical` `storytelling`

### AI Features

All features require `EVOLINK_API_KEY`. [Get one free](https://evolink.ai/signup?utm_source=clawhub&utm_medium=skill&utm_campaign=rewriter)

- **rewrite** — Rewrite content for a specific platform with optional tone
- **batch** — Generate versions for multiple platforms in one command
- **score** — AI quality analysis (readability, engagement, SEO, clarity, professionalism)
- **translate** — Translate content while preserving tone and structure

## Commands

| Command | Description |
|---------|-------------|
| `bash scripts/rewriter.sh platforms` | List all supported platforms |
| `bash scripts/rewriter.sh tones` | List all supported tones |
| `bash scripts/rewriter.sh rewrite <file> --platform <p> [--tone <t>]` | Rewrite for a platform |
| `bash scripts/rewriter.sh batch <file> --platforms <p1,p2,...>` | Batch rewrite |
| `bash scripts/rewriter.sh score <file>` | AI quality score |
| `bash scripts/rewriter.sh translate <file> --lang <language>` | Translate content |

## Example

User: "Rewrite my blog post for Twitter and LinkedIn"

    bash scripts/rewriter.sh batch blogpost.md --platforms twitter,linkedin

Output:

    --- twitter ---
    The future of AI isn't about replacing humans.

    It's about giving every developer superpowers.

    Here's what I learned building with Claude for 6 months: [thread]

    #AI #DevTools #Claude
    ---

    --- linkedin ---
    6 months ago, I started an experiment.

    I wanted to see if AI could genuinely make me a better developer
    — not just faster, but better.

    Here's what I found...

    [Full LinkedIn post with story arc and CTA]
    ---

## Configuration

| Variable | Default | Required | Description |
|---|---|---|---|
| `EVOLINK_API_KEY` | — | Yes | Your EvoLink API key. [Get one free](https://evolink.ai/signup?utm_source=clawhub&utm_medium=skill&utm_campaign=rewriter) |
| `EVOLINK_MODEL` | `claude-opus-4-6` | No | Model for AI processing |

Required binaries: `python3`, `curl`

## Security

**Data Transmission**

All AI commands send your content text to `api.evolink.ai` for processing by Claude. By setting `EVOLINK_API_KEY` and using these commands, you consent to this transmission. Data is not stored after the response is returned. The `platforms` and `tones` commands run locally and never transmit data.

**Network Access**

- `api.evolink.ai` — AI content rewriting (all AI commands)

**Persistence & Privilege**

This skill creates temporary files for API payload construction which are cleaned up automatically. No credentials or persistent data are stored.

## Links

- [GitHub](https://github.com/EvoLinkAI/content-rewriter-skill-for-openclaw)
- [EvoLink API](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=clawhub&utm_medium=skill&utm_campaign=rewriter)
- [Community](https://discord.com/invite/5mGHfA24kn)
- [Support](mailto:support@evolink.ai)
