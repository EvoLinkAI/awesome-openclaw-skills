---
name: web-research
description: Websuche über die EvoLink API. Gibt saubere, formatierte Ergebnisse mit Titeln, URLs und Beschreibungen zurück. Powered by evolink.ai
metadata: {"clawdbot":{"emoji":"🔍","requires":{"bins":["bash","curl","jq"],"env":["EVOLINK_API_KEY"]},"primaryEnv":"EVOLINK_API_KEY"}}
---

# Web Search Assistant

Websuche mit der EvoLink API. Gibt saubere, formatierte Ergebnisse mit Titeln, URLs und Beschreibungen zurück.

Powered by [Evolink.ai](https://evolink.ai?utm_source=clawhub&utm_medium=skill&utm_campaign=web-search)

## Wann zu verwenden

Verwenden Sie diesen Skill, wenn Benutzer Folgendes anfordern:
- Websuchen nach Informationen oder Ressourcen
- Aktuelle oder kürzliche Informationen online finden
- Recherchen, die aktuelle Webdaten erfordern
- Faktenprüfung oder Verifizierung mit Webquellen
- Sammeln von URLs und Ressourcen zu einem Thema

## Suche

```bash
{baseDir}/scripts/search.sh "Anfrage"
{baseDir}/scripts/search.sh "Anfrage" 20
```

## Optionen

- `<query>`: Suchanfrage
- `<max_results>`: Anzahl der Ergebnisse (Standard: 10)

## Konfiguration

Setzen Sie Ihren EvoLink API-Schlüssel:

```bash
export EVOLINK_API_KEY="your-evolink-api-key-here"
```

👉 [Kostenlosen API-Schlüssel erhalten](https://evolink.ai/signup?utm_source=clawhub&utm_medium=skill&utm_campaign=web-search)

## Beispiel

```bash
bash scripts/search.sh "Claude Opus 4 features"
```

Ausgabe:
```
🔍 Suche: Claude Opus 4 features

📄 Claude Opus 4: New Features and Capabilities
🔗 https://example.com/opus-4
📝 Comprehensive guide to Claude Opus 4's new features...

📄 What's New in Claude Opus 4
🔗 https://example.com/whats-new
📝 Latest updates and improvements in Claude Opus 4...
```

## Sicherheit

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

## Links

- [ClawHub](https://clawhub.ai/evolinkai/web-research)
- [API-Referenz](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=clawhub&utm_medium=skill&utm_campaign=web-search)
- [Community](https://discord.com/invite/5mGHfA24kn)
- [Support](mailto:support@evolink.ai)
