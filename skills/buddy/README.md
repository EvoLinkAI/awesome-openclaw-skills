# Buddy Skill — Distill Your Ideal Buddy into AI

> *Everything can be a buddy.*

**My AI buddy knows me better than I know myself.**

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Python 3.9+](https://img.shields.io/badge/Python-3.9%2B-blue.svg)](https://python.org)
[![Claude Code](https://img.shields.io/badge/Claude%20Code-Skill-blueviolet)](https://claude.ai/code)
[![EvoLink](https://img.shields.io/badge/Powered%20by-EvoLink-blue)](https://evolink.ai?utm_source=github&utm_medium=skill&utm_campaign=buddy)

Provide raw materials about your buddy (WeChat history, QQ messages, social media screenshots, photos) or simply describe your dream buddy — generate a **real AI Skill that talks like them**. Remembers your inside jokes, your favorite spots, and all the times things went hilariously wrong.

Powered by [EvoLink API](https://evolink.ai?utm_source=github&utm_medium=skill&utm_campaign=buddy)

[Install](#installation) · [Usage](#usage) · [Examples](#examples) · [中文](README.zh-CN.md)

**Language / 语言:**
[English](README.md) | [简体中文](README.zh-CN.md) | [日本語](README.ja.md) | [한국어](README.ko.md) | [Español](README.es.md) | [Français](README.fr.md) | [Deutsch](README.de.md) | [Türkçe](README.tr.md) | [Русский](README.ru.md)

---

## Installation

### Claude Code

```bash
mkdir -p .claude/skills
git clone https://github.com/EvoLinkAI/buddy-skill-for-openclaw .claude/skills/create-buddy
```

### ClawHub

```bash
npx clawhub install buddy-skill-creator
```

### Set up EvoLink API Key

```bash
export EVOLINK_API_KEY="your-key-here"
```

Get one free: [evolink.ai/signup](https://evolink.ai/signup?utm_source=github&utm_medium=skill&utm_campaign=buddy)

---

## Usage

In Claude Code, type:

```
/create-buddy
```

Answer 3 questions (nickname, buddy type, personality), optionally import chat history, and your buddy is ready.

Then use `/{slug}` to chat with your buddy.

### Commands

| Command | Description |
|---------|-------------|
| `/create-buddy` | Create a new buddy |
| `/list-buddies` | List all buddy Skills |
| `/{slug}` | Chat with buddy |
| `/{slug}-vibe` | Vibe mode (shared memories) |
| `/update-buddy {slug}` | Add memories / evolve |
| `/delete-buddy {slug}` | Delete buddy |

---

## Examples

> Input: `lunch buddy, coworker Wang, known for 3 years, ESTP, social butterfly, eats everything`

**Lunch invite:**
```
You    ❯ What should we eat for lunch

Buddy  ❯ The eternal question of mankind
        The cafeteria? Nah that pork yesterday still haunts me
        How about that new noodle place?
        I heard it's amazing let's go
```

**Late night:**
```
You    ❯ Still at work, so tired

Buddy  ❯ Bro you're STILL there??
        I just got home, already ordered takeout
        Tomorrow lunch is on me, hang in there
```

---

## Features

- **Multiple data sources**: WeChat, QQ, screenshots, photos, or pure imagination
- **Buddy types**: Lunch buddy, study buddy, gaming buddy, gym buddy, travel buddy, and more
- **Two-layer architecture**: Vibe Memory (shared experiences) + Persona (personality)
- **Evolution**: Add memories, correct responses, version history
- **AI-powered**: Analysis via EvoLink API (Claude models)

## Links

- [ClawHub](https://clawhub.ai/evolinkai/buddy-skill-creator)
- [EvoLink API](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=buddy)
- [Community](https://discord.com/invite/5mGHfA24kn)

## Credits

Inspired by [ex-skill](https://github.com/therealXiaomanChu/ex-skill) and [colleague-skill](https://github.com/titanwings/colleague-skill).

MIT License © [EvoLinkAI](https://github.com/EvoLinkAI)
