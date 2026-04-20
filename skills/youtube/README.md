# YouTube Assistant — Fetch Transcripts & Analyze Videos with AI

> *Watch smarter, not longer.*

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![EvoLink](https://img.shields.io/badge/Powered%20by-EvoLink-blue)](https://evolink.ai?utm_source=github&utm_medium=skill&utm_campaign=youtube)

Fetch YouTube video transcripts, metadata, and channel info. Summarize content, extract key takeaways, compare multiple videos, and ask questions about video content — all powered by AI.

[EvoLink API](https://evolink.ai?utm_source=github&utm_medium=skill&utm_campaign=youtube)

**Language:**
[English](README.md) | [简体中文](README.zh-CN.md) | [日本語](README.ja.md) | [한국어](README.ko.md) | [Español](README.es.md) | [Français](README.fr.md) | [Deutsch](README.de.md) | [Türkçe](README.tr.md) | [Русский](README.ru.md)

## Installation

```bash
# Install yt-dlp (required)
pip install yt-dlp

# Install skill
mkdir -p .claude/skills
git clone https://github.com/EvoLinkAI/youtube-skill-for-openclaw .claude/skills/youtube-assistant
export EVOLINK_API_KEY="your-key-here"
```

Free API key: [evolink.ai/signup](https://evolink.ai/signup?utm_source=github&utm_medium=skill&utm_campaign=youtube)

## Usage

```bash
# Get video transcript
bash scripts/youtube.sh transcript "https://www.youtube.com/watch?v=VIDEO_ID"

# Get video metadata
bash scripts/youtube.sh info "https://www.youtube.com/watch?v=VIDEO_ID"

# AI-summarize a video
bash scripts/youtube.sh ai-summary "https://www.youtube.com/watch?v=VIDEO_ID"
```

### Commands

| Command | Description |
|---------|-------------|
| `transcript <URL> [--lang]` | Get cleaned video transcript |
| `info <URL>` | Get video metadata (title, views, duration) |
| `channel <URL> [limit]` | List recent channel videos |
| `search <query> [limit]` | Search YouTube |
| `ai-summary <URL>` | AI-generated video summary |
| `ai-takeaways <URL>` | Extract key takeaways & action items |
| `ai-compare <URL1> <URL2>` | Compare multiple videos |
| `ai-ask <URL> <question>` | Ask questions about video content |

## Features

- Transcript extraction from any YouTube video (manual + auto-generated subtitles)
- Video metadata: title, duration, views, likes, description, tags
- Channel browsing and YouTube search
- AI-powered: summarization, takeaway extraction, multi-video comparison, Q&A
- Multi-language subtitle support
- EvoLink API integration (Claude models)

## Links

- [ClawHub](https://clawhub.ai/evolinkai/youtube-assistant)
- [EvoLink API](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=youtube)
- [Community](https://discord.com/invite/5mGHfA24kn)

MIT License © [EvoLinkAI](https://github.com/EvoLinkAI)
