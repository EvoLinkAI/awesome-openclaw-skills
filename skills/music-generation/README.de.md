# Evolink Music — KI-Musikgenerierung-Skill für OpenClaw

<p align="center">
  <strong>5 Musikmodelle, ein API-Key — Suno v4, v4.5, v5. Text-zu-Musik, benutzerdefinierte Lyrics, instrumental.</strong>
</p>

<p align="center">
  <a href="#was-ist-das">Was</a> •
  <a href="#installation">Installieren</a> •
  <a href="#api-key-erhalten">API Key</a> •
  <a href="#musikgenerierung">Generieren</a> •
  <a href="https://evolink.ai/signup?utm_source=github&utm_medium=readme&utm_campaign=music-generation-skill-for-openclaw">EvoLink</a>
</p>

<p align="center">
  <strong>🌐 Sprachen:</strong>
  <a href="README.md">English</a> |
  <a href="README.zh-CN.md">简体中文</a> |
  <a href="README.es.md">Español</a> |
  <a href="README.ja.md">日本語</a> |
  <a href="README.ko.md">한국어</a> |
  <a href="README.fr.md">Français</a> |
  <a href="README.de.md">Deutsch</a> |
  <a href="README.tr.md">Türkçe</a> |
  <a href="README.zh-TW.md">繁體中文</a>
</p>

---

## Was ist das?

Ein [OpenClaw](https://github.com/openclaw/openclaw)-Skill, angetrieben von [EvoLink](https://evolink.ai?utm_source=github&utm_medium=readme&utm_campaign=music-generation). Installieren Sie einen Skill und Ihr KI-Agent wird zu einem Musikstudio — **5 Suno-Modelle** zur Generierung von Liedern, Instrumentalen und benutzerdefinierten Kompositionen, alles über eine einzige API.

| Skill | Beschreibung | Modelle |
|-------|--------------|---------|
| **Evolink Music** | Text-zu-Musik, benutzerdefinierte Lyrics, instrumental, Stimmkontrolle | Suno v4, v4.5, v4.5plus, v4.5all, v5 |

📚 **Vollständiger Leitfaden**: Musikgenerierung mit vollständiger Kontrolle über Stil, Genre, Stimmung und Struktur.

---

## Installation

### Schnellinstallation (Empfohlen)

```bash
openclaw skills add https://github.com/EvoLinkAI/music-generation-skill-for-openclaw
```

Das war\'s! Der Skill ist jetzt für Ihren Agenten verfügbar.

### Manuelle Installation

```bash
git clone https://github.com/EvoLinkAI/music-generation-skill-for-openclaw.git
cd music-generation-skill-for-openclaw
openclaw skills add .
```

---

## API Key erhalten

1. Registrieren Sie sich bei [evolink.ai](https://evolink.ai/signup?utm_source=github&utm_medium=readme&utm_campaign=music-generation-skill-for-openclaw)utm_medium=readme[evolink.ai](https://evolink.ai/signup?utm_source=github&utm_medium=readme&utm_campaign=music-generation-skill-for-openclaw)utm_campaign=music-generation-skill-for-openclaw)
2. Gehen Sie zu Dashboard → API Keys
3. Erstellen Sie einen neuen API-Key
4. Konfigurieren Sie ihn in Ihrer Umgebung:

```bash
export EVOLINK_API_KEY=ihr_key_hier
```

---

## Musikgenerierung

### Verfügbare Modelle

| Modell | Beschreibung | Anwendungsfälle |
|--------|--------------|-----------------|
| **suno-v4** | Stabile Version, schnelle Generierung | Pop, elektronisch, Rock |
| **suno-v4.5** | Höhere Qualität, mehr Details | Professionelle Produktion |
| **suno-v4.5plus** | Maximale Qualität, Premium-Audio | Kommerzielle Veröffentlichungen |
| **suno-v4.5all** | Vollständige Vielseitigkeit | Alle Genres |
| **suno-v5** | Neueste Version, erweiterte Funktionen | Kreative Experimente |

### Funktionen

- **5 Modelle** mit unterschiedlichen Fähigkeiten
- **Stilkontrolle** — Genre, Stimmung, Tempo, Intensität
- **Benutzerdefinierte Lyrics** — schreiben Sie eigene oder lassen Sie die KI generieren
- **Instrumental-Modus** — Musik ohne Gesang
- **Stimmkontrolle** — Stimmentyp und Bereich anpassen

### Nutzungsbeispiele

Sprechen Sie einfach mit Ihrem Agenten:

> "Generiere einen fröhlichen Popsong über den Sommer mit Akustikgitarre"

> "Erstelle Jazz-Instrumentalmusik, 3 Minuten, entspannte Atmosphäre"

> "Schreibe einen Rocksong mit benutzerdefinierten Lyrics über Roadtrips"

---

## Fehlerbehebung

| Problem | Lösung |
|---------|--------|
| `401 Unauthorized` | Überprüfen Sie Ihren `EVOLINK_API_KEY` auf [evolink.ai/dashboard](https://evolink.ai/dashboard?utm_source=github&utm_medium=readme&utm_campaign=music-generation) |
| `402 Payment Required` | Fügen Sie Credits auf [evolink.ai/dashboard](https://evolink.ai/dashboard?utm_source=github&utm_medium=readme&utm_campaign=music-generation) hinzu |
| `429 Rate Limited` | Zu viele Anfragen — warten Sie einen Moment |

---

## Lizenz

MIT

---

<p align="center">
  Angetrieben von <a href="https://evolink.ai/signup?utm_source=github&utm_medium=readme&utm_campaign=music-generation-skill-for-openclaw"><strong>EvoLink</strong></a> — Einheitliches KI-API-Gateway
</p>
