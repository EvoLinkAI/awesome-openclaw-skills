# YouTube Assistant — OpenClaw Skill

Fetch YouTube video transcripts, metadata, and channel info with AI-powered summarization, key takeaway extraction, multi-video comparison, and Q&A.

Powered by [EvoLink API](https://evolink.ai?utm_source=npm&utm_medium=skill&utm_campaign=youtube) (Claude models)

## Install

```bash
npx evolinkai-youtube-assistant
```

Or via ClawHub:
```bash
npx clawhub install youtube-assistant
```

## Requirements

- `yt-dlp` — `pip install yt-dlp`
- `python3`
- `EVOLINK_API_KEY` (optional, for AI features) — [Get free key](https://evolink.ai/signup?utm_source=npm&utm_medium=skill&utm_campaign=youtube)

## Commands

| Command | Description |
|---------|-------------|
| `transcript <URL>` | Get cleaned video transcript |
| `info <URL>` | Get video metadata |
| `channel <URL> [limit]` | List channel videos |
| `search <query> [limit]` | Search YouTube |
| `ai-summary <URL>` | AI video summary |
| `ai-takeaways <URL>` | Extract key takeaways |
| `ai-compare <URL1> <URL2>` | Compare videos |
| `ai-ask <URL> <question>` | Ask about video content |

## Links

- [GitHub](https://github.com/EvoLinkAI/youtube-skill-for-openclaw)
- [ClawHub](https://clawhub.ai/evolinkai/youtube-assistant)
- [EvoLink API](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=npm&utm_medium=skill&utm_campaign=youtube)

MIT License © [EvoLinkAI](https://github.com/EvoLinkAI)
