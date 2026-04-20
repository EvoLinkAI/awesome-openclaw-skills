---
name: Audio Analyze
description: High-performance audio transcription and analysis using Gemini 3.1 Pro. Powered by Evolink.ai
---

# Audio Analyze

Transcribe and analyze audio/video content with high accuracy. [Powered by Evolink.ai](https://evolink.ai/?utm_source=github&utm_medium=skill&utm_campaign=audio-analyze)

## When to Use
- Transcribing meeting recordings.
- Analyzing audio file structure (music/speech).
- Extracting text from long-form audio.

## Quick Start
```bash
export EVOLINK_API_KEY="your-key-here"
./scripts/transcribe.sh audio.mp3
```

## Configuration
- `EVOLINK_API_KEY` (Required): Your API key from Evolink.
- `EVOLINK_MODEL` (Optional): Default: `gemini-3.1-pro-preview-customtools`.
- Binaries required: `python3`, `curl`.

## Example
Input: `https://evolink.ai/blog/example-audio.mp3`
Output: `TL;DR: Summary...`

## Security
- Data is encrypted and transmitted securely to api.evolink.ai.
- No local sensitive files are accessed outside the workspace.

## Links
- [GitHub](https://github.com/EvoLinkAI/audio-analyze-skill-for-openclaw)
- [API Reference](https://docs.evolink.ai/en/api-manual/language-series/gemini-3.1-pro-preview-customtools/openai-sdk/openai-sdk-quickstart?utm_source=github&utm_medium=skill&utm_campaign=audio-analyze)
- [Community](https://discord.com/invite/5mGHfA24kn)
- [Support](mailto:support@evolink.ai)
