# Multi Summarize — Skill de Résumé IA pour OpenClaw

Résumé rapide multi-format — collez une URL, déposez un fichier, obtenez les points clés. Propulsé par [EvoLink](https://evolink.ai?utm_source=github&utm_medium=readme&utm_campaign=multi-summarize-skill-for-openclaw?utm_source=github&utm_medium=skill&utm_campaign=summarize).

 [Présentation](#présentation) •
 [Installation](#installation) •
 [Clé API](#obtenir-une-clé-api) •
 [Utilisation](#utilisation) •
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

## Présentation

Un skill [OpenClaw](https://github.com/openclaw/openclaw) propulsé par [EvoLink](https://evolink.ai?utm_source=github&utm_medium=readme&utm_campaign=multi-summarize-skill-for-openclaw?utm_source=github&utm_medium=skill&utm_campaign=summarize). Installez un seul skill et votre agent IA pourra résumer n'importe quel contenu — URLs, PDFs, vidéos, fichiers audio, liens YouTube ou texte brut — en points clés concis et exploitables grâce à Claude Opus 4.6, le modèle de texte le plus performant disponible.

🚀 [Obtenez votre clé API →](https://evolink.ai/signup?utm_source=github&utm_medium=readme&utm_campaign=multi-summarize-skill-for-openclaw?utm_source=github&utm_medium=skill&utm_campaign=summarize)

## Installation

### Installation rapide (Recommandée)

```bash
openclaw skills add https://github.com/EvoLinkAI/multi-summarize-skill-for-openclaw
```

Terminé. Le skill est prêt pour votre agent.

### Via ClawHub

```bash
clawhub install multi-summarize
```

### Installation manuelle

```bash
git clone https://github.com/EvoLinkAI/multi-summarize-skill-for-openclaw.git
cd multi-summarize-skill-for-openclaw
openclaw skills add .
```

## Obtenir une clé API

1. Inscrivez-vous [ici](https://evolink.ai/signup?utm_source=github&utm_medium=readme&utm_campaign=multi-summarize-skill-for-openclaw?utm_source=github&utm_medium=skill&utm_campaign=summarize)
2. Allez dans Dashboard → API Keys
3. Créez une nouvelle clé
4. Configurez la variable d'environnement :

```bash
export EVOLINK_API_KEY=your_key_here
```

Ou dites simplement à votre agent OpenClaw : « Configure ma clé API EvoLink à ... » — il s'occupera du reste.

## Utilisation

### Formats supportés

- **URLs web** — Articles, blogs, documentation
- **PDF** — Rapports, articles scientifiques, livres blancs
- **Vidéo** — mp4, webm, liens YouTube
- **Audio** — mp3, wav, m4a, podcasts
- **Texte** — Markdown, texte brut, fichiers de code

### Exemples d'utilisation

Parlez naturellement à votre agent :

```
« Résume cet article : https://evolink.ai/blog/deepseek-v4-release-window-prep?utm_source=github&utm_medium=readme&utm_campaign=multi-summarize »
« De quoi parle ce PDF ? » (joindre le fichier)
« Donne-moi les points clés de cette vidéo YouTube : https://youtu.be/... »
« Résume cet enregistrement de podcast » (joindre le mp3)
« Fais-moi un TL;DR de ce document »
```

### Référence du script

Le skill inclut `scripts/summarize.sh` pour une utilisation directe en ligne de commande :

```bash
# Résumer un article web
bash scripts/summarize.sh "https://evolink.ai/blog/deepseek-v4-release-window-prep?utm_source=github&utm_medium=readme&utm_campaign=multi-summarize"

# Résumer un PDF local
bash scripts/summarize.sh "/path/to/report.pdf"

# Résumer une vidéo YouTube
bash scripts/summarize.sh "https://youtu.be/VIDEO_ID"

# Résumer un fichier audio
bash scripts/summarize.sh "/path/to/podcast.mp3"

# Résumer avec un focus personnalisé
bash scripts/summarize.sh "https://evolink.ai/blog/deepseek-v4-release-window-prep?utm_source=github&utm_medium=readme&utm_campaign=multi-summarize" "Focus sur le calendrier de sortie"
```

### Exemple de sortie

```
## TL;DR
DeepSeek V4 fait l'objet de rumeurs depuis janvier 2026 mais n'a toujours pas été
officiellement lancé en mars. Plusieurs fenêtres de lancement prévues sont passées.
Le modèle devrait se concentrer sur le codage avec des scores HumanEval de 90 % (non vérifiés).

## Points clés
- Reuters a rapporté en janvier que DeepSeek prévoit un modèle axé sur le codage pour février 2026
- DeepSeek a discrètement étendu le contexte de 128K à 1M de tokens en février — probable test d'infrastructure V4
- Des benchmarks non vérifiés revendiquent HumanEval 90 %, SWE-bench Verified 80 %+
- « V4 Lite » est apparu sur le site de DeepSeek en mars mais n'a jamais été officiellement confirmé
- Plusieurs fenêtres de lancement (mi-février, Nouvel An lunaire, début mars) sont passées sans lancement

## Actions recommandées
- Ne pas migrer les charges de travail de production avant l'annonce officielle
- Surveiller les canaux officiels de DeepSeek pour les spécifications confirmées
- Préparer l'intégration API — EvoLink supportera V4 dès le premier jour
```

## Configuration

Modèle par défaut : `claude-opus-4-6` (aucune configuration supplémentaire nécessaire).

Pour utiliser un modèle différent :

```bash
export EVOLINK_MODEL="claude-sonnet-4-5-20250929"
```

### Modèles disponibles

**Série Claude** (format API Anthropic — `/v1/messages`)
- **claude-opus-4-6** — Qualité maximale (par défaut)
- **claude-sonnet-4-6** — Dernier Sonnet, rapide + performant
- **claude-sonnet-4-5-20250929** — Rapide + économique
- **claude-haiku-4-5-20251001** — Ultra rapide, tâches légères

**Série GPT** (format API OpenAI — `/v1/chat/completions`)
- **gpt-5.4** — Dernier modèle phare d'OpenAI
- **gpt-4o** — Multimodal, rapide
- **gpt-4o-mini** — Léger, économique

**Série Gemini** (format API OpenAI — `/v1/chat/completions`)
- **gemini-3.1-flash-lite-preview** — Modèle ultra rapide et léger de Google
- **gemini-3-flash-preview** — Rapide, idéal pour les résumés

### Référence API

Documentation complète de l'API [ici](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=summarize).

## Structure des fichiers

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

## Dépannage

- **`python3: command not found`** — Installer Python 3 : `apt install python3` / `brew install python3`
- **`curl: command not found`** — Installer curl : `apt install curl` / `brew install curl`
- **`401 Unauthorized`** — Vérifiez EVOLINK_API_KEY sur votre [tableau de bord](https://evolink.ai/dashboard?utm_source=github&utm_medium=readme&utm_campaign=multi-summarize-skill-for-openclaw?utm_source=github&utm_medium=skill&utm_campaign=summarize)
- **`402 Payment Required`** — Rechargez sur votre [tableau de bord](https://evolink.ai/dashboard?utm_source=github&utm_medium=readme&utm_campaign=multi-summarize-skill-for-openclaw?utm_source=github&utm_medium=skill&utm_campaign=summarize)
- **Échec d'extraction PDF** — Installer markitdown : `pip install markitdown` ou poppler : `apt install poppler-utils`
- **Échec d'extraction YouTube** — Installer yt-dlp : `pip install yt-dlp`
- **Échec de transcription audio** — Installer whisper : `pip install openai-whisper`

## Liens

- [ClawHub](https://clawhub.ai/EvoLinkAI/multi-summarize)
- [API Reference](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=summarize)
- [Community](https://discord.com/invite/5mGHfA24kn)
- [Support](mailto:support@evolink.ai)

## Licence

MIT
