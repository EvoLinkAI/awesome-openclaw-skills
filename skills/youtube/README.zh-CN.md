# YouTube Assistant — AI 驱动的 YouTube 视频转录与分析

> *看得更聪明，而不是更久。*

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![EvoLink](https://img.shields.io/badge/Powered%20by-EvoLink-blue)](https://evolink.ai?utm_source=github&utm_medium=skill&utm_campaign=youtube)

获取 YouTube 视频字幕、元数据和频道信息。AI 驱动的内容摘要、关键要点提取、多视频对比分析和视频问答。

[EvoLink API](https://evolink.ai?utm_source=github&utm_medium=skill&utm_campaign=youtube)

**Language / 语言:**
[English](README.md) | [简体中文](README.zh-CN.md) | [日本語](README.ja.md) | [한국어](README.ko.md) | [Español](README.es.md) | [Français](README.fr.md) | [Deutsch](README.de.md) | [Türkçe](README.tr.md) | [Русский](README.ru.md)

## 安装

```bash
# 安装 yt-dlp（必需）
pip install yt-dlp

# 安装 Skill
mkdir -p .claude/skills
git clone https://github.com/EvoLinkAI/youtube-skill-for-openclaw .claude/skills/youtube-assistant
export EVOLINK_API_KEY="your-key-here"
```

免费获取 API Key: [evolink.ai/signup](https://evolink.ai/signup?utm_source=github&utm_medium=skill&utm_campaign=youtube)

## 使用方法

```bash
# 获取视频字幕
bash scripts/youtube.sh transcript "https://www.youtube.com/watch?v=VIDEO_ID"

# 获取视频信息
bash scripts/youtube.sh info "https://www.youtube.com/watch?v=VIDEO_ID"

# AI 视频摘要
bash scripts/youtube.sh ai-summary "https://www.youtube.com/watch?v=VIDEO_ID"
```

### 命令

| 命令 | 描述 |
|------|------|
| `transcript <URL> [--lang]` | 获取清洗后的视频字幕 |
| `info <URL>` | 获取视频元数据（标题、播放量、时长） |
| `channel <URL> [limit]` | 列出频道近期视频 |
| `search <query> [limit]` | 搜索 YouTube |
| `ai-summary <URL>` | AI 生成视频摘要 |
| `ai-takeaways <URL>` | 提取关键要点和行动项 |
| `ai-compare <URL1> <URL2>` | 对比分析多个视频 |
| `ai-ask <URL> <question>` | 针对视频内容提问 |

## 特性

- 从任意 YouTube 视频提取字幕（手动 + 自动生成）
- 视频元数据：标题、时长、播放量、点赞、简介、标签
- 频道浏览和 YouTube 搜索
- AI 驱动：摘要、要点提取、多视频对比、问答
- 多语言字幕支持
- EvoLink API 集成（Claude 模型）

## 链接

- [ClawHub](https://clawhub.ai/evolinkai/youtube-assistant)
- [EvoLink API](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=youtube)
- [社区](https://discord.com/invite/5mGHfA24kn)

MIT License © [EvoLinkAI](https://github.com/EvoLinkAI)
