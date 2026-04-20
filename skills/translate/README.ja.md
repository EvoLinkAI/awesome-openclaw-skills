# Translate — AI 言語翻訳 Skill (OpenClaw)

テキストを正確に翻訳 — フォーマットを保持し、複数を処理し、ロケールに合わせてトーンを調整します。Powered by [EvoLink](https://evolink.ai/?utm_source=github&utm_medium=skill&utm_campaign=translate).

🌐 [English](README.md) | [简体中文](README.zh-CN.md) | 日本語 | [한국어](README.ko.md) | [Español](README.es.md) | [Français](README.fr.md) | [Deutsch](README.de.md) | [Türkçe](README.tr.md) | [Русский](README.ru.md)

---

## この Skill は何ですか？

Translate は、高精度な OpenClaw 翻訳 Skill です。文脈を理解し、複雑な Markdown フォーマットを保持し、文化的なニュアンスに合わせてトーンを調整します。

[今すぐインストール →](https://clawhub.ai/EvoLinkAI/evolink-translate)

---

## フォーマットの保持

- コードブロック、HTML タグ、Markdown 構文内のコンテンツは翻訳しません
- `"{name}"`, `"{{variable}}"`, `"%s"`, `` などのプレースホルダーをそのまま保持します
- Markdown 構造（ヘッダー、リンク、太字/斜体）を維持します
- JSON/XML の構造とキーを維持 — 適切な値のみを翻訳します

## 内容ルール

- 翻訳しないもの: 固有名詞、ブランド名、技術用語、URL、メールアドレス
- 翻訳しないもの: コードスニペット、CSS クラス、API エンドポイント、ファイル拡張子
- 数値、日付、ID はロケール変換が必要な場合を除き、元の形式を保持します
- 用語の一貫性を保つ — 繰り返される用語の用語集を作成します

## 言語別の処理

- **複数形**: ターゲット言語のルールに従った正しい複数形を使用します（英語のパターンではありません）
- **性別**: ジェンダー化された言語（スペイン語/フランス語/ドイツ語）での名詞と形容詞の一致を確保します
- **丁寧さ**: 文脈に基づき適切な丁寧さ（tu/vous, tú/usted, du/Sie）を選択します
- **RTL 言語**: アラビア語/ヘブライ語のテキスト方向を考慮しますが、LTR 要素（URL、数字）は維持します

## 文化的な適応

- 直訳ではなく、慣用句や表現を適応させます
- 文化的に適切な場合に単位を変換します（マイル↔km、華氏↔摂氏）
- 日付形式をロケール基準に合わせます（MM/DD vs DD/MM vs DD.MM）
- 現地の通貨記号と数値フォーマット（カンマ vs 小数点）を使用します

## 文脈の把握

- 文脈に基づいて曖昧さを解消します：“bank”（金融 vs 川岸）、“mouse”（動物 vs コンピュータ）
- 文書のトーンを維持します：ビジネス（正式） vs ブログ（カジュアル） vs 技術マニュアル
- ターゲットオーディエンスを考慮します：子供向けコンテンツ vs 学術論文 vs マーケティングコピー
- 単なる文字通りの意味ではなく、元の意図と感情的なニュアンスを保持します

## 品質管理

- 意味を理解するために翻訳前に全文を読みます
- ターゲット言語で自然で流暢に読めるか確認します
- 翻訳後、すべてのフォーマット要素が機能しているか検証します
- 文書全体を通して、一貫した声と用語を確保します

---

## クイックスタート



## 設定

- `EVOLINK_API_KEY`: API アクセスに必須。
- `EVOLINK_MODEL`: オプション。デフォルトは `claude-opus-4-6` です。この設定でモデルを切り替えられます（例: `claude-sonnet-4-6`, `gpt-5.4`）。

[無料の API Key を取得 →](https://evolink.ai/signup?utm_source=github&utm_medium=skill&utm_campaign=translate)

---

## リンク

- [ClawHub](https://clawhub.ai/EvoLinkAI/evolink-translate)
- [API Reference](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=translate)
- [Community](https://discord.com/invite/clawd)
- [Support](mailto:support@evolink.ai)

---

## ライセンス
MIT
