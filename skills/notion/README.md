# Notion

🌐 English | [简体中文](README.zh-CN.md) | [日本語](README.ja.md) | [한국어](README.ko.md) | [Español](README.es.md) | [Français](README.fr.md) | [Русский](README.ru.md)
# Notion Skill for OpenClaw

🌐 English

This skill enables agents to interact with Notion pages and databases using the Notion API.

Powered by [Evolink.ai](https://evolink.ai/?utm_source=github&utm_medium=skill&utm_campaign=notion-skill-for-openclaw).

## Quick Start
1. Create a Notion Integration at [notion.so/my-integrations](https://www.notion.so/my-integrations)
2. Copy the Internal Integration Token
3. Share pages/databases with the integration
4. Configure `NOTION_API_KEY` and `EVOLINK_API_KEY`
5. Install: `clawhub install notion-skill-for-openclaw`

## Authentication

Export your Notion token:
```bash
export NOTION_API_KEY=secret_xxx
```

**Important:** Share the integration with the pages or databases you want to access. Unshared content is invisible to the API.

## Configuration

- `NOTION_API_KEY`: Notion Integration Token
- `EVOLINK_API_KEY`: API Key for Evolink services. Get your free API key at [evolink.ai/signup](https://evolink.ai/signup?utm_source=github&utm_medium=skill&utm_campaign=notion-skill-for-openclaw)

**Model Selection:**
- Default model: `claude-opus-4-6`
- Switch models by setting `EVOLINK_MODEL` environment variable (e.g., `claude-sonnet-4-6`, `claude-haiku-4-5-20251001`)

## Profiles (Optional)

Define multiple profiles (e.g., personal, work):
```bash
export NOTION_PROFILE=work  # Default: personal
```

## Usage

### Pages

**Read page:**
```bash
notion-cli page get <page_id>
```

**Append content:**
```bash
notion-cli block append <page_id> --markdown "..."
```

**Create page:**
```bash
notion-cli page create --parent <page_id> --title "..."
```

### Databases

**Inspect schema:**
```bash
notion-cli db get <database_id>
```

**Query database:**
```bash
notion-cli db query <database_id> --filter <json> --sort <json>
```

**Create row:**
```bash
notion-cli page create --database <database_id> --props <json>
```

**Update row:**
```bash
notion-cli page update <page_id> --props <json>
```

### Schema Changes (Advanced)

Always inspect diffs before applying:
```bash
notion-cli db schema diff <database_id> --desired <json>
notion-cli db schema apply <database_id> --desired <json>
```

## Security

- Notion API is rate-limited; batch requests carefully
- Prefer append and updates over destructive operations
- IDs are opaque; store them explicitly
- **NEVER** modify database schema without explicit confirmation
- Only share necessary pages with the integration
- Sensitive credentials must be managed via environment variables

## License
MIT License

## Links
- [ClawHub](https://clawhub.ai/EvoLinkAI/notion-skill-for-openclaw)
- [API Reference](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=notion-skill-for-openclaw)
- [Community](https://discord.com/invite/5mGHfA24kn)
- [Support](mailto:support@evolink.ai)
