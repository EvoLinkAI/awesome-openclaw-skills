# YouTube Assistant — AI搭載のYouTube動画文字起こし＆分析

> *もっと賢く、もっと短く。*

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![EvoLink](https://img.shields.io/badge/Powered%20by-EvoLink-blue)](https://evolink.ai?utm_source=github&utm_medium=skill&utm_campaign=youtube)

YouTube動画の字幕、メタデータ、チャンネル情報を取得。AIによるコンテンツ要約、キーポイント抽出、複数動画比較分析、動画Q&A機能を搭載。

[EvoLink API](https://evolink.ai?utm_source=github&utm_medium=skill&utm_campaign=youtube)

**Language / 言語:**
[English](README.md) | [简体中文](README.zh-CN.md) | [日本語](README.ja.md) | [한국어](README.ko.md) | [Español](README.es.md) | [Français](README.fr.md) | [Deutsch](README.de.md) | [Türkçe](README.tr.md) | [Русский](README.ru.md)

## インストール

```bash
# yt-dlpのインストール（必須）
pip install yt-dlp

# Skillのインストール
mkdir -p .claude/skills
git clone https://github.com/EvoLinkAI/youtube-skill-for-openclaw .claude/skills/youtube-assistant
export EVOLINK_API_KEY="your-key-here"
```

無料APIキー: [evolink.ai/signup](https://evolink.ai/signup?utm_source=github&utm_medium=skill&utm_campaign=youtube)

## 使い方

```bash
# 動画の字幕を取得
bash scripts/youtube.sh transcript "https://www.youtube.com/watch?v=VIDEO_ID"

# 動画のメタデータを取得
bash scripts/youtube.sh info "https://www.youtube.com/watch?v=VIDEO_ID"

# AI動画要約
bash scripts/youtube.sh ai-summary "https://www.youtube.com/watch?v=VIDEO_ID"
```

### コマンド

| コマンド | 説明 |
|----------|------|
| `transcript <URL> [--lang]` | クリーンな動画字幕を取得 |
| `info <URL>` | 動画メタデータを取得 |
| `channel <URL> [limit]` | チャンネルの最新動画一覧 |
| `search <query> [limit]` | YouTube検索 |
| `ai-summary <URL>` | AI動画要約 |
| `ai-takeaways <URL>` | キーポイント抽出 |
| `ai-compare <URL1> <URL2>` | 複数動画の比較分析 |
| `ai-ask <URL> <question>` | 動画内容について質問 |

## 特徴

- あらゆるYouTube動画から字幕を抽出（手動＋自動生成）
- 動画メタデータ：タイトル、再生時間、視聴回数、いいね、説明、タグ
- チャンネル閲覧とYouTube検索
- AI搭載：要約、ポイント抽出、動画比較、Q&A
- 多言語字幕対応
- EvoLink API統合（Claudeモデル）

## リンク

- [ClawHub](https://clawhub.ai/evolinkai/youtube-assistant)
- [EvoLink API](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=youtube)
- [コミュニティ](https://discord.com/invite/5mGHfA24kn)

MIT License © [EvoLinkAI](https://github.com/EvoLinkAI)
