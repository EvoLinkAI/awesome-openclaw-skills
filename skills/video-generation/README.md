# Evolink Video — AI Video Generation Skill for OpenClaw

<p align="center">
  <strong>37 video models, one API key — Sora, Kling, Veo 3, Seedance, Hailuo, WAN, Grok.</strong>
</p>

<p align="center">
  <a href="#what-is-this">What</a> •
  <a href="#installation">Install</a> •
  <a href="#get-api-key">API Key</a> •
  <a href="#video-generation">Generate</a> •
  <a href="https://evolink.ai/signup?utm_source=github&utm_medium=readme&utm_campaign=video-generation-skill-for-openclaw">EvoLink</a>
</p>

<p align="center">
  <strong>🌐 Languages:</strong>
  <a href="README.md">English</a> |
  <a href="README.zh-CN.md">简体中文</a>
</p>

---

## What Is This?

An [OpenClaw](https://github.com/openclaw/openclaw) skill powered by [EvoLink](https://evolink.ai?utm_source=github&utm_medium=readme&utm_campaign=video-generation). Install one skill, and your AI agent gains the ability to generate videos with **37 models** from the world's leading providers — all through a single API.

| Skill | Description | Providers |
|-------|-------------|-----------|
| **Evolink Video** | Text-to-video, image-to-video, first-last-frame, video editing, audio generation | Sora, Kling, Veo 3, Seedance, Hailuo, WAN, Grok |

> This is the video-focused view of [evolink-media](https://clawhub.ai/EvoLinkAI/evolink-media). Install the full skill for image and music generation too.

🚀 **[Try All Models Now →](https://evolink.ai/models?utm_source=github&utm_medium=readme&utm_campaign=video-generation)**

More skills coming soon.

---

## Installation

### Quick Install (Recommended)

```bash
openclaw skills add https://github.com/EvoLinkAI/video-generation-skill-for-openclaw
```

Done. The skill is ready for your agent.

### Manual Install

```bash
git clone https://github.com/EvoLinkAI/video-generation-skill-for-openclaw.git
cd video-generation-skill-for-openclaw
openclaw skills add .
```

---

## Get API Key

1. Sign up at [evolink.ai](https://evolink.ai/signup?utm_source=github&utm_medium=readme&utm_campaign=video-generation-skill-for-openclaw)
2. Go to Dashboard → API Keys
3. Create a new Key
4. Set the environment variable:

```bash
export EVOLINK_API_KEY=your_key_here
```

Or just tell your OpenClaw agent: *"Set my EvoLink API key to ..."* — it'll handle the rest.

---

## Video Generation

Generate AI videos through natural conversation with your OpenClaw agent.

### Capabilities

- **Text-to-Video** — Describe a scene, get a video
- **Image-to-Video** — Provide reference images to guide output
- **First-Last-Frame** — Define start and end frames for precise control
- **Video Editing** — Edit and transform existing videos
- **Auto Audio** — Sync voice, sound effects, and background music
- **Multi-Resolution** — 480p, 720p, 1080p, 4K
- **Flexible Duration** — 3–15 seconds (model dependent)
- **Aspect Ratios** — 16:9, 9:16, 1:1, 4:3, 3:4, 21:9

### Usage Examples

Just talk to your agent:

> "Generate a 5-second video of a cat playing piano"

> "Create a cinematic ocean sunset shot, 1080p, 16:9"

> "Use this image as reference and generate an 8-second animated video"

> "Edit this video to add a dreamy slow-motion effect"

The agent will guide you through missing details and handle generation.

### Models (37)

#### Top Picks

| Model | Best for | Features |
|-------|----------|----------|
| `seedance-1.5-pro` *(default)* | Image-to-video, first-last-frame | i2v, 4–12s, 1080p, audio |
| `sora-2-preview` | Cinematic preview | t2v, i2v, 1080p |
| `kling-o3-text-to-video` | Text-to-video, 1080p | t2v, 3–15s |
| `veo-3.1-generate-preview` | Google video preview | t2v, 1080p |
| `MiniMax-Hailuo-2.3` | High-quality video | t2v, 1080p |
| `wan2.6-text-to-video` | Alibaba latest t2v | t2v |
| `sora-2` [BETA] | Cinematic, prompt adherence | t2v, i2v, 1080p |
| `veo3.1-pro` [BETA] | Top quality + audio | t2v, 1080p, audio |

#### Stable Models (26)

`seedance-1.5-pro`, `seedance-2.0`, `doubao-seedance-1.0-pro-fast`, `sora-2-preview`, `kling-o3-text-to-video`, `kling-o3-image-to-video`, `kling-o3-reference-to-video`, `kling-o3-video-edit`, `kling-v3-text-to-video`, `kling-v3-image-to-video`, `kling-o1-image-to-video`, `kling-o1-video-edit`, `kling-o1-video-edit-fast`, `kling-custom-element`, `veo-3.1-generate-preview`, `veo-3.1-fast-generate-preview`, `MiniMax-Hailuo-2.3`, `MiniMax-Hailuo-2.3-Fast`, `MiniMax-Hailuo-02`, `wan2.5-t2v-preview`, `wan2.5-i2v-preview`, `wan2.5-text-to-video`, `wan2.5-image-to-video`, `wan2.6-text-to-video`, `wan2.6-image-to-video`, `wan2.6-reference-video`

#### Beta Models (11)

`sora-2`, `sora-2-pro`, `sora-2-beta-max`, `sora-character`, `veo3.1-pro`, `veo3.1-fast`, `veo3.1-fast-extend`, `veo3`, `veo3-fast`, `grok-imagine-text-to-video`, `grok-imagine-image-to-video`

### MCP Tools

| Tool | Purpose |
|------|---------|
| `generate_video` | Create AI videos from text or images |
| `upload_file` | Upload local images for i2v workflows |
| `delete_file` | Remove uploaded files to free quota |
| `list_files` | View uploaded files and check storage quota |
| `check_task` | Poll generation progress and get result URLs |
| `list_models` | Browse available video models |
| `estimate_cost` | Check model pricing |

### Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `prompt` | string | — | Video description (required) |
| `model` | enum | `seedance-1.5-pro` | Model to use |
| `duration` | integer | model default | Duration in seconds |
| `aspect_ratio` | enum | `16:9` | `16:9`, `9:16`, `1:1`, `4:3`, `3:4`, `21:9` |
| `quality` | enum | model default | `480p` / `720p` / `1080p` / `4k` |
| `image_urls` | string[] | — | Reference images for i2v |
| `generate_audio` | boolean | model default | Auto-generate audio |

---

## Setup — MCP Server Bridge

For the full tool experience, bridge the MCP server `@evolinkai/evolink-media` ([npm](https://www.npmjs.com/package/@evolinkai/evolink-media)):

**Via mcporter:**

```bash
mcporter call --stdio "npx -y @evolinkai/evolink-media@latest" list_models
```

**Or add to mcporter config:**

```json
{
  "evolink-media": {
    "transport": "stdio",
    "command": "npx",
    "args": ["-y", "@evolinkai/evolink-media@latest"],
    "env": { "EVOLINK_API_KEY": "your-key-here" }
  }
}
```

**Direct install (Claude Code):**

```bash
claude mcp add evolink-media -e EVOLINK_API_KEY=your-key -- npx -y @evolinkai/evolink-media@latest
```

---

## File Upload

For image-to-video generation, upload reference images first:

1. Call `upload_file` with `file_path`, `base64_data`, or `file_url` → get `file_url` (synchronous)
2. Use that `file_url` as `image_urls` input for `generate_video`

**Supported:** Images (JPEG, PNG, GIF, WebP). Max **100MB**. Files expire after **72 hours**. Quota: 100 files (default) / 500 (VIP).

---

## Workflow

1. Upload reference images if needed (via `upload_file`)
2. Call `generate_video` → get `task_id`
3. Poll `check_task` every 10–15s until `completed`
4. Download result URLs (expire in 24h)

---

## Script Reference

The skill includes `scripts/evolink-video-gen.sh` for direct command-line usage:

```bash
# Text-to-video
./scripts/evolink-video-gen.sh "Serene mountain dawn landscape" --duration 5 --quality 720p

# With reference image
./scripts/evolink-video-gen.sh "Gentle ocean waves" --image "https://example.com/beach.jpg" --duration 8 --quality 1080p

# Vertical (social media)
./scripts/evolink-video-gen.sh "Dancing particles" --aspect-ratio 9:16 --duration 4 --quality 720p

# Choose a specific model
./scripts/evolink-video-gen.sh "Cinematic car chase" --model sora-2-preview --duration 10 --quality 1080p

# No audio
./scripts/evolink-video-gen.sh "Abstract art animation" --duration 6 --quality 720p --no-audio
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
    └── evolink-video-gen.sh     # Video generation script
```

---

## Troubleshooting

| Problem | Solution |
|---------|----------|
| `jq: command not found` | Install jq: `apt install jq` / `brew install jq` |
| `curl: command not found` | Install curl: `apt install curl` / `brew install curl` |
| `401 Unauthorized` | Check `EVOLINK_API_KEY` at [evolink.ai/dashboard](https://evolink.ai/dashboard?utm_source=github&utm_medium=readme&utm_campaign=video-generation) |
| `402 Payment Required` | Top up at [evolink.ai/dashboard](https://evolink.ai/dashboard?utm_source=github&utm_medium=readme&utm_campaign=video-generation) |
| Content blocked | Real faces may be restricted — modify your prompt |
| Generation timeout | Video generation takes 30–180s, try lower resolution first |
| Model unavailable | Beta models may have limited availability — use a stable model |

---

## More Skills

More EvoLink skills are in development. Follow for updates or [submit a request](https://github.com/EvoLinkAI/video-generation-skill-for-openclaw/issues).

---

## Download from ClawHub

You can also install this skill directly from ClawHub:

👉 **[Download on ClawHub →](https://clawhub.ai/EvoLinkAI/evolink-video)**

---

## License

MIT

---

<p align="center">
  Powered by <a href="https://evolink.ai/signup?utm_source=github&utm_medium=readme&utm_campaign=video-generation-skill-for-openclaw"><strong>EvoLink</strong></a> — Unified AI API Gateway
</p>
