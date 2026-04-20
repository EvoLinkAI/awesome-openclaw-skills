---
name: Debug Assistant
description: AI-powered debugging assistant. Analyze error logs, explain error messages, parse stack traces, and get fix suggestions with cheatsheets for 8 languages. Powered by evolink.ai
version: 1.0.0
homepage: https://github.com/EvoLinkAI/debug-skill-for-openclaw
metadata: {"openclaw":{"homepage":"https://github.com/EvoLinkAI/debug-skill-for-openclaw","requires":{"bins":["python3","curl"],"env":["EVOLINK_API_KEY"]},"primaryEnv":"EVOLINK_API_KEY"}}
---

# Debug Assistant

AI-powered debugging from your terminal. Analyze error logs, explain error messages, parse stack traces, get fix suggestions, and access debugging cheatsheets for 8 languages.

Powered by [Evolink.ai](https://evolink.ai?utm_source=clawhub&utm_medium=skill&utm_campaign=debug)

## When to Use

- User shares an error log and asks "what went wrong?"
- User pastes an error message and wants an explanation
- User has a stack trace and needs help understanding it
- User has buggy code and a known error, wants fix suggestions
- User needs quick debugging commands for a specific language

## Quick Start

### 1. Set your EvoLink API key

    export EVOLINK_API_KEY="your-key-here"

Get a free key: [evolink.ai/signup](https://evolink.ai/signup?utm_source=clawhub&utm_medium=skill&utm_campaign=debug)

### 2. Analyze an error

    bash scripts/debug.sh analyze error.log

    bash scripts/debug.sh explain "Cannot read property 'map' of undefined"

### 3. Get a cheatsheet

    bash scripts/debug.sh cheatsheet python

## Capabilities

### AI Commands (require EVOLINK_API_KEY)

| Command | Description |
|---------|-------------|
| `analyze <file>` | Analyze error log — summary, root cause, error chain, fix steps |
| `explain <error_message>` | Explain error — meaning, common causes, quick fix, proper fix |
| `trace <file>` | Parse stack trace — origin, call chain, root cause, fix |
| `suggest <file> --error <msg>` | Fix suggestions — bug location, why it fails, corrected code |

### Info Commands (no API key needed)

| Command | Description |
|---------|-------------|
| `languages` | List all supported languages |
| `cheatsheet [language]` | Debugging commands and common errors |

### Supported Languages

| Language | Debugger | Key Tools |
|----------|----------|-----------|
| `javascript` | Node --inspect, Chrome DevTools | console.trace, memory profiling |
| `python` | pdb, breakpoint() | tracemalloc, cProfile |
| `go` | Delve | -race flag, pprof |
| `rust` | rust-gdb, rust-lldb | RUST_BACKTRACE, env_logger |
| `java` | Remote JDWP | jmap, jstack, GC logging |
| `network` | curl -v, dig | lsof, netstat, ss |
| `css` | Outline trick | Grid/Flex inspectors |
| `git` | git bisect | Automated bisect with test scripts |

## Examples

### Analyze an error log

    bash scripts/debug.sh analyze server-crash.log

Output:

    **Error Summary:** Node.js process crashed due to unhandled promise rejection
    in the database connection pool.

    **Root Cause:** The PostgreSQL connection string contains an expired SSL
    certificate path, causing all new connections to fail silently...

    **Fix Steps:**
    1. Update the SSL certificate at /etc/ssl/certs/db.pem
    2. ...

### Explain an error message

    bash scripts/debug.sh explain "ECONNREFUSED 127.0.0.1:5432"

### Parse a stack trace

    bash scripts/debug.sh trace crash-dump.txt

### Suggest fixes for buggy code

    bash scripts/debug.sh suggest api/handler.py --error "KeyError: 'user_id'"

## Configuration

| Variable | Default | Required | Description |
|---|---|---|---|
| `EVOLINK_API_KEY` | — | Yes | Your EvoLink API key. [Get one free](https://evolink.ai/signup?utm_source=clawhub&utm_medium=skill&utm_campaign=debug) |
| `EVOLINK_MODEL` | `claude-opus-4-6` | No | Model for AI analysis |

Required binaries: `python3`, `curl`

## Security

**Data Transmission**

AI commands send user-provided content (error logs, messages, code files) to `api.evolink.ai` for analysis by Claude. By setting `EVOLINK_API_KEY` and using these commands, you consent to this transmission. Data is not stored after the response is returned. The `languages` and `cheatsheet` commands run entirely locally and never transmit data.

**Network Access**

- `api.evolink.ai` — AI error analysis (AI commands only)

**Persistence & Privilege**

This skill creates temporary files for API payload construction which are cleaned up automatically. No credentials or persistent data are stored. The skill only reads files explicitly passed as arguments — it never scans or reads files on its own.

## Links

- [GitHub](https://github.com/EvoLinkAI/debug-skill-for-openclaw)
- [EvoLink API](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=clawhub&utm_medium=skill&utm_campaign=debug)
- [Community](https://discord.com/invite/5mGHfA24kn)
- [Support](mailto:support@evolink.ai)
