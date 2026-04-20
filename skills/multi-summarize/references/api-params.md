# API Parameters Reference

## Endpoint

```
POST https://api.evolink.ai/v1/messages
```

## Authentication

```
Authorization: Bearer YOUR_EVOLINK_API_KEY
```

## Request Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `model` | string | Yes | `claude-opus-4-6` | Model to use for summarization |
| `max_tokens` | integer | Yes | `4096` | Maximum tokens in the response |
| `system` | string | No | — | System prompt for summarization behavior |
| `messages` | array | Yes | — | Input messages array |

### Available Models

**Claude Series** (Anthropic API format — `POST /v1/messages`)

| Model ID | Description |
|----------|-------------|
| `claude-opus-4-6` | Most capable, highest quality (default) |
| `claude-sonnet-4-6` | Latest Sonnet, fast + capable |
| `claude-sonnet-4-5-20250929` | Fast, cost-effective |
| `claude-haiku-4-5-20251001` | Ultra-fast, lightweight |
| `claude-opus-4-5-20251101` | Previous Opus generation |
| `claude-opus-4-1-20250805` | Legacy Opus |
| `claude-sonnet-4-20250514` | Legacy Sonnet |

**GPT Series** (OpenAI API format — `POST /v1/chat/completions`)

| Model ID | Description |
|----------|-------------|
| `gpt-5.4` | OpenAI's latest flagship model |
| `gpt-4o` | Multimodal, fast |
| `gpt-4o-mini` | Lightweight, cost-effective |

**Gemini Series** (OpenAI API format — `POST /v1/chat/completions`)

| Model ID | Description |
|----------|-------------|
| `gemini-3.1-flash-lite-preview` | Google's ultra-fast lightweight model |
| `gemini-3-flash-preview` | Fast, great for summarization |

### Message Format

```json
{
  "model": "claude-opus-4-6",
  "max_tokens": 4096,
  "system": "You are an expert summarizer...",
  "messages": [
    {
      "role": "user",
      "content": "Summarize the following content:\n\n..."
    }
  ]
}
```

## Response Format

```json
{
  "id": "msg_...",
  "type": "message",
  "role": "assistant",
  "model": "claude-opus-4-6",
  "content": [
    {
      "type": "text",
      "text": "## TL;DR\n..."
    }
  ],
  "stop_reason": "end_turn",
  "usage": {
    "input_tokens": 1500,
    "output_tokens": 350
  }
}
```

## Error Codes

| Code | Type | Description |
|------|------|-------------|
| 400 | `invalid_request_error` | Invalid request parameters |
| 401 | `authentication_error` | Invalid or missing API key |
| 402 | `billing_error` | Insufficient balance |
| 403 | `permission_error` | Permission denied |
| 429 | `rate_limit_error` | Too many requests |
| 500 | `api_error` | Internal server error |
| 502 | `timeout_error` | Gateway timeout |
| 503 | `overloaded_error` | Service overloaded |

## Environment Variables

| Variable | Required | Description |
|----------|----------|-------------|
| `EVOLINK_API_KEY` | Yes | Your EvoLink API key |
| `EVOLINK_MODEL` | No | Override default model (default: `claude-opus-4-6`) |

## Full Documentation

- [EvoLink API Docs](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api)
- [EvoLink Dashboard](https://evolink.ai/dashboard)
- [Get API Key](https://evolink.ai/signup?utm_source=github&utm_medium=skill&utm_campaign=summarize)
