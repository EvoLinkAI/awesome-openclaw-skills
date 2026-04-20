---
name: Git Assistant
description: AI-powered git commit messages, changelogs, release notes, PR descriptions, and commit review. Analyzes staged changes and git history to generate professional, Conventional Commits-compliant output. Powered by evolink.ai
version: 1.0.0
homepage: https://github.com/EvoLinkAI/git-skill-for-openclaw
metadata: {"openclaw":{"homepage":"https://github.com/EvoLinkAI/git-skill-for-openclaw","requires":{"bins":["python3","curl","git"],"env":["EVOLINK_API_KEY"]},"primaryEnv":"EVOLINK_API_KEY"}}
---

# Git Assistant

AI-powered git workflow assistant. Generate commit messages from staged changes, review commit quality, create changelogs from git history, generate release notes between tags, and write PR descriptions from branch diffs.

Powered by [Evolink.ai](https://evolink.ai?utm_source=clawhub&utm_medium=skill&utm_campaign=git)

## When to Use

- User has staged changes and wants a commit message
- User asks to review or improve a commit message
- User needs a changelog from recent commits
- User wants release notes between two tags
- User needs a PR description for the current branch
- User asks about Conventional Commits format

## Quick Start

### 1. Set your EvoLink API key

    export EVOLINK_API_KEY="your-key-here"

Get a free key: [evolink.ai/signup](https://evolink.ai/signup?utm_source=clawhub&utm_medium=skill&utm_campaign=git)

### 2. Generate a commit message

    git add .
    bash scripts/git-assist.sh commit

### 3. Generate a changelog

    bash scripts/git-assist.sh changelog --from v1.0.0

## Capabilities

### Local Commands (no API key needed)

| Command | Description |
|---------|-------------|
| `conventions` | Conventional Commits quick reference |

### AI Commands (require EVOLINK_API_KEY)

| Command | Description |
|---------|-------------|
| `commit` | AI generate commit message from staged changes |
| `review <message>` | AI review commit message for quality and conventions |
| `changelog [--from <tag>]` | AI generate changelog from git log |
| `release [--from <tag>] [--to <tag>]` | AI generate release notes between tags |
| `pr` | AI generate PR description from branch diff |

## Examples

### Generate commit message from staged changes

    git add src/auth.ts src/middleware.ts
    bash scripts/git-assist.sh commit

Output:

    feat(auth): add JWT refresh token rotation

    - Implement automatic token rotation on refresh
    - Add refresh token family tracking to detect reuse
    - Update middleware to handle expired access tokens gracefully

    BREAKING CHANGE: refresh endpoint now returns both access and refresh tokens

### Review a commit message

    bash scripts/git-assist.sh review "fixed stuff"

Output:

    Commit Review: 3/10

    Issues:
      [FAIL] No type prefix (should be fix:, feat:, etc.)
      [FAIL] Vague description — what was fixed?
      [WARN] All lowercase is fine, but be consistent
      [FAIL] No scope — which module was affected?

    Suggested rewrite:
      fix(auth): resolve token expiration race condition

### Generate changelog

    bash scripts/git-assist.sh changelog --from v1.2.0

### Generate release notes

    bash scripts/git-assist.sh release --from v1.0.0 --to v2.0.0

### Generate PR description

    bash scripts/git-assist.sh pr

## Configuration

| Variable | Default | Required | Description |
|---|---|---|---|
| `EVOLINK_API_KEY` | — | Yes (AI commands) | Your EvoLink API key. [Get one free](https://evolink.ai/signup?utm_source=clawhub&utm_medium=skill&utm_campaign=git) |
| `EVOLINK_MODEL` | `claude-opus-4-6` | No | Model for AI analysis |

Required binaries: `python3`, `curl`, `git`

## Security

**Data Transmission**

AI commands send git diff output or commit history to `api.evolink.ai` for analysis by Claude. By setting `EVOLINK_API_KEY` and using these commands, you consent to this transmission. Data is not stored after the response is returned. The `conventions` command runs entirely locally.

**Network Access**

- `api.evolink.ai` — AI analysis (AI commands only)

**Persistence & Privilege**

No files are written. No credentials stored. Temporary files for API payloads are cleaned up automatically. This skill never runs `git commit`, `git push`, or any destructive git operations — it only reads.

## Links

- [GitHub](https://github.com/EvoLinkAI/git-skill-for-openclaw)
- [EvoLink API](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=clawhub&utm_medium=skill&utm_campaign=git)
- [Community](https://discord.com/invite/5mGHfA24kn)
- [Support](mailto:support@evolink.ai)
