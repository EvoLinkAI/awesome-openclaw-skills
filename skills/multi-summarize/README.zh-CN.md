# Multi Summarize — OpenClaw AI 摘要技能

快速多格式摘要 — 粘贴 URL、拖入文件，即刻获取关键要点。由 [EvoLink](https://evolink.ai?utm_source=github&utm_medium=readme&utm_campaign=multi-summarize-skill-for-openclaw?utm_source=github&utm_medium=skill&utm_campaign=summarize) 提供支持。

 [简介](#简介) •
 [安装](#安装) •
 [获取 API Key](#获取-api-key) •
 [使用方法](#使用方法) •
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

## 简介

这是一个 [OpenClaw](https://github.com/openclaw/openclaw) 技能，由 [EvoLink](https://evolink.ai?utm_source=github&utm_medium=readme&utm_campaign=multi-summarize-skill-for-openclaw?utm_source=github&utm_medium=skill&utm_campaign=summarize) 提供支持。安装后，你的 AI Agent 即可使用 Claude Opus 4.6（当前最强文本处理模型）将任何内容（URL、PDF、视频、音频、YouTube 链接或纯文本）总结为简洁、可操作的要点。

🚀 [立即获取 API Key →](https://evolink.ai/signup?utm_source=github&utm_medium=readme&utm_campaign=multi-summarize-skill-for-openclaw?utm_source=github&utm_medium=skill&utm_campaign=summarize)

## 安装

### 快速安装（推荐）

```bash
openclaw skills add https://github.com/EvoLinkAI/multi-summarize-skill-for-openclaw
```

安装完成，技能即刻可用。

### 通过 ClawHub 安装

```bash
clawhub install multi-summarize
```

### 手动安装

```bash
git clone https://github.com/EvoLinkAI/multi-summarize-skill-for-openclaw.git
cd multi-summarize-skill-for-openclaw
openclaw skills add .
```

## 获取 API Key

1. 在[这里](https://evolink.ai/signup?utm_source=github&utm_medium=readme&utm_campaign=multi-summarize-skill-for-openclaw?utm_source=github&utm_medium=skill&utm_campaign=summarize)注册账号
2. 进入 Dashboard → API Keys
3. 创建新的 Key
4. 设置环境变量：

```bash
export EVOLINK_API_KEY=your_key_here
```

或者直接告诉你的 OpenClaw Agent："把我的 EvoLink API key 设置为 ..."——它会自动处理。

## 使用方法

### 支持的格式

- **网页 URL** — 文章、博客、文档
- **PDF** — 报告、论文、白皮书
- **视频** — mp4、webm、YouTube 链接
- **音频** — mp3、wav、m4a、播客
- **文本** — Markdown、纯文本、代码文件

### 使用示例

直接用自然语言和你的 Agent 对话：

```
"帮我总结这篇文章：https://evolink.ai/blog/deepseek-v4-release-window-prep?utm_source=github&utm_medium=readme&utm_campaign=multi-summarize"
"这个 PDF 讲了什么？"（附上文件）
"帮我提取这个 YouTube 视频的要点：https://youtu.be/..."
"总结一下这段播客录音"（附上 mp3）
"给我一个 TL;DR"
```

### 脚本使用

技能包含 `scripts/summarize.sh` 脚本，可直接在命令行使用：

```bash
# 总结网页文章
bash scripts/summarize.sh "https://evolink.ai/blog/deepseek-v4-release-window-prep?utm_source=github&utm_medium=readme&utm_campaign=multi-summarize"

# 总结本地 PDF
bash scripts/summarize.sh "/path/to/report.pdf"

# 总结 YouTube 视频
bash scripts/summarize.sh "https://youtu.be/VIDEO_ID"

# 总结音频文件
bash scripts/summarize.sh "/path/to/podcast.mp3"

# 自定义关注点
bash scripts/summarize.sh "https://evolink.ai/blog/deepseek-v4-release-window-prep?utm_source=github&utm_medium=readme&utm_campaign=multi-summarize" "重点关注发布时间线"
```

### 输出示例

```
## TL;DR
DeepSeek V4 自 2026 年 1 月起就有传闻，但截至 3 月仍未正式发布。
多个预测的发布窗口均已过去。该模型预计聚焦编程能力，
HumanEval 得分据传达 90%（未经验证）。

## 关键要点
- 路透社 1 月报道 DeepSeek 计划在 2 月推出编程专用模型
- DeepSeek 2 月悄然将上下文窗口从 128K 扩展到 1M tokens — 疑似 V4 基础设施测试
- 未经验证的基准测试声称 HumanEval 90%、SWE-bench Verified 80%+
- "V4 Lite" 3 月出现在 DeepSeek 网站但从未被官方确认
- 多个发布窗口（2 月中旬、春节、3 月初）均未兑现

## 行动建议
- 在官方公告发布前不要迁移生产工作负载
- 持续关注 DeepSeek 官方渠道获取确认规格
- 提前准备 API 集成 — EvoLink 将在第一时间支持 V4
```

## 配置

默认模型：`claude-opus-4-6`（无需额外配置）。

使用其他模型：

```bash
export EVOLINK_MODEL="claude-sonnet-4-5-20250929"
```

### 可用模型

**Claude 系列**（Anthropic API 格式 — `/v1/messages`）
- **claude-opus-4-6** — 最高质量（默认）
- **claude-sonnet-4-6** — 最新 Sonnet，快速 + 强大
- **claude-sonnet-4-5-20250929** — 快速 + 高性价比
- **claude-haiku-4-5-20251001** — 超快速，轻量任务

**GPT 系列**（OpenAI API 格式 — `/v1/chat/completions`）
- **gpt-5.4** — OpenAI 最新旗舰模型
- **gpt-4o** — 多模态，快速
- **gpt-4o-mini** — 轻量，高性价比

**Gemini 系列**（OpenAI API 格式 — `/v1/chat/completions`）
- **gemini-3.1-flash-lite-preview** — Google 超快速轻量模型
- **gemini-3-flash-preview** — 快速，适合摘要任务

### API 文档

完整 API 文档请查看[这里](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=summarize)。

## 文件结构

```
.
├── README.md              # English
├── README.zh-CN.md        # 简体中文
├── SKILL.md               # OpenClaw 技能定义
├── references/
│   └── api-params.md      # 完整 API 参数文档
└── scripts/
    └── summarize.sh       # 摘要脚本
```

## 常见问题

- **`python3: command not found`** — 安装 Python 3：`apt install python3` / `brew install python3`
- **`curl: command not found`** — 安装 curl：`apt install curl` / `brew install curl`
- **`401 Unauthorized`** — 检查 EVOLINK_API_KEY，前往[控制台](https://evolink.ai/dashboard?utm_source=github&utm_medium=readme&utm_campaign=multi-summarize-skill-for-openclaw?utm_source=github&utm_medium=skill&utm_campaign=summarize)
- **`402 Payment Required`** — 前往[控制台](https://evolink.ai/dashboard?utm_source=github&utm_medium=readme&utm_campaign=multi-summarize-skill-for-openclaw?utm_source=github&utm_medium=skill&utm_campaign=summarize)充值
- **PDF 提取失败** — 安装 markitdown：`pip install markitdown` 或 poppler：`apt install poppler-utils`
- **YouTube 提取失败** — 安装 yt-dlp：`pip install yt-dlp`
- **音频转录失败** — 安装 whisper：`pip install openai-whisper`

## 链接

- [ClawHub](https://clawhub.ai/EvoLinkAI/multi-summarize)
- [API Reference](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=summarize)
- [Community](https://discord.com/invite/5mGHfA24kn)
- [Support](mailto:support@evolink.ai)

## 许可证

MIT
