# Multi Summarize

AI-powered multi-format summarization skill for OpenClaw. Supports 29+ languages.

Powered by [Evolink.ai](https://evolink.ai?utm_source=github&utm_medium=skill&utm_campaign=summarize)

## What It Does

Summarizes any content — URLs, PDFs, videos, audio files, YouTube links, or plain text — into concise, actionable key points.

## Install

```bash
clawhub install multi-summarize
```

## Setup

1. Get a free API key at [evolink.ai/signup](https://evolink.ai/signup?utm_source=github&utm_medium=readme&utm_campaign=multi-summarize-skill-for-openclaw?utm_source=github&utm_medium=skill&utm_campaign=summarize)
2. Set the environment variable:
```bash
export EVOLINK_API_KEY="your-key-here"
```

## Usage

```bash
# Summarize a web article
bash scripts/summarize.sh "https://example.com/article"

# Summarize a local PDF
bash scripts/summarize.sh "/path/to/report.pdf"

# Summarize a YouTube video
bash scripts/summarize.sh "https://youtu.be/VIDEO_ID"

# Summarize an audio file
bash scripts/summarize.sh "/path/to/podcast.mp3"
```

## Configuration

| Variable | Default | Required | Description |
|---|---|---|---|
| `EVOLINK_API_KEY` | — | Yes | Your Evolink API key. [Get one free →](https://evolink.ai/signup?utm_source=github&utm_medium=readme&utm_campaign=multi-summarize-skill-for-openclaw?utm_source=github&utm_medium=skill&utm_campaign=summarize) |
| `EVOLINK_MODEL` | `claude-opus-4-6` | No | Model for processing. Switch to any model supported by the [Evolink API](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=summarize) |
| `SUMMARIZE_SAFE_DIR` | `$HOME/.openclaw/workspace` | No | Allowed directory for local file access |

Required binaries: `curl`, `python3`, `realpath`, `file`, `stat`.

Optional binaries: `yt-dlp` (YouTube), `ffmpeg` + `whisper` (audio/video transcription), `pdftotext` or `markitdown` (PDF extraction).

## Security & Usage Limits

**File Access Controls**

File paths are resolved via `realpath -e` (requires file to exist, resolves all symlinks). Symlink inputs are explicitly rejected.

The resolved path must fall within `SUMMARIZE_SAFE_DIR` (default: `$HOME/.openclaw/workspace`). A trailing-slash comparison prevents prefix-bypass attacks.

Sensitive files are blacklisted by name: `.env*`, `*.key`, `*.pem`, `*.p12`, `*.pfx`, `id_rsa*`, `authorized_keys`, `config.json`, `.bash_history`, `.ssh`, `shadow`, `passwd`.

**Tiered Size Limits**

| File Type | Limit |
|---|---|
| Text / Code / Config | 5MB |
| PDF Documents | 50MB |
| Audio / Video | 1GB |

**MIME Validation**: Only `text/*`, `application/pdf`, `video/*`, `audio/*`, `application/json` accepted.

**Network**: All extracted content is sent to `api.evolink.ai` for summarization. No data is stored after the response is returned.

**Temporary Files**: Transcripts and subtitles created in `/tmp` during processing are cleaned up after extraction.

## Links

- [Source Code](https://github.com/EvoLinkAI/multi-summarize-skill-for-openclaw) — GitHub
- [API Reference](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=summarize)
- [Community](https://discord.com/invite/5mGHfA24kn)
- [Support](mailto:support@evolink.ai)
- [Get API Key](https://evolink.ai/signup?utm_source=github&utm_medium=readme&utm_campaign=multi-summarize-skill-for-openclaw?utm_source=github&utm_medium=skill&utm_campaign=summarize) — Free signup

## License

MIT

Powered by [Evolink.ai](https://evolink.ai?utm_source=github&utm_medium=skill&utm_campaign=summarize)
