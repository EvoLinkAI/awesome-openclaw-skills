---
name: web-research
description: Веб-поиск через EvoLink API. Возвращает чистые, отформатированные результаты с заголовками, URL и описаниями. Powered by evolink.ai
metadata: {"clawdbot":{"emoji":"🔍","requires":{"bins":["bash","curl","jq"],"env":["EVOLINK_API_KEY"]},"primaryEnv":"EVOLINK_API_KEY"}}
---

# Web Search Assistant

Веб-поиск с использованием EvoLink API. Возвращает чистые, отформатированные результаты с заголовками, URL и описаниями.

Powered by [Evolink.ai](https://evolink.ai?utm_source=clawhub&utm_medium=skill&utm_campaign=web-search)

## Когда использовать

Используйте этот навык, когда пользователи запрашивают:
- Веб-поиск информации или ресурсов
- Поиск текущей или недавней информации онлайн
- Исследования, требующие актуальных веб-данных
- Проверку фактов или верификацию с использованием веб-источников
- Сбор URL и ресурсов по теме

## Поиск

```bash
{baseDir}/scripts/search.sh "запрос"
{baseDir}/scripts/search.sh "запрос" 20
```

## Опции

- `<query>`: Поисковый запрос
- `<max_results>`: Количество результатов (по умолчанию: 10)

## Настройка

Установите ваш API-ключ EvoLink:

```bash
export EVOLINK_API_KEY="your-evolink-api-key-here"
```

👉 [Получить бесплатный API-ключ](https://evolink.ai/signup?utm_source=clawhub&utm_medium=skill&utm_campaign=web-search)

## Пример

```bash
bash scripts/search.sh "Claude Opus 4 features"
```

Вывод:
```
🔍 Поиск: Claude Opus 4 features

📄 Claude Opus 4: New Features and Capabilities
🔗 https://example.com/opus-4
📝 Comprehensive guide to Claude Opus 4's new features...

📄 What's New in Claude Opus 4
🔗 https://example.com/whats-new
📝 Latest updates and improvements in Claude Opus 4...
```

## Безопасность

**Учетные данные и сеть**

`EVOLINK_API_KEY` требуется для вызова EvoLink API. Ваши поисковые запросы отправляются на `api.evolink.ai` для обработки. EvoLink обрабатывает веб-поиск внутренне и возвращает отформатированные результаты.

**Доступ к файлам**

Этот навык не читает и не записывает файлы.

**Сетевой доступ**

Этот навык выполняет сетевые запросы к:
- **EvoLink API** (`api.evolink.ai`) - для выполнения веб-поиска

Все сетевые вызовы выполняются через curl и могут быть проверены в исходном коде скрипта.

**Постоянство и привилегии**

Этот навык не изменяет другие навыки или системные настройки. Повышенные или постоянные привилегии не запрашиваются.

## Ссылки

- [ClawHub](https://clawhub.ai/evolinkai/web-research)
- [Справочник API](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=clawhub&utm_medium=skill&utm_campaign=web-search)
- [Сообщество](https://discord.com/invite/5mGHfA24kn)
- [Поддержка](mailto:support@evolink.ai)
