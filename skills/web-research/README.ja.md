🌐 [English](README.md) | 日本語 | [한국어](README.ko.md) | [简体中文](README.zh-CN.md) | [Français](README.fr.md) | [Deutsch](README.de.md) | [Русский](README.ru.md) | [हिन्दी](README.hi.md) | [Türkçe](README.tr.md)

# Web Search Assistant

**EvoLink APIを使用したAI搭載ウェブ検索**

Powered by [Evolink.ai](https://evolink.ai?utm_source=github&utm_medium=skill&utm_campaign=web-search)

ウェブを検索し、タイトル、URL、説明を含むクリーンでフォーマットされた結果を取得します。

## 🚀 クイックスタート

```bash
bash scripts/search.sh "AI coding assistants 2026"
bash scripts/search.sh "quantum computing breakthroughs" 20
```

## 🔑 設定

EvoLink APIキーを設定します：

```bash
export EVOLINK_API_KEY="your-evolink-api-key-here"
```

👉 [無料APIキーを取得](https://evolink.ai/signup?utm_source=github&utm_medium=skill&utm_campaign=web-search)

## 📖 使い方

### 基本検索

```bash
bash scripts/search.sh "検索クエリ"
```

上位10件の結果を返します。

### 結果数の制限

```bash
bash scripts/search.sh "検索クエリ" 20
```

最大結果数を指定します。

## 🔒 セキュリティ

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

## 📄 ライセンス

MIT

## 🔗 リンク

- [ClawHub](https://clawhub.ai/evolinkai/web-research)
- [APIリファレンス](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=web-search)
- [コミュニティ](https://discord.com/invite/5mGHfA24kn)
- [サポート](mailto:support@evolink.ai)
