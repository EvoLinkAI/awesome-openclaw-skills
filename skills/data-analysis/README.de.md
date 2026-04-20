🌐 [English](README.md) | [日本語](README.ja.md) | [한국어](README.ko.md) | [Français](README.fr.md) | [Deutsch](README.de.md) | [Русский](README.ru.md) | [हिन्दी](README.hi.md) | [Türkçe](README.tr.md) | [中文](README.zh.md)

# Datenanalyse-Assistent

**KI-gestützte Datenanalyse mit EvoLink API**

Bereitgestellt von [Evolink.ai](https://evolink.ai?utm_source=github&utm_medium=skill&utm_campaign=data-analysis)

Analysieren Sie CSV-, Excel- und JSON-Dateien mit entscheidungsorientierter Methodik und statistischer Genauigkeit.

## 🚀 Schnellstart

```bash
bash scripts/analyze.sh sales_data.csv "Was sind die wichtigsten Umsatztreiber?"
```

## 🔑 Konfiguration

Setzen Sie Ihren API-Schlüssel:

```bash
export EVOLINK_API_KEY="ihr-schlüssel"
```

👉 [Kostenlosen API-Schlüssel erhalten](https://evolink.ai/signup?utm_source=github&utm_medium=skill&utm_campaign=data-analysis)

## 📖 Verwendung

### Grundlegende Analyse

```bash
bash scripts/analyze.sh <dateipfad> "<analysefrage>"
```

**Unterstützte Formate:**
- CSV (`.csv`)
- Excel (`.xlsx`, `.xls`)
- JSON (`.json`)

### Beispielfragen

```bash
# Trendanalyse
bash scripts/analyze.sh sales.csv "Wie ist der monatliche Umsatztrend?"

# Vergleich
bash scripts/analyze.sh experiment.csv "Ist Variante A signifikant besser als B?"

# Segmentierung
bash scripts/analyze.sh users.csv "Welche Benutzersegmente haben die höchste Retention?"

# Anomalieerkennung
bash scripts/analyze.sh metrics.csv "Gibt es ungewöhnliche Muster in den letzten 30 Tagen?"
```

## ⚙️ Konfiguration

| Variable | Standard | Erforderlich | Beschreibung |
|---|---|---|---|
| `EVOLINK_API_KEY` | — | Ja | Ihr Evolink API-Schlüssel. [Kostenlos erhalten →](https://evolink.ai/signup?utm_source=github&utm_medium=skill&utm_campaign=data-analysis) |
| `EVOLINK_MODEL` | `[REDACTED]` | Nein | Modell für die Analyse. Wechseln Sie zu jedem von der [Evolink API](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=data-analysis) unterstützten Modell |
| `DATA_ANALYSIS_SAFE_DIR` | `$HOME/.openclaw/workspace` | Nein | Zulässiges Verzeichnis für lokalen Dateizugriff |

Erforderliche Programme: `curl`, `jq`, `python3`, `file`.

## 🎯 Kernprinzip

**Analyse ohne Entscheidung ist nur Arithmetik.**

Dieser Skill betont:
- Entscheidungsorientierte Methodik
- Statistische Genauigkeit (Stichprobengröße, Konfidenzintervalle, Effektgröße)
- Klare Ausgabestandards (Erkenntnisse zuerst, quantifizierte Unsicherheit)
- Explizite Einschränkungen und Vorbehalte

## 📊 Was es tut

1. **Liest Ihre Datendatei** (CSV/Excel/JSON)
2. **Sendet an EvoLink API** mit Ihrer Analysefrage
3. **Gibt strukturierte Erkenntnisse zurück** mit:
   - Wichtigsten Ergebnissen
   - Statistischer Konfidenz
   - Vorbehalten und Einschränkungen
   - Empfohlenen nächsten Schritten

## 🔒 Sicherheit

**Zugangsdaten & Netzwerk**

Benötigt `EVOLINK_API_KEY` zum Aufrufen der EvoLink API. Ihr Dateiinhalt und Ihre Analysefrage werden zur Verarbeitung an `api.evolink.ai` gesendet. EvoLink verarbeitet die Daten und gibt Analyseergebnisse zurück. Nach der Verarbeitung werden keine Daten gespeichert.

**Dateizugriff**

Liest die angegebene Datendatei aus Ihrem lokalen Dateisystem. Dateien müssen sich innerhalb von `DATA_ANALYSIS_SAFE_DIR` befinden (Standard: `$HOME/.openclaw/workspace`). Das Skript validiert Dateipfade und lehnt Symlinks aus Sicherheitsgründen ab.

Dateipfade werden über `realpath -e` aufgelöst (erfordert, dass die Datei existiert, löst alle Symlinks auf). Symlink-Eingaben werden explizit abgelehnt.

Sensible Dateien sind nach Namen auf der Blacklist: `.env*`, `*.key`, `*.pem`, `*.p12`, `*.pfx`, `id_rsa*`, `authorized_keys`, `config.json`, `.bash_history`, `.ssh`, `shadow`, `passwd`.

**Dateigrößenlimit**: Maximal 50MB für Datendateien.

**MIME-Validierung**: Nur `text/csv`, `text/plain`, `application/json`, `application/vnd.ms-excel`, `application/vnd.openxmlformats-officedocument.spreadsheetml.sheet` akzeptiert.

**Netzwerkzugriff**

- **EvoLink API** (`api.evolink.ai`) - Sendet Daten und empfängt Analysen

Alle Netzwerkaufrufe verwenden curl und können im Skript-Quellcode überprüft werden.

**Persistenz & Berechtigungen**

Dieser Skill ändert keine anderen Skills oder Systemeinstellungen. Fordert keine erhöhten oder persistenten Berechtigungen an.

## 📄 Lizenz

MIT

## 🔗 Links

- [API-Referenz](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=data-analysis)
- [Community](https://discord.com/invite/5mGHfA24kn)
- [Support](mailto:support@evolink.ai)
- [API-Schlüssel erhalten](https://evolink.ai/signup?utm_source=github&utm_medium=skill&utm_campaign=data-analysis) — Kostenlose Registrierung

Bereitgestellt von [Evolink.ai](https://evolink.ai?utm_source=github&utm_medium=skill&utm_campaign=data-analysis)
