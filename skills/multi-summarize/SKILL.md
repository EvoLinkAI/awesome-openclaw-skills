---
name: Summarize
description: Fast multi-format summarization — paste a URL, drop a file, get the key points. Powered by evolink.ai
---

# Summarize

Summarize any content with Claude Opus 4.6 — the most capable text model available.

## When to Use

- User says "summarize this", "what's this about?", "give me the key points"
- User shares a URL, PDF, video, audio file, or long text
- User asks for meeting notes, article digest, or video recap
- User wants a TL;DR of any content

## Quick Start

```bash
bash scripts/summarize.sh "https://example.com/article"
bash scripts/summarize.sh "/path/to/document.pdf"
bash scripts/summarize.sh "https://youtu.be/dQw4w9WgXcQ"
bash scripts/summarize.sh "/path/to/recording.mp3"
```

## Supported Formats

- **Web URLs** — Articles, blogs, documentation
- **PDF** — Reports, papers, whitepapers
- **Video** — mp4, webm, YouTube links
- **Audio** — mp3, wav, m4a, podcasts
- **Text** — Markdown, plain text, code files

## Example

User: "Summarize this article: https://evolink.ai/blog/deepseek-v4-release-window-prep"

Output:

```
## TL;DR
DeepSeek V4 has been rumored since January 2026 but still hasn't officially
launched as of March. Multiple predicted windows have passed. The model is
expected to focus on coding with 90% HumanEval scores (unverified).

## Key Takeaways
- Reuters reported in Jan that DeepSeek plans a coding-focused model for Feb 2026
- DeepSeek silently expanded context from 128K to 1M tokens in Feb — likely V4 infra testing
- Unverified benchmarks claim 90% HumanEval, 80%+ SWE-bench Verified
- "V4 Lite" appeared on DeepSeek's site in March but was never officially confirmed
- Multiple launch windows (mid-Feb, Lunar New Year, early March) all passed without release

## Action Items
- Do not migrate production workloads until official announcement
- Monitor DeepSeek's official channels for confirmed specs
- Prepare API integration — EvoLink will support V4 on day one
```

## Configuration

Set your Evolink API key:

```bash
export EVOLINK_API_KEY="your-key-here"
```

Default model: `claude-opus-4-6` (no configuration needed).

To use a different model:

```bash
export EVOLINK_MODEL="claude-sonnet-4-5-20250929"
```

[Get your API key →](https://evolink.ai/signup?utm_source=github&utm_medium=skill&utm_campaign=summarize)

## Links

- [GitHub](https://github.com/EvoLinkAI/multi-summarize-skill-for-openclaw)
- [API Reference](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=clawhub&utm_medium=skill&utm_campaign=summarize)
- [Community](https://discord.com/invite/5mGHfA24kn)
- [Support](mailto:support@evolink.ai)

## Security

**Credentials & Network**

`EVOLINK_API_KEY` is required to call the Evolink API for summarization. Extracted content is sent to `api.evolink.ai` and discarded after the response is returned. No data is stored. Review Evolink's privacy policy before sending sensitive content.

Required binaries: `curl`, `python3`, `realpath`, `file`, `stat`. Optional: `yt-dlp`, `ffmpeg`, `whisper`, `pdftotext`, `markitdown`.

**File Access Controls**

File paths are resolved via `realpath -e` (requires file to exist, resolves all symlinks). Symlink inputs are explicitly rejected.

The resolved path must fall within `SUMMARIZE_SAFE_DIR` (default: `$HOME/.openclaw/workspace`). A trailing-slash comparison prevents prefix-bypass attacks.

Sensitive files are blacklisted by name: `.env*`, `*.key`, `*.pem`, `*.p12`, `*.pfx`, `id_rsa*`, `authorized_keys`, `config.json`, `.bash_history`, `.ssh`, `shadow`, `passwd`.

Tiered size limits: 5MB text / 50MB PDF / 1GB media. MIME validation via `file --mime-type`.

**Temporary Files**

Transcripts and subtitles created in `/tmp` during processing are cleaned up after extraction. PID-based filenames prevent collisions.

**Persistence & Privilege**

This skill does not modify other skills or system settings. No elevated or persistent privileges are requested.
