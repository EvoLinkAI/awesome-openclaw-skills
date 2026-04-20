# Nano Banana 2 — AI Image Generation Skill for OpenClaw

<p align="center">
  <strong>Google Gemini 3.1 Flash image generation, one API key — fast, versatile, ready to go.</strong>
</p>

<p align="center">
  <a href="#what-is-this">What</a> •
  <a href="#installation">Install</a> •
  <a href="#get-api-key">API Key</a> •
  <a href="#image-generation">Generate</a> •
  <a href="https://evolink.ai/signup?utm_source=github&utm_medium=readme&utm_campaign=nano-banana-2-skill-for-openclaw">EvoLink</a>
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

---

## What Is This?

An [OpenClaw](https://github.com/openclaw/openclaw) skill powered by [EvoLink](https://evolink.ai?utm_source=github&utm_medium=readme&utm_campaign=nano-banana-2-skill-for-openclaw). Install one skill, and your AI agent gets access to Google's Gemini 3.1 Flash image model — fast text-to-image and image editing through a single API.

| Skill | Description | Provider |
|-------|-------------|----------|
| **Nano Banana 2** | Text-to-image, image editing | Google (Gemini 3.1 Flash) |

> Focused view of [evolink-image](https://clawhub.ai/EvoLinkAI/evolink-image). Install the full skill for 19 image models, video, and music.

🚀 **[Try All Models Now →](https://evolink.ai/models?utm_source=github&utm_medium=readme&utm_campaign=nano-banana-2-skill-for-openclaw)**

---

## Installation

### Quick Install (Recommended)

```bash
openclaw skills add https://github.com/EvoLinkAI/nano-banana-2-skill
```

Done. The skill is ready for your agent.

### Manual Install

```bash
git clone https://github.com/EvoLinkAI/nano-banana-2-skill.git
cd nano-banana-2-skill
openclaw skills add .
```

---

## Get API Key

1. Sign up at [evolink.ai](https://evolink.ai/signup?utm_source=github&utm_medium=readme&utm_campaign=nano-banana-2-skill-for-openclaw)
2. Go to Dashboard → API Keys
3. Create a new Key
4. Set the environment variable:

```bash
export EVOLINK_API_KEY=your_key_here
```

Or just tell your OpenClaw agent: *"Set my EvoLink API key to ..."* — it'll handle the rest.

---

## Image Generation

Generate and edit AI images through natural conversation with your OpenClaw agent.

### Capabilities

- **Text-to-Image** — Describe what you want, get an image
- **Image Editing** — Transform existing images with reference
- **Multi-Resolution** — 1024×1024, 1024×1536, 1536×1024, and custom aspect ratios
- **Batch Generation** — Generate 1–4 variations in one call
- **Aspect Ratios** — 1:1, 16:9, 9:16, 4:3, 3:4, 2:3, 3:2, and more

### Why Nano Banana 2?

- **Google's latest** — Built on Gemini 3.1 Flash, the newest generation architecture
- **Fast generation** — Optimized for speed without sacrificing quality
- **Versatile** — General-purpose image creation for any creative need
- **Strong prompt adherence** — Excellent at following complex, detailed descriptions

### Lite Variant

`nano-banana-2-lite` [BETA] — Lightweight version for ultra-fast iterations when speed is the top priority.

### Usage Examples

Just talk to your agent:

> "Generate a watercolor painting of a mountain sunset"

> "Edit this photo to make it look like a vintage film still"

> "Create 4 variations of a logo design for a coffee shop"

> "Make this image look more cinematic with warm tones"

The agent will guide you through missing details and handle generation.

### Alternative Models

| Model | Best for | Speed |
|-------|----------|-------|
| `gpt-image-1.5` *(default)* | Latest OpenAI generation | Medium |
| `gpt-4o-image` [BETA] | Best quality, complex editing | Medium |
| `z-image-turbo` | Quick iterations | Ultra-fast |
| `doubao-seedream-4.5` | Photorealistic | Medium |
| `gemini-3-pro-image-preview` | Google Pro generation | Medium |

### MCP Tools

| Tool | Purpose |
|------|---------|
| `generate_image` | Create or edit AI images from text or reference images |
| `upload_file` | Upload local images for editing/reference workflows |
| `delete_file` | Remove uploaded files to free quota |
| `list_files` | View uploaded files and check storage quota |
| `check_task` | Poll generation progress and get result URLs |
| `list_models` | Browse available image models |
| `estimate_cost` | Check model pricing |

### Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `prompt` | string | — | Image description (required) |
| `model` | enum | `gemini-3.1-flash-image-preview` | Model to use |
| `size` | enum | `1024x1024` | Output size or aspect ratio |
| `n` | integer | `1` | Number of images (1–4) |
| `image_urls` | string[] | — | Reference images for i2i (up to 14) |

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

For image editing or reference workflows, upload images first:

1. Call `upload_file` with `file_path`, `base64_data`, or `file_url` → get `file_url` (synchronous)
2. Use that `file_url` as `image_urls` for `generate_image`

**Supported:** Images (JPEG, PNG, GIF, WebP). Max **100MB**. Files expire after **72 hours**. Quota: 100 files (default) / 500 (VIP).

---

## Workflow

1. Upload reference images if needed (via `upload_file`)
2. Call `generate_image` → get `task_id`
3. Poll `check_task` every 3–5s until `completed`
4. Download result URLs (expire in 24h)

---

## Script Reference

The skill includes `scripts/evolink-image-gen.sh` for direct command-line usage:

```bash
# Text-to-image
./scripts/evolink-image-gen.sh "Watercolor mountain sunset" --size 1024x1536

# With reference image
./scripts/evolink-image-gen.sh "Make it look vintage" --image "https://example.com/photo.jpg"

# Batch generation (4 variations)
./scripts/evolink-image-gen.sh "Coffee shop logo design" --n 4

# Quick iteration with lite variant
./scripts/evolink-image-gen.sh "Abstract geometric pattern" --model nano-banana-2-lite
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
    └── evolink-image-gen.sh     # Image generation script
```

---

## Troubleshooting

| Problem | Solution |
|---------|----------|
| `jq: command not found` | Install jq: `apt install jq` / `brew install jq` |
| `curl: command not found` | Install curl: `apt install curl` / `brew install curl` |
| `401 Unauthorized` | Check `EVOLINK_API_KEY` at [evolink.ai/dashboard](https://evolink.ai/dashboard?utm_source=github&utm_medium=readme&utm_campaign=nano-banana-2-skill-for-openclaw) |
| `402 Payment Required` | Top up at [evolink.ai/dashboard](https://evolink.ai/dashboard?utm_source=github&utm_medium=readme&utm_campaign=nano-banana-2-skill-for-openclaw) |
| Content blocked | Celebrities/NSFW/violence restricted — modify your prompt |
| Generation timeout | Try `nano-banana-2-lite` for faster results |

---

## More Skills

More EvoLink skills are in development. Follow for updates or [submit a request](https://github.com/EvoLinkAI/nano-banana-2-skill/issues).

---

## Download from ClawHub

You can also install this skill directly from ClawHub:

👉 **[Download on ClawHub →](https://clawhub.ai/EvoLinkAI/evolink-nano-banana-2)**

---

## License

MIT

---

<p align="center">
  Powered by <a href="https://evolink.ai/signup?utm_source=github&utm_medium=readme&utm_campaign=nano-banana-2-skill-for-openclaw"><strong>EvoLink</strong></a> — Unified AI API Gateway
</p>
