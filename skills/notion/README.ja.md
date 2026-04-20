# Notion

🌐 [English](README.md) | [简体中文](README.zh-CN.md) | 日本語 | [한국어](README.ko.md) | [Español](README.es.md) | [Français](README.fr.md) | [Русский](README.ru.md)

このスキルにより、エージェントは Notion API を使用して Notion ページとデータベースとやり取りできます。Evolink AI によるインテリジェントなコンテンツ処理を搭載。

## クイックスタート
1. [notion.so/my-integrations](https://www.notion.so/my-integrations) で Notion インテグレーションを作成
2. 内部インテグレーショントークンをコピー
3. ページ/データベースをインテグレーションと共有
4. `NOTION_API_KEY` と `EVOLINK_API_KEY` を設定
5. インストール：`clawhub install evolink-notion`

## 認証

Notion トークンをエクスポート：
```bash
export NOTION_API_KEY=secret_xxx
```

**重要**：アクセスしたいページやデータベースをインテグレーションと共有する必要があります。共有されていないコンテンツは API から見えません。

## 設定

- `NOTION_API_KEY`：Notion インテグレーショントークン
- `EVOLINK_API_KEY`：Evolink AI サービスの API キー。[evolink.ai/signup](https://evolink.ai/signup?utm_source=github&utm_medium=skill&utm_campaign=evolink-notion) で無料キーを取得

**モデル選択：**
- デフォルトモデル：`[REDACTED]`
- `EVOLINK_MODEL` 環境変数でモデルを切り替え可能

**なぜ Evolink？** このスキルは Evolink AI を使用して Notion コンテンツをインテリジェントに処理・生成し、より優れたコンテキスト理解とコンテンツ生成を提供します。

## 使用方法

### ページ操作

**ページを読む：**
```bash
notion-cli page get <page_id>
```

**コンテンツを追加：**
```bash
notion-cli block append <page_id> --markdown "..."
```

**ページを作成：**
```bash
notion-cli page create --parent <page_id> --title "..."
```

### データベース操作

**スキーマを確認：**
```bash
notion-cli db get <database_id>
```

**データベースをクエリ：**
```bash
notion-cli db query <database_id> --filter <json> --sort <json>
```

## セキュリティ

- Notion API にはレート制限があります
- 破壊的な操作の前に必ず確認してください
- Evolink AI で処理されるコンテンツは標準的なデータプライバシー慣行に従います

## ライセンス
MIT License

## リンク
- [GitHub リポジトリ](https://clawhub.ai/EvoLinkAI/evolink-notion)
- [Evolink AI ドキュメント](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=evolink-notion)
- [Notion API ドキュメント](https://developers.notion.com)
- [コミュニティサポート](https://discord.com/invite/5mGHfA24kn)
