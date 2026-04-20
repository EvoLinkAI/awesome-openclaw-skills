# Git Assistant — OpenClaw Skill

AI-powered git workflow helper. Generate commit messages from staged changes, review commit quality, create changelogs, write release notes, and generate PR descriptions — all from your terminal.

Powered by [EvoLink.ai](https://evolink.ai)

## Install

### Via ClawHub (Recommended)

```
npx clawhub install ai-git-assistant
```

### Via npm

```
npx evolinkai-git-assistant
```

## Quick Start

```bash
# Set your API key
export EVOLINK_API_KEY="your-key-here"

# Generate commit message from staged changes
git add .
bash scripts/git-assist.sh commit

# Review a commit message
bash scripts/git-assist.sh review "fixed stuff"

# Generate changelog since a tag
bash scripts/git-assist.sh changelog --from v1.0.0

# Generate release notes
bash scripts/git-assist.sh release --from v1.0.0

# Generate PR description
bash scripts/git-assist.sh pr

# Conventional Commits reference
bash scripts/git-assist.sh conventions
```

Get a free API key at [evolink.ai/signup](https://evolink.ai/signup)

## What This Skill Does

### Local Commands (no API key needed)

| Command | Description |
|---------|-------------|
| `conventions` | Conventional Commits quick reference with types, scopes, and examples |

### AI Commands (require EVOLINK_API_KEY)

| Command | Description |
|---------|-------------|
| `commit` | Analyze `git diff --cached` and generate a Conventional Commits message |
| `review <message>` | Score commit message 1-10, check conventions, suggest rewrite |
| `changelog [--from <tag>]` | Generate grouped changelog from git log (Features, Fixes, etc.) |
| `release [--from <tag>] [--to <tag>]` | Generate professional release notes between tags |
| `pr` | Generate PR description from current branch diff vs base |

## How It Works

```
git add .                          ← you stage changes
bash git-assist.sh commit          ← AI reads the diff
                                   ↓
feat(auth): add JWT refresh token rotation

- Implement automatic token rotation on refresh
- Add refresh token family tracking
- Update middleware for expired access tokens

BREAKING CHANGE: refresh endpoint returns both tokens
                                   ↑
                                   copy & paste into git commit
```

The skill only reads git state — it never runs `git commit`, `git push`, or any destructive operation.

## Structure

```
git-skill-for-openclaw/
├── SKILL.md                    # Skill definition for ClawHub
├── _meta.json                  # Metadata
├── scripts/
│   └── git-assist.sh           # Core script — all commands
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

Required: `python3`, `curl`, `git`

## Security & Data

- AI commands send git diff output or commit history to `api.evolink.ai` for analysis. Data is not stored after response.
- `conventions` runs entirely locally — no network access.
- This skill is read-only: it never executes `git commit`, `git push`, or modifies your repository.
- Temporary files are cleaned up automatically. No credentials stored.

## Links

- [ClawHub](https://clawhub.ai/evolinkai/ai-git-assistant)
- [EvoLink API Docs](https://docs.evolink.ai)
- [Discord](https://discord.com/invite/5mGHfA24kn)

## License

MIT
