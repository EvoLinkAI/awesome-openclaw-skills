# Buddy Skill — Дистиллируйте идеального напарника в ИИ

> *Всё может быть напарником.*

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![EvoLink](https://img.shields.io/badge/Powered%20by-EvoLink-blue)](https://evolink.ai?utm_source=github&utm_medium=skill&utm_campaign=buddy)

Предоставьте материалы о вашем напарнике (история WeChat, сообщения QQ, скриншоты соцсетей, фото) или просто опишите идеального напарника — создайте **AI Skill, который говорит как они**.

[EvoLink API](https://evolink.ai?utm_source=github&utm_medium=skill&utm_campaign=buddy)

**Language / Язык:**
[English](README.md) | [简体中文](README.zh-CN.md) | [日本語](README.ja.md) | [한국어](README.ko.md) | [Español](README.es.md) | [Français](README.fr.md) | [Deutsch](README.de.md) | [Türkçe](README.tr.md) | [Русский](README.ru.md)

## Установка

```bash
mkdir -p .claude/skills
git clone https://github.com/EvoLinkAI/buddy-skill-for-openclaw .claude/skills/create-buddy
export EVOLINK_API_KEY="your-key-here"
```

Бесплатный ключ: [evolink.ai/signup](https://evolink.ai/signup?utm_source=github&utm_medium=skill&utm_campaign=buddy)

## Использование

В Claude Code введите `/create-buddy`. Ответьте на 3 вопроса, импортируйте данные (или представьте) и готово.

### Команды

| Команда | Описание |
|---------|----------|
| `/create-buddy` | Создать нового напарника |
| `/list-buddies` | Список всех |
| `/{slug}` | Чат с напарником |
| `/{slug}-vibe` | Режим воспоминаний |
| `/update-buddy {slug}` | Добавить воспоминания |
| `/delete-buddy {slug}` | Удалить |

## Возможности

- Множество источников: WeChat, QQ, скриншоты, фото, чистое воображение
- Типы: напарник по еде, учёбе, играм, спорту, путешествиям и другие
- Двухслойная архитектура: Vibe Memory + Persona
- Эволюция: добавление воспоминаний, коррекция ответов, история версий
- ИИ-анализ: EvoLink API (модели Claude)

## Ссылки

- [ClawHub](https://clawhub.ai/evolinkai/buddy-skill-creator)
- [EvoLink API](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=buddy)
- [Сообщество](https://discord.com/invite/5mGHfA24kn)

MIT License © [EvoLinkAI](https://github.com/EvoLinkAI)
