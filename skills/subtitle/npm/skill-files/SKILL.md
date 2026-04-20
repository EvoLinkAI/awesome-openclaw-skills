---
name: Subtitle Assistant
description: Download YouTube subtitles and use AI to summarize, translate, or extract key points. No login or cookies required. Powered by evolink.ai
version: 1.0.0
homepage: https://github.com/EvoLinkAI/subtitle-skill-for-openclaw
metadata: {"openclaw":{"homepage":"https://github.com/EvoLinkAI/subtitle-skill-for-openclaw","requires":{"bins":["python3","curl","yt-dlp"],"env":["EVOLINK_API_KEY"]},"primaryEnv":"EVOLINK_API_KEY"}}
---

# Subtitle Assistant

Download YouTube subtitles and use AI to summarize, translate, or extract key points — all from your terminal. No login, no cookies, no browser required.

Powered by [Evolink.ai](https://evolink.ai?utm_source=clawhub&utm_medium=skill&utm_campaign=subtitle)

## When to Use

- User shares a YouTube link and wants a summary
- User wants to translate a video's content to another language
- User needs key points or action items from a talk/tutorial
- User wants to download subtitles for offline reading

## Quick Start

### 1. Install yt-dlp

    pip install yt-dlp

### 2. Set your EvoLink API key

    export EVOLINK_API_KEY="your-key-here"

Get a free key: [evolink.ai/signup](https://evolink.ai/signup?utm_source=clawhub&utm_medium=skill&utm_campaign=subtitle)

### 3. Summarize a video

    bash scripts/subtitle.sh summarize "https://www.youtube.com/watch?v=VIDEO_ID"

## Capabilities

### Download Commands (require yt-dlp, no API key needed)

| Command | Description |
|---------|-------------|
| `download <url> [--lang <code>]` | Download subtitles to a text file |
| `languages <url>` | List available subtitle languages for a video |

### AI Commands (require EVOLINK_API_KEY + yt-dlp)

| Command | Description |
|---------|-------------|
| `summarize <url\|file> [--lang <code>]` | Comprehensive summary with key takeaways |
| `translate <url\|file> --lang <language>` | Natural translation to target language |
| `keypoints <url\|file> [--lang <code>]` | Structured key points and action items |

All AI commands accept either a YouTube URL or a local subtitle file.

## Examples

### Download subtitles

    bash scripts/subtitle.sh download "https://youtube.com/watch?v=..." --lang en

Output:

    Subtitles saved to: sub_temp/VIDEO_ID.txt

    Preview (first 10 lines):
    Welcome to this tutorial on building REST APIs...

### Summarize a video

    bash scripts/subtitle.sh summarize "https://youtube.com/watch?v=..."

Output:

    **Title/Topic:** A comprehensive tutorial on building production-ready
    REST APIs with Node.js and Express.

    **Summary:**
    The video covers the complete process of setting up a REST API...

    **Key Takeaways:**
    - Use middleware for authentication and error handling
    - ...

### Translate subtitles to Chinese

    bash scripts/subtitle.sh translate "https://youtube.com/watch?v=..." --lang zh

### Extract key points from a local file

    bash scripts/subtitle.sh keypoints downloaded-subtitles.txt

## Configuration

| Variable | Default | Required | Description |
|---|---|---|---|
| `EVOLINK_API_KEY` | — | Yes (AI commands) | Your EvoLink API key. [Get one free](https://evolink.ai/signup?utm_source=clawhub&utm_medium=skill&utm_campaign=subtitle) |
| `EVOLINK_MODEL` | `claude-opus-4-6` | No | Model for AI analysis |

Required binaries: `python3`, `curl`, `yt-dlp`

Install yt-dlp: `pip install yt-dlp`

## Security

**Data Transmission**

AI commands send downloaded subtitle text to `api.evolink.ai` for analysis by Claude. By setting `EVOLINK_API_KEY` and using these commands, you consent to this transmission. Data is not stored after the response is returned. The `download` and `languages` commands only interact with YouTube via yt-dlp and never send data to evolink.ai.

**No Login Required**

This skill downloads publicly available YouTube subtitles. It does not require any login, cookies, or authentication tokens. No credentials are stored.

**Network Access**

- YouTube (via yt-dlp) — subtitle download
- `api.evolink.ai` — AI analysis (AI commands only)

**Persistence & Privilege**

Downloaded subtitles are saved to a `sub_temp/` directory in the current working directory. Temporary files for API payloads are cleaned up automatically. No system-level changes are made.

## Links

- [GitHub](https://github.com/EvoLinkAI/subtitle-skill-for-openclaw)
- [EvoLink API](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=clawhub&utm_medium=skill&utm_campaign=subtitle)
- [Community](https://discord.com/invite/5mGHfA24kn)
- [Support](mailto:support@evolink.ai)
