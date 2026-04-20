# Gmail Assistant — ИИ-навык электронной почты для OpenClaw

Интеграция Gmail API с ИИ-суммаризацией, умными черновиками ответов и приоритизацией входящих. Работает на базе [evolink.ai](https://evolink.ai?utm_source=github&utm_medium=skill&utm_campaign=gmail)

[Что это?](#что-это) | [Установка](#установка) | [Настройка](#руководство-по-настройке) | [Использование](#использование) | [EvoLink](https://evolink.ai?utm_source=github&utm_medium=skill&utm_campaign=gmail)

**Language / Язык:**
[English](README.md) | [简体中文](README.zh-CN.md) | [日本語](README.ja.md) | [한국어](README.ko.md) | [Español](README.es.md) | [Français](README.fr.md) | [Deutsch](README.de.md) | [Türkçe](README.tr.md) | [Русский](README.ru.md)

## Что это?

Gmail Assistant — это навык OpenClaw, который подключает вашу учётную запись Gmail к вашему ИИ-агенту. Он обеспечивает полный доступ к Gmail API — чтение, отправка, поиск, метки, архивация — а также ИИ-функции: суммаризация входящих, умные черновики ответов и приоритизация писем с помощью Claude через EvoLink.

**Основные операции Gmail работают без API-ключа.** Для ИИ-функций (суммаризация, черновики, приоритизация) требуется дополнительный API-ключ EvoLink.

[Получите бесплатный API-ключ EvoLink](https://evolink.ai/signup?utm_source=github&utm_medium=skill&utm_campaign=gmail)

## Установка

### Быстрая установка

```bash
openclaw skills add https://github.com/EvoLinkAI/gmail-skill-for-openclaw
```

### Через ClawHub

```bash
npx clawhub install evolinkai/gmail
```

### Ручная установка

```bash
git clone https://github.com/EvoLinkAI/gmail-skill-for-openclaw.git
cd gmail-skill-for-openclaw
```

## Руководство по настройке

### Шаг 1: Создание учётных данных Google OAuth

1. Перейдите в [Google Cloud Console](https://console.cloud.google.com/)
2. Создайте новый проект (или выберите существующий)
3. Включите **Gmail API**: APIs & Services > Library > найдите «Gmail API» > Enable
4. Настройте экран согласия OAuth: APIs & Services > OAuth consent screen > External > заполните обязательные поля
5. Создайте учётные данные OAuth: APIs & Services > Credentials > Create Credentials > OAuth client ID > **Desktop app**
6. Скачайте файл `credentials.json`

### Шаг 2: Конфигурация

```bash
mkdir -p ~/.gmail-skill
cp credentials.json ~/.gmail-skill/credentials.json
bash scripts/gmail-auth.sh setup
```

### Шаг 3: Авторизация

```bash
bash scripts/gmail-auth.sh login
```

Эта команда откроет браузер для подтверждения доступа через Google OAuth. Токены сохраняются локально в `~/.gmail-skill/token.json`.

### Шаг 4: Установка API-ключа EvoLink (необязательно — для ИИ-функций)

```bash
export EVOLINK_API_KEY="your-key-here"
```

[Получите API-ключ](https://evolink.ai/signup?utm_source=github&utm_medium=skill&utm_campaign=gmail)

## Использование

### Основные команды

```bash
# Показать последние письма
bash scripts/gmail.sh list

# Показать с фильтром
bash scripts/gmail.sh list --query "is:unread" --max 20

# Прочитать конкретное письмо
bash scripts/gmail.sh read MESSAGE_ID

# Отправить письмо
bash scripts/gmail.sh send "to@example.com" "Встреча завтра" "Привет, можем встретиться в 15:00?"

# Ответить на письмо
bash scripts/gmail.sh reply MESSAGE_ID "Спасибо, буду на месте."

# Поиск писем
bash scripts/gmail.sh search "from:boss@company.com has:attachment"

# Показать метки
bash scripts/gmail.sh labels

# Добавить/удалить метку
bash scripts/gmail.sh label MESSAGE_ID +STARRED
bash scripts/gmail.sh label MESSAGE_ID -UNREAD

# Пометить / Архивировать / В корзину
bash scripts/gmail.sh star MESSAGE_ID
bash scripts/gmail.sh archive MESSAGE_ID
bash scripts/gmail.sh trash MESSAGE_ID

# Просмотреть всю цепочку писем
bash scripts/gmail.sh thread THREAD_ID

# Информация об аккаунте
bash scripts/gmail.sh profile
```

### ИИ-команды (требуется EVOLINK_API_KEY)

```bash
# Суммаризировать непрочитанные письма
bash scripts/gmail.sh ai-summary

# Суммаризировать с пользовательским запросом
bash scripts/gmail.sh ai-summary --query "from:team@company.com after:2026/04/01" --max 15

# Сгенерировать ИИ-черновик ответа
bash scripts/gmail.sh ai-reply MESSAGE_ID "Вежливо отклонить и предложить следующую неделю"

# Приоритизировать входящие
bash scripts/gmail.sh ai-prioritize --max 30
```

### Пример вывода

```
Сводка входящих (5 непрочитанных писем):

1. [СРОЧНО] Срок проекта перенесён — от: manager@company.com
   Дедлайн запуска продукта Q2 перенесён с 15 апреля на 10 апреля.
   Требуется действие: Обновить план спринта до завтрашнего конца дня.

2. Счёт №4521 — от: billing@vendor.com
   Ежемесячный счёт за подписку SaaS на сумму $299. Оплата до 15 апреля.
   Требуется действие: Утвердить или переслать в финансовый отдел.

3. Обед с командой в пятницу — от: hr@company.com
   Обед для тимбилдинга в пятницу в 12:30. Требуется подтверждение участия.
   Требуется действие: Ответить о присутствии.

4. Рассылка: AI Weekly — от: newsletter@aiweekly.com
   Низкий приоритет. Еженедельная подборка новостей ИИ.
   Требуется действие: Нет.

5. Уведомление GitHub — от: notifications@github.com
   PR #247 влит в main. CI пройден.
   Требуется действие: Нет.
```

## Конфигурация

Необходимые программы: `python3`, `curl`

| Переменная | По умолчанию | Обязательно | Описание |
|-----------|-------------|------------|----------|
| `credentials.json` | — | Да (основное) | Учётные данные Google OAuth — см. [руководство по настройке](#руководство-по-настройке) |
| `EVOLINK_API_KEY` | — | Необязательно (ИИ) | API-ключ EvoLink — [зарегистрируйтесь здесь](https://evolink.ai/signup?utm_source=github&utm_medium=skill&utm_campaign=gmail) |
| `EVOLINK_MODEL` | `claude-opus-4-6` | Нет | ИИ-модель — см. [документацию API EvoLink](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=gmail) |
| `GMAIL_SKILL_DIR` | `~/.gmail-skill` | Нет | Пользовательский путь для хранения учётных данных |

## Синтаксис запросов Gmail

- `is:unread` — Непрочитанные сообщения
- `is:starred` — Помеченные сообщения
- `from:user@example.com` — От конкретного отправителя
- `to:user@example.com` — Конкретному получателю
- `subject:keyword` — Тема содержит ключевое слово
- `after:2026/01/01` — После даты
- `before:2026/12/31` — До даты
- `has:attachment` — С вложениями
- `label:work` — С определённой меткой

## Структура файлов

```
.
├── README.md               # English (основной)
├── README.zh-CN.md         # 简体中文
├── README.ja.md            # 日本語
├── README.ko.md            # 한국어
├── README.es.md            # Español
├── README.fr.md            # Français
├── README.de.md            # Deutsch
├── README.tr.md            # Türkçe
├── README.ru.md            # Русский
├── SKILL.md                # Определение навыка OpenClaw
├── _meta.json              # Метаданные навыка
├── LICENSE                 # Лицензия MIT
├── references/
│   └── api-params.md       # Справочник параметров Gmail API
└── scripts/
    ├── gmail-auth.sh       # Менеджер аутентификации OAuth
    └── gmail.sh            # Операции Gmail + ИИ-функции
```

## Устранение неполадок

- **«Not authenticated»** — Выполните `bash scripts/gmail-auth.sh login` для авторизации
- **«credentials.json not found»** — Скачайте учётные данные OAuth из Google Cloud Console и поместите в `~/.gmail-skill/credentials.json`
- **«Token refresh failed»** — Возможно, истёк срок действия токена обновления. Выполните `bash scripts/gmail-auth.sh login` повторно
- **«Set EVOLINK_API_KEY»** — ИИ-функции требуют API-ключ EvoLink. Основные операции Gmail работают без него
- **«Error 403: access_denied»** — Убедитесь, что Gmail API включён в вашем проекте Google Cloud и экран согласия OAuth настроен
- **Безопасность токенов** — Токены хранятся с правами `chmod 600`. Только ваша учётная запись может их прочитать

## Ссылки

- [ClawHub](https://clawhub.ai/EvoLinkAI/gmail-assistant)
- [Справочник API](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=gmail)
- [Сообщество](https://discord.com/invite/5mGHfA24kn)
- [Поддержка](mailto:support@evolink.ai)

## Лицензия

MIT — подробности в файле [LICENSE](LICENSE).
