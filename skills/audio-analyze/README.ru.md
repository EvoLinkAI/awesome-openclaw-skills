# audio-analyze-skill-for-openclaw

Транскрибируйте и анализируйте аудио/видео контент с высокой точностью. [Powered by Evolink.ai](https://evolink.ai/?utm_source=github&utm_medium=skill&utm_campaign=audio-analyze)

🌐 [English](README.md) | [日本語](README.ja.md) | [简体中文](README.zh-CN.md) | [한국어](README.ko.md) | [Español](README.es.md) | [Français](README.fr.md) | [Deutsch](README.de.md) | [Türkçe](README.tr.md) | [Русский](README.ru.md)

## Что это такое?

Автоматически транскрибируйте и анализируйте ваши аудио/видео файлы с помощью Gemini 3.1 Pro. [Получите бесплатный API ключ →](https://evolink.ai/signup?utm_source=github&utm_medium=skill&utm_campaign=audio-analyze)

## Установка

### Через ClawHub (Рекомендуется)

```bash
openclaw skills add https://github.com/EvoLinkAI/audio-analyze-skill-for-openclaw
```

### Ручная Установка

```bash
git clone https://github.com/EvoLinkAI/audio-analyze-skill-for-openclaw
cd audio-analyze-skill-for-openclaw
pip install -r requirements.txt
```

## Конфигурация

| Переменная | Описание | По умолчанию |
| :--- | :--- | :--- |
| `EVOLINK_API_KEY` | API ключ Evolink | (Обязательно) |
| `EVOLINK_MODEL` | Модель транскрипции | gemini-3.1-pro-preview-customtools |

*Для подробной конфигурации API и поддержки моделей см. [Документацию API EvoLink](https://docs.evolink.ai/en/api-manual/language-series/gemini-3.1-pro-preview-customtools/openai-sdk/openai-sdk-quickstart?utm_source=github&utm_medium=skill&utm_campaign=audio-analyze).*

## Использование

### Базовое Использование

```bash
export EVOLINK_API_KEY="your-key-here"
./scripts/transcribe.sh audio.mp3
```

### Расширенное Использование

```bash
./scripts/transcribe.sh audio.mp3 --diarize --lang ja
```

### Пример Вывода

* **TL;DR**: Аудио представляет собой образец трека для тестирования.
* **Ключевые Моменты**: Высококачественный звук, четкая частотная характеристика.
* **Действия**: Загрузить в продакшн для финального тестирования.

## Доступные Модели

- **Серия Gemini** (OpenAI API — `/v1/chat/completions`)

## Структура Файлов

```
.
├── README.md
├── SKILL.md
├── _meta.json
├── scripts/
│   └── transcribe.sh
└── references/
    └── api-params.md
```

## Устранение Неполадок

- **Argument list too long**: Используйте временные файлы для больших аудио данных.
- **API Key Error**: Убедитесь, что `EVOLINK_API_KEY` экспортирован.

## Ссылки

- [ClawHub](https://clawhub.ai/EvoLinkAI/audio-analyze)
- [Справочник API](https://docs.evolink.ai/en/api-manual/language-series/gemini-3.1-pro-preview-customtools/openai-sdk/openai-sdk-quickstart?utm_source=github&utm_medium=skill&utm_campaign=audio-analyze)
- [Сообщество](https://discord.com/invite/5mGHfA24kn)
- [Поддержка](mailto:support@evolink.ai)

## Лицензия

MIT
