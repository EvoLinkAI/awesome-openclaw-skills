# API Parameters Reference

Full parameter reference for the Evolink Video generation API.

## generate_video

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `prompt` | string | ✅ | — | Text description of the video to generate |
| `model` | enum | ❌ | `seedance-1.5-pro` | Video model to use (see [model list](#models)) |
| `duration` | integer | ❌ | model default | Video duration in seconds (3–15, model dependent) |
| `aspect_ratio` | enum | ❌ | `16:9` | Aspect ratio: `16:9`, `9:16`, `1:1`, `4:3`, `3:4`, `21:9` |
| `quality` | enum | ❌ | model default | Output quality: `480p`, `720p`, `1080p`, `4k` |
| `image_urls` | string[] | ❌ | — | Reference image URLs for image-to-video generation |
| `generate_audio` | boolean | ❌ | model default | Auto-generate synchronized audio |

## upload_file

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `file_path` | string | ❌* | Local file path to upload |
| `base64_data` | string | ❌* | Base64-encoded file data |
| `file_url` | string | ❌* | URL of file to upload |

\* One of `file_path`, `base64_data`, or `file_url` is required.

**Response:** Returns `file_url` (public link, expires in 72h).

**Limits:**
- Max file size: 100MB
- Supported formats: JPEG, PNG, GIF, WebP
- File expiry: 72 hours
- Quota: 100 files (default) / 500 (VIP)

## check_task

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `task_id` | string | ✅ | Task ID returned by `generate_video` |

**Response states:** `pending`, `processing`, `completed`, `failed`

When `completed`, response includes `result_url` (expires in 24h).

## list_models

No parameters. Returns all available video models with metadata.

## estimate_cost

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `model` | enum | ✅ | Model to check pricing for |

## delete_file / list_files

| Tool | Parameters | Description |
|------|-----------|-------------|
| `delete_file` | `file_id` (string, required) | Remove an uploaded file |
| `list_files` | — | List all uploaded files and quota usage |

---

## Models

### Stable Models (26)

| Model | Type | Duration | Max Quality | Audio |
|-------|------|----------|-------------|-------|
| `seedance-1.5-pro` | i2v | 4–12s | 1080p | ✅ |
| `seedance-2.0` | i2v | 4–12s | 1080p | ✅ |
| `doubao-seedance-1.0-pro-fast` | i2v | 4–12s | 1080p | ❌ |
| `sora-2-preview` | t2v, i2v | — | 1080p | ❌ |
| `kling-o3-text-to-video` | t2v | 3–15s | 1080p | ❌ |
| `kling-o3-image-to-video` | i2v | 3–15s | 1080p | ❌ |
| `kling-o3-reference-to-video` | ref | 3–15s | 1080p | ❌ |
| `kling-o3-video-edit` | edit | — | 1080p | ❌ |
| `kling-v3-text-to-video` | t2v | 3–15s | 1080p | ❌ |
| `kling-v3-image-to-video` | i2v | 3–15s | 1080p | ❌ |
| `kling-o1-image-to-video` | i2v | 3–10s | 1080p | ❌ |
| `kling-o1-video-edit` | edit | — | 1080p | ❌ |
| `kling-o1-video-edit-fast` | edit | — | 1080p | ❌ |
| `kling-custom-element` | custom | — | 1080p | ❌ |
| `veo-3.1-generate-preview` | t2v | — | 1080p | ❌ |
| `veo-3.1-fast-generate-preview` | t2v | — | 1080p | ❌ |
| `MiniMax-Hailuo-2.3` | t2v | — | 1080p | ❌ |
| `MiniMax-Hailuo-2.3-Fast` | t2v | — | 1080p | ❌ |
| `MiniMax-Hailuo-02` | t2v | — | 1080p | ❌ |
| `wan2.5-t2v-preview` | t2v | — | — | ❌ |
| `wan2.5-i2v-preview` | i2v | — | — | ❌ |
| `wan2.5-text-to-video` | t2v | — | — | ❌ |
| `wan2.5-image-to-video` | i2v | — | — | ❌ |
| `wan2.6-text-to-video` | t2v | — | — | ❌ |
| `wan2.6-image-to-video` | i2v | — | — | ❌ |
| `wan2.6-reference-video` | ref | — | — | ❌ |

### Beta Models (11)

| Model | Type | Max Quality | Audio |
|-------|------|-------------|-------|
| `sora-2` | t2v, i2v | 1080p | ❌ |
| `sora-2-pro` | t2v, i2v | 1080p | ❌ |
| `sora-2-beta-max` | t2v, i2v | 1080p | ❌ |
| `sora-character` | t2v | 1080p | ❌ |
| `veo3.1-pro` | t2v | 1080p | ✅ |
| `veo3.1-fast` | t2v | 1080p | ❌ |
| `veo3.1-fast-extend` | t2v | 1080p | ❌ |
| `veo3` | t2v | 1080p | ✅ |
| `veo3-fast` | t2v | 1080p | ❌ |
| `grok-imagine-text-to-video` | t2v | — | ❌ |
| `grok-imagine-image-to-video` | i2v | — | ❌ |

---

## Direct API (without MCP)

### Upload File

```bash
# Upload local file
curl -X POST https://files-api.evolink.ai/api/v1/files/upload/stream \
  -H "Authorization: Bearer $EVOLINK_API_KEY" \
  -F "file=@/path/to/image.jpg"

# Upload from URL
curl -X POST https://files-api.evolink.ai/api/v1/files/upload/url \
  -H "Authorization: Bearer $EVOLINK_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"file_url": "https://example.com/image.jpg"}'
```

Response returns `file_url` (public link, expires in 72h).
