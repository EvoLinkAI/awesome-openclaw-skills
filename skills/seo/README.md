# SEO Assistant — OpenClaw Skill

AI-powered SEO analysis and optimization. Audit HTML pages, rewrite meta tags, research keywords, generate schema markup, and create sitemaps — all from your terminal.

Powered by [EvoLink.ai](https://evolink.ai)

## Install

### Via ClawHub (Recommended)

```
npx clawhub install ai-seo-assistant
```

### Via npm

```
npx evolinkai-seo-assistant
```

## Quick Start

```bash
# Set your API key
export EVOLINK_API_KEY="your-key-here"

# Audit an HTML file
bash scripts/seo.sh audit index.html

# Check a live URL
bash scripts/seo.sh check https://example.com

# AI rewrite meta tags
bash scripts/seo.sh rewrite index.html

# Research keywords for a topic
bash scripts/seo.sh keywords "cloud computing SaaS"

# Generate schema markup
bash scripts/seo.sh schema index.html --type Article

# Generate sitemap
bash scripts/seo.sh sitemap ./public --base https://example.com
```

Get a free API key at [evolink.ai/signup](https://evolink.ai/signup)

## Links

- [ClawHub](https://clawhub.ai/evolinkai/ai-seo-assistant)
- [EvoLink API Docs](https://docs.evolink.ai)
- [Discord](https://discord.com/invite/5mGHfA24kn)

## License

MIT
