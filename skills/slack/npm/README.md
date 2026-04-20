# Slack Assistant — OpenClaw Skill Installer

Slack API integration with smart AI features — send messages, read channels, search conversations, and manage workspaces with Claude-powered summarization and drafting. Powered by [evolink.ai](https://evolink.ai?utm_source=npm&utm_medium=skill&utm_campaign=slack)

## Install

```bash
npx evolinkai-slack-assistant
```

### Other methods

```bash
npx clawhub install slack-assistant
openclaw skills add https://github.com/EvoLinkAI/slack-skill-for-openclaw
```

## Setup

1. Create a Slack app at [api.slack.com/apps](https://api.slack.com/apps)
2. Add Bot Token Scopes (channels:read, chat:write, etc.)
3. Install to Workspace and copy the Bot Token
4. Save credentials:

```bash
mkdir -p ~/.slack-skill
echo '{"bot_token": "xoxb-your-token"}' > ~/.slack-skill/credentials.json
```

## Usage

```bash
bash scripts/slack.sh channels
bash scripts/slack.sh send "#general" "Hello!"
bash scripts/slack.sh ai-summary "#engineering" 50
```

## Links

- [ClawHub](https://clawhub.ai/EvoLinkAI/slack-assistant)
- [GitHub](https://github.com/EvoLinkAI/slack-skill-for-openclaw)

## License

MIT
