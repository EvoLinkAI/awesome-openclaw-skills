---
name: web-research
description: Web search via EvoLink API. Returns clean, formatted results with titles, URLs, and descriptions. Powered by evolink.ai
metadata: {"clawdbot":{"emoji":"🔍","requires":{"bins":["bash","curl","jq"],"env":["EVOLINK_API_KEY"]},"primaryEnv":"EVOLINK_API_KEY"}}
---

# Web Search Assistant

Web search using EvoLink API. Returns clean, formatted results with titles, URLs, and descriptions.

Powered by [Evolink.ai](https://evolink.ai?utm_source=clawhub&utm_medium=skill&utm_campaign=web-search)

## When to Use

Use this skill when users request:
- Web searches for information or resources
- Finding current or recent information online
- Research requiring current web data
- Fact-checking or verification using web sources
- Gathering URLs and resources on a topic

## Search

```bash
{baseDir}/scripts/search.sh "query"
{baseDir}/scripts/search.sh "query" 20
```

## Options

- `<query>`: Search query
- `<max_results>`: Number of results (default: 10)

## Configuration

Set your EvoLink API key:

```bash
export EVOLINK_API_KEY="your-evolink-api-key-here"
```

👉 [Get free API key](https://evolink.ai/signup?utm_source=clawhub&utm_medium=skill&utm_campaign=web-search)

## Example

```bash
bash scripts/search.sh "Claude Opus 4 features"
```

Output:
```
🔍 Searching: Claude Opus 4 features

📄 Claude Opus 4: New Features and Capabilities
🔗 https://example.com/opus-4
📝 Comprehensive guide to Claude Opus 4's new features...

📄 What's New in Claude Opus 4
🔗 https://example.com/whats-new
📝 Latest updates and improvements in Claude Opus 4...
```

## Security

**Credentials & Network**

`EVOLINK_API_KEY` is required to call the EvoLink API. Your search queries are sent to `api.evolink.ai` for processing. EvoLink handles the web search internally and returns formatted results.

**File Access**

This skill does not read or write any files.

**Network Access**

This skill makes network requests to:
- **EvoLink API** (`api.evolink.ai`) - to perform web searches

All network calls are performed via curl and can be audited in the script source code.

**Persistence & Privilege**

This skill does not modify other skills or system settings. No elevated or persistent privileges are requested.

## Links

- [ClawHub](https://clawhub.ai/evolinkai/web-research)
- [API Reference](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=clawhub&utm_medium=skill&utm_campaign=web-search)
- [Community](https://discord.com/invite/5mGHfA24kn)
- [Support](mailto:support@evolink.ai)
