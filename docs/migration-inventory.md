# Migration Inventory

This file tracks how standalone skill repositories will map into the consolidated OpenClaw skills repository.

| Source Repository | Target Folder | Key Files and Assets | Notes |
|---|---|---|---|
| `youtube-skill-for-openclaw` | `skills/youtube/` | `SKILL.md`, `README*.md`, `scripts/` | Multi-language README set present |
| `web-research-skill-for-openclaw` | `skills/web-research/` | `SKILL.md`, `SKILL.*.md`, `README*.md`, `scripts/` | Has translated `SKILL` docs too |
| `video-generation-skill-for-openclaw` | `skills/video-generation/` | `SKILL.md`, `README*.md`, `_meta.json`, `scripts/`, `references/` | Good candidate for featured skill page |
| `translate-skill-for-openclaw` | `skills/translate/` | `SKILL.md`, `README*.md`, `_meta.json` | Light structure |
| `text-humanizer-skill-for-openclaw` | `skills/text-humanizer/` | `SKILL.md`, `README*.md`, `scripts/` | Uses underscore-style translated README names |
| `subtitle-skill-for-openclaw` | `skills/subtitle/` | `SKILL.md`, `README.md`, `_meta.json`, `scripts/`, `npm/` | Needs npm folder preserved |
| `slack-skill-for-openclaw` | `skills/slack/` | `SKILL.md`, `README*.md`, `scripts/` | Multi-language README set present |
| `seo-skill-for-openclaw` | `skills/seo/` | `SKILL.md`, `README.md`, `_meta.json`, `scripts/`, `npm/` | Includes npm assets |
| `seedance2-video-gen-skill-for-openclaw` | `skills/seedance2-video-gen/` | `SKILL.md`, `README*.md`, `package.json`, `assets/`, `scripts/`, `references/` | Current parent repo, needs internal relocation later |
| `regex-skill-for-openclaw` | `skills/regex/` | `SKILL.md`, `README.md`, `_meta.json`, `scripts/`, `npm/` | Includes npm assets |
| `playwright-cli-skill-for-claude-code` | `skills/playwright-cli/` | `SKILL.md`, `README.md`, `package.json`, `scripts/`, `.github/`, `.claude/` | Claude Code oriented, preserve metadata files selectively |
| `pdf-skill-for-openclaw` | `skills/pdf/` | `SKILL.md`, `README*.md`, `_meta.json` | Multi-language README set present |
| `notion-skill-for-openclaw` | `skills/notion/` | `SKILL.md`, `README*.md`, `_meta.json`, `scripts/` | Multi-language README set present |
| `Nano-banana-2-skill-for-openclaw` | `skills/nano-banana-2/` | `SKILL.md`, `README*.md`, `_meta.json`, `scripts/`, `references/` | Repo name uses capitalized prefix |
| `music-generation-skill-for-openclaw` | `skills/music-generation/` | `SKILL.md`, `README*.md`, `_meta.json`, `scripts/`, `references/` | Multi-language README set present |
| `multi-summarize-skill-for-openclaw` | `skills/multi-summarize/` | `SKILL.md`, `README*.md`, `scripts/`, `references/` | Multi-language README set present |
| `image-generation-skill-for-openclaw` | `skills/image-generation/` | `SKILL.md`, `README*.md`, `_meta.json`, `scripts/`, `references/` | Good SEO target |
| `google-sheets-skill-for-openclaw` | `skills/google-sheets/` | `SKILL.md`, `README.md`, `_meta.json`, `scripts/`, `npm/` | Includes npm assets |
| `gmail-skill-for-openclaw` | `skills/gmail/` | `SKILL.md`, `README*.md`, `scripts/`, `references/` | Good SEO target |
| `git-skill-for-openclaw` | `skills/git/` | `SKILL.md`, `README.md`, `_meta.json`, `scripts/`, `npm/` | Includes npm assets |
| `email-skill-for-openclaw` | `skills/email/` | `SKILL.md`, `README.md`, `_meta.json`, `scripts/`, `npm/` | Includes npm assets |
| `diagram-skill-for-openclaw` | `skills/diagram/` | `SKILL.md`, `README.md`, `_meta.json`, `scripts/`, `npm/` | Includes npm assets |
| `debug-skill-for-openclaw` | `skills/debug/` | `SKILL.md`, `README.md`, `_meta.json`, `scripts/`, `npm/` | Includes npm assets |
| `data-analysis-skill-for-openclaw` | `skills/data-analysis/` | `SKILL.md`, `README*.md`, `_meta.json`, `scripts/` | Multi-language README set present |
| `content-rewriter-skill-for-openclaw` | `skills/content-rewriter/` | `SKILL.md`, `README.md`, `_meta.json`, `scripts/`, `npm/` | Includes npm assets |
| `code-assistant-skill-for-openclaw` | `skills/code-assistant/` | `SKILL.md`, `README.md`, `package.json`, `bin/`, `examples/` | Needs package-aware migration |
| `buddy-skill-for-openclaw` | `skills/buddy/` | `SKILL.md`, `README*.md` | Multi-language README set present |
| `audio-analyze-skill-for-openclaw` | `skills/audio-analyze/` | `SKILL.md`, `README*.md`, `_meta.json`, `scripts/` | Has `README.base.md` |

## Suggested First Migration Batch

1. `video-generation-skill-for-openclaw`
2. `youtube-skill-for-openclaw`
3. `gmail-skill-for-openclaw`
4. `pdf-skill-for-openclaw`
5. `image-generation-skill-for-openclaw`

These are strong candidates for early migration because they are easy to explain, search-friendly, and useful as flagship categories in the root README.
