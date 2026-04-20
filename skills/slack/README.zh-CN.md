# Slack Assistant — Claude Code 的 OpenClaw 技能

Slack API 集成，搭载智能 AI 功能 — 发送消息、阅读频道、搜索对话、管理工作区，内置 Claude 驱动的摘要和起草功能。由 [evolink.ai](https://evolink.ai?utm_source=github&utm_medium=skill&utm_campaign=slack) 提供支持

[这是什么？](#这是什么) | [安装](#安装) | [配置指南](#配置指南) | [使用方法](#使用方法) | [EvoLink](https://evolink.ai?utm_source=github&utm_medium=skill&utm_campaign=slack)

**Language / 语言:**
[English](README.md) | [简体中文](README.zh-CN.md) | [日本語](README.ja.md) | [한국어](README.ko.md) | [Español](README.es.md) | [Français](README.fr.md) | [Deutsch](README.de.md) | [Türkçe](README.tr.md) | [Русский](README.ru.md)

## 这是什么？

一个 [OpenClaw](https://clawhub.ai) 技能，将 Claude Code 连接到你的 Slack 工作区。只需告诉 Claude 你需要什么：

- "给 #general 发条消息"
- "#engineering 频道最近在聊什么？"
- "总结 #product 频道最近 50 条消息"
- "帮我起草一条回复"

## 安装

### 方式一：ClawHub（推荐）
```bash
npx clawhub install slack-assistant
```

### 方式二：npm
```bash
npx evolinkai-slack-assistant
```

### 方式三：手动安装
```bash
git clone https://github.com/EvoLinkAI/slack-skill-for-openclaw.git
cp -r slack-skill-for-openclaw /path/to/your/skills/slack-assistant/
```

## 配置指南

### 1. 创建 Slack 应用

1. 前往 [api.slack.com/apps](https://api.slack.com/apps)
2. 点击 **Create New App** > **From scratch**
3. 命名应用并选择工作区
4. 进入 **OAuth & Permissions** > **Bot Token Scopes**
5. 添加以下权限范围：
   - `channels:read`, `channels:write`, `channels:history`, `channels:manage`
   - `chat:write`
   - `files:read`, `files:write`
   - `groups:read`, `groups:write`, `groups:history`
   - `im:read`, `im:write`, `im:history`
   - `mpim:read`, `mpim:write`, `mpim:history`
   - `search:read`
   - `users:read`, `users:read.email`
   - `reactions:read`, `reactions:write`
6. 点击 **Install to Workspace** 并授权
7. 复制 **Bot User OAuth Token**（以 `xoxb-` 开头）

### 2. 配置凭证

```bash
# 创建配置目录
mkdir -p ~/.slack-skill

# 保存 Bot Token
echo '{"bot_token": "xoxb-your-token-here"}' > ~/.slack-skill/credentials.json
chmod 600 ~/.slack-skill/credentials.json
```

### 3.（可选）启用 AI 功能

```bash
export EVOLINK_API_KEY="your-key-here"
```

在 [evolink.ai/signup](https://evolink.ai/signup?utm_source=github&utm_medium=skill&utm_campaign=slack) 免费获取 API Key

## 使用方法

### 基础操作

```bash
# 列出频道
bash scripts/slack.sh channels

# 查看最近消息
bash scripts/slack.sh list "#general" 20

# 发送消息
bash scripts/slack.sh send "#general" "大家好！"
bash scripts/slack.sh send "@alice" "嗨，问个问题..."

# 搜索消息
bash scripts/slack.sh search "部署"

# 查看消息线程
bash scripts/slack.sh read CHANNEL_ID 1234567890.123456

# 在线程中回复
bash scripts/slack.sh reply CHANNEL_ID 1234567890.123456 "谢谢！"
```

### AI 功能

```bash
# 总结频道活动
bash scripts/slack.sh ai-summary "#engineering" 50

# AI 起草回复
bash scripts/slack.sh ai-reply CHANNEL_ID 1234567890.123456

# 按重要性排序消息
bash scripts/slack.sh ai-prioritize "#general" 30
```

### 频道管理

```bash
# 创建频道
bash scripts/slack.sh create-channel "new-project" --private

# 邀请用户
bash scripts/slack.sh invite "#new-project" "@alice"

# 上传文件
bash scripts/slack.sh upload "#general" ./report.pdf
```

## 配置项

| 变量 | 默认值 | 说明 |
|---|---|---|
| `SLACK_SKILL_DIR` | `~/.slack-skill` | 配置目录 |
| `EVOLINK_API_KEY` | — | AI 功能的 API Key（[免费获取](https://evolink.ai/signup?utm_source=github&utm_medium=skill&utm_campaign=slack)）|
| `EVOLINK_MODEL` | `claude-opus-4-6` | AI 模型（[文档](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=slack)）|

## 链接

- [ClawHub](https://clawhub.ai/EvoLinkAI/slack-assistant)
- [Slack API 文档](https://api.slack.com/methods)
- [EvoLink API](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=slack)
- [社区](https://discord.com/invite/5mGHfA24kn)
- [支持](mailto:support@evolink.ai)

## 许可证

MIT
