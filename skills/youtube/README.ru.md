# YouTube Assistant — Транскрипции и Анализ Видео с ИИ

> *Смотрите умнее, а не дольше.*

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![EvoLink](https://img.shields.io/badge/Powered%20by-EvoLink-blue)](https://evolink.ai?utm_source=github&utm_medium=skill&utm_campaign=youtube)

Получайте транскрипции видео, метаданные и информацию о каналах YouTube. ИИ-резюме контента, извлечение ключевых выводов, сравнительный анализ видео и вопросы по содержанию.

[EvoLink API](https://evolink.ai?utm_source=github&utm_medium=skill&utm_campaign=youtube)

**Language / Язык:**
[English](README.md) | [简体中文](README.zh-CN.md) | [日本語](README.ja.md) | [한국어](README.ko.md) | [Español](README.es.md) | [Français](README.fr.md) | [Deutsch](README.de.md) | [Türkçe](README.tr.md) | [Русский](README.ru.md)

## Установка

```bash
# Установить yt-dlp (обязательно)
pip install yt-dlp

# Установить Skill
mkdir -p .claude/skills
git clone https://github.com/EvoLinkAI/youtube-skill-for-openclaw .claude/skills/youtube-assistant
export EVOLINK_API_KEY="your-key-here"
```

Бесплатный API-ключ: [evolink.ai/signup](https://evolink.ai/signup?utm_source=github&utm_medium=skill&utm_campaign=youtube)

## Использование

```bash
# Получить транскрипцию видео
bash scripts/youtube.sh transcript "https://www.youtube.com/watch?v=VIDEO_ID"

# Получить метаданные видео
bash scripts/youtube.sh info "https://www.youtube.com/watch?v=VIDEO_ID"

# ИИ-резюме видео
bash scripts/youtube.sh ai-summary "https://www.youtube.com/watch?v=VIDEO_ID"
```

### Команды

| Команда | Описание |
|---------|----------|
| `transcript <URL> [--lang]` | Очищенная транскрипция видео |
| `info <URL>` | Метаданные видео |
| `channel <URL> [limit]` | Список видео канала |
| `search <query> [limit]` | Поиск на YouTube |
| `ai-summary <URL>` | ИИ-резюме видео |
| `ai-takeaways <URL>` | Ключевые выводы и действия |
| `ai-compare <URL1> <URL2>` | Сравнение нескольких видео |
| `ai-ask <URL> <question>` | Вопросы по содержанию видео |

## Возможности

- Извлечение субтитров из любого видео (ручные + автосгенерированные)
- Метаданные: название, длительность, просмотры, лайки, описание, теги
- Просмотр каналов и поиск по YouTube
- ИИ: резюме, извлечение ключевых моментов, сравнение видео, Q&A
- Поддержка многоязычных субтитров
- Интеграция EvoLink API (модели Claude)

## Ссылки

- [ClawHub](https://clawhub.ai/evolinkai/youtube-assistant)
- [EvoLink API](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=youtube)
- [Сообщество](https://discord.com/invite/5mGHfA24kn)

MIT License © [EvoLinkAI](https://github.com/EvoLinkAI)
