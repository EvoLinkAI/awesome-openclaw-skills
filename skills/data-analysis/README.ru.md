🌐 [English](README.md) | [日本語](README.ja.md) | [한국어](README.ko.md) | [Français](README.fr.md) | [Deutsch](README.de.md) | [Русский](README.ru.md) | [हिन्दी](README.hi.md) | [Türkçe](README.tr.md) | [中文](README.zh.md)

# Ассистент анализа данных

**Анализ данных на основе ИИ с использованием EvoLink API**

Работает на [Evolink.ai](https://evolink.ai?utm_source=github&utm_medium=skill&utm_campaign=data-analysis)

Анализируйте CSV, Excel и JSON файлы с методологией, ориентированной на принятие решений, и статистической строгостью.

## 🚀 Быстрый старт

```bash
bash scripts/analyze.sh sales_data.csv "Каковы основные драйверы дохода?"
```

## 🔑 Конфигурация

Установите ваш API ключ:

```bash
export EVOLINK_API_KEY="your-key"
```

👉 [Получить бесплатный API ключ](https://evolink.ai/signup?utm_source=github&utm_medium=skill&utm_campaign=data-analysis)

## 📖 Использование

### Базовый анализ

```bash
bash scripts/analyze.sh <путь_к_файлу> "<вопрос_для_анализа>"
```

**Поддерживаемые форматы:**
- CSV (`.csv`)
- Excel (`.xlsx`, `.xls`)
- JSON (`.json`)

### Примеры вопросов

```bash
# Анализ трендов
bash scripts/analyze.sh sales.csv "Какова тенденция месячного дохода?"

# Сравнение
bash scripts/analyze.sh experiment.csv "Вариант A значительно лучше варианта B?"

# Сегментация
bash scripts/analyze.sh users.csv "Какие сегменты пользователей имеют наивысшую удержание?"

# Обнаружение аномалий
bash scripts/analyze.sh metrics.csv "Есть ли необычные паттерны за последние 30 дней?"
```

## ⚙️ Конфигурация

| Переменная | По умолчанию | Обязательно | Описание |
|---|---|---|---|
| `EVOLINK_API_KEY` | — | Да | Ваш API ключ Evolink. [Получить бесплатно →](https://evolink.ai/signup?utm_source=github&utm_medium=skill&utm_campaign=data-analysis) |
| `EVOLINK_MODEL` | `[REDACTED]` | Нет | Модель для анализа. Переключитесь на любую модель, поддерживаемую [Evolink API](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=data-analysis) |
| `DATA_ANALYSIS_SAFE_DIR` | `$HOME/.openclaw/workspace` | Нет | Разрешенная директория для доступа к локальным файлам |

Требуемые бинарные файлы: `curl`, `jq`, `python3`, `file`.

## 🎯 Основной принцип

**Анализ без решения — это просто арифметика.**

Этот навык подчеркивает:
- Методологию, ориентированную на решения
- Статистическую строгость (размер выборки, доверительные интервалы, размер эффекта)
- Четкие стандарты вывода (сначала инсайты, количественная неопределенность)
- Явные ограничения и оговорки

## 📊 Что он делает

1. **Читает ваш файл данных** (CSV/Excel/JSON)
2. **Отправляет в EvoLink API** с вашим вопросом для анализа
3. **Возвращает структурированные инсайты** с:
   - Ключевыми выводами
   - Статистической уверенностью
   - Оговорками и ограничениями
   - Рекомендуемыми следующими шагами

## 🔒 Безопасность

**Учетные данные и сеть**

Требуется `EVOLINK_API_KEY` для вызова EvoLink API. Содержимое вашего файла данных и вопрос для анализа отправляются на `api.evolink.ai` для обработки. EvoLink обрабатывает данные и возвращает результаты анализа. Данные не хранятся после обработки.

**Доступ к файлам**

Читает указанный файл данных из вашей локальной файловой системы. Файлы должны находиться в `DATA_ANALYSIS_SAFE_DIR` (по умолчанию: `$HOME/.openclaw/workspace`). Скрипт проверяет пути к файлам и отклоняет символические ссылки для безопасности.

Пути к файлам разрешаются через `realpath -e` (требует существования файла, разрешает все символические ссылки). Входные символические ссылки явно отклоняются.

Чувствительные файлы занесены в черный список по имени: `.env*`, `*.key`, `*.pem`, `*.p12`, `*.pfx`, `id_rsa*`, `authorized_keys`, `config.json`, `.bash_history`, `.ssh`, `shadow`, `passwd`.

**Ограничение размера файла**: максимум 50 МБ для файлов данных.

**Проверка MIME**: принимаются только `text/csv`, `text/plain`, `application/json`, `application/vnd.ms-excel`, `application/vnd.openxmlformats-officedocument.spreadsheetml.sheet`.

**Сетевой доступ**

- **EvoLink API** (`api.evolink.ai`) - Отправляет данные и получает анализ

Все сетевые вызовы используют curl и могут быть проверены в исходном коде скрипта.

**Постоянство и привилегии**

Этот навык не изменяет другие навыки или системные настройки. Не запрашивает повышенные или постоянные разрешения.

## 📄 Лицензия

MIT

## 🔗 Ссылки

- [Справочник API](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=data-analysis)
- [Сообщество](https://discord.com/invite/5mGHfA24kn)
- [Поддержка](mailto:support@evolink.ai)
- [Получить API ключ](https://evolink.ai/signup?utm_source=github&utm_medium=skill&utm_campaign=data-analysis) — Бесплатная регистрация

Работает на [Evolink.ai](https://evolink.ai?utm_source=github&utm_medium=skill&utm_campaign=data-analysis)
