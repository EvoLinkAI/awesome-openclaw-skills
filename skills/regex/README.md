# Regex Assistant — OpenClaw Skill

AI-powered regular expression generation, explanation, testing, debugging, and cross-language conversion — all from your terminal.

Powered by [EvoLink.ai](https://evolink.ai)

## Install

### Via ClawHub (Recommended)

```
npx clawhub install ai-regex-assistant
```

### Via npm

```
npx evolinkai-regex-assistant
```

## Quick Start

```bash
# Set your API key
export EVOLINK_API_KEY="your-key-here"

# Generate a regex from description
bash scripts/regex.sh generate "match email addresses" --lang python

# Explain a complex pattern
bash scripts/regex.sh explain "\b\d{1,3}(\.\d{1,3}){3}\b"

# Test regex against a file
bash scripts/regex.sh test "\d{4}-\d{2}-\d{2}" server.log

# Debug a failing regex
bash scripts/regex.sh debug "(\d+\.)+\d+" "192.168.1.1" "should match full IP"

# Convert between languages
bash scripts/regex.sh convert "(?P<year>\d{4})" --from python --to go

# Quick reference
bash scripts/regex.sh cheatsheet
```

Get a free API key at [evolink.ai/signup](https://evolink.ai/signup)

## What This Skill Does

### Local Commands (no API key needed)

| Command | Description |
|---------|-------------|
| `cheatsheet` | Regex syntax quick reference |

### AI Commands (require EVOLINK_API_KEY)

| Command | Description |
|---------|-------------|
| `generate "<desc>" [--lang <lang>]` | AI generate regex from natural language |
| `explain "<pattern>" [--lang <lang>]` | AI explain regex pattern in plain language |
| `test "<pattern>" <file>` | AI test regex against file, find matches and edge cases |
| `debug "<pattern>" "<input>" "<expected>"` | AI diagnose regex failures and provide fixes |
| `convert "<pattern>" --from <lang> --to <lang>` | AI convert regex between programming languages |

### Supported Languages

`python` · `javascript` · `go` · `java` · `rust` · `php` · `ruby` · `csharp` · `perl`

## Structure

```
regex-skill-for-openclaw/
├── SKILL.md                    # Skill definition for ClawHub
├── _meta.json                  # Metadata
├── scripts/
│   └── regex.sh                # Core script — all commands
└── npm/
    ├── package.json            # npm package config
    ├── bin/install.js          # npm installer
    └── skill-files/            # Files copied on install
```

## Configuration

| Variable | Default | Required | Description |
|---|---|---|---|
| `EVOLINK_API_KEY` | — | Yes (AI commands) | EvoLink API key. [Get one free](https://evolink.ai/signup) |
| `EVOLINK_MODEL` | `claude-opus-4-6` | No | AI model for analysis |

Required: `python3`, `curl`

## Security & Data

- AI commands send regex patterns and test content to `api.evolink.ai` for analysis. Data is not stored after response.
- `cheatsheet` runs entirely locally — no network access.
- Temporary files are cleaned up automatically. No credentials stored.

## Links

- [ClawHub](https://clawhub.ai/evolinkai/ai-regex-assistant)
- [EvoLink API Docs](https://docs.evolink.ai)
- [Discord](https://discord.com/invite/5mGHfA24kn)

## License

MIT
