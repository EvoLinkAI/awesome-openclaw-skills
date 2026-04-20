# Gmail Assistant — OpenClaw AI 邮件技能

通过 Gmail API 集成，支持 AI 驱动的邮件摘要、智能回复起草和收件箱优先级排序。由 [evolink.ai](https://evolink.ai?utm_source=github&utm_medium=skill&utm_campaign=gmail) 提供支持

[这是什么？](#这是什么) | [安装](#安装) | [设置指南](#设置指南) | [使用方法](#使用方法) | [EvoLink](https://evolink.ai?utm_source=github&utm_medium=skill&utm_campaign=gmail)

**Language / 语言:**
[English](README.md) | [简体中文](README.zh-CN.md) | [日本語](README.ja.md) | [한국어](README.ko.md) | [Español](README.es.md) | [Français](README.fr.md) | [Deutsch](README.de.md) | [Türkçe](README.tr.md) | [Русский](README.ru.md)

## 这是什么？

Gmail Assistant 是一个 OpenClaw 技能，将你的 Gmail 账户连接到 AI 代理。它提供完整的 Gmail API 访问——阅读、发送、搜索、标签、归档——以及通过 EvoLink 使用 Claude 实现的 AI 驱动功能，包括收件箱摘要、智能回复起草和邮件优先级排序。

**核心 Gmail 操作无需任何 API 密钥。** AI 功能（摘要、起草、优先级排序）需要可选的 EvoLink API 密钥。

[获取免费 EvoLink API 密钥](https://evolink.ai/signup?utm_source=github&utm_medium=skill&utm_campaign=gmail)

## 安装

### 快速安装

```bash
openclaw skills add https://github.com/EvoLinkAI/gmail-skill-for-openclaw
```

### 通过 ClawHub

```bash
npx clawhub install evolinkai/gmail
```

### 手动安装

```bash
git clone https://github.com/EvoLinkAI/gmail-skill-for-openclaw.git
cd gmail-skill-for-openclaw
```

## 设置指南

### 第 1 步：创建 Google OAuth 凭证

1. 前往 [Google Cloud Console](https://console.cloud.google.com/)
2. 创建新项目（或选择现有项目）
3. 启用 **Gmail API**：API 和服务 > 库 > 搜索 "Gmail API" > 启用
4. 配置 OAuth 同意屏幕：API 和服务 > OAuth 同意屏幕 > 外部 > 填写必填字段
5. 创建 OAuth 凭证：API 和服务 > 凭证 > 创建凭证 > OAuth 客户端 ID > **桌面应用**
6. 下载 `credentials.json` 文件

### 第 2 步：配置

```bash
mkdir -p ~/.gmail-skill
cp credentials.json ~/.gmail-skill/credentials.json
bash scripts/gmail-auth.sh setup
```

### 第 3 步：授权

```bash
bash scripts/gmail-auth.sh login
```

这将打开浏览器进行 Google OAuth 授权。令牌存储在本地 `~/.gmail-skill/token.json`。

### 第 4 步：设置 EvoLink API 密钥（可选——用于 AI 功能）

```bash
export EVOLINK_API_KEY="your-key-here"
```

[获取 API 密钥](https://evolink.ai/signup?utm_source=github&utm_medium=skill&utm_campaign=gmail)

## 使用方法

### 核心命令

```bash
# 列出最近的邮件
bash scripts/gmail.sh list

# 使用过滤器列出
bash scripts/gmail.sh list --query "is:unread" --max 20

# 阅读特定邮件
bash scripts/gmail.sh read MESSAGE_ID

# 发送邮件
bash scripts/gmail.sh send "to@example.com" "明天会议" "你好，下午3点可以见面吗？"

# 回复邮件
bash scripts/gmail.sh reply MESSAGE_ID "谢谢，我会到的。"

# 搜索邮件
bash scripts/gmail.sh search "from:boss@company.com has:attachment"

# 列出标签
bash scripts/gmail.sh labels

# 加星 / 归档 / 删除
bash scripts/gmail.sh star MESSAGE_ID
bash scripts/gmail.sh archive MESSAGE_ID
bash scripts/gmail.sh trash MESSAGE_ID

# 查看账户信息
bash scripts/gmail.sh profile
```

### AI 命令（需要 EVOLINK_API_KEY）

```bash
# 摘要未读邮件
bash scripts/gmail.sh ai-summary

# 使用自定义查询摘要
bash scripts/gmail.sh ai-summary --query "from:team@company.com after:2026/04/01" --max 15

# AI 起草回复
bash scripts/gmail.sh ai-reply MESSAGE_ID "礼貌地拒绝并建议下周"

# 优先级排序收件箱
bash scripts/gmail.sh ai-prioritize --max 30
```

### 示例输出

```
收件箱摘要（5 封未读邮件）：

1. [紧急] 项目截止日期提前 — 来自：manager@company.com
   Q2 产品发布截止日期从 4 月 15 日提前到 4 月 10 日。
   需要操作：明天下班前更新冲刺计划。

2. 发票 #4521 — 来自：billing@vendor.com
   每月 SaaS 订阅发票 $299。4 月 15 日到期。
   需要操作：批准或转发给财务。

3. 周五团队午餐 — 来自：hr@company.com
   周五 12:30 团队建设午餐。请回复出席。
   需要操作：回复是否参加。

4. 简报：AI Weekly — 来自：newsletter@aiweekly.com
   低优先级。每周 AI 新闻汇总。
   需要操作：无。

5. GitHub 通知 — 来自：notifications@github.com
   PR #247 已合并到 main。CI 通过。
   需要操作：无。
```

## 配置

| 变量 | 默认值 | 必填 | 说明 |
|---|---|---|---|
| `credentials.json` | — | 是（核心） | Google OAuth 客户端凭证。参见[设置指南](#设置指南) |
| `EVOLINK_API_KEY` | — | 可选（AI） | 用于 AI 功能的 EvoLink API 密钥。[免费获取](https://evolink.ai/signup?utm_source=github&utm_medium=skill&utm_campaign=gmail) |
| `EVOLINK_MODEL` | `claude-opus-4-6` | 否 | AI 处理模型。可切换为 [EvoLink API](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=gmail) 支持的任意模型 |
| `GMAIL_SKILL_DIR` | `~/.gmail-skill` | 否 | 凭证和令牌的自定义存储路径 |

必需的二进制文件：`python3`、`curl`

## 故障排除

- **"Not authenticated"** — 运行 `bash scripts/gmail-auth.sh login` 进行授权
- **"credentials.json not found"** — 从 Google Cloud Console 下载 OAuth 凭证并放置在 `~/.gmail-skill/credentials.json`
- **"Token refresh failed"** — 刷新令牌可能已过期。再次运行 `bash scripts/gmail-auth.sh login`
- **"Set EVOLINK_API_KEY"** — AI 功能需要 EvoLink API 密钥。核心 Gmail 操作无需密钥
- **"Error 403: access_denied"** — 确保在 Google Cloud 项目中启用了 Gmail API 并配置了 OAuth 同意屏幕

## 链接

- [ClawHub](https://clawhub.ai/EvoLinkAI/gmail-assistant)
- [API 参考](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=gmail)
- [社区](https://discord.com/invite/5mGHfA24kn)
- [支持](mailto:support@evolink.ai)

## 许可证

MIT — 详见 [LICENSE](LICENSE)。
