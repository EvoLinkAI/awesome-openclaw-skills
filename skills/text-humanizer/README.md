# Humanize Text

**English** | [中文](README_zh.md) | [日本語](README_ja.md) | [한국어](README_ko.md) | [Русский](README_ru.md) | [हिन्दी](README_hi.md) | [Deutsch](README_de.md) | [Français](README_fr.md) | [Italiano](README_it.md)

Remove AI writing patterns from any text. Supports 29+ languages.

Paste a blog post, email, essay, or report — get back a clean version that sounds like a real person wrote it.

Powered by [Evolink.ai](https://evolink.ai?utm_source=github&utm_medium=skill&utm_campaign=humanize)

## How to use

Just tell your agent:
- "Humanize this text"
- "Make this sound more natural"
- "Remove the AI tone from this paragraph"
- "Rewrite this to sound like a real person wrote it"

Or from the command line:

```bash
bash scripts/humanize.sh "draft.txt"
bash scripts/humanize.sh "draft.txt" "casual blog post"
echo "Your text here" | bash scripts/humanize.sh -
```

## What it does

**Layer 1 — Pattern Scanner**: Detects 24 common AI writing patterns across vocabulary, structure, tone, and formatting.

**Layer 2 — Rewriter**: Replaces flagged phrases with natural alternatives. Varies sentence rhythm, cuts filler.

**Layer 3 — Style Adapter**: Matches the rewrite to your context — blog, academic, business email, or casual.

## Patterns it catches

| Category | Examples |
|---|---|
| Filler phrases | "It is worth noting that", "In order to", "Furthermore" |
| Promotional fluff | "groundbreaking", "nestled", "vibrant", "breathtaking" |
| Fake depth | "-ing" chains: "highlighting... showcasing... reflecting..." |
| Vague attribution | "Experts believe", "Studies show" |
| Structural tells | Rule of three, uniform sentence length, formulaic conclusions |
| Vocabulary giveaways | "delve", "tapestry", "landscape", "crucial", "robust", "seamless" |
| Chatbot artifacts | "Great question!", "I hope this helps!" |

## Supported languages

29+ languages including English, Chinese, Japanese, Korean, Russian, Hindi, German, French, Italian, Spanish, Portuguese, Dutch, Polish, Turkish, Arabic, and more.

Language is auto-detected. No configuration needed.

## Example

**Before** (AI-heavy):

> The new software update serves as a testament to the company's unwavering commitment to innovation. Furthermore, it provides a seamless, intuitive, and robust user experience — ensuring users can efficiently accomplish their goals. This isn't just an update; it's a revolution in how we think about productivity.

**After**:

> The new software update includes batch processing, keyboard shortcuts, and an offline mode. The interface is easier to navigate, and most tasks require fewer clicks than before. It's a solid improvement to the workflow.

## Setup

1. Get an API key at [evolink.ai/signup](https://evolink.ai/signup?utm_source=github&utm_medium=readme&utm_campaign=text-humanizer-skill-for-openclaw?utm_source=github&utm_medium=skill&utm_campaign=humanize)
2. Set the environment variable:

```bash
export EVOLINK_API_KEY="your-key-here"
```

## Configuration

| Variable | Default | Description |
|---|---|---|
| `EVOLINK_API_KEY` | (required) | Your Evolink API key |
| `EVOLINK_MODEL` | `claude-opus-4-6` | Model for processing. Switch to any model supported by the [Evolink API](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=humanize) |

## Security & Trust

This skill's code, runtime instructions, and resource requirements are consistent with its stated purpose (detecting and rewriting AI-style writing patterns).

### Purpose & Capability
- Name and description align with the included code (pattern detectors, vocabulary lists, rewriting engine)
- The declared requirements are minimal (`EVOLINK_API_KEY` only) — no unrelated binaries or system dependencies

### Instruction Scope
- SKILL.md instructs the agent to scan and rewrite user-provided text for 24 defined patterns
- It does not instruct reading unrelated files, modifying system config, or exfiltrating data
- All processing is scoped to user-provided text content only

### File Access Controls
- **Path Pinning**: File paths are resolved via `realpath` and restricted to a configurable safe directory (default: `~/.openclaw/workspace`)
- **Path Traversal Prevention**: `../` sequences are blocked by the `realpath` check
- **Sensitive File Blacklist**: Access to `.env`, `*.key`, `id_rsa*`, `config.json`, `.bash_history`, `.ssh` is hardcoded blocked
- **Size Limit**: 5MB maximum for text files — prevents memory exhaustion
- **MIME Validation**: Only `text/*` and `application/json` files are accepted via `file --mime-type` check

### Credentials & Network
- Only one credential required: `EVOLINK_API_KEY` for the Evolink API (`api.evolink.ai`)
- No other external endpoints are contacted
- No data is stored after processing

### Persistence & Privilege
- The skill does not modify other skills or system-wide settings
- No elevated or persistent privileges are requested

### Source Code
- Full source is available at [GitHub](https://github.com/EvoLinkAI/text-humanizer-skill-for-openclaw)

## Links

- [Source Code](https://github.com/EvoLinkAI/text-humanizer-skill-for-openclaw) — GitHub repository
- [API Docs (EN)](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=humanize) — API reference
- [API Docs (中文)](https://docs.evolink.ai/cn/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=humanize) — API documentation
- [Get API Key](https://evolink.ai/signup?utm_source=github&utm_medium=readme&utm_campaign=text-humanizer-skill-for-openclaw?utm_source=github&utm_medium=skill&utm_campaign=humanize) — Free signup

## License

MIT

Powered by [Evolink.ai](https://evolink.ai?utm_source=github&utm_medium=skill&utm_campaign=humanize)
