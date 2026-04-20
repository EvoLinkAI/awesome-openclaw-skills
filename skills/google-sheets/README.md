# Google Sheets Assistant — Read, Write & Analyze with AI

> *Your spreadsheets, smarter.*

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![EvoLink](https://img.shields.io/badge/Powered%20by-EvoLink-blue)](https://evolink.ai?utm_source=github&utm_medium=skill&utm_campaign=google-sheets)

Read, write, and analyze Google Sheets with AI-powered data insights, formula generation, and summarization — all from your terminal.

[EvoLink API](https://evolink.ai?utm_source=github&utm_medium=skill&utm_campaign=google-sheets) + [Maton](https://maton.ai)

**Language:**
[English](README.md) | [简体中文](README.zh-CN.md) | [日本語](README.ja.md) | [한국어](README.ko.md) | [Español](README.es.md) | [Français](README.fr.md) | [Deutsch](README.de.md) | [Türkçe](README.tr.md) | [Русский](README.ru.md)

## Installation

```bash
# Install skill
mkdir -p .claude/skills
git clone https://github.com/EvoLinkAI/google-sheets-skill-for-openclaw .claude/skills/google-sheets-assistant

# Set API keys
export MATON_API_KEY="your-maton-key"          # Required — get at maton.ai/settings
export EVOLINK_API_KEY="your-evolink-key"      # Optional — get at evolink.ai/signup

# Connect Google account
bash scripts/sheets.sh connection create
```

## Usage

```bash
# Read spreadsheet data
bash scripts/sheets.sh read SPREADSHEET_ID "Sheet1!A1:D10"

# Write values
bash scripts/sheets.sh write SPREADSHEET_ID "Sheet1!A1" '[["Name","Score"],["Alice",95]]'

# Create new spreadsheet
bash scripts/sheets.sh create "Q1 Sales Report"

# AI: Analyze data patterns
bash scripts/sheets.sh ai-analyze SPREADSHEET_ID

# AI: Generate formula from description
bash scripts/sheets.sh ai-formula "average of column B where column A is not empty"
```

### Commands

| Command | Description |
|---------|-------------|
| `read <ID> [range]` | Read values with pretty-printed table output |
| `write <ID> <range> <json>` | Write values to a range |
| `append <ID> <range> <json>` | Append rows to a range |
| `info <ID>` | Get spreadsheet metadata |
| `create <title>` | Create a new spreadsheet |
| `clear <ID> <range>` | Clear a range |
| `format <ID> <json>` | Apply batchUpdate formatting |
| `connection list\|create\|delete` | Manage Google OAuth connections |
| `ai-analyze <ID> [range]` | AI data analysis with insights |
| `ai-formula <description>` | Generate formula from natural language |
| `ai-summary <ID> [range]` | Summarize spreadsheet content |

## Features

- Read, write, append, and clear spreadsheet data
- Create new spreadsheets and apply formatting
- Pretty-printed table output for read operations
- Google OAuth via managed Maton gateway (no GCP setup needed)
- AI-powered: data analysis, formula generation, content summarization
- EvoLink API integration (Claude models)

## Links

- [ClawHub](https://clawhub.ai/evolinkai/google-sheets-assistant)
- [EvoLink API](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=google-sheets)
- [Community](https://discord.com/invite/5mGHfA24kn)

MIT License © [EvoLinkAI](https://github.com/EvoLinkAI)
