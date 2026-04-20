---
name: SEO Assistant
description: AI-powered SEO analysis and optimization. Audit HTML pages, rewrite meta tags, research keywords, generate schema markup, and create sitemaps. Powered by evolink.ai
version: 1.0.0
homepage: https://github.com/EvoLinkAI/seo-skill-for-openclaw
metadata: {"openclaw":{"homepage":"https://github.com/EvoLinkAI/seo-skill-for-openclaw","requires":{"bins":["python3","curl"],"env":["EVOLINK_API_KEY"]},"primaryEnv":"EVOLINK_API_KEY"}}
---

# SEO Assistant

AI-powered SEO analysis and optimization from your terminal. Audit HTML pages locally with scoring, fetch and analyze live URLs, rewrite meta tags, research keywords, generate JSON-LD schema markup, and create XML sitemaps.

Powered by [Evolink.ai](https://evolink.ai?utm_source=clawhub&utm_medium=skill&utm_campaign=seo)

## When to Use

- User wants to audit HTML files for SEO issues
- User asks "how's my SEO?" or "check my page"
- User needs optimized title/meta/description tags
- User wants keyword research for a topic
- User needs schema markup (Article, Product, FAQ, etc.)
- User wants to generate a sitemap

## Quick Start

### 1. Set your EvoLink API key

    export EVOLINK_API_KEY="your-key-here"

Get a free key: [evolink.ai/signup](https://evolink.ai/signup?utm_source=clawhub&utm_medium=skill&utm_campaign=seo)

### 2. Audit your HTML

    bash scripts/seo.sh audit index.html

### 3. AI-powered analysis

    bash scripts/seo.sh check https://example.com

## Capabilities

### Local Commands (no API key needed)

| Command | Description |
|---------|-------------|
| `audit <file\|dir>` | Local HTML SEO audit with 0-100 scoring |
| `sitemap <dir> --base <url>` | Generate XML sitemap from HTML files |

### AI Commands (require EVOLINK_API_KEY)

| Command | Description |
|---------|-------------|
| `check <url>` | Fetch live URL + AI deep SEO analysis |
| `rewrite <file>` | AI rewrite title, meta, description, OG, Twitter tags |
| `keywords <topic>` | AI keyword research with content strategy |
| `schema <file> --type <type>` | AI generate JSON-LD schema markup |

### Schema Types

| Type | Key Properties |
|------|---------------|
| `Article` | headline, author, datePublished, image, publisher |
| `Product` | name, description, price, availability, review |
| `FAQ` | mainEntity with Question/Answer pairs |
| `HowTo` | name, step, totalTime, tool, supply |
| `LocalBusiness` | name, address, telephone, openingHours |
| `Event` | name, startDate, location, performer |

## Examples

### Local audit with scoring

    bash scripts/seo.sh audit ./public

Output:

    === ./public/index.html ===
      [ISSUE] Missing meta description
      [ISSUE] 2/5 images missing alt text
      [WARN]  Title too short (12 chars, aim for 50-60)
      [WARN]  Missing Open Graph tags
      [OK]    H1 OK: Welcome to Our Site
      [OK]    HTML lang attribute present

    SEO Score: 67/100  (2 issues, 2 warnings, 1 files)

### AI check a live URL

    bash scripts/seo.sh check https://example.com

### AI rewrite meta tags

    bash scripts/seo.sh rewrite index.html

Output:

    **Title Tag**
    Before: <title>Home</title>
    After:  <title>Cloud Computing Solutions for Small Business | YourBrand</title>

    **Meta Description**
    Before: (missing)
    After:  <meta name="description" content="Scalable cloud solutions...">

### AI keyword research

    bash scripts/seo.sh keywords "cloud computing SaaS"

### Generate schema markup

    bash scripts/seo.sh schema blog-post.html --type Article

### Generate sitemap

    bash scripts/seo.sh sitemap ./public --base https://example.com

## Configuration

| Variable | Default | Required | Description |
|---|---|---|---|
| `EVOLINK_API_KEY` | — | Yes (AI commands) | Your EvoLink API key. [Get one free](https://evolink.ai/signup?utm_source=clawhub&utm_medium=skill&utm_campaign=seo) |
| `EVOLINK_MODEL` | `claude-opus-4-6` | No | Model for AI analysis |

Required binaries: `python3`, `curl`

## Security

**Data Transmission**

AI commands send HTML content or topic descriptions to `api.evolink.ai` for analysis by Claude. By setting `EVOLINK_API_KEY` and using these commands, you consent to this transmission. Data is not stored after the response is returned. The `audit` and `sitemap` commands run entirely locally and never transmit data.

**Network Access**

- Target URL (via curl) — `check` command fetches the page
- `api.evolink.ai` — AI analysis (AI commands only)

**Persistence & Privilege**

The `sitemap` command writes a `sitemap.xml` file to the specified directory. Temporary files for API payloads are cleaned up automatically. No credentials or persistent data are stored.

## Links

- [GitHub](https://github.com/EvoLinkAI/seo-skill-for-openclaw)
- [EvoLink API](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=clawhub&utm_medium=skill&utm_campaign=seo)
- [Community](https://discord.com/invite/5mGHfA24kn)
- [Support](mailto:support@evolink.ai)
