# Gmail Assistant — OpenClaw AI メールスキル

Gmail API 統合、AI によるメール要約、スマートな返信下書き、受信トレイの優先度分析機能を搭載。[evolink.ai](https://evolink.ai?utm_source=github&utm_medium=skill&utm_campaign=gmail) 提供

[概要](#概要) | [インストール](#インストール) | [セットアップ](#セットアップガイド) | [使い方](#使い方) | [EvoLink](https://evolink.ai?utm_source=github&utm_medium=skill&utm_campaign=gmail)

**Language / 言語:**
[English](README.md) | [简体中文](README.zh-CN.md) | [日本語](README.ja.md) | [한국어](README.ko.md) | [Español](README.es.md) | [Français](README.fr.md) | [Deutsch](README.de.md) | [Türkçe](README.tr.md) | [Русский](README.ru.md)

## 概要

Gmail Assistant は、Gmail アカウントを AI エージェントに接続する OpenClaw スキルです。Gmail API へのフルアクセス（閲覧、送信、検索、ラベル管理、アーカイブ）に加え、EvoLink 経由の Claude を使用した AI 機能（受信トレイの要約、スマート返信下書き、メール優先度分析）を提供します。

**コア Gmail 操作は API キー不要で動作します。** AI 機能（要約、下書き、優先度分析）にはオプションの EvoLink API キーが必要です。

[無料の EvoLink API キーを取得](https://evolink.ai/signup?utm_source=github&utm_medium=skill&utm_campaign=gmail)

## インストール

### クイックインストール

```bash
openclaw skills add https://github.com/EvoLinkAI/gmail-skill-for-openclaw
```

### ClawHub 経由

```bash
npx clawhub install evolinkai/gmail
```

### 手動インストール

```bash
git clone https://github.com/EvoLinkAI/gmail-skill-for-openclaw.git
cd gmail-skill-for-openclaw
```

## セットアップガイド

### ステップ 1: Google OAuth 認証情報を作成

1. [Google Cloud Console](https://console.cloud.google.com/) にアクセス
2. 新しいプロジェクトを作成（または既存のプロジェクトを選択）
3. **Gmail API** を有効化: API とサービス > ライブラリ > "Gmail API" を検索 > 有効にする
4. OAuth 同意画面を設定: API とサービス > OAuth 同意画面 > 外部 > 必須項目を入力
5. OAuth 認証情報を作成: API とサービス > 認証情報 > 認証情報を作成 > OAuth クライアント ID > **デスクトップアプリ**
6. `credentials.json` ファイルをダウンロード

### ステップ 2: 設定

```bash
mkdir -p ~/.gmail-skill
cp credentials.json ~/.gmail-skill/credentials.json
bash scripts/gmail-auth.sh setup
```

### ステップ 3: 認可

```bash
bash scripts/gmail-auth.sh login
```

ブラウザで Google OAuth 同意画面が開きます。トークンはローカルの `~/.gmail-skill/token.json` に保存されます。

### ステップ 4: EvoLink API キーの設定（オプション — AI 機能用）

```bash
export EVOLINK_API_KEY="your-key-here"
```

[API キーを取得](https://evolink.ai/signup?utm_source=github&utm_medium=skill&utm_campaign=gmail)

## 使い方

### コアコマンド

```bash
# 最新のメールを一覧表示
bash scripts/gmail.sh list

# フィルター付きで一覧表示
bash scripts/gmail.sh list --query "is:unread" --max 20

# 特定のメールを読む
bash scripts/gmail.sh read MESSAGE_ID

# メールを送信
bash scripts/gmail.sh send "to@example.com" "会議の件" "こんにちは、午後3時に打ち合わせできますか？"

# メールに返信
bash scripts/gmail.sh reply MESSAGE_ID "ありがとうございます、参加します。"

# メールを検索
bash scripts/gmail.sh search "from:boss@company.com has:attachment"

# ラベル一覧
bash scripts/gmail.sh labels

# スター / アーカイブ / ゴミ箱
bash scripts/gmail.sh star MESSAGE_ID
bash scripts/gmail.sh archive MESSAGE_ID
bash scripts/gmail.sh trash MESSAGE_ID

# アカウント情報
bash scripts/gmail.sh profile
```

### AI コマンド（EVOLINK_API_KEY が必要）

```bash
# 未読メールを要約
bash scripts/gmail.sh ai-summary

# カスタムクエリで要約
bash scripts/gmail.sh ai-summary --query "from:team@company.com after:2026/04/01" --max 15

# AI で返信を下書き
bash scripts/gmail.sh ai-reply MESSAGE_ID "丁寧にお断りし、来週を提案してください"

# 受信トレイを優先度順に分析
bash scripts/gmail.sh ai-prioritize --max 30
```

### 出力例

```
受信トレイ要約（未読メール 5 通）：

1. [緊急] プロジェクト締切変更 — 送信者: manager@company.com
   Q2 製品リリースの締切が 4 月 15 日から 4 月 10 日に前倒しされました。
   必要な対応: 明日の終業までにスプリント計画を更新。

2. 請求書 #4521 — 送信者: billing@vendor.com
   月額 SaaS サブスクリプション請求書 $299。期限: 4 月 15 日。
   必要な対応: 承認または経理に転送。

3. 金曜チームランチ — 送信者: hr@company.com
   金曜 12:30 にチームビルディングランチ。出欠回答をお願いします。
   必要な対応: 参加可否を返信。

4. ニュースレター: AI Weekly — 送信者: newsletter@aiweekly.com
   低優先度。週刊 AI ニュースまとめ。
   必要な対応: なし。

5. GitHub 通知 — 送信者: notifications@github.com
   PR #247 が main にマージされました。CI 通過。
   必要な対応: なし。
```

## 設定

| 変数 | デフォルト | 必須 | 説明 |
|---|---|---|---|
| `credentials.json` | — | はい（コア） | Google OAuth クライアント認証情報。[セットアップガイド](#セットアップガイド)を参照 |
| `EVOLINK_API_KEY` | — | オプション（AI） | AI 機能用の EvoLink API キー。[無料で取得](https://evolink.ai/signup?utm_source=github&utm_medium=skill&utm_campaign=gmail) |
| `EVOLINK_MODEL` | `claude-opus-4-6` | いいえ | AI 処理モデル。[EvoLink API](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=gmail) がサポートする任意のモデルに切替可能 |
| `GMAIL_SKILL_DIR` | `~/.gmail-skill` | いいえ | 認証情報とトークンのカスタム保存先 |

必要なバイナリ：`python3`、`curl`

## トラブルシューティング

- **"Not authenticated"** — `bash scripts/gmail-auth.sh login` を実行して認可
- **"credentials.json not found"** — Google Cloud Console から OAuth 認証情報をダウンロードし `~/.gmail-skill/credentials.json` に配置
- **"Token refresh failed"** — リフレッシュトークンが期限切れの可能性。`bash scripts/gmail-auth.sh login` を再実行
- **"Set EVOLINK_API_KEY"** — AI 機能には EvoLink API キーが必要。コア Gmail 操作はキー不要
- **"Error 403: access_denied"** — Google Cloud プロジェクトで Gmail API が有効になっていること、OAuth 同意画面が設定されていることを確認

## リンク

- [ClawHub](https://clawhub.ai/EvoLinkAI/gmail-assistant)
- [API リファレンス](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=gmail)
- [コミュニティ](https://discord.com/invite/5mGHfA24kn)
- [サポート](mailto:support@evolink.ai)

## ライセンス

MIT — 詳細は [LICENSE](LICENSE) をご覧ください。
