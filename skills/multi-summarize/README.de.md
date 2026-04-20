# Multi Summarize — KI-Zusammenfassungs-Skill für OpenClaw

Schnelle Zusammenfassung in mehreren Formaten — URL einfügen, Datei ablegen, Kernpunkte erhalten. Bereitgestellt von [EvoLink](https://evolink.ai?utm_source=github&utm_medium=readme&utm_campaign=multi-summarize-skill-for-openclaw?utm_source=github&utm_medium=skill&utm_campaign=summarize).

 [Überblick](#überblick) •
 [Installation](#installation) •
 [API Key](#api-key-erhalten) •
 [Nutzung](#nutzung) •
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

## Überblick

Ein [OpenClaw](https://github.com/openclaw/openclaw)-Skill, bereitgestellt von [EvoLink](https://evolink.ai?utm_source=github&utm_medium=readme&utm_campaign=multi-summarize-skill-for-openclaw?utm_source=github&utm_medium=skill&utm_campaign=summarize). Installieren Sie einen einzigen Skill und Ihr KI-Agent kann jeden Inhalt — URLs, PDFs, Videos, Audiodateien, YouTube-Links oder Klartext — mit Claude Opus 4.6, dem leistungsfähigsten verfügbaren Textmodell, in prägnante, umsetzbare Kernpunkte zusammenfassen.

🚀 [API Key erhalten →](https://evolink.ai/signup?utm_source=github&utm_medium=readme&utm_campaign=multi-summarize-skill-for-openclaw?utm_source=github&utm_medium=skill&utm_campaign=summarize)

## Installation

### Schnellinstallation (Empfohlen)

```bash
openclaw skills add https://github.com/EvoLinkAI/multi-summarize-skill-for-openclaw
```

Fertig. Der Skill ist sofort einsatzbereit.

### Über ClawHub

```bash
clawhub install multi-summarize
```

### Manuelle Installation

```bash
git clone https://github.com/EvoLinkAI/multi-summarize-skill-for-openclaw.git
cd multi-summarize-skill-for-openclaw
openclaw skills add .
```

## API Key erhalten

1. Registrieren Sie sich [hier](https://evolink.ai/signup?utm_source=github&utm_medium=readme&utm_campaign=multi-summarize-skill-for-openclaw?utm_source=github&utm_medium=skill&utm_campaign=summarize)
2. Gehen Sie zu Dashboard → API Keys
3. Erstellen Sie einen neuen Key
4. Setzen Sie die Umgebungsvariable:

```bash
export EVOLINK_API_KEY=your_key_here
```

Oder sagen Sie einfach Ihrem OpenClaw-Agent: „Setze meinen EvoLink API Key auf ..." — er erledigt den Rest.

## Nutzung

### Unterstützte Formate

- **Web-URLs** — Artikel, Blogs, Dokumentation
- **PDF** — Berichte, Facharbeiten, Whitepapers
- **Video** — mp4, webm, YouTube-Links
- **Audio** — mp3, wav, m4a, Podcasts
- **Text** — Markdown, Klartext, Code-Dateien

### Anwendungsbeispiele

Sprechen Sie einfach natürlich mit Ihrem Agent:

```
„Fasse diesen Artikel zusammen: https://evolink.ai/blog/deepseek-v4-release-window-prep?utm_source=github&utm_medium=readme&utm_campaign=multi-summarize"
„Worum geht es in diesem PDF?" (Datei anhängen)
„Gib mir die Kernpunkte aus diesem YouTube-Video: https://youtu.be/..."
„Fasse diese Podcast-Aufnahme zusammen" (mp3 anhängen)
„Gib mir ein TL;DR dieses Dokuments"
```

### Skript-Referenz

Der Skill enthält `scripts/summarize.sh` für die direkte Nutzung über die Kommandozeile:

```bash
# Web-Artikel zusammenfassen
bash scripts/summarize.sh "https://evolink.ai/blog/deepseek-v4-release-window-prep?utm_source=github&utm_medium=readme&utm_campaign=multi-summarize"

# Lokales PDF zusammenfassen
bash scripts/summarize.sh "/path/to/report.pdf"

# YouTube-Video zusammenfassen
bash scripts/summarize.sh "https://youtu.be/VIDEO_ID"

# Audiodatei zusammenfassen
bash scripts/summarize.sh "/path/to/podcast.mp3"

# Mit benutzerdefiniertem Fokus zusammenfassen
bash scripts/summarize.sh "https://evolink.ai/blog/deepseek-v4-release-window-prep?utm_source=github&utm_medium=readme&utm_campaign=multi-summarize" "Fokus auf den Release-Zeitplan"
```

### Beispielausgabe

```
## TL;DR
DeepSeek V4 wird seit Januar 2026 gemunkelt, wurde aber bis März noch nicht
offiziell veröffentlicht. Mehrere vorhergesagte Veröffentlichungsfenster sind verstrichen.
Das Modell soll sich auf Programmierung konzentrieren mit HumanEval-Scores von 90 % (unbestätigt).

## Kernpunkte
- Reuters berichtete im Januar, dass DeepSeek ein auf Programmierung fokussiertes Modell für Februar 2026 plant
- DeepSeek erweiterte im Februar stillschweigend das Kontextfenster von 128K auf 1M Tokens — wahrscheinlich V4-Infrastrukturtest
- Unbestätigte Benchmarks behaupten HumanEval 90 %, SWE-bench Verified 80 %+
- „V4 Lite" erschien im März auf der DeepSeek-Website, wurde aber nie offiziell bestätigt
- Mehrere Veröffentlichungsfenster (Mitte Februar, Mondneujahr, Anfang März) vergingen ohne Release

## Empfohlene Maßnahmen
- Produktions-Workloads nicht vor der offiziellen Ankündigung migrieren
- Offizielle DeepSeek-Kanäle auf bestätigte Spezifikationen überwachen
- API-Integration vorbereiten — EvoLink wird V4 ab dem ersten Tag unterstützen
```

## Konfiguration

Standardmodell: `claude-opus-4-6` (keine zusätzliche Konfiguration erforderlich).

Um ein anderes Modell zu verwenden:

```bash
export EVOLINK_MODEL="claude-sonnet-4-5-20250929"
```

### Verfügbare Modelle

**Claude-Serie** (Anthropic API-Format — `/v1/messages`)
- **claude-opus-4-6** — Höchste Qualität (Standard)
- **claude-sonnet-4-6** — Neuestes Sonnet, schnell + leistungsfähig
- **claude-sonnet-4-5-20250929** — Schnell + kosteneffizient
- **claude-haiku-4-5-20251001** — Ultraschnell, leichte Aufgaben

**GPT-Serie** (OpenAI API-Format — `/v1/chat/completions`)
- **gpt-5.4** — OpenAIs neuestes Flaggschiff-Modell
- **gpt-4o** — Multimodal, schnell
- **gpt-4o-mini** — Leichtgewicht, kosteneffizient

**Gemini-Serie** (OpenAI API-Format — `/v1/chat/completions`)
- **gemini-3.1-flash-lite-preview** — Googles ultraschnelles Leichtgewicht-Modell
- **gemini-3-flash-preview** — Schnell, ideal für Zusammenfassungen

### API-Referenz

Vollständige API-Dokumentation [hier](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=summarize).

## Dateistruktur

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

## Fehlerbehebung

- **`python3: command not found`** — Python 3 installieren: `apt install python3` / `brew install python3`
- **`curl: command not found`** — curl installieren: `apt install curl` / `brew install curl`
- **`401 Unauthorized`** — EVOLINK_API_KEY im [Dashboard](https://evolink.ai/dashboard?utm_source=github&utm_medium=readme&utm_campaign=multi-summarize-skill-for-openclaw?utm_source=github&utm_medium=skill&utm_campaign=summarize) überprüfen
- **`402 Payment Required`** — Im [Dashboard](https://evolink.ai/dashboard?utm_source=github&utm_medium=readme&utm_campaign=multi-summarize-skill-for-openclaw?utm_source=github&utm_medium=skill&utm_campaign=summarize) aufladen
- **PDF-Extraktion fehlgeschlagen** — markitdown installieren: `pip install markitdown` oder poppler: `apt install poppler-utils`
- **YouTube-Extraktion fehlgeschlagen** — yt-dlp installieren: `pip install yt-dlp`
- **Audio-Transkription fehlgeschlagen** — whisper installieren: `pip install openai-whisper`

## Links

- [ClawHub](https://clawhub.ai/EvoLinkAI/multi-summarize)
- [API Reference](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=summarize)
- [Community](https://discord.com/invite/5mGHfA24kn)
- [Support](mailto:support@evolink.ai)

## Lizenz

MIT
