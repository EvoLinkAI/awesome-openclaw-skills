# Multi Summarize — OpenClaw 用 AI 要約スキル

高速マルチフォーマット要約 — URL を貼り付け、ファイルをドロップするだけで、要点を即座に取得。[EvoLink](https://evolink.ai?utm_source=github&utm_medium=readme&utm_campaign=multi-summarize-skill-for-openclaw?utm_source=github&utm_medium=skill&utm_campaign=summarize) 提供。

 [概要](#概要) •
 [インストール](#インストール) •
 [API Key 取得](#api-key-の取得) •
 [使い方](#使い方) •
 [EvoLink](https://evolink.ai?utm_source=github&utm_medium=readme&utm_campaign=multi-summarize-skill-for-openclaw?utm_source=github&utm_medium=skill&utm_campaign=summarize)

 🌐 Languages:
 [English](/EvoLinkAI/multi-summarize-skill-for-openclaw/blob/main/README.md) |
 [简体中文](/EvoLinkAI/multi-summarize-skill-for-openclaw/blob/main/README.zh-CN.md) |
 [日本語](/EvoLinkAI/multi-summarize-skill-for-openclaw/blob/main/README.ja.md) |
 [한국어](/EvoLinkAI/multi-summarize-skill-for-openclaw/blob/main/README.ko.md) |
 [Español](/EvoLinkAI/multi-summarize-skill-for-openclaw/blob/main/README.es.md) |
 [Français](/EvoLinkAI/multi-summarize-skill-for-openclaw/blob/main/README.fr.md) |
 [Deutsch](/EvoLinkAI/multi-summarize-skill-for-openclaw/blob/main/README.de.md) |
 [Türkçe](/EvoLinkAI/multi-summarize-skill-for-openclaw/blob/main/README.tr.md) |
 [Русский](/EvoLinkAI/multi-summarize-skill-for-openclaw/blob/main/README.ru.md)

## 概要

[EvoLink](https://evolink.ai?utm_source=github&utm_medium=readme&utm_campaign=multi-summarize-skill-for-openclaw?utm_source=github&utm_medium=skill&utm_campaign=summarize) が提供する [OpenClaw](https://github.com/openclaw/openclaw) スキルです。このスキルをインストールするだけで、AI エージェントが URL、PDF、動画、音声ファイル、YouTube リンク、プレーンテキストなど、あらゆるコンテンツを Claude Opus 4.6（現在最も高性能なテキストモデル）を使って簡潔で実用的な要点に要約できるようになります。

🚀 [API Key を取得 →](https://evolink.ai/signup?utm_source=github&utm_medium=readme&utm_campaign=multi-summarize-skill-for-openclaw?utm_source=github&utm_medium=skill&utm_campaign=summarize)

## インストール

### クイックインストール（推奨）

```bash
openclaw skills add https://github.com/EvoLinkAI/multi-summarize-skill-for-openclaw
```

完了。スキルはすぐに使えます。

### ClawHub 経由

```bash
clawhub install multi-summarize
```

### 手動インストール

```bash
git clone https://github.com/EvoLinkAI/multi-summarize-skill-for-openclaw.git
cd multi-summarize-skill-for-openclaw
openclaw skills add .
```

## API Key の取得

1. [こちら](https://evolink.ai/signup?utm_source=github&utm_medium=readme&utm_campaign=multi-summarize-skill-for-openclaw?utm_source=github&utm_medium=skill&utm_campaign=summarize)でアカウント登録
2. Dashboard → API Keys に移動
3. 新しい Key を作成
4. 環境変数を設定：

```bash
export EVOLINK_API_KEY=your_key_here
```

または OpenClaw エージェントに「EvoLink API key を設定して」と伝えるだけで、自動的に処理されます。

## 使い方

### 対応フォーマット

- **Web URL** — 記事、ブログ、ドキュメント
- **PDF** — レポート、論文、ホワイトペーパー
- **動画** — mp4、webm、YouTube リンク
- **音声** — mp3、wav、m4a、ポッドキャスト
- **テキスト** — Markdown、プレーンテキスト、コードファイル

### 使用例

エージェントに自然に話しかけるだけ：

```
「この記事を要約して：https://evolink.ai/blog/deepseek-v4-release-window-prep」?utm_source=github&utm_medium=readme&utm_campaign=multi-summarize
「この PDF は何について？」（ファイルを添付）
「この YouTube 動画の要点を教えて：https://youtu.be/...」
「このポッドキャストを要約して」（mp3 を添付）
「TL;DR をお願い」
```

### スクリプトリファレンス

コマンドラインで直接使用できる `scripts/summarize.sh` が含まれています：

```bash
# Web 記事を要約
bash scripts/summarize.sh "https://evolink.ai/blog/deepseek-v4-release-window-prep?utm_source=github&utm_medium=readme&utm_campaign=multi-summarize"

# ローカル PDF を要約
bash scripts/summarize.sh "/path/to/report.pdf"

# YouTube 動画を要約
bash scripts/summarize.sh "https://youtu.be/VIDEO_ID"

# 音声ファイルを要約
bash scripts/summarize.sh "/path/to/podcast.mp3"

# カスタムフォーカスで要約
bash scripts/summarize.sh "https://evolink.ai/blog/deepseek-v4-release-window-prep?utm_source=github&utm_medium=readme&utm_campaign=multi-summarize" "リリースタイムラインに注目"
```

### 出力例

```
## TL;DR
DeepSeek V4 は 2026 年 1 月から噂されていますが、3 月時点でまだ正式にリリースされていません。
複数の予測されたリリースウィンドウがすべて過ぎました。
このモデルはコーディングに特化し、HumanEval スコア 90%（未検証）が期待されています。

## 主要ポイント
- ロイターが 1 月に DeepSeek が 2 月にコーディング特化モデルを計画していると報道
- DeepSeek が 2 月にコンテキストウィンドウを 128K から 1M トークンに静かに拡張 — V4 インフラテストの可能性
- 未検証のベンチマークが HumanEval 90%、SWE-bench Verified 80%+ を主張
- 「V4 Lite」が 3 月に DeepSeek のサイトに登場したが公式確認なし
- 複数のリリースウィンドウ（2 月中旬、旧正月、3 月初旬）がすべて未達

## アクションアイテム
- 公式発表まで本番ワークロードの移行を控える
- DeepSeek の公式チャンネルで確定スペックを監視
- API 統合の準備 — EvoLink は初日からV4 をサポート予定
```

## 設定

デフォルトモデル：`claude-opus-4-6`（追加設定不要）。

別のモデルを使用する場合：

```bash
export EVOLINK_MODEL="claude-sonnet-4-5-20250929"
```

### 利用可能なモデル

**Claude シリーズ**（Anthropic API 形式 — `/v1/messages`）
- **claude-opus-4-6** — 最高品質（デフォルト）
- **claude-sonnet-4-6** — 最新 Sonnet、高速 + 高性能
- **claude-sonnet-4-5-20250929** — 高速 + コスト効率
- **claude-haiku-4-5-20251001** — 超高速、軽量タスク

**GPT シリーズ**（OpenAI API 形式 — `/v1/chat/completions`）
- **gpt-5.4** — OpenAI 最新フラッグシップモデル
- **gpt-4o** — マルチモーダル、高速
- **gpt-4o-mini** — 軽量、コスト効率

**Gemini シリーズ**（OpenAI API 形式 — `/v1/chat/completions`）
- **gemini-3.1-flash-lite-preview** — Google 超高速軽量モデル
- **gemini-3-flash-preview** — 高速、要約に最適

### API リファレンス

完全な API ドキュメントは[こちら](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=summarize)。

## ファイル構成

```
.
├── README.md              # English
├── README.zh-CN.md        # 简体中文
├── README.ja.md           # 日本語
├── README.ko.md           # 한국어
├── README.es.md           # Español
├── README.fr.md           # Français
├── README.de.md           # Deutsch
├── README.tr.md           # Türkçe
├── README.ru.md           # Русский
├── SKILL.md               # OpenClaw skill definition
├── references/
│   └── api-params.md      # Full API parameter docs
└── scripts/
    └── summarize.sh       # Summarization script
```

## トラブルシューティング

- **`python3: command not found`** — Python 3 をインストール：`apt install python3` / `brew install python3`
- **`curl: command not found`** — curl をインストール：`apt install curl` / `brew install curl`
- **`401 Unauthorized`** — [ダッシュボード](https://evolink.ai/dashboard?utm_source=github&utm_medium=readme&utm_campaign=multi-summarize-skill-for-openclaw?utm_source=github&utm_medium=skill&utm_campaign=summarize)で EVOLINK_API_KEY を確認
- **`402 Payment Required`** — [ダッシュボード](https://evolink.ai/dashboard?utm_source=github&utm_medium=readme&utm_campaign=multi-summarize-skill-for-openclaw?utm_source=github&utm_medium=skill&utm_campaign=summarize)でチャージ
- **PDF 抽出失敗** — markitdown をインストール：`pip install markitdown` または poppler：`apt install poppler-utils`
- **YouTube 抽出失敗** — yt-dlp をインストール：`pip install yt-dlp`
- **音声文字起こし失敗** — whisper をインストール：`pip install openai-whisper`

## リンク

- [ClawHub](https://clawhub.ai/EvoLinkAI/multi-summarize)
- [API Reference](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=summarize)
- [Community](https://discord.com/invite/5mGHfA24kn)
- [Support](mailto:support@evolink.ai)

## ライセンス

MIT
