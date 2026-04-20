# Content Rewriter — OpenClaw Skill

Rewrite and optimize content for 8+ platforms with AI-powered tone adjustment, batch conversion, quality scoring, and translation.

**Platforms:** Twitter, LinkedIn, Blog, Email, Medium, Reddit, Product Hunt, WeChat

**Tones:** Professional, Casual, Humorous, Inspirational, Educational, Persuasive, Technical, Storytelling

Powered by [EvoLink.ai](https://evolink.ai)

## Install

### Via ClawHub (Recommended)

```
npx clawhub install content-rewriter-pro
```

### Via npm

```
npx evolinkai-content-rewriter
```

## Quick Start

```bash
# Set your API key
export EVOLINK_API_KEY="your-key-here"

# Rewrite for a platform
bash scripts/rewriter.sh rewrite mypost.txt --platform twitter

# Batch rewrite
bash scripts/rewriter.sh batch mypost.txt --platforms twitter,linkedin,blog

# Score content quality
bash scripts/rewriter.sh score mypost.txt

# Translate
bash scripts/rewriter.sh translate mypost.txt --lang Spanish
```

Get a free API key at [evolink.ai/signup](https://evolink.ai/signup)

## Links

- [ClawHub](https://clawhub.ai/evolinkai/content-rewriter-pro)
- [EvoLink API Docs](https://docs.evolink.ai)
- [Discord](https://discord.com/invite/5mGHfA24kn)

## License

MIT
