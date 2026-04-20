# Evolink Image — AI Image Generation & Editing Skill for OpenClaw

<p align="center">
  <strong>19 image models, one API key — GPT Image, Seedream, Qwen, WAN, Gemini.</strong>
</p>

<p align="center">
  <a href="#what-is-this">What</a> •
  <a href="#installation">Install</a> •
  <a href="#get-api-key">API Key</a> •
  <a href="#image-generation">Generate</a> •
  <a href="https://evolink.ai/signup?utm_source=github&utm_medium=readme&utm_campaign=image-generation-skill-for-openclaw?utm_source=github&utm_medium=readme&utm_campaign=image-generation-skill-for-openclaw">EvoLink</a>
</p>

<p align="center">
  <strong>🌐 Languages:</strong>
  <a href="README.md">English</a> |
  <a href="README.zh-CN.md">简体中文</a>
</p>

---

## What Is This?

An [OpenClaw](https://github.com/openclaw/openclaw) skill powered by [EvoLink](https://evolink.ai?utm_source=github&utm_medium=readme&utm_campaign=image-generation-skill-for-openclaw). Install one skill, and your AI agent becomes a full image studio — **19 models** for generation, editing, and inpainting, all through a single API.

| Skill | Description | Providers |
|-------|-------------|-----------|
| **Evolink Image** | Text-to-image, image-to-image, inpainting, instruction-based editing | GPT Image, GPT-4o, Seedream, Qwen, WAN, Gemini |

> This is the image-focused view of [evolink-media](https://clawhub.ai/EvoLinkAI/evolink-media). Install the full skill for video and music generation too.

🚀 **[Try All Models Now →](https://evolink.ai/models)**

More skills coming soon.

---

## Installation

### Quick Install (Recommended)

```bash
openclaw skills add https://github.com/EvoLinkAI/image-generation-skill-for-openclaw
```

Done. The skill is ready for your agent.

### Manual Install

```bash
git clone https://github.com/EvoLinkAI/image-generation-skill-for-openclaw.git
cd image-generation-skill-for-openclaw
openclaw skills add .
```

---

## Get API Key

1. Sign up at [evolink.ai](https://evolink.ai/signup?utm_source=github&utm_medium=readme&utm_campaign=image-generation-skill-for-openclaw)utm_medium=readme[evolink.ai](https://evolink.ai/signup?utm_source=github&utm_medium=readme&utm_campaign=image-generation-skill-for-openclaw?utm_source=github&utm_medium=readme&utm_campaign=image-generation-skill-for-openclaw)utm_campaign=image-generation-skill-for-openclaw)
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
- **Image-to-Image** — Transform existing images with reference
- **Inpainting** — Edit specific regions with mask support
- **Instruction-based Editing** — Tell the AI what to change in natural language
- **Multi-Resolution** — 1024×1024, 1024×1536, 1536×1024, and custom aspect ratios
- **Batch Generation** — Generate 1–4 variations in one call
- **Aspect Ratios** — 1:1, 16:9, 9:16, 4:3, 3:4, and more

### Usage Examples

Just talk to your agent:

> "Generate a watercolor painting of a mountain sunset"

> "Edit this photo to make it look like a vintage film still"

> "Remove the background from this image and replace it with a beach"

> "Create 4 variations of a logo design for a coffee shop"

The agent will guide you through missing details and handle generation.

### Models (19)

#### Top Picks

| Model | Best for | Speed |
|-------|----------|-------|
| `gpt-image-1.5` *(default)* | Latest OpenAI generation | Medium |
| `z-image-turbo` | Quick iterations | Ultra-fast |
| `doubao-seedream-4.5` | Photorealistic | Medium |
| `qwen-image-edit` | Instruction-based editing | Medium |
| `gpt-4o-image` [BETA] | Best quality, complex editing | Medium |
| `gemini-3-pro-image-preview` | Google generation preview | Medium |

#### Stable Models (15)

`gpt-image-1.5`, `gpt-image-1`, `gemini-3-pro-image-preview`, `z-image-turbo`, `doubao-seedream-4.5`, `doubao-seedream-4.0`, `doubao-seedream-3.0-t2i`, `doubao-seededit-4.0-i2i`, `doubao-seededit-3.0-i2i`, `qwen-image-edit`, `qwen-image-edit-plus`, `wan2.5-t2i-preview`, `wan2.5-i2i-preview`, `wan2.5-text-to-image`, `wan2.5-image-to-image`

#### Beta Models (4)

`gpt-image-1.5-lite`, `gpt-4o-image`, `gemini-2.5-flash-image`, `nano-banana-2-lite`

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
| `model` | enum | `gpt-image-1.5` | Model to use |
| `size` | enum | `1024x1024` | Output size or aspect ratio |
| `n` | integer | `1` | Number of images (1–4) |
| `image_urls` | string[] | — | Reference images for i2i (up to 14) |
| `mask_url` | string | — | PNG mask for inpainting (`gpt-4o-image` only) |

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

**Direct install (Claude  Code):**

```bash
claude mcp add evolink-media -e EVOLINK_API_KEY=your-key -- npx -y @evolinkai/evolink-media@latest
```

---

## File Upload

For image editing or reference workflows, upload images first:

1. Call `upload_file` with `file_path`, `base64_data`, or `file_url` → get `file_url` (synchronous)
2. Use that `file_url` as `image_urls` or `mask_url` for `generate_image`

**Supported:** Images (JPEG, PNG, GIF, WebP). Max **100MB**. Files expire after **72 hours**. Quota: 100 files (default) / 500 (VIP).

---

## Workflow

1. Upload reference images or masks if needed (via `upload_file`)
2. Call `generate_image` → get `task_id`
3. Poll `check_task` every 3–5s until `completed`
4. Download result URLs (expire in 24h)

---

## Script Reference

The skill includes `scripts/evolink-image-gen.sh` for direct command-line usage:

```bash
# Text-to-image
./scripts/evolink-image-gen.sh "Watercolor mountain sunset" --quality 1024x1536

# With reference image
./scripts/evolink-image-gen.sh "Make it look vintage" --image "https://example.com/photo.jpg"

# Batch generation (4 variations)
./scripts/evolink-image-gen.sh "Coffee shop logo design" --n 4

# Choose a specific model
./scripts/evolink-image-gen.sh "Photorealistic portrait" --model doubao-seedream-4.5

# Quick iteration with turbo
./scripts/evolink-image-gen.sh "Abstract geometric pattern" --model z-image-turbo
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
| `401 Unauthorized` | Check `EVOLINK_API_KEY` at [evolink.ai/dashboard](https://evolink.ai/dashboard) |
| `402 Payment Required` | Top up at [evolink.ai/dashboard](https://evolink.ai/dashboard) |
| Content blocked | Celebrities/NSFW/violence restricted — modify your prompt |
| Generation timeout | Try `z-image-turbo` for faster results |
| Image dimension mismatch | Resize image to match the model's supported aspect ratio |

---

## More Skills

More EvoLink skills are in development. Follow for updates or [submit a request](https://github.com/EvoLinkAI/image-generation-skill-for-openclaw/issues).

---

## Download from ClawHub

You can also install this skill directly from ClawHub:

👉 **[Download on ClawHub →](https://clawhub.ai/EvoLinkAI/evolink-image)**

---

## License

MIT

---

<p align="center">
  Powered by <a href="https://evolink.ai/signup?utm_source=github&utm_medium=readme&utm_campaign=image-generation-skill-for-openclaw?utm_source=github&utm_medium=readme&utm_campaign=image-generation-skill-for-openclaw"><strong>EvoLink</strong></a> — Unified AI API Gateway
</p>
