# Slack Assistant — Навык OpenClaw для Claude Code

Интеграция с API Slack с интеллектуальными функциями ИИ — отправка сообщений, чтение каналов, поиск разговоров и управление рабочими пространствами с функциями резюмирования и составления черновиков на базе Claude. Разработано [evolink.ai](https://evolink.ai?utm_source=github&utm_medium=skill&utm_campaign=slack)

[Что это?](#что-это) | [Установка](#установка) | [Настройка](#руководство-по-настройке) | [Использование](#использование) | [EvoLink](https://evolink.ai?utm_source=github&utm_medium=skill&utm_campaign=slack)

**Language / Язык:**
[English](README.md) | [简体中文](README.zh-CN.md) | [日本語](README.ja.md) | [한국어](README.ko.md) | [Español](README.es.md) | [Français](README.fr.md) | [Deutsch](README.de.md) | [Türkçe](README.tr.md) | [Русский](README.ru.md)

## Что это?

Навык [OpenClaw](https://clawhub.ai), который подключает Claude Code к вашему рабочему пространству Slack. Просто скажите Claude, что вам нужно:

- «Отправь сообщение в #general»
- «Что происходит в #engineering?»
- «Резюмируй последние 50 сообщений в #product»
- «Составь черновик ответа на этот тред»

## Установка

### Вариант 1: ClawHub (Рекомендуется)
```bash
npx clawhub install slack-assistant
```

### Вариант 2: npm
```bash
npx evolinkai-slack-assistant
```

### Вариант 3: Вручную
```bash
git clone https://github.com/EvoLinkAI/slack-skill-for-openclaw.git
cp -r slack-skill-for-openclaw /path/to/your/skills/slack-assistant/
```

## Руководство по настройке

### 1. Создайте приложение Slack

1. Перейдите на [api.slack.com/apps](https://api.slack.com/apps)
2. Нажмите **Create New App** > **From scratch**
3. Назовите приложение и выберите рабочее пространство
4. Перейдите в **OAuth & Permissions** > **Bot Token Scopes**
5. Добавьте следующие разрешения:
   - `channels:read`, `channels:write`, `channels:history`, `channels:manage`
   - `chat:write`
   - `files:read`, `files:write`
   - `groups:read`, `groups:write`, `groups:history`
   - `im:read`, `im:write`, `im:history`
   - `mpim:read`, `mpim:write`, `mpim:history`
   - `search:read`
   - `users:read`, `users:read.email`
   - `reactions:read`, `reactions:write`
6. Нажмите **Install to Workspace** и авторизуйте
7. Скопируйте **Bot User OAuth Token** (начинается с `xoxb-`)

### 2. Настройте учётные данные

```bash
mkdir -p ~/.slack-skill
echo '{"bot_token": "xoxb-your-token-here"}' > ~/.slack-skill/credentials.json
chmod 600 ~/.slack-skill/credentials.json
```

### 3. (Необязательно) Включите функции ИИ

```bash
export EVOLINK_API_KEY="your-key-here"
```

Получите бесплатный API-ключ на [evolink.ai/signup](https://evolink.ai/signup?utm_source=github&utm_medium=skill&utm_campaign=slack)

## Использование

### Основные операции

```bash
bash scripts/slack.sh channels
bash scripts/slack.sh list "#general" 20
bash scripts/slack.sh send "#general" "Привет команда!"
bash scripts/slack.sh search "деплой"
bash scripts/slack.sh read CHANNEL_ID 1234567890.123456
bash scripts/slack.sh reply CHANNEL_ID 1234567890.123456 "Спасибо!"
```

### Функции ИИ

```bash
bash scripts/slack.sh ai-summary "#engineering" 50
bash scripts/slack.sh ai-reply CHANNEL_ID 1234567890.123456
bash scripts/slack.sh ai-prioritize "#general" 30
```

### Управление каналами

```bash
bash scripts/slack.sh create-channel "new-project" --private
bash scripts/slack.sh invite "#new-project" "@alice"
bash scripts/slack.sh upload "#general" ./report.pdf
```

## Конфигурация

| Переменная | По умолчанию | Описание |
|---|---|---|
| `SLACK_SKILL_DIR` | `~/.slack-skill` | Каталог конфигурации |
| `EVOLINK_API_KEY` | — | API-ключ для функций ИИ ([получить](https://evolink.ai/signup?utm_source=github&utm_medium=skill&utm_campaign=slack)) |
| `EVOLINK_MODEL` | `claude-opus-4-6` | Модель ИИ ([документация](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=slack)) |

## Ссылки

- [ClawHub](https://clawhub.ai/EvoLinkAI/slack-assistant)
- [Справочник API Slack](https://api.slack.com/methods)
- [EvoLink API](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=slack)
- [Сообщество](https://discord.com/invite/5mGHfA24kn)
- [Поддержка](mailto:support@evolink.ai)

## Лицензия

MIT
