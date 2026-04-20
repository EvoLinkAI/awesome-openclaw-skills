🌐 [English](README.md) | [日本語](README.ja.md) | [한국어](README.ko.md) | [简体中文](README.zh-CN.md) | [Français](README.fr.md) | [Deutsch](README.de.md) | Русский | [हिन्दी](README.hi.md) | [Türkçe](README.tr.md)

# Web Search Assistant

**Веб-поиск на основе ИИ с использованием EvoLink API**

Powered by [Evolink.ai](https://evolink.ai?utm_source=github&utm_medium=skill&utm_campaign=web-search)

Ищите в интернете и получайте чистые, отформатированные результаты с заголовками, URL и описаниями.

## 🚀 Быстрый старт

```bash
bash scripts/search.sh "AI coding assistants 2026"
bash scripts/search.sh "quantum computing breakthroughs" 20
```

## 🔑 Настройка

Установите ваш API-ключ EvoLink:

```bash
export EVOLINK_API_KEY="your-evolink-api-key-here"
```

👉 [Получить бесплатный API-ключ](https://evolink.ai/signup?utm_source=github&utm_medium=skill&utm_campaign=web-search)

## 📖 Использование

### Базовый поиск

```bash
bash scripts/search.sh "поисковый запрос"
```

Возвращает топ-10 результатов.

### Ограничение результатов

```bash
bash scripts/search.sh "поисковый запрос" 20
```

Укажите максимальное количество результатов.

## 🔒 Безопасность

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

## 📄 Лицензия

MIT

## 🔗 Ссылки

- [ClawHub](https://clawhub.ai/evolinkai/web-research)
- [Справочник API](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=web-search)
- [Сообщество](https://discord.com/invite/5mGHfA24kn)
- [Поддержка](mailto:support@evolink.ai)
