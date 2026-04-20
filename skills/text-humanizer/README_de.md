# Text Humanisierung

[English](README.md) | [中文](README_zh.md) | [日本語](README_ja.md) | [한국어](README_ko.md) | [Русский](README_ru.md) | [हिन्दी](README_hi.md) | **Deutsch** | [Français](README_fr.md) | [Italiano](README_it.md)

KI-Schreibmuster aus beliebigen Texten entfernen. Unterstützt 29+ Sprachen.

Fügen Sie einen Blogbeitrag, eine E-Mail, einen Aufsatz oder Bericht ein — und erhalten Sie eine saubere Version, die wie von einem echten Menschen geschrieben klingt.

Powered by [Evolink.ai](https://evolink.ai?utm_source=github&utm_medium=skill&utm_campaign=humanize)

## Verwendung

Sagen Sie Ihrem Agenten:
- "Humanize this text"
- "Mach den Text natürlicher"
- "Make this sound more natural"
- "Entferne den KI-Ton aus diesem Text"

Über die Kommandozeile:

```bash
bash scripts/humanize.sh "draft.txt"
bash scripts/humanize.sh "draft.txt" "casual blog post"
echo "Your text here" | bash scripts/humanize.sh -
```

## So funktioniert es

**Ebene 1 — Mustererkennung**: Erkennt 24 gängige KI-Schreibmuster in Wortschatz, Struktur, Ton und Formatierung.

**Ebene 2 — Umschreibung**: Ersetzt markierte Phrasen durch natürliche Alternativen, variiert den Satzrhythmus, entfernt Füllwörter.

**Ebene 3 — Stilanpassung**: Passt den Ton an den Kontext an — Blog, akademisch, Geschäfts-E-Mail, locker.

## Erkannte Muster

| Kategorie | Beispiele |
|---|---|
| Füllphrasen | „Darüber hinaus", „Es ist erwähnenswert", „Zusammenfassend" |
| Werbesprache | „bahnbrechend", „wegweisend", „einzigartig" |
| Falsche Tiefe | „aufzeigend… widerspiegelnd… hervorhebend…" |
| Vage Zuschreibungen | „Experten zufolge", „Laut Branchenberichten" |
| Strukturelle Merkmale | Dreierregel, einheitliche Satzlänge |
| KI-Vokabular | „äußerst wichtig", „nahtlos", „robust" |
| Chatbot-Artefakte | „Ich hoffe, das hilft!", „Bei Fragen..." |

## Unterstützte Sprachen

29+ Sprachen, darunter Englisch, Chinesisch, Japanisch, Koreanisch, Russisch, Hindi, Deutsch, Französisch, Italienisch, Spanisch, Portugiesisch, Niederländisch, Polnisch, Türkisch, Arabisch und mehr.

Die Sprache wird automatisch erkannt. Keine Konfiguration nötig.

## Beispiel

**Vorher** (starker KI-Stil):

> Dieses Software-Update ist ein eindrucksvolles Zeugnis des unerschütterlichen Engagements des Unternehmens für Innovation. Darüber hinaus bietet es ein nahtloses, intuitives und robustes Benutzererlebnis, das sicherstellt, dass Nutzer ihre Ziele effizient erreichen können.

**Nachher**:

> Das Update bringt Stapelverarbeitung, Tastenkürzel und einen Offline-Modus. Die Oberfläche ist übersichtlicher, die meisten Aufgaben brauchen weniger Klicks. Eine solide Verbesserung.

## Einrichtung

1. API-Schlüssel auf [evolink.ai/signup](https://evolink.ai/signup?utm_source=github&utm_medium=readme&utm_campaign=text-humanizer-skill-for-openclaw?utm_source=github&utm_medium=skill&utm_campaign=humanize) holen
2. Umgebungsvariable setzen:

```bash
export EVOLINK_API_KEY="your-key-here"
```

## Links

- [Quellcode](https://github.com/EvoLinkAI/text-humanizer-skill-for-openclaw) — GitHub
- [API-Dokumentation (EN)](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=humanize)
- [API-Schlüssel holen](https://evolink.ai/signup?utm_source=github&utm_medium=readme&utm_campaign=text-humanizer-skill-for-openclaw?utm_source=github&utm_medium=skill&utm_campaign=humanize) — Kostenlose Registrierung

## Lizenz

MIT

Powered by [Evolink.ai](https://evolink.ai?utm_source=github&utm_medium=skill&utm_campaign=humanize)
