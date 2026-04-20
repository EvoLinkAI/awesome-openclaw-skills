---
name: Email Assistant
description: AI-powered email writing, review, and compliance checking. Generate templates, optimize subject lines, audit for spam triggers, and check CAN-SPAM/GDPR/CASL compliance. Powered by evolink.ai
version: 1.0.0
homepage: https://github.com/EvoLinkAI/email-skill-for-openclaw
metadata: {"openclaw":{"homepage":"https://github.com/EvoLinkAI/email-skill-for-openclaw","requires":{"bins":["python3","curl"],"env":["EVOLINK_API_KEY"]},"primaryEnv":"EVOLINK_API_KEY"}}
---

# Email Assistant

AI-powered email writing, review, and compliance checking from your terminal. Generate professional email templates, optimize subject lines, audit for spam triggers, and verify CAN-SPAM/GDPR/CASL compliance.

Powered by [Evolink.ai](https://evolink.ai?utm_source=clawhub&utm_medium=skill&utm_campaign=email)

## When to Use

- User wants to generate an email template (welcome, password reset, newsletter, etc.)
- User asks to review an email for spam triggers or readability
- User needs subject line suggestions or A/B variants
- User wants to check email content for CAN-SPAM/GDPR/CASL compliance
- User needs to translate an email to another language
- User asks about SPF/DKIM/DMARC DNS setup

## Quick Start

### 1. Set your EvoLink API key

    export EVOLINK_API_KEY="your-key-here"

Get a free key: [evolink.ai/signup](https://evolink.ai/signup?utm_source=clawhub&utm_medium=skill&utm_campaign=email)

### 2. Generate an email template

    bash scripts/email.sh generate welcome --tone professional

### 3. Review an email

    bash scripts/email.sh review my-email.html

## Capabilities

### Local Commands (no API key needed)

| Command | Description |
|---------|-------------|
| `templates` | List all available email template types |
| `dns` | SPF/DKIM/DMARC configuration guide |

### AI Commands (require EVOLINK_API_KEY)

| Command | Description |
|---------|-------------|
| `generate <type> [--tone <tone>]` | AI generate email template |
| `review <file>` | AI review for spam triggers, readability, and best practices |
| `subject <file>` | AI generate 5 subject line variants with A/B tips |
| `compliance <file>` | AI check CAN-SPAM, GDPR, CASL compliance |
| `translate <file> --lang <language>` | AI translate email content |

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

## Examples

### Generate a welcome email

    bash scripts/email.sh generate welcome --tone friendly

### Review email for issues

    bash scripts/email.sh review campaign.html

Output:

    === Email Review ===

    Spam Score: 2/10 (Low Risk)

    Issues Found:
      [SPAM]  "FREE" in subject — common spam trigger word
      [WARN]  No plain-text alternative mentioned
      [OK]    Unsubscribe link present
      [OK]    Physical address included
      [OK]    Image-to-text ratio acceptable

    Readability: Grade 8 (Good)
    Estimated deliverability: High

### Generate subject line variants

    bash scripts/email.sh subject newsletter.html

### Check compliance

    bash scripts/email.sh compliance promo-email.html

### Translate email

    bash scripts/email.sh translate welcome.html --lang Spanish

### DNS setup guide

    bash scripts/email.sh dns

## Configuration

| Variable | Default | Required | Description |
|---|---|---|---|
| `EVOLINK_API_KEY` | — | Yes (AI commands) | Your EvoLink API key. [Get one free](https://evolink.ai/signup?utm_source=clawhub&utm_medium=skill&utm_campaign=email) |
| `EVOLINK_MODEL` | `claude-opus-4-6` | No | Model for AI analysis |

Required binaries: `python3`, `curl`

## Security

**Data Transmission**

AI commands send email content to `api.evolink.ai` for analysis by Claude. By setting `EVOLINK_API_KEY` and using these commands, you consent to this transmission. Data is not stored after the response is returned. The `templates` and `dns` commands run entirely locally and never transmit data.

**Network Access**

- `api.evolink.ai` — AI analysis (AI commands only)

**Persistence & Privilege**

Temporary files for API payloads are cleaned up automatically. No credentials or persistent data are stored.

## Links

- [GitHub](https://github.com/EvoLinkAI/email-skill-for-openclaw)
- [EvoLink API](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=clawhub&utm_medium=skill&utm_campaign=email)
- [Community](https://discord.com/invite/5mGHfA24kn)
- [Support](mailto:support@evolink.ai)
