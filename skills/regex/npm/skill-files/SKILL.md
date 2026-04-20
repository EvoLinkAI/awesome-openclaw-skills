---
name: Regex Assistant
description: AI-powered regular expression generation, explanation, testing, debugging, and cross-language conversion. Generate regex from natural language, explain complex patterns, test against files, debug failures, and convert between Python, JavaScript, Go, Java, Rust and more. Powered by evolink.ai
version: 1.0.0
homepage: https://github.com/EvoLinkAI/regex-skill-for-openclaw
metadata: {"openclaw":{"homepage":"https://github.com/EvoLinkAI/regex-skill-for-openclaw","requires":{"bins":["python3","curl"],"env":["EVOLINK_API_KEY"]},"primaryEnv":"EVOLINK_API_KEY"}}
---

# Regex Assistant

AI-powered regular expression generation, explanation, testing, debugging, and cross-language conversion from your terminal.

Powered by [Evolink.ai](https://evolink.ai?utm_source=clawhub&utm_medium=skill&utm_campaign=regex)

## When to Use

- User wants to generate a regex pattern from a plain language description
- User asks to explain what a regex pattern does
- User needs to test a regex against a file and find matches/edge cases
- User has a regex that doesn't work and needs debugging
- User needs to convert a regex between programming languages
- User wants a quick reference for regex syntax

## Quick Start

### 1. Set your EvoLink API key

    export EVOLINK_API_KEY="your-key-here"

Get a free key: [evolink.ai/signup](https://evolink.ai/signup?utm_source=clawhub&utm_medium=skill&utm_campaign=regex)

### 2. Generate a regex

    bash scripts/regex.sh generate "match email addresses" --lang python

### 3. Explain a regex

    bash scripts/regex.sh explain "(?<=@)[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}"

## Capabilities

### Local Commands (no API key needed)

| Command | Description |
|---------|-------------|
| `cheatsheet` | Regex syntax quick reference — characters, quantifiers, groups, flags, common patterns |

### AI Commands (require EVOLINK_API_KEY)

| Command | Description |
|---------|-------------|
| `generate "<desc>" [--lang <lang>]` | AI generate regex from natural language with usage examples |
| `explain "<pattern>" [--lang <lang>]` | AI explain regex pattern component by component |
| `test "<pattern>" <file>` | AI test regex against file content, find matches and edge cases |
| `debug "<pattern>" "<input>" "<expected>"` | AI diagnose why a regex fails and provide a fix |
| `convert "<pattern>" --from <lang> --to <lang>` | AI convert regex between programming languages |

### Supported Languages

`python` · `javascript` · `go` · `java` · `rust` · `php` · `ruby` · `csharp` · `perl`

## Examples

### Generate a regex for URLs

    bash scripts/regex.sh generate "match HTTP and HTTPS URLs" --lang javascript

### Explain a complex pattern

    bash scripts/regex.sh explain "\b\d{1,3}(\.\d{1,3}){3}\b"

### Test a regex against a log file

    bash scripts/regex.sh test "\d{4}-\d{2}-\d{2}" server.log

### Debug a failing regex

    bash scripts/regex.sh debug "(\d+\.)+\d+" "192.168.1.1" "should match full IP but only matches partial"

### Convert Python regex to Go

    bash scripts/regex.sh convert "(?P<year>\d{4})-(?P<month>\d{2})" --from python --to go

### Quick reference

    bash scripts/regex.sh cheatsheet

## Configuration

| Variable | Default | Required | Description |
|---|---|---|---|
| `EVOLINK_API_KEY` | — | Yes (AI commands) | Your EvoLink API key. [Get one free](https://evolink.ai/signup?utm_source=clawhub&utm_medium=skill&utm_campaign=regex) |
| `EVOLINK_MODEL` | `claude-opus-4-6` | No | Model for AI analysis |

Required binaries: `python3`, `curl`

## Security

**Data Transmission**

AI commands send regex patterns and test content to `api.evolink.ai` for analysis by Claude. By setting `EVOLINK_API_KEY` and using these commands, you consent to this transmission. Data is not stored after the response is returned. The `cheatsheet` command runs entirely locally and never transmits data.

**Network Access**

- `api.evolink.ai` — AI analysis (AI commands only)

**Persistence & Privilege**

Temporary files for API payloads are cleaned up automatically. No credentials or persistent data are stored.

## Links

- [GitHub](https://github.com/EvoLinkAI/regex-skill-for-openclaw)
- [EvoLink API](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=clawhub&utm_medium=skill&utm_campaign=regex)
- [Community](https://discord.com/invite/5mGHfA24kn)
- [Support](mailto:support@evolink.ai)
