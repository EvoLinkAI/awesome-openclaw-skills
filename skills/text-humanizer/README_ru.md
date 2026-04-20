# Гуманизация текста

[English](README.md) | [中文](README_zh.md) | [日本語](README_ja.md) | [한국어](README_ko.md) | **Русский** | [हिन्दी](README_hi.md) | [Deutsch](README_de.md) | [Français](README_fr.md) | [Italiano](README_it.md)

Удаление паттернов ИИ-письма из любого текста. Поддержка 29+ языков.

Вставьте блог-пост, письмо, эссе или отчёт — получите чистую версию, написанную как живой человек.

Powered by [Evolink.ai](https://evolink.ai?utm_source=github&utm_medium=skill&utm_campaign=humanize)

## Как использовать

Скажите вашему агенту:
- "Humanize this text"
- "Сделай текст более естественным"
- "Make this sound more natural"
- "Убери ИИ-стиль из этого текста"

Из командной строки:

```bash
bash scripts/humanize.sh "draft.txt"
bash scripts/humanize.sh "draft.txt" "casual blog post"
echo "Your text here" | bash scripts/humanize.sh -
```

## Как это работает

**Уровень 1 — Сканер паттернов**: Обнаруживает 24 типичных паттерна ИИ-письма в лексике, структуре, тоне и форматировании.

**Уровень 2 — Перезапись**: Заменяет отмеченные фразы естественными альтернативами, варьирует ритм предложений, убирает воду.

**Уровень 3 — Стилевая адаптация**: Подстраивает текст под контекст — блог, академический, деловое письмо, разговорный.

## Обнаруживаемые паттерны

| Категория | Примеры |
|---|---|
| Слова-связки | «Кроме того», «Стоит отметить», «Подводя итог» |
| Рекламный стиль | «революционный», «беспрецедентный», «уникальный» |
| Ложная глубина | «демонстрируя… отражая… подчёркивая…» |
| Размытые ссылки | «Эксперты считают», «По мнению специалистов» |
| Структурные маркеры | Правило трёх, одинаковая длина предложений |
| ИИ-лексика | «ключевой», «крайне важный», «бесшовный» |
| Артефакты чат-бота | «Надеюсь, это поможет!», «Если есть вопросы...» |

## Поддерживаемые языки

29+ языков, включая английский, китайский, японский, корейский, русский, хинди, немецкий, французский, итальянский, испанский, португальский, нидерландский, польский, турецкий, арабский и другие.

Язык определяется автоматически. Настройка не требуется.

## Пример

**До** (сильный ИИ-стиль):

> Данное обновление программного обеспечения является ярким свидетельством непоколебимой приверженности компании инновациям. Кроме того, оно обеспечивает бесшовный, интуитивно понятный и надёжный пользовательский опыт, гарантируя эффективное достижение целей пользователями.

**После**:

> В обновлении добавили пакетную обработку, горячие клавиши и офлайн-режим. Интерфейс стал удобнее, большинство операций требуют меньше кликов. Крепкое улучшение.

## Настройка

1. Получите API-ключ на [evolink.ai/signup](https://evolink.ai/signup?utm_source=github&utm_medium=readme&utm_campaign=text-humanizer-skill-for-openclaw?utm_source=github&utm_medium=skill&utm_campaign=humanize)
2. Задайте переменную окружения:

```bash
export EVOLINK_API_KEY="your-key-here"
```

| Переменная | По умолчанию | Описание |
|---|---|---|
| `EVOLINK_API_KEY` | (обязательно) | Ваш Evolink API-ключ |
| `EVOLINK_MODEL` | `claude-opus-4-6` | Модель обработки. Можно переключить на любую модель, поддерживаемую [Evolink API](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=humanize) |

## Безопасность

- **Доступ к файлам**: только в пределах настроенной безопасной директории
- **Блокировка чувствительных файлов**: `.env`, `.ssh`, `config.json`, приватные ключи
- **Лимит размера**: 5 МБ для текстовых файлов
- **MIME-валидация**: принимаются только текстовые файлы
- Данные не сохраняются после обработки

## Ссылки

- [Исходный код](https://github.com/EvoLinkAI/text-humanizer-skill-for-openclaw) — GitHub
- [Документация API (EN)](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=humanize)
- [Документация API (中文)](https://docs.evolink.ai/cn/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=humanize)
- [Получить API-ключ](https://evolink.ai/signup?utm_source=github&utm_medium=readme&utm_campaign=text-humanizer-skill-for-openclaw?utm_source=github&utm_medium=skill&utm_campaign=humanize) — бесплатная регистрация

## Лицензия

MIT

Powered by [Evolink.ai](https://evolink.ai?utm_source=github&utm_medium=skill&utm_campaign=humanize)
