# Evolink Music — AI Music Generation Skill for OpenClaw

<p align="center">
  <strong>5 music models, one API key — Suno v4, v4.5, v5. Text-to-music, custom lyrics, instrumental.</strong>
</p>

<p align="center">
  <a href="#what-is-this">What</a> •
  <a href="#installation">Install</a> •
  <a href="#get-api-key">API Key</a> •
  <a href="#music-generation">Generate</a> •
  <a href="https://evolink.ai/signup?utm_source=github&utm_medium=readme&utm_campaign=music-generation-skill-for-openclaw">EvoLink</a>
</p>

<p align="center">
  <strong>🌐 Languages:</strong>
  <a href="README.md">English</a> |
  <a href="README.zh-CN.md">简体中文</a>
</p>

---

## What Is This?

An [OpenClaw](https://github.com/openclaw/openclaw) skill powered by [EvoLink](https://evolink.ai?utm_source=github&utm_medium=readme&utm_campaign=music-generation). Install one skill, and your AI agent becomes a music studio — **5 Suno models** for generating songs, instrumentals, and custom compositions, all through a single API.

| Skill | Description | Models |
|-------|-------------|--------|
| **Evolink Music** | Text-to-music, custom lyrics, instrumental, vocal control | Suno v4, v4.5, v4.5plus, v4.5all, v5 |

> This is the music-focused view of [evolink-media](https://clawhub.ai/EvoLinkAI/evolink-media). Install the full skill for video and image generation too.

🚀 **[Try All Models Now →](https://evolink.ai/models?utm_source=github&utm_medium=readme&utm_campaign=music-generation)**

More skills coming soon.

---

## Installation

### Quick Install (Recommended)

```bash
openclaw skills add https://github.com/EvoLinkAI/music-generation-skill-for-openclaw
```

Done. The skill is ready for your agent.

### Manual Install

```bash
git clone https://github.com/EvoLinkAI/music-generation-skill-for-openclaw.git
cd music-generation-skill-for-openclaw
openclaw skills add .
```

---

## Get API Key

1. Sign up at [evolink.ai](https://evolink.ai/signup?utm_source=github&utm_medium=readme&utm_campaign=music-generation-skill-for-openclaw)utm_medium=readme[evolink.ai](https://evolink.ai/signup?utm_source=github&utm_medium=readme&utm_campaign=music-generation-skill-for-openclaw)utm_campaign=music-generation-skill-for-openclaw)
2. Go to Dashboard → API Keys
3. Create a new Key
4. Set the environment variable:

```bash
export EVOLINK_API_KEY=your_key_here
```

Or just tell your OpenClaw agent: *"Set my EvoLink API key to ..."* — it'll handle the rest.

---

## Music Generation

Generate AI music and songs through natural conversation with your OpenClaw agent.

### Two Modes

#### Simple Mode (`custom_mode: false`)

Describe what you want — AI writes lyrics and picks style automatically.

> "Generate a cheerful pop song about summer road trips"

> "Create a relaxing lo-fi instrumental track, 2 minutes"

#### Custom Mode (`custom_mode: true`)

You control everything: lyrics, style, title, vocal gender.

> "Write a rock ballad titled 'Midnight Rain' with these lyrics:
> [Verse] Walking through the empty streets...
> [Chorus] Midnight rain keeps falling down..."

> "Create a jazz instrumental in the style of smooth jazz, 120 BPM, 3 minutes"

### Capabilities

- **Text-to-Music** — Describe a mood, genre, or scene, get a song
- **Custom Lyrics** — Write your own lyrics with `[Verse]`, `[Chorus]`, `[Bridge]` tags
- **Instrumental** — Pure music, no vocals
- **Vocal Control** — Choose male or female vocals
- **Style Tags** — Control genre, mood, tempo
- **Negative Tags** — Exclude unwanted styles
- **Flexible Duration** — 30–240 seconds (model dependent)

### Models (5, all BETA)

| Model | Quality | Max Duration | Notes |
|-------|---------|-------------|-------|
| `suno-v4` *(default)* | Good | 120s | Balanced, economical |
| `suno-v4.5` | Better | 240s | Style control |
| `suno-v4.5plus` | Better | 240s | Extended features |
| `suno-v4.5all` | Better | 240s | All v4.5 features |
| `suno-v5` | Best | 240s | Studio-grade output |

### MCP Tools

| Tool | Purpose |
|------|---------|
| `generate_music` | Create AI music or songs |
| `upload_file` | Upload audio files for reference or continuation |
| `delete_file` | Remove uploaded files to free quota |
| `list_files` | View uploaded files and check storage quota |
| `check_task` | Poll generation progress and get result URLs |
| `list_models` | Browse available music models |
| `estimate_cost` | Check model pricing |

### Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `prompt` | string | — | Description or lyrics (required) |
| `custom_mode` | boolean | — | Simple vs custom mode (required) |
| `instrumental` | boolean | — | Instrumental or with vocals (required) |
| `model` | enum | `suno-v4` | Model to use |
| `duration` | integer | model decides | Target length in seconds (30–240s) |
| `style` | string | — | Genre/mood/tempo tags (custom mode) |
| `title` | string | — | Song title (custom mode, max 80 chars) |
| `negative_tags` | string | — | Styles to exclude |
| `vocal_gender` | enum | — | `m` or `f` (custom mode) |

---

## File Upload

Upload audio files for music continuation or remix workflows:

1. Call `upload_file` with `file_path`, `base64_data`, or `file_url` → get `file_url` (synchronous)

**Supported:** Audio (MP3, WAV, FLAC, AAC, OGG, M4A, etc.). Max **100MB**. Files expire after **72 hours**. Quota: 100 files (default) / 500 (VIP).

---

## Workflow

1. Set `custom_mode` + `instrumental` (both required, no defaults)
2. Call `generate_music` → get `task_id`
3. Poll `check_task` every 5–10s until `completed`
4. Download result URLs (expire in 24h)

---

## Script Reference

The skill includes `scripts/evolink-music-gen.sh` for direct command-line usage:

```bash
# Simple mode — describe and generate
./scripts/evolink-music-gen.sh "Upbeat pop song about summer" --vocal

# Simple instrumental
./scripts/evolink-music-gen.sh "Relaxing lo-fi beats" --instrumental

# Custom mode with lyrics
./scripts/evolink-music-gen.sh "[Verse] Walking down the road... [Chorus] Here we go again..." \
  --custom --title "Road Song" --style "pop rock, upbeat" --vocal --gender f

# Use Suno v5 for best quality
./scripts/evolink-music-gen.sh "Epic orchestral battle theme" --instrumental --model suno-v5 --duration 180

# Exclude styles
./scripts/evolink-music-gen.sh "A chill electronic track" --instrumental --negative "heavy metal, screaming"
```

### API Reference

Full API documentation: [references/api-params.md](references/api-params.md)

---

## File Structure

```
.
├── README.md                    # English
├── README.zh-CN.md              # 简体中文
├── SKILL.md                     # OpenClaw skill definition
├── _meta.json                   # Skill metadata
├── references/
│   └── api-params.md            # Full API parameter docs
└── scripts/
    └── evolink-music-gen.sh     # Music generation script
```

---

## Troubleshooting

| Problem | Solution |
|---------|----------|
| `jq: command not found` | Install jq: `apt install jq` / `brew install jq` |
| `curl: command not found` | Install curl: `apt install curl` / `brew install curl` |
| `401 Unauthorized` | Check `EVOLINK_API_KEY` at [evolink.ai/dashboard](https://evolink.ai/dashboard?utm_source=github&utm_medium=readme&utm_campaign=music-generation) |
| `402 Payment Required` | Top up at [evolink.ai/dashboard](https://evolink.ai/dashboard?utm_source=github&utm_medium=readme&utm_campaign=music-generation) |
| Content blocked | Some lyric content may be restricted — modify your prompt |
| Generation timeout | Music generation takes 30–120s, try shorter duration first |
| Missing required params | Both `custom_mode` and `instrumental` are required — set them explicitly |

---

## More Skills

More EvoLink skills are in development. Follow for updates or [submit a request](https://github.com/EvoLinkAI/music-generation-skill-for-openclaw/issues).

---

## Download from ClawHub

You can also install this skill directly from ClawHub:

👉 **[Download on ClawHub →](https://clawhub.ai/EvoLinkAI/evolink-music)**

---

## License

MIT

---

<p align="center">
  Powered by <a href="https://evolink.ai/signup?utm_source=github&utm_medium=readme&utm_campaign=music-generation-skill-for-openclaw"><strong>EvoLink</strong></a> — Unified AI API Gateway
</p>

<p align="center">
  <strong>🌐 Languages:</strong>
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
