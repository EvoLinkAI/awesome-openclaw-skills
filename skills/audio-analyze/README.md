# audio-analyze-skill-for-openclaw

Transcribe and analyze audio/video content with high accuracy. [Powered by Evolink.ai](https://evolink.ai/?utm_source=github&utm_medium=skill&utm_campaign=audio-analyze)

🌐 English | [日本語](README.ja.md) | [简体中文](README.zh-CN.md) | [한국어](README.ko.md) | [Español](README.es.md) | [Français](README.fr.md) | [Deutsch](README.de.md) | [Türkçe](README.tr.md) | [Русский](README.ru.md)

## What Is This?

Transcribe and analyze your audio/video files automatically using Gemini 3.1 Pro. [Get your free API key →](https://evolink.ai/signup?utm_source=github&utm_medium=skill&utm_campaign=audio-analyze)

## Installation

### Via ClawHub (Recommended)

```bash
openclaw skills add https://github.com/EvoLinkAI/audio-analyze-skill-for-openclaw
```

### Manual Install

```bash
git clone https://github.com/EvoLinkAI/audio-analyze-skill-for-openclaw
cd audio-analyze-skill-for-openclaw
pip install -r requirements.txt
```

## Configuration

| Variable | Description | Default |
| :--- | :--- | :--- |
| `EVOLINK_API_KEY` | Evolink API Key | (Required) |
| `EVOLINK_MODEL` | Transcription Model | gemini-3.1-pro-preview-customtools |

*For detailed API configuration and model support, refer to the [EvoLink API Documentation](https://docs.evolink.ai/en/api-manual/language-series/gemini-3.1-pro-preview-customtools/openai-sdk/openai-sdk-quickstart?utm_source=github&utm_medium=skill&utm_campaign=audio-analyze).*

## Usage

### Basic Usage

```bash
export EVOLINK_API_KEY="your-key-here"
./scripts/transcribe.sh audio.mp3
```

### Advanced Usage

```bash
./scripts/transcribe.sh audio.mp3 --diarize --lang ja
```

### Example Output

* **TL;DR**: The audio is a sample track for testing.
* **Key Takeaways**: High-fidelity sound, clear frequency response.
* **Action Items**: Upload to production for final testing.

## Available Models

- **Gemini Series** (OpenAI API — `/v1/chat/completions`)

## File Structure

```
.
├── README.md
├── SKILL.md
├── _meta.json
├── scripts/
│   └── transcribe.sh
└── references/
    └── api-params.md
```

## Troubleshooting

- **Argument list too long**: Use temporary files for large audio data.
- **API Key Error**: Ensure `EVOLINK_API_KEY` is exported.

## Links

- [ClawHub](https://clawhub.ai/EvoLinkAI/audio-analyze)
- [API Reference](https://docs.evolink.ai/en/api-manual/language-series/gemini-3.1-pro-preview-customtools/openai-sdk/openai-sdk-quickstart?utm_source=github&utm_medium=skill&utm_campaign=audio-analyze)
- [Community](https://discord.com/invite/5mGHfA24kn)
- [Support](mailto:support@evolink.ai)

## License

MIT
