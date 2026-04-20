---
name: web-research
description: EvoLink APIを使用したウェブ検索。タイトル、URL、説明を含むクリーンでフォーマットされた結果を返します。Powered by evolink.ai
metadata: {"clawdbot":{"emoji":"🔍","requires":{"bins":["bash","curl","jq"],"env":["EVOLINK_API_KEY"]},"primaryEnv":"EVOLINK_API_KEY"}}
---

# Web Search Assistant

EvoLink APIを使用したウェブ検索。タイトル、URL、説明を含むクリーンでフォーマットされた結果を返します。

Powered by [Evolink.ai](https://evolink.ai?utm_source=clawhub&utm_medium=skill&utm_campaign=web-search)

## 使用タイミング

ユーザーが以下をリクエストした場合にこのスキルを使用します：
- 情報やリソースのウェブ検索
- 最新または最近の情報をオンラインで検索
- 現在のウェブデータを必要とする調査
- ウェブソースを使用したファクトチェックまたは検証
- トピックに関するURLとリソースの収集

## 検索

```bash
{baseDir}/scripts/search.sh "クエリ"
{baseDir}/scripts/search.sh "クエリ" 20
```

## オプション

- `<query>`: 検索クエリ
- `<max_results>`: 結果数（デフォルト：10）

## 設定

EvoLink APIキーを設定します：

```bash
export EVOLINK_API_KEY="your-evolink-api-key-here"
```

👉 [無料APIキーを取得](https://evolink.ai/signup?utm_source=clawhub&utm_medium=skill&utm_campaign=web-search)

## 例

```bash
bash scripts/search.sh "Claude Opus 4 features"
```

出力：
```
🔍 検索中: Claude Opus 4 features

📄 Claude Opus 4: New Features and Capabilities
🔗 https://example.com/opus-4
📝 Comprehensive guide to Claude Opus 4's new features...

📄 What's New in Claude Opus 4
🔗 https://example.com/whats-new
📝 Latest updates and improvements in Claude Opus 4...
```

## セキュリティ

**認証情報とネットワーク**

EvoLink APIを呼び出すには`EVOLINK_API_KEY`が必要です。検索クエリは処理のために`api.evolink.ai`に送信されます。EvoLinkは内部でウェブ検索を処理し、フォーマットされた結果を返します。

**ファイルアクセス**

このスキルはファイルの読み書きを行いません。

**ネットワークアクセス**

このスキルは以下にネットワークリクエストを行います：
- **EvoLink API** (`api.evolink.ai`) - ウェブ検索を実行するため

すべてのネットワーク呼び出しはcurlを介して実行され、スクリプトのソースコードで監査できます。

**永続性と権限**

このスキルは他のスキルやシステム設定を変更しません。昇格された権限や永続的な権限は要求されません。

## リンク

- [ClawHub](https://clawhub.ai/evolinkai/web-research)
- [APIリファレンス](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=clawhub&utm_medium=skill&utm_campaign=web-search)
- [コミュニティ](https://discord.com/invite/5mGHfA24kn)
- [サポート](mailto:support@evolink.ai)
