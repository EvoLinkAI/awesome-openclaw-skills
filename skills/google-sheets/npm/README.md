# Google Sheets Assistant — OpenClaw Skill

Read, write, and analyze Google Sheets with AI-powered insights, formula generation, and data summarization.

Powered by [EvoLink API](https://evolink.ai?utm_source=npm&utm_medium=skill&utm_campaign=google-sheets) + [Maton](https://maton.ai)

## Install

```bash
npx evolinkai-google-sheets-assistant
```

Or via ClawHub:
```bash
npx clawhub install google-sheets-assistant
```

## Requirements

- `python3`
- `curl`
- `MATON_API_KEY` (required) — [Get key](https://maton.ai/settings)
- `EVOLINK_API_KEY` (optional, for AI features) — [Get free key](https://evolink.ai/signup?utm_source=npm&utm_medium=skill&utm_campaign=google-sheets)

## Commands

| Command | Description |
|---------|-------------|
| `read <ID> [range]` | Read spreadsheet values |
| `write <ID> <range> <json>` | Write values |
| `append <ID> <range> <json>` | Append rows |
| `info <ID>` | Get metadata |
| `create <title>` | Create spreadsheet |
| `clear <ID> <range>` | Clear range |
| `format <ID> <json>` | Apply formatting |
| `connection list\|create\|delete` | Manage Google connections |
| `ai-analyze <ID> [range]` | AI data analysis |
| `ai-formula <description>` | Generate formula |
| `ai-summary <ID> [range]` | Summarize data |

## Links

- [GitHub](https://github.com/EvoLinkAI/google-sheets-skill-for-openclaw)
- [ClawHub](https://clawhub.ai/evolinkai/google-sheets-assistant)
- [EvoLink API](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=npm&utm_medium=skill&utm_campaign=google-sheets)

MIT License © [EvoLinkAI](https://github.com/EvoLinkAI)
