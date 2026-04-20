---
name: Google Sheets Assistant
description: Read, write, and analyze Google Sheets with AI-powered insights, formula generation, and data summarization. Powered by evolink.ai
version: 1.0.3
homepage: https://github.com/EvoLinkAI/google-sheets-skill-for-openclaw
metadata: {"openclaw":{"homepage":"https://github.com/EvoLinkAI/google-sheets-skill-for-openclaw","requires":{"bins":["python3","curl"],"env":["MATON_API_KEY","EVOLINK_API_KEY"]},"primaryEnv":"MATON_API_KEY"}}
---

# Google Sheets Assistant

Read, write, and analyze Google Sheets with AI-powered data insights, formula generation, and summarization — all from your terminal.

Powered by [Evolink.ai](https://evolink.ai?utm_source=clawhub&utm_medium=skill&utm_campaign=google-sheets) + [Maton](https://maton.ai)

## When to Use

- User says "read my spreadsheet", "get data from Google Sheets"
- User wants to write data, update cells, or append rows
- User says "create a spreadsheet" or "make a new sheet"
- User wants formatting: "make the header bold", "resize columns"
- User says "analyze this data", "find patterns"
- User asks "what formula would...", "suggest a formula for..."
- User says "summarize the spreadsheet"
- User needs to connect their Google account

## Quick Start

### 1. Get your Maton API key

Sign up at [maton.ai](https://maton.ai), then copy your key from [maton.ai/settings](https://maton.ai/settings).

    export MATON_API_KEY="your-maton-key"

### 2. Connect your Google account

    bash scripts/sheets.sh connection create

Open the returned URL in your browser to authorize Google access.

### 3. Read a spreadsheet

    bash scripts/sheets.sh read SPREADSHEET_ID "Sheet1!A1:D10"

### 4. (Optional) Enable AI features

Get a free EvoLink key at [evolink.ai/signup](https://evolink.ai/signup?utm_source=clawhub&utm_medium=skill&utm_campaign=google-sheets):

    export EVOLINK_API_KEY="your-evolink-key"

### 5. Try AI analysis

    bash scripts/sheets.sh ai-analyze SPREADSHEET_ID

## Capabilities

### Core Operations
- **Read** — Fetch and display spreadsheet values with aligned table output
- **Write** — Update cell values in any range
- **Append** — Add new rows to the end of a range
- **Info** — Get spreadsheet metadata (title, sheets, dimensions)
- **Create** — Create a new spreadsheet
- **Clear** — Clear values from a range
- **Format** — Apply formatting via Google Sheets batchUpdate API

### Connection Management
- **List** — View active Google OAuth connections
- **Create** — Start OAuth flow to connect a Google account
- **Delete** — Remove a connection

### AI Features (Optional)
Requires `EVOLINK_API_KEY`. [Get one free](https://evolink.ai/signup?utm_source=clawhub&utm_medium=skill&utm_campaign=google-sheets)

- **ai-analyze** — AI-powered data analysis with patterns, insights, and recommendations
- **ai-formula** — Generate Google Sheets formulas from natural language descriptions
- **ai-summary** — Summarize spreadsheet content with key figures and trends

## Commands

### Core Operations

| Command | Description |
|---------|-------------|
| `bash scripts/sheets.sh read <ID> [range]` | Read values (default: Sheet1) |
| `bash scripts/sheets.sh write <ID> <range> <json>` | Write values to range |
| `bash scripts/sheets.sh append <ID> <range> <json>` | Append rows |
| `bash scripts/sheets.sh info <ID>` | Get spreadsheet metadata |
| `bash scripts/sheets.sh create <title>` | Create new spreadsheet |
| `bash scripts/sheets.sh clear <ID> <range>` | Clear a range |
| `bash scripts/sheets.sh format <ID> <json>` | Apply batchUpdate formatting |

### Connection Management

| Command | Description |
|---------|-------------|
| `bash scripts/sheets.sh connection list` | List Google connections |
| `bash scripts/sheets.sh connection create` | Connect Google account |
| `bash scripts/sheets.sh connection delete <id>` | Remove connection |

### AI Operations

| Command | Description |
|---------|-------------|
| `bash scripts/sheets.sh ai-analyze <ID> [range]` | Analyze data patterns |
| `bash scripts/sheets.sh ai-formula <description>` | Generate formula |
| `bash scripts/sheets.sh ai-summary <ID> [range]` | Summarize data |

## Examples

Read a range:

    bash scripts/sheets.sh read 1BxiMVs0XRA5nFMdKvBdBZjgmUUqptlbs74OgVE2upms "Sheet1!A1:D10"

Write values:

    bash scripts/sheets.sh write 1BxiMVs0XRA5nFMdKvBdBZjgmUUqptlbs74OgVE2upms "Sheet1!A1" '[["Name","Score"],["Alice",95],["Bob",87]]'

Create a new spreadsheet:

    bash scripts/sheets.sh create "Q1 Sales Report"

Generate a formula:

    bash scripts/sheets.sh ai-formula "sum all values in column B where column A equals Sales"

## Configuration

| Variable | Default | Required | Description |
|---|---|---|---|
| `MATON_API_KEY` | — | Yes | Maton API key for Google Sheets access. [Get one](https://maton.ai/settings) |
| `EVOLINK_API_KEY` | — | Optional (AI) | EvoLink API key for AI features. [Get one free](https://evolink.ai/signup?utm_source=clawhub&utm_medium=skill&utm_campaign=google-sheets) |
| `EVOLINK_MODEL` | `claude-opus-4-6` | No | Model for AI processing. [EvoLink API](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=clawhub&utm_medium=skill&utm_campaign=google-sheets) |

Required binaries: `python3`, `curl`

## Security

**Important: Data Consent**

All spreadsheet operations are proxied through `gateway.maton.ai`, which manages your Google OAuth tokens. By setting `MATON_API_KEY` and authorizing via the connection flow, you consent to Maton accessing your Google Sheets on your behalf.

AI commands (`ai-analyze`, `ai-formula`, `ai-summary`) transmit spreadsheet data to `api.evolink.ai` for processing by Claude. By setting `EVOLINK_API_KEY` and using these commands, you explicitly consent to this transmission. Data is not stored after the response is returned.

Core operations never transmit data to evolink.ai — only to the Maton gateway.

**Network Access**

- `gateway.maton.ai` — Google Sheets API proxy (all operations)
- `ctrl.maton.ai` — OAuth connection management
- `api.evolink.ai` — AI features only (optional)

**Persistence & Privilege**

This skill creates temporary files for API request payloads which are cleaned up automatically. No credentials or persistent data are stored locally.

## Links

- [GitHub](https://github.com/EvoLinkAI/google-sheets-skill-for-openclaw)
- [EvoLink API](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=clawhub&utm_medium=skill&utm_campaign=google-sheets)
- [Maton](https://maton.ai)
- [Community](https://discord.com/invite/5mGHfA24kn)
- [Support](mailto:support@evolink.ai)
