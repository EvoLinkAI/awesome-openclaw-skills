# Notion Skill for OpenClaw

This skill lets the agent work with Notion pages and databases using the official Notion API.

Powered by [Evolink.ai](https://evolink.ai/?utm_source=github&utm_medium=skill&utm_campaign=notion-skill-for-openclaw).

## When to Use
Use this skill when user asks to:
- Read from or append to Notion pages
- Query or update Notion databases
- Create new pages or database entries
- Automate Notion workflows

## Authentication

Create a Notion Integration at [notion.so/my-integrations](https://www.notion.so/my-integrations) and copy the Internal Integration Token.

Export it as:
```bash
export NOTION_API_KEY=secret_xxx
```

**Important:** Share the integration with the pages or databases you want to access. Unshared content is invisible to the API.

## Configuration

Required environment variables:
- `NOTION_API_KEY`: Internal Integration Token from Notion
- `EVOLINK_API_KEY`: API Key for Evolink services. Get your free API key at [evolink.ai/signup](https://evolink.ai/signup?utm_source=github&utm_medium=skill&utm_campaign=notion-skill-for-openclaw)

**Model Selection:**
- Default model: `claude-opus-4-6`
- Switch models by setting `EVOLINK_MODEL` environment variable

## Profiles (personal / work)

You may define multiple profiles (e.g. personal, work) via env or config.

Default profile: `personal`

Override via:
```bash
export NOTION_PROFILE=work
```

## Pages

**Read page:**
```bash
notion-cli page get <page_id>
```

**Append blocks:**
```bash
notion-cli block append <page_id> --markdown "..."
```

Prefer appending over rewriting content.

**Create page:**
```bash
notion-cli page create --parent <page_id> --title "..."
```

## Databases

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

## Schema Changes (Advanced)

Always inspect diffs before applying schema changes.

**Never modify database schema without explicit confirmation.**

Recommended flow:
```bash
notion-cli db schema diff <database_id> --desired <json>
notion-cli db schema apply <database_id> --desired <json>
```

## Security

- Notion API is rate-limited; batch requests carefully
- Prefer append and updates over destructive operations
- IDs are opaque; store them explicitly, do not infer from URLs
- **NEVER** perform destructive operations without explicit confirmation
- Notion shares must be configured manually via "Add connections"

## Links
- [ClawHub](https://clawhub.ai/EvoLinkAI/notion-skill-for-openclaw)
- [API Reference](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=notion-skill-for-openclaw)
- [Community](https://discord.com/invite/5mGHfA24kn)
- [Support](mailto:support@evolink.ai)
