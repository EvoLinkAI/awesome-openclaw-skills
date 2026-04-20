# Nano Banana 2 — OpenClaw 向け AI 画像生成スキル

<p align="center">
  <strong>Google Gemini 3.1 Flash 画像生成、1 つの API キー — 高速、多用途、すぐに使える。</strong>
</p>

<p align="center">
  <a href="#これは何ですか">概要</a> •
  <a href="#インストール">インストール</a> •
  <a href="#api-key-の取得">API Key</a> •
  <a href="#画像生成">生成</a> •
  <a href="https://evolink.ai/signup?utm_source=github&utm_medium=readme&utm_campaign=nano-banana-2-skill-for-openclaw">EvoLink</a>
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

[EvoLink](https://evolink.ai?utm_source=github&utm_medium=readme&utm_campaign=nano-banana-2-skill-for-openclaw) 提供の [OpenClaw](https://github.com/openclaw/openclaw) スキルです。1 つのスキルをインストールすると、AI エージェントが Google の Gemini 3.1 Flash 画像モデルにアクセス — 高速なテキストから画像への生成と画像編集が単一の API で行えます。

| スキル | 説明 | プロバイダー |
|--------|------|-------------|
| **Nano Banana 2** | テキストから画像、画像編集 | Google (Gemini 3.1 Flash) |

📚 **特化ビュー**: [evolink-image](https://clawhub.ai/EvoLinkAI/evolink-image)。19 の画像モデル、動画、音楽用には完全版スキルをインストールしてください。

---

## インストール

### クイックインストール（推奨）

```bash
openclaw skills add https://github.com/EvoLinkAI/Nano-banana-2-skill-for-openclaw
```

完了！スキルがエージェントで利用可能になりました。

### 手動インストール

```bash
git clone https://github.com/EvoLinkAI/Nano-banana-2-skill-for-openclaw.git
cd Nano-banana-2-skill-for-openclaw
openclaw skills add .
```

---

## API Key の取得

1. [evolink.ai](https://evolink.ai/signup?utm_source=github&utm_medium=readme&utm_campaign=nano-banana-2-skill-for-openclaw) で登録
2. Dashboard → API Keys に移動
3. 新しい API キーを作成
4. 環境変数に設定：

```bash
export EVOLINK_API_KEY=your_key_here
```

---

## 画像生成

### 機能

- **高速生成** — Gemini 3.1 Flash で
- **テキストから画像** — シーンを説明すると、画像が生成されます
- **画像編集** — 既存の画像を修正
- **構造化レスポンス** — 画像 URL と分析を含む JSON

### 使用例

エージェントに話しかけるだけ：

> 「宇宙で宇宙飛行士の猫の画像を生成して、リアルなスタイルで」

> 「この画像を編集して背景をトロピカルビーチに変更して」

> 「カフェのミニマルなロゴを作成して」

---

## ライセンス

MIT

---

<p align="center">
  Powered by <a href="https://evolink.ai/signup?utm_source=github&utm_medium=readme&utm_campaign=nano-banana-2-skill-for-openclaw"><strong>EvoLink</strong></a> — Unified AI API Gateway
</p>
