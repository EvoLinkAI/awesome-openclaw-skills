🌐 [English](README.md) | [日本語](README.ja.md) | [한국어](README.ko.md) | [简体中文](README.zh-CN.md) | Deutsch | [Русский](README.ru.md) | [हिन्दी](README.hi.md) | [Türkçe](README.tr.md)

# Web Search Assistant

**KI-gestützte Websuche mit der EvoLink API**

Powered by [Evolink.ai](https://evolink.ai?utm_source=github&utm_medium=skill&utm_campaign=web-search)

Durchsuchen Sie das Web und erhalten Sie saubere, formatierte Ergebnisse mit Titeln, URLs und Beschreibungen.

## 🚀 Schnellstart

```bash
bash scripts/search.sh "AI coding assistants 2026"
bash scripts/search.sh "quantum computing breakthroughs" 20
```

## 🔑 Konfiguration

Setzen Sie Ihren EvoLink API-Schlüssel:

```bash
export EVOLINK_API_KEY="your-evolink-api-key-here"
```

👉 [Kostenlosen API-Schlüssel erhalten](https://evolink.ai/signup?utm_source=github&utm_medium=skill&utm_campaign=web-search)

## 📖 Verwendung

### Grundlegende Suche

```bash
bash scripts/search.sh "Suchanfrage"
```

Gibt die Top 10 Ergebnisse zurück.

### Ergebnisse begrenzen

```bash
bash scripts/search.sh "Suchanfrage" 20
```

Geben Sie die maximale Anzahl der Ergebnisse an.

## 🔒 Sicherheit

**Anmeldeinformationen und Netzwerk**

`EVOLINK_API_KEY` ist erforderlich, um die EvoLink API aufzurufen. Ihre Suchanfragen werden zur Verarbeitung an `api.evolink.ai` gesendet. EvoLink verarbeitet die Websuche intern und gibt formatierte Ergebnisse zurück.

**Dateizugriff**

Dieser Skill liest oder schreibt keine Dateien.

**Netzwerkzugriff**

Dieser Skill führt Netzwerkanfragen durch an:
- **EvoLink API** (`api.evolink.ai`) - zur Durchführung von Websuchen

Alle Netzwerkaufrufe werden über curl durchgeführt und können im Quellcode des Skripts überprüft werden.

**Persistenz und Berechtigungen**

Dieser Skill ändert keine anderen Skills oder Systemeinstellungen. Es werden keine erhöhten oder persistenten Berechtigungen angefordert.

## 📄 Lizenz

MIT

## 🔗 Links

- [ClawHub](https://clawhub.ai/evolinkai/web-research)
- [API-Referenz](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=web-search)
- [Community](https://discord.com/invite/5mGHfA24kn)
- [Support](mailto:support@evolink.ai)
