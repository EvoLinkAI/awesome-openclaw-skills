🌐 [English](README.md) | [日本語](README.ja.md) | [한국어](README.ko.md) | [Français](README.fr.md) | [Deutsch](README.de.md) | [Русский](README.ru.md) | [हिन्दी](README.hi.md) | [Türkçe](README.tr.md) | [中文](README.zh.md)

# データ分析アシスタント

**EvoLink API を使用した AI パワードのデータ分析**

[Evolink.ai](https://evolink.ai?utm_source=github&utm_medium=skill&utm_campaign=data-analysis) によって提供されます

意思決定優先の方法論と統計的厳密さで CSV、Excel、JSON ファイルを分析します。

## 🚀 クイックスタート

```bash
bash scripts/analyze.sh sales_data.csv "トップの収益ドライバーは何ですか？"
```

## 🔑 設定

APIキーを設定します。

```bash
export EVOLINK_API_KEY="your-key"
```

👉 [無料APIキーを取得する](https://evolink.ai/signup?utm_source=github&utm_medium=skill&utm_campaign=data-analysis)

## 📖 使用方法

### 基本的な分析

```bash
bash scripts/analyze.sh <ファイルパス> "<分析の質問>"
```

**サポートされている形式:**
- CSV (`.csv`)
- Excel (`.xlsx`, `.xls`)
- JSON (`.json`)

### 質問例

```bash
# トレンド分析
bash scripts/analyze.sh sales.csv "月間収益のトレンドはどうですか？"

# 比較
bash scripts/analyze.sh experiment.csv "バリアントAはバリアントBよりも有意に優れていますか？"

# セグメンテーション
bash scripts/analyze.sh users.csv "最も高い定着率を持つユーザーセグメントはどれですか？"

# 異常検知
bash scripts/analyze.sh metrics.csv "過去30日間に異常なパターンはありますか？"
```

## ⚙️ 設定

| 変数 | デフォルト | 必須 | 説明 |
|---|---|---|---|
| `EVOLINK_API_KEY` | — | はい | あなたのEvolink APIキー。[無料キーをここで取得 →](https://evolink.ai/signup?utm_source=github&utm_medium=skill&utm_campaign=data-analysis) |
| `EVOLINK_MODEL` | `claude-opus-4-6` | いいえ | 分析用モデル。[Evolink API](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=data-analysis) でサポートされている任意のモデルに切り替えることができます。 |
| `DATA_ANALYSIS_SAFE_DIR` | `$HOME/.openclaw/workspace` | いいえ | ローカルファイルアクセスが許可されるディレクトリ |

必要なバイナリ: `curl`, `jq`, `python3`, `file`。

## 🎯 核となる原則

**意思決定を伴わない分析は単なる計算にすぎません。**

このスキルは以下を重視します。
- 意思決定優先の方法論
- 統計的厳密さ（サンプルサイズ、信頼区間、効果量）
- 明確な出力基準（洞察優先、定量化された不確実性）
- 明示的な制限と注意事項

## 📊 機能

1. **データファイルを読み込みます** (CSV/Excel/JSON)
2. あなたの分析の質問とともに **EvoLink API に送信します**
3. 以下の項目を含む **構造化された洞察を返します**
   - 主要な発見事項
   - 統計的信頼性
   - 注意事項と制限事項
   - 推奨される次のステップ

<h2>🔒 セキュリティ</h2>

**認証情報とネットワーク**

EvoLink API を呼び出すには `EVOLINK_API_KEY` が必要です。データファイルの内容と分析の質問は処理のために `api.evolink.ai` に送信されます。EvoLink はデータを処理し、分析結果を返します。処理後にデータが保存されることはありません。

**ファイルアクセス**

ローカルファイルシステムから指定されたデータファイルを読み取ります。ファイルは `DATA_ANALYSIS_SAFE_DIR` (デフォルト: `$HOME/.openclaw/workspace`) 内にある必要があります。スクリプトはファイルパスを検証し、セキュリティのためにシンボリックリンクを拒否します。

ファイルパスは `realpath -e` を介して解決されます（ファイルが存在し、すべてのシンボリックリンクを解決する必要があります）。シンボリックリンクの入力は明示的に拒否されます。

機密ファイルは名前でブラックリストに登録されています: `.env*`, `*.key`, `*.pem`, `*.p12`, `*.pfx`, `id_rsa*`, `authorized_keys`, `config.json`, `.bash_history`, `.ssh`, `shadow`, `passwd`。

**ファイルサイズ制限**: データファイルの最大サイズは50MBです。

**MIME検証**: `text/csv`, `text/plain`, `application/json`, `application/vnd.ms-excel`, `application/vnd.openxmlformats-officedocument.spreadsheetml.sheet` のみが受け入れられます。

**ネットワークアクセス**

- **EvoLink API** (`api.evolink.ai`) - データの送信と分析の受信

すべてのネットワーク呼び出しは curl を使用しており、スクリプトソースで監査可能です。

**永続性と特権**

このスキルは他のスキルやシステム設定を変更しません。昇格した権限や永続的な権限を要求しません。

## 📄 ライセンス

MIT

## 🔗 リンク

- [APIリファレンス](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=data-analysis)
- [コミュニティ](https://discord.com/invite/5mGHfA24kn)
- [サポート](mailto:support@evolink.ai)
- [APIキーを取得](https://evolink.ai/signup?utm_source=github&utm_medium=skill&utm_campaign=data-analysis) — 無料登録

[EvoLink.ai](https://evolink.ai?utm_source=github&utm_medium=skill&utm_campaign=data-analysis) によって提供されます
