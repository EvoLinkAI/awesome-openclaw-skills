# テキスト人間化ツール

[English](README.md) | [中文](README_zh.md) | **日本語** | [한국어](README_ko.md) | [Русский](README_ru.md) | [हिन्दी](README_hi.md) | [Deutsch](README_de.md) | [Français](README_fr.md) | [Italiano](README_it.md)

あらゆるテキストからAIの書き方パターンを除去します。29以上の言語に対応。

ブログ記事、メール、論文、レポートを貼り付けるだけで、人間が書いたような自然な文章に仕上げます。

Powered by [Evolink.ai](https://evolink.ai?utm_source=github&utm_medium=skill&utm_campaign=humanize)

## 使い方

エージェントに話しかけてください：
- "Humanize this text"
- "このテキストを自然にして"
- "Make this sound more natural"
- "AI っぽさを消して"

コマンドラインから：

```bash
bash scripts/humanize.sh "draft.txt"
bash scripts/humanize.sh "draft.txt" "casual blog post"
echo "Your text here" | bash scripts/humanize.sh -
```

## 仕組み

**レイヤー1 — パターンスキャン**：語彙、構造、トーン、フォーマットにわたる24の一般的なAI文章パターンを検出。

**レイヤー2 — リライト**：フラグが立ったフレーズを自然な表現に置き換え、文のリズムを変え、無駄を省く。

**レイヤー3 — スタイル適応**：文脈に合わせて調整 — ブログ、学術、ビジネスメール、カジュアル。

## 検出パターン

| カテゴリ | 例 |
|---|---|
| つなぎ言葉 | 「さらに」「特筆すべきは」「以上のことから」 |
| 宣伝調 | 「画期的な」「革新的な」「比類なき」 |
| 偽りの深み | 「〜を示し…〜を反映し…〜を浮き彫りにし…」 |
| 曖昧な帰属 | 「専門家によると」「関係者は述べている」 |
| 構造的な特徴 | 三段論法、均一な文長、定型的な結論 |
| AI頻出語彙 | 「包括的」「堅牢」「シームレス」「活用」 |
| チャットボット的表現 | 「お役に立てれば幸いです！」「ご不明な点がございましたら」 |

## 対応言語

英語、中国語、日本語、韓国語、ロシア語、ヒンディー語、ドイツ語、フランス語、イタリア語、スペイン語、ポルトガル語、オランダ語、ポーランド語、トルコ語、アラビア語など29以上の言語。

言語は自動検出。設定不要。

## 例

**変換前**（AI感が強い）：

> 今回のソフトウェアアップデートは、技術革新に対する同社の揺るぎないコミットメントを如実に体現するものであり、さらに、シームレスかつ直感的で堅牢なユーザー体験を提供し、ユーザーが効率的に目標を達成できることを確約するものです。

**変換後**：

> 今回のアップデートで一括処理、ショートカットキー、オフラインモードが追加された。画面も使いやすくなって、ほとんどの操作はクリック数が減った。全体的にしっかりした改善。

## 設定

1. [evolink.ai/signup](https://evolink.ai/signup?utm_source=github&utm_medium=readme&utm_campaign=text-humanizer-skill-for-openclaw?utm_source=github&utm_medium=skill&utm_campaign=humanize) でAPIキーを取得
2. 環境変数を設定：

```bash
export EVOLINK_API_KEY="your-key-here"
```

| 変数 | デフォルト | 説明 |
|---|---|---|
| `EVOLINK_API_KEY` | （必須） | Evolink APIキー |
| `EVOLINK_MODEL` | `claude-opus-4-6` | 処理モデル。[Evolink API](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=humanize)対応の任意のモデルに切替可能 |

## セキュリティ

- **ファイルアクセス**：設定された安全ディレクトリ内のファイルのみ
- **機密ファイルブロック**：`.env`、`.ssh`、`config.json`、秘密鍵など
- **サイズ制限**：テキストファイル5MB
- **MIME検証**：テキストファイルのみ受付
- 処理後のデータ保存なし

## リンク

- [ソースコード](https://github.com/EvoLinkAI/text-humanizer-skill-for-openclaw) — GitHubリポジトリ
- [APIドキュメント (EN)](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=humanize)
- [APIドキュメント (中文)](https://docs.evolink.ai/cn/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=humanize)
- [APIキー取得](https://evolink.ai/signup?utm_source=github&utm_medium=readme&utm_campaign=text-humanizer-skill-for-openclaw?utm_source=github&utm_medium=skill&utm_campaign=humanize) — 無料登録

## ライセンス

MIT

Powered by [Evolink.ai](https://evolink.ai?utm_source=github&utm_medium=skill&utm_campaign=humanize)
