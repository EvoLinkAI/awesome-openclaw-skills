# Gmail Assistant — KI-E-Mail-Skill für OpenClaw

Gmail-API-Integration mit KI-gestützter Zusammenfassung, intelligentem Antwortentwurf und Posteingangs-Priorisierung. Bereitgestellt von [evolink.ai](https://evolink.ai?utm_source=github&utm_medium=skill&utm_campaign=gmail)

[Was ist das?](#was-ist-das) | [Installation](#installation) | [Einrichtung](#einrichtungsanleitung) | [Verwendung](#verwendung) | [EvoLink](https://evolink.ai?utm_source=github&utm_medium=skill&utm_campaign=gmail)

**Language / Sprache:**
[English](README.md) | [简体中文](README.zh-CN.md) | [日本語](README.ja.md) | [한국어](README.ko.md) | [Español](README.es.md) | [Français](README.fr.md) | [Deutsch](README.de.md) | [Türkçe](README.tr.md) | [Русский](README.ru.md)

## Was ist das?

Gmail Assistant ist ein OpenClaw-Skill, der Ihr Gmail-Konto mit Ihrem KI-Agenten verbindet. Er bietet vollstaendigen Gmail-API-Zugriff -- Lesen, Senden, Suchen, Labels verwalten, Archivieren -- sowie KI-gestuetzte Funktionen wie Posteingangs-Zusammenfassung, intelligenten Antwortentwurf und E-Mail-Priorisierung ueber Claude via EvoLink.

**Die grundlegenden Gmail-Operationen funktionieren ohne API-Schluessel.** KI-Funktionen (Zusammenfassung, Entwurf, Priorisierung) erfordern einen optionalen EvoLink-API-Schluessel.

[Holen Sie sich Ihren kostenlosen EvoLink-API-Schluessel](https://evolink.ai/signup?utm_source=github&utm_medium=skill&utm_campaign=gmail)

## Installation

### Schnellinstallation

```bash
openclaw skills add https://github.com/EvoLinkAI/gmail-skill-for-openclaw
```

### Ueber ClawHub

```bash
npx clawhub install evolinkai/gmail
```

### Manuelle Installation

```bash
git clone https://github.com/EvoLinkAI/gmail-skill-for-openclaw.git
cd gmail-skill-for-openclaw
```

## Einrichtungsanleitung

### Schritt 1: Google-OAuth-Anmeldedaten erstellen

1. Gehen Sie zur [Google Cloud Console](https://console.cloud.google.com/)
2. Erstellen Sie ein neues Projekt (oder waehlen Sie ein bestehendes aus)
3. Aktivieren Sie die **Gmail API**: APIs & Services > Library > suchen Sie nach "Gmail API" > Enable
4. Konfigurieren Sie den OAuth-Zustimmungsbildschirm: APIs & Services > OAuth consent screen > External > fuellen Sie die erforderlichen Felder aus
5. Erstellen Sie OAuth-Anmeldedaten: APIs & Services > Credentials > Create Credentials > OAuth client ID > **Desktop app**
6. Laden Sie die Datei `credentials.json` herunter

### Schritt 2: Konfigurieren

```bash
mkdir -p ~/.gmail-skill
cp credentials.json ~/.gmail-skill/credentials.json
bash scripts/gmail-auth.sh setup
```

### Schritt 3: Autorisieren

```bash
bash scripts/gmail-auth.sh login
```

Dadurch wird ein Browser fuer die Google-OAuth-Zustimmung geoeffnet. Tokens werden lokal unter `~/.gmail-skill/token.json` gespeichert.

### Schritt 4: EvoLink-API-Schluessel festlegen (Optional -- fuer KI-Funktionen)

```bash
export EVOLINK_API_KEY="your-key-here"
```

[API-Schluessel erhalten](https://evolink.ai/signup?utm_source=github&utm_medium=skill&utm_campaign=gmail)

## Verwendung

### Kernbefehle

```bash
# Aktuelle E-Mails auflisten
bash scripts/gmail.sh list

# Mit Filter auflisten
bash scripts/gmail.sh list --query "is:unread" --max 20

# Eine bestimmte E-Mail lesen
bash scripts/gmail.sh read MESSAGE_ID

# Eine E-Mail senden
bash scripts/gmail.sh send "to@example.com" "Meeting tomorrow" "Hi, can we meet at 3pm?"

# Auf eine E-Mail antworten
bash scripts/gmail.sh reply MESSAGE_ID "Thanks, I'll be there."

# E-Mails durchsuchen
bash scripts/gmail.sh search "from:boss@company.com has:attachment"

# Labels auflisten
bash scripts/gmail.sh labels

# Label hinzufuegen/entfernen
bash scripts/gmail.sh label MESSAGE_ID +STARRED
bash scripts/gmail.sh label MESSAGE_ID -UNREAD

# Markieren / Archivieren / Loeschen
bash scripts/gmail.sh star MESSAGE_ID
bash scripts/gmail.sh archive MESSAGE_ID
bash scripts/gmail.sh trash MESSAGE_ID

# Vollstaendigen Thread anzeigen
bash scripts/gmail.sh thread THREAD_ID

# Kontoinformationen
bash scripts/gmail.sh profile
```

### KI-Befehle (erfordert EVOLINK_API_KEY)

```bash
# Ungelesene E-Mails zusammenfassen
bash scripts/gmail.sh ai-summary

# Zusammenfassung mit benutzerdefinierter Abfrage
bash scripts/gmail.sh ai-summary --query "from:team@company.com after:2026/04/01" --max 15

# KI-Antwort entwerfen
bash scripts/gmail.sh ai-reply MESSAGE_ID "Politely decline and suggest next week"

# Posteingang priorisieren
bash scripts/gmail.sh ai-prioritize --max 30
```

### Beispielausgabe

```
Posteingangs-Zusammenfassung (5 ungelesene E-Mails):

1. [DRINGEND] Projektfrist verschoben — von: manager@company.com
   Die Frist fuer den Q2-Produktstart wurde vom 15. April auf den 10. April vorverlegt.
   Handlungsbedarf: Sprint-Plan bis morgen Geschaeftsschluss aktualisieren.

2. Rechnung #4521 — von: billing@vendor.com
   Monatliche SaaS-Abonnementrechnung ueber 299 $. Faellig am 15. April.
   Handlungsbedarf: Genehmigen oder an die Finanzabteilung weiterleiten.

3. Team-Mittagessen am Freitag — von: hr@company.com
   Teambuilding-Mittagessen um 12:30 Uhr am Freitag. Um Rueckmeldung wird gebeten.
   Handlungsbedarf: Mit Teilnahmebestaetigung antworten.

4. Newsletter: AI Weekly — von: newsletter@aiweekly.com
   Niedrige Prioritaet. Woechentliche KI-Nachrichten-Zusammenfassung.
   Handlungsbedarf: Keiner.

5. GitHub-Benachrichtigung — von: notifications@github.com
   PR #247 in main gemergt. CI bestanden.
   Handlungsbedarf: Keiner.
```

## Konfiguration

Erforderliche Binardateien: `python3`, `curl`

| Variable | Standard | Erforderlich | Beschreibung |
|----------|---------|-------------|--------------|
| `credentials.json` | — | Ja (Kern) | Google OAuth-Anmeldedaten — siehe [Einrichtungsanleitung](#einrichtungsanleitung) |
| `EVOLINK_API_KEY` | — | Optional (KI) | EvoLink-API-Schluessel — [hier registrieren](https://evolink.ai/signup?utm_source=github&utm_medium=skill&utm_campaign=gmail) |
| `EVOLINK_MODEL` | `claude-opus-4-6` | Nein | KI-Modell — siehe [EvoLink-API-Dokumentation](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=gmail) |
| `GMAIL_SKILL_DIR` | `~/.gmail-skill` | Nein | Benutzerdefinierter Pfad fuer Anmeldedaten-Speicherung |

## Gmail-Abfragesyntax

- `is:unread` — Ungelesene Nachrichten
- `is:starred` — Markierte Nachrichten
- `from:user@example.com` — Von einem bestimmten Absender
- `to:user@example.com` — An einen bestimmten Empfaenger
- `subject:keyword` — Betreff enthaelt Schluesselwort
- `after:2026/01/01` — Nach Datum
- `before:2026/12/31` — Vor Datum
- `has:attachment` — Hat Anhaenge
- `label:work` — Hat ein bestimmtes Label

## Dateistruktur

```
.
├── README.md               # English (Hauptversion)
├── README.zh-CN.md         # 简体中文
├── README.ja.md            # 日本語
├── README.ko.md            # 한국어
├── README.es.md            # Español
├── README.fr.md            # Français
├── README.de.md            # Deutsch
├── README.tr.md            # Türkçe
├── README.ru.md            # Русский
├── SKILL.md                # OpenClaw-Skill-Definition
├── _meta.json              # Skill-Metadaten
├── LICENSE                 # MIT-Lizenz
├── references/
│   └── api-params.md       # Gmail-API-Parameterreferenz
└── scripts/
    ├── gmail-auth.sh       # OAuth-Authentifizierungsmanager
    └── gmail.sh            # Gmail-Operationen + KI-Funktionen
```

## Fehlerbehebung

- **"Not authenticated"** — Fuehren Sie `bash scripts/gmail-auth.sh login` aus, um sich zu autorisieren
- **"credentials.json not found"** — Laden Sie die OAuth-Anmeldedaten von der Google Cloud Console herunter und legen Sie sie unter `~/.gmail-skill/credentials.json` ab
- **"Token refresh failed"** — Ihr Aktualisierungs-Token ist moeglicherweise abgelaufen. Fuehren Sie `bash scripts/gmail-auth.sh login` erneut aus
- **"Set EVOLINK_API_KEY"** — KI-Funktionen erfordern einen EvoLink-API-Schluessel. Die grundlegenden Gmail-Operationen funktionieren ohne ihn
- **"Error 403: access_denied"** — Stellen Sie sicher, dass die Gmail API in Ihrem Google Cloud-Projekt aktiviert ist und der OAuth-Zustimmungsbildschirm konfiguriert wurde
- **Token-Sicherheit** — Tokens werden mit `chmod 600`-Berechtigungen gespeichert. Nur Ihr Benutzerkonto kann sie lesen

## Links

- [ClawHub](https://clawhub.ai/EvoLinkAI/gmail-assistant)
- [API-Referenz](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=gmail)
- [Community](https://discord.com/invite/5mGHfA24kn)
- [Support](mailto:support@evolink.ai)

## Lizenz

MIT — siehe [LICENSE](LICENSE) fuer Details.
