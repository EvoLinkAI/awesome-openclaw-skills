# Email Assistant — OpenClaw Skill

AI-powered email writing, review, and compliance checking. Generate professional templates, optimize subject lines, audit for spam triggers, and verify CAN-SPAM/GDPR/CASL compliance — all from your terminal.

Powered by [EvoLink.ai](https://evolink.ai)

## Install

### Via ClawHub (Recommended)

```
npx clawhub install ai-email-assistant
```

### Via npm

```
npx evolinkai-email-assistant
```

## Quick Start

```bash
# Set your API key
export EVOLINK_API_KEY="your-key-here"

# Generate a welcome email template
bash scripts/email.sh generate welcome --tone friendly

# Review an email for spam triggers
bash scripts/email.sh review campaign.html

# Generate subject line variants
bash scripts/email.sh subject newsletter.html

# Check CAN-SPAM/GDPR/CASL compliance
bash scripts/email.sh compliance promo.html

# Translate an email
bash scripts/email.sh translate welcome.html --lang Spanish

# DNS authentication guide
bash scripts/email.sh dns
```

Get a free API key at [evolink.ai/signup](https://evolink.ai/signup)

## What This Skill Does

### Local Commands (no API key needed)

| Command | Description |
|---------|-------------|
| `templates` | List all available email template types |
| `dns` | Interactive SPF/DKIM/DMARC configuration guide |

### AI Commands (require EVOLINK_API_KEY)

| Command | Description |
|---------|-------------|
| `generate <type> [--tone <tone>]` | Generate production-ready HTML email templates |
| `review <file>` | Audit for spam triggers, readability, and deliverability |
| `subject <file>` | Generate 5 subject line variants with A/B testing tips |
| `compliance <file>` | Check against CAN-SPAM, GDPR, and CASL regulations |
| `translate <file> --lang <lang>` | Translate and localize email content |

### Template Types

| Type | Description |
|------|-------------|
| `welcome` | New user onboarding email |
| `password-reset` | Password reset with secure link |
| `verification` | Email address verification / double opt-in |
| `order-confirmation` | E-commerce order receipt |
| `shipping` | Shipping notification with tracking |
| `invoice` | Payment invoice / billing receipt |
| `newsletter` | Newsletter / content digest |
| `promotion` | Promotional offer / sale announcement |
| `reengagement` | Win-back inactive users |
| `security-alert` | Account security notification |

### Tones

`professional` · `casual` · `friendly` · `urgent` · `minimal`

## Structure

```
email-skill-for-openclaw/
├── SKILL.md                    # Skill definition for ClawHub
├── _meta.json                  # Metadata
├── scripts/
│   └── email.sh                # Core script — all commands
└── npm/
    ├── package.json            # npm package config
    ├── bin/install.js          # npm installer
    └── skill-files/            # Files copied on install
```

## Configuration

| Variable | Default | Required | Description |
|---|---|---|---|
| `EVOLINK_API_KEY` | — | Yes (AI commands) | EvoLink API key. [Get one free](https://evolink.ai/signup) |
| `EVOLINK_MODEL` | `claude-opus-4-6` | No | AI model for analysis |

Required: `python3`, `curl`

## Security & Data

- AI commands send email content to `api.evolink.ai` for analysis. Data is not stored after response.
- `templates` and `dns` commands run entirely locally — no network access.
- Temporary files are cleaned up automatically. No credentials stored.

## Links

- [ClawHub](https://clawhub.ai/evolinkai/ai-email-assistant)
- [EvoLink API Docs](https://docs.evolink.ai)
- [Discord](https://discord.com/invite/5mGHfA24kn)

## License

MIT
