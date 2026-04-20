# Subtitle Assistant — OpenClaw Skill

Download YouTube subtitles and use AI to summarize, translate, or extract key points — all from your terminal.

Powered by [EvoLink.ai](https://evolink.ai)

## Install

### Via ClawHub (Recommended)

```
npx clawhub install ai-subtitle-assistant
```

### Via npm

```
npx evolinkai-subtitle-assistant
```

## Quick Start

```bash
# Set your API key
export EVOLINK_API_KEY="your-key-here"

# Download subtitles from YouTube
bash scripts/subtitle.sh download "https://www.youtube.com/watch?v=dQw4w9WgXcQ"

# Download + AI summarize
bash scripts/subtitle.sh summarize "https://www.youtube.com/watch?v=dQw4w9WgXcQ"

# Download + AI translate to Chinese
bash scripts/subtitle.sh translate "https://www.youtube.com/watch?v=dQw4w9WgXcQ" --lang zh

# Extract key points
bash scripts/subtitle.sh keypoints "https://www.youtube.com/watch?v=dQw4w9WgXcQ"
```

Requires `yt-dlp`: `pip install yt-dlp`

Get a free API key at [evolink.ai/signup](https://evolink.ai/signup)

## Links

- [ClawHub](https://clawhub.ai/evolinkai/ai-subtitle-assistant)
- [EvoLink API Docs](https://docs.evolink.ai)
- [Discord](https://discord.com/invite/5mGHfA24kn)

## License

MIT
