# audio-analyze-skill-for-openclaw

Transkribieren und analysieren Sie Audio-/Videoinhalte mit hoher Genauigkeit. [Powered by Evolink.ai](https://evolink.ai/?utm_source=github&utm_medium=skill&utm_campaign=audio-analyze)

🌐 [English](README.md) | [日本語](README.ja.md) | [简体中文](README.zh-CN.md) | [한국어](README.ko.md) | [Español](README.es.md) | [Français](README.fr.md) | [Deutsch](README.de.md) | [Türkçe](README.tr.md) | [Русский](README.ru.md)

## Was ist das?

Transkribieren und analysieren Sie Ihre Audio-/Videodateien automatisch mit Gemini 3.1 Pro. [Holen Sie sich Ihren kostenlosen API-Schlüssel →](https://evolink.ai/signup?utm_source=github&utm_medium=skill&utm_campaign=audio-analyze)

## Installation

### Über ClawHub (Empfohlen)

```bash
openclaw skills add https://github.com/EvoLinkAI/audio-analyze-skill-for-openclaw
```

### Manuelle Installation

```bash
git clone https://github.com/EvoLinkAI/audio-analyze-skill-for-openclaw
cd audio-analyze-skill-for-openclaw
pip install -r requirements.txt
```

## Konfiguration

| Variable | Beschreibung | Standard |
| :--- | :--- | :--- |
| `EVOLINK_API_KEY` | Evolink API-Schlüssel | (Erforderlich) |
| `EVOLINK_MODEL` | Transkriptionsmodell | gemini-3.1-pro-preview-customtools |

*Für detaillierte API-Konfiguration und Modellunterstützung siehe [EvoLink API-Dokumentation](https://docs.evolink.ai/en/api-manual/language-series/gemini-3.1-pro-preview-customtools/openai-sdk/openai-sdk-quickstart?utm_source=github&utm_medium=skill&utm_campaign=audio-analyze).*

## Verwendung

### Grundlegende Verwendung

```bash
export EVOLINK_API_KEY="your-key-here"
./scripts/transcribe.sh audio.mp3
```

### Erweiterte Verwendung

```bash
./scripts/transcribe.sh audio.mp3 --diarize --lang ja
```

### Beispielausgabe

* **TL;DR**: Das Audio ist ein Beispieltrack zum Testen.
* **Wichtige Erkenntnisse**: High-Fidelity-Sound, klare Frequenzantwort.
* **Aktionspunkte**: Für abschließende Tests in die Produktion hochladen.

## Verfügbare Modelle

- **Gemini-Serie** (OpenAI API — `/v1/chat/completions`)

## Dateistruktur

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

## Fehlerbehebung

- **Argument list too long**: Verwenden Sie temporäre Dateien für große Audiodaten.
- **API Key Error**: Stellen Sie sicher, dass `EVOLINK_API_KEY` exportiert ist.

## Links

- [ClawHub](https://clawhub.ai/EvoLinkAI/audio-analyze)
- [API-Referenz](https://docs.evolink.ai/en/api-manual/language-series/gemini-3.1-pro-preview-customtools/openai-sdk/openai-sdk-quickstart?utm_source=github&utm_medium=skill&utm_campaign=audio-analyze)
- [Community](https://discord.com/invite/5mGHfA24kn)
- [Support](mailto:support@evolink.ai)

## Lizenz

MIT
