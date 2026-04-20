🌐 English | [日本語](README.ja.md) | [한국어](README.ko.md) | [简体中文](README.zh-CN.md) | [Français](README.fr.md) | [Deutsch](README.de.md) | [Русский](README.ru.md) | [हिन्दी](README.hi.md) | [Türkçe](README.tr.md)

# Web Search Assistant

**AI-powered web search using EvoLink API**

Powered by [Evolink.ai](https://evolink.ai?utm_source=github&utm_medium=skill&utm_campaign=web-search)

Search the web and get clean, formatted results with titles, URLs, and descriptions.

## 🚀 Quick Start

```bash
bash scripts/search.sh "AI coding assistants 2026"
bash scripts/search.sh "quantum computing breakthroughs" 20
```

## 🔑 Configuration

Set your EvoLink API key:

```bash
export EVOLINK_API_KEY="your-evolink-api-key-here"
```

👉 [Get free API key](https://evolink.ai/signup?utm_source=github&utm_medium=skill&utm_campaign=web-search)

## 📖 Usage

### Basic Search

```bash
bash scripts/search.sh "search query"
```

Returns top 10 results.

### Limit Results

```bash
bash scripts/search.sh "search query" 20
```

Specify maximum number of results.

## 🔒 Security

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

## 📄 License

MIT

## 🔗 Links

- [ClawHub](https://clawhub.ai/evolinkai/web-research)
- [API Reference](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=web-search)
- [Community](https://discord.com/invite/5mGHfA24kn)
- [Support](mailto:support@evolink.ai)
