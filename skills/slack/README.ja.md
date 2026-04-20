# Slack Assistant — Claude Code 用 OpenClaw スキル

スマート AI 機能搭載の Slack API 統合 — メッセージ送信、チャンネル閲覧、会話検索、ワークスペース管理を Claude による要約・下書き機能付きで実現。[evolink.ai](https://evolink.ai?utm_source=github&utm_medium=skill&utm_campaign=slack) 提供

[これは何？](#これは何) | [インストール](#インストール) | [セットアップ](#セットアップガイド) | [使い方](#使い方) | [EvoLink](https://evolink.ai?utm_source=github&utm_medium=skill&utm_campaign=slack)

**Language / 語言:**
[English](README.md) | [簡体中文](README.zh-CN.md) | [日本語](README.ja.md) | [한국어](README.ko.md) | [Español](README.es.md) | [Français](README.fr.md) | [Deutsch](README.de.md) | [Türkçe](README.tr.md) | [Русский](README.ru.md)

## これは何？

Claude Code を Slack ワークスペースに接続する [OpenClaw](https://clawhub.ai) スキルです。Claude に話しかけるだけ：

- 「#general にメッセージを送って」
- 「#engineering で何が起きてる？」
- 「#product の最新50件のメッセージを要約して」
- 「そのスレッドへの返信を下書きして」

## インストール

### 方法1：ClawHub（推奨）
```bash
npx clawhub install slack-assistant
```

### 方法2：npm
```bash
npx evolinkai-slack-assistant
```

### 方法3：手動
```bash
git clone https://github.com/EvoLinkAI/slack-skill-for-openclaw.git
cp -r slack-skill-for-openclaw /path/to/your/skills/slack-assistant/
```

## セットアップガイド

### 1. Slack アプリを作成

1. [api.slack.com/apps](https://api.slack.com/apps) にアクセス
2. **Create New App** > **From scratch** をクリック
3. アプリ名を入力しワークスペースを選択
4. **OAuth & Permissions** > **Bot Token Scopes** に移動
5. 以下のスコープを追加：
   - `channels:read`, `channels:write`, `channels:history`, `channels:manage`
   - `chat:write`
   - `files:read`, `files:write`
   - `groups:read`, `groups:write`, `groups:history`
   - `im:read`, `im:write`, `im:history`
   - `mpim:read`, `mpim:write`, `mpim:history`
   - `search:read`
   - `users:read`, `users:read.email`
   - `reactions:read`, `reactions:write`
6. **Install to Workspace** をクリックして認可
7. **Bot User OAuth Token**（`xoxb-` で始まる）をコピー

### 2. 認証情報を設定

```bash
mkdir -p ~/.slack-skill
echo '{"bot_token": "xoxb-your-token-here"}' > ~/.slack-skill/credentials.json
chmod 600 ~/.slack-skill/credentials.json
```

### 3.（任意）AI 機能を有効化

```bash
export EVOLINK_API_KEY="your-key-here"
```

[evolink.ai/signup](https://evolink.ai/signup?utm_source=github&utm_medium=skill&utm_campaign=slack) で無料 API キーを取得

## 使い方

### 基本操作

```bash
bash scripts/slack.sh channels
bash scripts/slack.sh list "#general" 20
bash scripts/slack.sh send "#general" "こんにちは！"
bash scripts/slack.sh search "デプロイ"
bash scripts/slack.sh read CHANNEL_ID 1234567890.123456
bash scripts/slack.sh reply CHANNEL_ID 1234567890.123456 "ありがとう！"
```

### AI 機能

```bash
bash scripts/slack.sh ai-summary "#engineering" 50
bash scripts/slack.sh ai-reply CHANNEL_ID 1234567890.123456
bash scripts/slack.sh ai-prioritize "#general" 30
```

### チャンネル管理

```bash
bash scripts/slack.sh create-channel "new-project" --private
bash scripts/slack.sh invite "#new-project" "@alice"
bash scripts/slack.sh upload "#general" ./report.pdf
```

## 設定

| 変数 | デフォルト | 説明 |
|---|---|---|
| `SLACK_SKILL_DIR` | `~/.slack-skill` | 設定ディレクトリ |
| `EVOLINK_API_KEY` | — | AI 機能用 API キー（[取得](https://evolink.ai/signup?utm_source=github&utm_medium=skill&utm_campaign=slack)）|
| `EVOLINK_MODEL` | `claude-opus-4-6` | AI モデル（[ドキュメント](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=slack)）|

## リンク

- [ClawHub](https://clawhub.ai/EvoLinkAI/slack-assistant)
- [Slack API リファレンス](https://api.slack.com/methods)
- [EvoLink API](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=slack)
- [コミュニティ](https://discord.com/invite/5mGHfA24kn)
- [サポート](mailto:support@evolink.ai)

## ライセンス

MIT
