# Evolink Music — OpenClaw AI 音樂生成技能包

<p align="center">
  <strong>5 個音樂模型，1 個 API 金鑰 — Suno v4、v4.5、v5。文字轉音樂、自定義歌詞、純音樂。</strong>
</p>

<p align="center">
  <a href="#這是什麼">簡介</a> •
  <a href="#安裝">安裝</a> •
  <a href="#取得-api-key">API Key</a> •
  <a href="#音樂生成">生成</a> •
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

## 這是什麼？

[EvoLink](https://evolink.ai?utm_source=github&utm_medium=readme&utm_campaign=music-generation) 提供的 [OpenClaw](https://github.com/openclaw/openclaw) 技能包。安裝一個技能，你的 AI 代理就變成音樂工作室 — **5 個 Suno 模型**用於生成歌曲、純音樂和自定義作曲，全部通過單一 API。

| 技能 | 描述 | 模型 |
|------|------|------|
| **Evolink Music** | 文字轉音樂、自定義歌詞、純音樂、聲音控制 | Suno v4、v4.5、v4.5plus、v4.5all、v5 |

📚 **完整指南**：完全控制風格、流派、氛圍和結構的音樂生成。

---

## 安裝

### 快速安裝（推薦）

```bash
openclaw skills add https://github.com/EvoLinkAI/music-generation-skill-for-openclaw
```

完成！技能現已可用於你的代理。

### 手動安裝

```bash
git clone https://github.com/EvoLinkAI/music-generation-skill-for-openclaw.git
cd music-generation-skill-for-openclaw
openclaw skills add .
```

---

## 取得 API Key

1. 在 [evolink.ai](https://evolink.ai/signup?utm_source=github&utm_medium=readme&utm_campaign=music-generation-skill-for-openclaw)utm_medium=readme[evolink.ai](https://evolink.ai/signup?utm_source=github&utm_medium=readme&utm_campaign=music-generation-skill-for-openclaw)utm_campaign=music-generation-skill-for-openclaw) 註冊
2. 前往 Dashboard → API Keys
3. 創建新的 API 金鑰
4. 設置環境變量：

```bash
export EVOLINK_API_KEY=your_key_here
```

---

## 音樂生成

### 可用模型

| 模型 | 描述 | 使用案例 |
|------|------|----------|
| **suno-v4** | 穩定版本，快速生成 | 流行、電子、搖滚 |
| **suno-v4.5** | 更高品質，更豐富細節 | 專業製作 |
| **suno-v4.5plus** | 最高品質，優質音頻 | 商業發布 |
| **suno-v4.5all** | 完全多功能 | 所有流派 |
| **suno-v5** | 最新版本，高級功能 | 創意實驗 |

### 功能

- **5 個模型**具有不同功能
- **風格控制** — 流派、氛圍、節奏、強度
- **自定義歌詞** — 自己撰寫或讓 AI 生成
- **純音樂模式** — 無人聲音樂
- **聲音控制** — 調整聲音類型和音域

### 使用示例

與你的代理對話：

> 「用原聲吉他生成一首關於夏天的陽快流行歌曲」

> 「創建 3 分鐘的輕鬆爵士純音樂」

> 「寫一首關於公路旅行的自定義歌詞搖滚歌曲」

---

## 問題排解

| 問題 | 解決方案 |
|------|----------|
| `401 Unauthorized` | 在 [evolink.ai/dashboard](https://evolink.ai/dashboard?utm_source=github&utm_medium=readme&utm_campaign=music-generation) 檢查你的 `EVOLINK_API_KEY` |
| `402 Payment Required` | 在 [evolink.ai/dashboard](https://evolink.ai/dashboard?utm_source=github&utm_medium=readme&utm_campaign=music-generation) 充值 |
| `429 Rate Limited` | 請求過多 — 請稍候 |

---

## 授權條款

MIT

---

<p align="center">
  由 <a href="https://evolink.ai/signup?utm_source=github&utm_medium=readme&utm_campaign=music-generation-skill-for-openclaw"><strong>EvoLink</strong></a> 提供支持 — 統一 AI API 閘道
</p>
