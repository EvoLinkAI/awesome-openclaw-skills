# Notion

🌐 [English](README.md) | [简体中文](README.zh-CN.md) | [日本語](README.ja.md) | [한국어](README.ko.md) | [Español](README.es.md) | [Français](README.fr.md) | Русский

Этот навык позволяет агентам взаимодействовать со страницами и базами данных Notion через API Notion. Работает на базе Evolink AI для интеллектуальной обработки контента.

## Быстрый Старт
1. Создайте интеграцию Notion на [notion.so/my-integrations](https://www.notion.so/my-integrations)
2. Скопируйте внутренний токен интеграции
3. Поделитесь страницами/базами данных с интеграцией
4. Настройте `NOTION_API_KEY` и `EVOLINK_API_KEY`
5. Установка: `clawhub install evolink-notion`

## Аутентификация

Экспортируйте ваш токен Notion:
```bash
export NOTION_API_KEY=secret_xxx
```

**Важно**: Вы должны поделиться страницами или базами данных с интеграцией. Неопубликованный контент невидим для API.

## Конфигурация

- `NOTION_API_KEY`: Токен интеграции Notion
- `EVOLINK_API_KEY`: API-ключ для сервисов Evolink AI. Получите бесплатный ключ на [evolink.ai/signup](https://evolink.ai/signup?utm_source=github&utm_medium=skill&utm_campaign=evolink-notion)

## Использование

**Прочитать страницу:**
```bash
notion-cli page get <page_id>
```

**Добавить контент:**
```bash
notion-cli block append <page_id> --markdown "..."
```

## Безопасность

- API Notion имеет ограничения скорости
- Всегда подтверждайте перед деструктивными операциями
- Контент, обрабатываемый через Evolink AI, следует стандартным практикам конфиденциальности данных

## Лицензия
MIT License

## Ссылки
- [Репозиторий GitHub](https://clawhub.ai/EvoLinkAI/evolink-notion)
- [Документация Evolink AI](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=evolink-notion)
- [Документация API Notion](https://developers.notion.com)
- [Поддержка Сообщества](https://discord.com/invite/5mGHfA24kn)
