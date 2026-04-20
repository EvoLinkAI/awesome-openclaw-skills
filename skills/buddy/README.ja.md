# 搭子.skill — 理想の相棒をAIに蒸留する

> *すべてが「搭子」になれる。*

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![EvoLink](https://img.shields.io/badge/Powered%20by-EvoLink-blue)](https://evolink.ai?utm_source=github&utm_medium=skill&utm_campaign=buddy)

相棒の素材（WeChatチャット履歴、QQメッセージ、SNSスクリーンショット、写真）を提供するか、理想の相棒を純粋に描写して、**本物のように話すAI Skill**を生成します。

[EvoLink API](https://evolink.ai?utm_source=github&utm_medium=skill&utm_campaign=buddy) 提供

**Language / 語言:**
[English](README.md) | [简体中文](README.zh-CN.md) | [日本語](README.ja.md) | [한국어](README.ko.md) | [Español](README.es.md) | [Français](README.fr.md) | [Deutsch](README.de.md) | [Türkçe](README.tr.md) | [Русский](README.ru.md)

## インストール

```bash
mkdir -p .claude/skills
git clone https://github.com/EvoLinkAI/buddy-skill-for-openclaw .claude/skills/create-buddy
export EVOLINK_API_KEY="your-key-here"
```

[evolink.ai/signup](https://evolink.ai/signup?utm_source=github&utm_medium=skill&utm_campaign=buddy) で無料APIキーを取得

## 使い方

Claude Codeで `/create-buddy` と入力。3つの質問に答え、素材をインポート（または純粋に想像）すれば完成。

### コマンド

| コマンド | 説明 |
|---------|------|
| `/create-buddy` | 新しい相棒を作成 |
| `/list-buddies` | 全相棒一覧 |
| `/{slug}` | 相棒とチャット |
| `/{slug}-vibe` | 思い出モード |
| `/update-buddy {slug}` | 記憶を追加 |
| `/delete-buddy {slug}` | 削除 |

## 特徴

- 複数データソース：WeChat、QQ、スクリーンショット、写真、純粋な想像
- 相棒タイプ：ご飯仲間、勉強仲間、ゲーム仲間、ジム仲間など
- 二層アーキテクチャ：Vibe Memory + Persona
- 進化：記憶追加、応答修正、バージョン管理
- AI分析：EvoLink API（Claudeモデル）

## リンク

- [ClawHub](https://clawhub.ai/evolinkai/buddy-skill-creator)
- [EvoLink API](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=buddy)
- [コミュニティ](https://discord.com/invite/5mGHfA24kn)

MIT License © [EvoLinkAI](https://github.com/EvoLinkAI)
