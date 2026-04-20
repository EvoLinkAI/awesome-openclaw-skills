# API Parameters Reference

Full parameter reference for the Evolink Music generation API.

## generate_music

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `prompt` | string | ✅ | — | Description of the music or song lyrics |
| `custom_mode` | boolean | ✅ | — | `false` = simple mode (AI writes lyrics/style), `true` = custom mode (you control everything) |
| `instrumental` | boolean | ✅ | — | `true` = instrumental only, `false` = with vocals |
| `model` | enum | ❌ | `suno-v4` | Music model to use (see [model list](#models)) |
| `duration` | integer | ❌ | model decides | Target duration in seconds (30–240s) |
| `style` | string | ❌ | — | Genre/mood/tempo tags, e.g. `"pop rock, upbeat, 120bpm"` (custom mode) |
| `title` | string | ❌ | — | Song title, max 80 characters (custom mode) |
| `negative_tags` | string | ❌ | — | Styles to exclude, e.g. `"heavy metal, screaming"` |
| `vocal_gender` | enum | ❌ | — | `m` (male) or `f` (female) — custom mode only |

### Simple Mode (`custom_mode: false`)

- `prompt`: Describe what you want (mood, genre, topic)
- AI automatically writes lyrics, picks style, and generates

### Custom Mode (`custom_mode: true`)

- `prompt`: Your lyrics with structure tags: `[Verse]`, `[Chorus]`, `[Bridge]`, `[Intro]`, `[Outro]`
- `style`: Genre and mood tags
- `title`: Song title
- `vocal_gender`: Male or female vocals

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
- Supported formats: MP3, WAV, FLAC, AAC, OGG, M4A, and more
- File expiry: 72 hours
- Quota: 100 files (default) / 500 (VIP)

## check_task

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `task_id` | string | ✅ | Task ID returned by `generate_music` |

**Response states:** `pending`, `processing`, `completed`, `failed`

When `completed`, response includes result URLs (expire in 24h).

**Polling strategy:** Every 5–10 seconds. Timeout after 5 minutes.

## list_models

No parameters. Returns all available music models with metadata.

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

All music models are currently in **BETA**.

| Model | Quality | Max Duration | Speed | Notes |
|-------|---------|-------------|-------|-------|
| `suno-v4` | Good | 120s | Fast | Balanced, economical — good default |
| `suno-v4.5` | Better | 240s | Medium | Style control, longer tracks |
| `suno-v4.5plus` | Better | 240s | Medium | Extended v4.5 features |
| `suno-v4.5all` | Better | 240s | Medium | All v4.5 features combined |
| `suno-v5` | Best | 240s | Medium | Studio-grade output, highest quality |

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
| `content_policy_violation` | ❌ | Revise lyrics/prompt |
| `invalid_parameters` | ❌ | Check values — `custom_mode` and `instrumental` are required |
| `generation_timeout` | ✅ | Retry; try shorter duration |
| `quota_exceeded` | ✅ | Top up credits |
| `resource_exhausted` | ✅ | Wait 30–60s, retry |
| `service_error` | ✅ | Retry after 1 min |

---

## Style Tag Examples

Use these as `style` parameter in custom mode:

| Genre | Example Tags |
|-------|-------------|
| Pop | `pop, catchy, upbeat, 120bpm` |
| Rock | `rock, electric guitar, powerful, 140bpm` |
| Jazz | `smooth jazz, saxophone, relaxing, 90bpm` |
| Electronic | `EDM, synth, energetic, 128bpm` |
| Classical | `orchestral, strings, cinematic, epic` |
| Lo-fi | `lo-fi, chill, mellow, beats, 85bpm` |
| Hip-hop | `hip-hop, trap, bass, 90bpm` |
| R&B | `r&b, soulful, smooth, 95bpm` |

---

## Lyric Structure Tags

Use these tags in your lyrics for custom mode:

```
[Intro]
(Instrumental opening)

[Verse]
Your verse lyrics here...

[Pre-Chorus]
Building up to the chorus...

[Chorus]
The main hook and melody...

[Bridge]
A contrasting section...

[Outro]
(Fade out or final notes)
```
