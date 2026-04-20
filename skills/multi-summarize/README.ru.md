# Multi Summarize — Навык ИИ-суммаризации для OpenClaw

Быстрое мультиформатное резюмирование — вставьте URL, загрузите файл, получите ключевые тезисы. Работает на [EvoLink](https://evolink.ai?utm_source=github&utm_medium=readme&utm_campaign=multi-summarize-skill-for-openclaw?utm_source=github&utm_medium=skill&utm_campaign=summarize).

 [Описание](#описание) •
 [Установка](#установка) •
 [API Key](#получение-api-key) •
 [Использование](#использование) •
 [EvoLink](https://evolink.ai?utm_source=github&utm_medium=readme&utm_campaign=multi-summarize-skill-for-openclaw?utm_source=github&utm_medium=skill&utm_campaign=summarize)

 🌐 Languages:
 [English](/EvoLinkAI/multi-summarize-skill-for-openclaw/blob/main/README.md) |
 [简体中文](/EvoLinkAI/multi-summarize-skill-for-openclaw/blob/main/README.zh-CN.md) |
 [日本語](/EvoLinkAI/multi-summarize-skill-for-openclaw/blob/main/README.ja.md) |
 [한국어](/EvoLinkAI/multi-summarize-skill-for-openclaw/blob/main/README.ko.md) |
 [Español](/EvoLinkAI/multi-summarize-skill-for-openclaw/blob/main/README.es.md) |
 [Français](/EvoLinkAI/multi-summarize-skill-for-openclaw/blob/main/README.fr.md) |
 [Deutsch](/EvoLinkAI/multi-summarize-skill-for-openclaw/blob/main/README.de.md) |
 [Türkçe](/EvoLinkAI/multi-summarize-skill-for-openclaw/blob/main/README.tr.md) |
 [Русский](/EvoLinkAI/multi-summarize-skill-for-openclaw/blob/main/README.ru.md)

## Описание

Навык [OpenClaw](https://github.com/openclaw/openclaw), работающий на [EvoLink](https://evolink.ai?utm_source=github&utm_medium=readme&utm_campaign=multi-summarize-skill-for-openclaw?utm_source=github&utm_medium=skill&utm_campaign=summarize). Установите один навык, и ваш ИИ-агент сможет резюмировать любой контент — URL, PDF, видео, аудиофайлы, ссылки YouTube или обычный текст — в краткие и практичные ключевые тезисы с помощью Claude Opus 4.6, самой мощной текстовой модели на сегодняшний день.

🚀 [Получить API Key →](https://evolink.ai/signup?utm_source=github&utm_medium=readme&utm_campaign=multi-summarize-skill-for-openclaw?utm_source=github&utm_medium=skill&utm_campaign=summarize)

## Установка

### Быстрая установка (Рекомендуется)

```bash
openclaw skills add https://github.com/EvoLinkAI/multi-summarize-skill-for-openclaw
```

Готово. Навык готов к использованию.

### Через ClawHub

```bash
clawhub install multi-summarize
```

### Ручная установка

```bash
git clone https://github.com/EvoLinkAI/multi-summarize-skill-for-openclaw.git
cd multi-summarize-skill-for-openclaw
openclaw skills add .
```

## Получение API Key

1. Зарегистрируйтесь [здесь](https://evolink.ai/signup?utm_source=github&utm_medium=readme&utm_campaign=multi-summarize-skill-for-openclaw?utm_source=github&utm_medium=skill&utm_campaign=summarize)
2. Перейдите в Dashboard → API Keys
3. Создайте новый Key
4. Установите переменную окружения:

```bash
export EVOLINK_API_KEY=your_key_here
```

Или просто скажите вашему агенту OpenClaw: «Установи мой EvoLink API key на ...» — он сделает всё сам.

## Использование

### Поддерживаемые форматы

- **Веб-URL** — Статьи, блоги, документация
- **PDF** — Отчёты, научные статьи, технические документы
- **Видео** — mp4, webm, ссылки YouTube
- **Аудио** — mp3, wav, m4a, подкасты
- **Текст** — Markdown, обычный текст, файлы кода

### Примеры использования

Просто говорите с агентом естественным языком:

```
«Резюмируй эту статью: https://evolink.ai/blog/deepseek-v4-release-window-prep»?utm_source=github&utm_medium=readme&utm_campaign=multi-summarize
«О чём этот PDF?» (прикрепите файл)
«Дай мне ключевые тезисы из этого видео на YouTube: https://youtu.be/...»
«Резюмируй эту запись подкаста» (прикрепите mp3)
«Сделай TL;DR этого документа»
```

### Справка по скрипту

Навык включает `scripts/summarize.sh` для прямого использования из командной строки:

```bash
# Резюмировать веб-статью
bash scripts/summarize.sh "https://evolink.ai/blog/deepseek-v4-release-window-prep?utm_source=github&utm_medium=readme&utm_campaign=multi-summarize"

# Резюмировать локальный PDF
bash scripts/summarize.sh "/path/to/report.pdf"

# Резюмировать видео YouTube
bash scripts/summarize.sh "https://youtu.be/VIDEO_ID"

# Резюмировать аудиофайл
bash scripts/summarize.sh "/path/to/podcast.mp3"

# Резюмировать с пользовательским фокусом
bash scripts/summarize.sh "https://evolink.ai/blog/deepseek-v4-release-window-prep?utm_source=github&utm_medium=readme&utm_campaign=multi-summarize" "Фокус на графике выпуска"
```

### Пример вывода

```
## TL;DR
О DeepSeek V4 ходят слухи с января 2026 года, но по состоянию на март модель
так и не была официально выпущена. Несколько прогнозируемых окон запуска прошли.
Ожидается, что модель будет ориентирована на программирование с результатами HumanEval 90% (не подтверждено).

## Ключевые тезисы
- Reuters сообщил в январе, что DeepSeek планирует модель для программирования на февраль 2026
- DeepSeek тихо расширил контекстное окно со 128K до 1M токенов в феврале — вероятно, тестирование инфраструктуры V4
- Неподтверждённые бенчмарки заявляют HumanEval 90%, SWE-bench Verified 80%+
- «V4 Lite» появился на сайте DeepSeek в марте, но так и не был официально подтверждён
- Несколько окон запуска (середина февраля, Лунный Новый год, начало марта) прошли без релиза

## Рекомендуемые действия
- Не мигрировать рабочие нагрузки до официального объявления
- Отслеживать официальные каналы DeepSeek для подтверждённых спецификаций
- Подготовить API-интеграцию — EvoLink поддержит V4 с первого дня
```

## Конфигурация

Модель по умолчанию: `claude-opus-4-6` (дополнительная настройка не требуется).

Для использования другой модели:

```bash
export EVOLINK_MODEL="claude-sonnet-4-5-20250929"
```

### Доступные модели

**Серия Claude** (формат API Anthropic — `/v1/messages`)
- **claude-opus-4-6** — Наивысшее качество (по умолчанию)
- **claude-sonnet-4-6** — Новейший Sonnet, быстрый + мощный
- **claude-sonnet-4-5-20250929** — Быстрый + экономичный
- **claude-haiku-4-5-20251001** — Сверхбыстрый, лёгкие задачи

**Серия GPT** (формат API OpenAI — `/v1/chat/completions`)
- **gpt-5.4** — Новейшая флагманская модель OpenAI
- **gpt-4o** — Мультимодальная, быстрая
- **gpt-4o-mini** — Лёгкая, экономичная

**Серия Gemini** (формат API OpenAI — `/v1/chat/completions`)
- **gemini-3.1-flash-lite-preview** — Сверхбыстрая лёгкая модель Google
- **gemini-3-flash-preview** — Быстрая, идеальна для резюмирования

### Справка по API

Полная документация API [здесь](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=summarize).

## Структура файлов

```
.
├── README.md              # English
├── README.zh-CN.md        # 简体中文
├── README.ja.md           # 日本語
├── README.ko.md           # 한국어
├── README.es.md           # Español
├── README.fr.md           # Français
├── README.de.md           # Deutsch
├── README.tr.md           # Türkçe
├── README.ru.md           # Русский
├── SKILL.md               # OpenClaw skill definition
├── references/
│   └── api-params.md      # Full API parameter docs
└── scripts/
    └── summarize.sh       # Summarization script
```

## Устранение неполадок

- **`python3: command not found`** — Установите Python 3: `apt install python3` / `brew install python3`
- **`curl: command not found`** — Установите curl: `apt install curl` / `brew install curl`
- **`401 Unauthorized`** — Проверьте EVOLINK_API_KEY в [панели управления](https://evolink.ai/dashboard?utm_source=github&utm_medium=readme&utm_campaign=multi-summarize-skill-for-openclaw?utm_source=github&utm_medium=skill&utm_campaign=summarize)
- **`402 Payment Required`** — Пополните баланс в [панели управления](https://evolink.ai/dashboard?utm_source=github&utm_medium=readme&utm_campaign=multi-summarize-skill-for-openclaw?utm_source=github&utm_medium=skill&utm_campaign=summarize)
- **Ошибка извлечения PDF** — Установите markitdown: `pip install markitdown` или poppler: `apt install poppler-utils`
- **Ошибка извлечения YouTube** — Установите yt-dlp: `pip install yt-dlp`
- **Ошибка транскрипции аудио** — Установите whisper: `pip install openai-whisper`

## Ссылки

- [ClawHub](https://clawhub.ai/EvoLinkAI/multi-summarize)
- [API Reference](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=summarize)
- [Community](https://discord.com/invite/5mGHfA24kn)
- [Support](mailto:support@evolink.ai)

## Лицензия

MIT
