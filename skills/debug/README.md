# Debug Assistant — OpenClaw Skill

AI-powered debugging assistant. Analyze error logs, explain error messages, parse stack traces, and get fix suggestions — all from your terminal.

Powered by [EvoLink.ai](https://evolink.ai)

## Install

### Via ClawHub (Recommended)

```
npx clawhub install debug-assistant
```

### Via npm

```
npx evolinkai-debug-assistant
```

## Quick Start

```bash
# Set your API key
export EVOLINK_API_KEY="your-key-here"

# Analyze an error log file
bash scripts/debug.sh analyze error.log

# Explain an error message
bash scripts/debug.sh explain "Cannot read property 'map' of undefined"

# Parse a stack trace file
bash scripts/debug.sh trace stacktrace.txt

# Get fix suggestions for a code file with known error
bash scripts/debug.sh suggest buggy.py --error "IndexError: list index out of range"
```

Get a free API key at [evolink.ai/signup](https://evolink.ai/signup)

## Links

- [ClawHub](https://clawhub.ai/evolinkai/debug-assistant)
- [EvoLink API Docs](https://docs.evolink.ai)
- [Discord](https://discord.com/invite/5mGHfA24kn)

## License

MIT
