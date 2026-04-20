---
name: YouTube Assistant
description: Fetch YouTube video transcripts, metadata, and channel info with AI-powered summarization, key takeaway extraction, and multi-video analysis. Powered by evolink.ai
---

# YouTube Assistant

Fetch transcripts, metadata, and channel info from YouTube videos. Summarize content, extract key takeaways, compare multiple videos, and ask questions about video content — all from your terminal.

Powered by [Evolink.ai](https://evolink.ai?utm_source=clawhub&utm_medium=skill&utm_campaign=youtube)

## When to Use

- User says "watch this YouTube video", "summarize this video"
- User shares a YouTube URL and wants to understand the content
- User says "what are the key points in this video?"
- User wants to compare multiple videos or analyze a channel
- User asks a question about a YouTube video's content
- User says "get the transcript" or "video transcript"

## Quick Start

### 1. Install yt-dlp

macOS: `brew install yt-dlp`

Windows / Linux: `pip install yt-dlp`

### 2. Set your EvoLink API key (for AI features)

    export EVOLINK_API_KEY="your-key-here"

Get a free key: [evolink.ai/signup](https://evolink.ai/signup?utm_source=clawhub&utm_medium=skill&utm_campaign=youtube)

### 3. Use YouTube Assistant

Get video transcript:

    bash scripts/youtube.sh transcript "https://www.youtube.com/watch?v=VIDEO_ID"

Get video metadata:

    bash scripts/youtube.sh info "https://www.youtube.com/watch?v=VIDEO_ID"

AI-summarize a video:

    bash scripts/youtube.sh ai-summary "https://www.youtube.com/watch?v=VIDEO_ID"

## Capabilities

### Core Operations
- **Transcript** — Download and clean video subtitles (auto or manual)
- **Info** — Fetch title, duration, views, upload date, description, tags
- **Channel** — List recent videos from a channel
- **Search** — Search YouTube for videos by keyword

### AI Features (Optional)
Requires `EVOLINK_API_KEY`. [Get one free](https://evolink.ai/signup?utm_source=clawhub&utm_medium=skill&utm_campaign=youtube)

- **ai-summary** — Generate structured summary of video content
- **ai-takeaways** — Extract key takeaways and action items
- **ai-compare** — Compare content across multiple videos
- **ai-ask** — Ask questions about a video's content

## Commands

### Basic Operations

| Command | Description |
|---------|-------------|
| `bash scripts/youtube.sh transcript URL [--lang LANG]` | Get cleaned video transcript |
| `bash scripts/youtube.sh info URL` | Get video metadata |
| `bash scripts/youtube.sh channel CHANNEL_URL [limit]` | List channel videos |
| `bash scripts/youtube.sh search "query" [limit]` | Search YouTube |

### AI Operations

| Command | Description |
|---------|-------------|
| `bash scripts/youtube.sh ai-summary URL` | Summarize video content |
| `bash scripts/youtube.sh ai-takeaways URL` | Extract key takeaways |
| `bash scripts/youtube.sh ai-compare URL1 URL2 [URL3...]` | Compare multiple videos |
| `bash scripts/youtube.sh ai-ask URL "question"` | Ask about a video |

## Example

User: "Summarize this video"

    bash scripts/youtube.sh ai-summary "https://www.youtube.com/watch?v=dQw4w9WgXcQ"

Output:

    Video Summary: "Never Gonna Give You Up - Rick Astley"
    Duration: 3:33 | Views: 1.5B | Published: 2009-10-25

    Overview:
      This is the official music video for Rick Astley's 1987 hit single...

    Key Points:
      - Classic 80s pop song that became an internet cultural phenomenon
      - The "Rickroll" meme made it one of the most viewed videos on YouTube

    Topics Covered:
      1. Music performance and choreography
      2. Internet culture and meme history

## Configuration

| Variable | Default | Required | Description |
|---|---|---|---|
| `EVOLINK_API_KEY` | — | Optional (AI) | Your EvoLink API key for AI features. [Get one free](https://evolink.ai/signup?utm_source=clawhub&utm_medium=skill&utm_campaign=youtube) |
| `EVOLINK_MODEL` | `claude-opus-4-6` | No | Model for AI processing. [EvoLink API](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=clawhub&utm_medium=skill&utm_campaign=youtube) |

Required binaries: `python3`, `yt-dlp`, `curl`

## Security

**Important: Data Consent for AI Features**

AI commands (`ai-summary`, `ai-takeaways`, `ai-compare`, `ai-ask`) transmit video transcript text and metadata to `api.evolink.ai` for processing by Claude. By setting `EVOLINK_API_KEY` and using these commands, you explicitly consent to this transmission. Data is not stored after the response is returned. Core operations (transcript, info, channel, search) never transmit data to any third party.

**Network Access**

- `youtube.com` — Video transcript and metadata fetching via yt-dlp
- `api.evolink.ai` — AI features only (optional)

**Persistence & Privilege**

This skill creates temporary files for transcript processing which are cleaned up automatically. No credentials or persistent data are stored.

## Links

- [GitHub](https://github.com/EvoLinkAI/youtube-skill-for-openclaw)
- [EvoLink API](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=clawhub&utm_medium=skill&utm_campaign=youtube)
- [Community](https://discord.com/invite/5mGHfA24kn)
- [Support](mailto:support@evolink.ai)
