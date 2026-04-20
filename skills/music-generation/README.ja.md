# Evolink Music — OpenClaw 向け AI 音楽生成スキル

<p align="center">
  <strong>5 つの音楽モデル、1 つの API キー — Suno v4、v4.5、v5。テキストから音楽、カスタム歌詞、インストゥルメンタル。</strong>
</p>

<p align="center">
  <a href="#これは何ですか">概要</a> •
  <a href="#インストール">インストール</a> •
  <a href="#api-key-の取得">API Key</a> •
  <a href="#音楽生成">生成</a> •
  <a href="https://evolink.ai/signup?utm_source=github&utm_medium=readme&utm_campaign=music-generation-skill-for-openclaw">EvoLink</a>
</p>

<p align="center">
  <strong>🌐 Languages:</strong>
  <a href="README.md">English</a> |
  <a href="README.zh-CN.md">简体中文</a> |
  <a href="README.es.md">Español</a> |
  <a href="README.ja.md">日本語</a> |
  <a href="README.ko.md">한국어</a> |
  <a href="README.fr.md">Français</a> |
  <a href="README.de.md">Deutsch</a> |
  <a href="README.tr.md">Türkçe</a> |
  <a href="README.zh-TW.md">繁體中文</a>
</p>

---

## これは何ですか？

[EvoLink](https://evolink.ai?utm_source=github&utm_medium=readme&utm_campaign=music-generation) 提供の [OpenClaw](https://github.com/openclaw/openclaw) スキルです。1 つのスキルをインストールすると、AI エージェントが音楽スタジオに変身 — **5 つの Suno モデル**で楽曲、インストゥルメンタル、カスタム作曲を生成できます。すべて単一の API で。

| スキル | 説明 | モデル |
|--------|------|--------|
| **Evolink Music** | テキストから音楽、カスタム歌詞、インストゥルメンタル、ボーカルコントロール | Suno v4、v4.5、v4.5plus、v4.5all、v5 |

📚 **完全ガイド**: スタイル、ジャンル、雰囲気、構造を完全にコントロールして音楽生成。

---

## インストール

### クイックインストール（推奨）

```bash
openclaw skills add https://github.com/EvoLinkAI/music-generation-skill-for-openclaw
```

完了！スキルがエージェントで利用可能になりました。

### 手動インストール

```bash
git clone https://github.com/EvoLinkAI/music-generation-skill-for-openclaw.git
cd music-generation-skill-for-openclaw
openclaw skills add .
```

---

## API Key の取得

1. [evolink.ai](https://evolink.ai/signup?utm_source=github&utm_medium=readme&utm_campaign=music-generation-skill-for-openclaw)utm_medium=readme[evolink.ai](https://evolink.ai/signup?utm_source=github&utm_medium=readme&utm_campaign=music-generation-skill-for-openclaw)utm_campaign=music-generation-skill-for-openclaw) で登録
2. Dashboard → API Keys に移動
3. 新しい API key を作成
4. 環境変数に設定：

```bash
export EVOLINK_API_KEY=your_key_here
```

---

## 音楽生成

### 利用可能なモデル

| モデル | 説明 | ユースケース |
|--------|------|-------------|
| **suno-v4** | 安定版、高速生成 | ポップ、エレクトロニック、ロック |
| **suno-v4.5** | より高品質、詳細豊か | プロフェッショナル制作 |
| **suno-v4.5plus** | 最高品質、プレミアムオーディオ | 商業リリース |
| **suno-v4.5all** | 完全な汎用性 | すべてのジャンル |
| **suno-v5** | 最新版、高度な機能 | クリエイティブ実験 |

### 機能

- **5 モデル** — 異なる機能を持つ
- **スタイルコントロール** — ジャンル、雰囲気、テンポ、強度
- **カスタム歌詞** — 自分で書くか、AI に生成させる
- **インストゥルメンタルモード** — ボーカルなしの音楽
- **ボーカルコントロール** — ボイスタイプと音域を調整

### 使用例

エージェントに話しかけるだけ：

> 「アコースティックギターで、夏についての陽気なポップソングを生成して」

> 「リラックスした雰囲気のジャズインストゥルメンタル、3分間作成して」

> 「ロードトリップについてのカスタム歌詞付きロックソングを書いて」

---

## トラブルシューティング

| 問題 | 解決策 |
|------|--------|
| `401 Unauthorized` | [evolink.ai/dashboard](https://evolink.ai/dashboard?utm_source=github&utm_medium=readme&utm_campaign=music-generation) で `EVOLINK_API_KEY` を確認 |
| `402 Payment Required` | [evolink.ai/dashboard](https://evolink.ai/dashboard?utm_source=github&utm_medium=readme&utm_campaign=music-generation) でクレジットを追加 |
| `429 Rate Limited` | リクエスト过多 — しばらく待ってください |

---

## ライセンス

MIT

---

<p align="center">
  Powered by <a href="https://evolink.ai/signup?utm_source=github&utm_medium=readme&utm_campaign=music-generation-skill-for-openclaw"><strong>EvoLink</strong></a> — Unified AI API Gateway
</p>
