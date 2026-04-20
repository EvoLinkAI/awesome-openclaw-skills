# API Parameters Reference

Full parameter reference for the Nano Banana 2 image generation API via EvoLink.

## generate_image

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `prompt` | string | ✅ | — | Text description of the image to generate |
| `model` | enum | ❌ | `gemini-3.1-flash-image-preview` | Image model to use (see [model info](#nano-banana-2)) |
| `size` | enum | ❌ | `1024x1024` | Output size. Ratio format: `1:1`, `16:9`, `9:16`, `2:3`, `3:2`, `4:3`, `3:4` etc. |
| `n` | integer | ❌ | `1` | Number of images to generate (1–4) |
| `image_urls` | string[] | ❌ | — | Reference image URLs for image-to-image (up to 14) |

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
| `task_id` | string | ✅ | Task ID returned by `generate_image` |

**Response states:** `pending`, `processing`, `completed`, `failed`

When `completed`, response includes result URLs (expire in 24h).

**Polling strategy:** Every 3–5 seconds. Timeout after 5 minutes.

## list_models

No parameters. Returns all available image models with metadata.

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

## Nano Banana 2

| Property | Value |
|----------|-------|
| Model ID | `gemini-3.1-flash-image-preview` |
| Provider | Google (Gemini 3.1 Flash) |
| Status | BETA |
| Capability | text-to-image, image-editing |
| Speed | Fast |
| Best for | Quick, versatile image generation with strong prompt understanding |

### Lite Variant

| Property | Value |
|----------|-------|
| Model ID | `nano-banana-2-lite` |
| Status | BETA |
| Speed | Ultra-fast |
| Best for | Rapid iterations when speed is top priority |

### Alternative Models

| Model | Best for | Speed |
|-------|----------|-------|
| `gpt-image-1.5` *(default)* | Latest OpenAI generation | Medium |
| `gpt-4o-image` [BETA] | Best quality, complex editing | Medium |
| `z-image-turbo` | Quick iterations | Ultra-fast |
| `doubao-seedream-4.5` | Photorealistic | Medium |
| `gemini-3-pro-image-preview` | Google Pro generation | Medium |

---

## Error Codes

### HTTP Errors

| Code | Meaning | Action |
|------|---------|--------|
| 401 | Unauthorized | Check `EVOLINK_API_KEY` |
| 402 | Payment Required | Top up credits |
| 429 | Rate Limited | Wait 30s, retry |
| 503 | Service Unavailable | Retry in 1 minute |

### Task Errors (status: "failed")

| Error Code | Retryable | Action |
|-----------|-----------|--------|
| `content_policy_violation` | ❌ | Revise prompt (no celebrities, NSFW, violence) |
| `invalid_parameters` | ❌ | Check values against model limits |
| `image_processing_error` | ❌ | Check format/size/URL accessibility |
| `generation_timeout` | ✅ | Retry; simplify prompt if repeated |
| `service_error` | ✅ | Retry after 1 min |
| `generation_failed_no_content` | ✅ | Modify prompt, retry |

---

## External Endpoints

| Service | URL |
|---------|-----|
| Generation API | `https://api.evolink.ai/v1/images/generations` (POST) |
| Task Status | `https://api.evolink.ai/v1/tasks/{task_id}` (GET) |
| File Upload (stream) | `https://files-api.evolink.ai/api/v1/files/upload/stream` (POST) |
| File Upload (URL) | `https://files-api.evolink.ai/api/v1/files/upload/url` (POST) |
| File List | `https://files-api.evolink.ai/api/v1/files` (GET) |
| File Delete | `https://files-api.evolink.ai/api/v1/files/{file_id}` (DELETE) |

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
