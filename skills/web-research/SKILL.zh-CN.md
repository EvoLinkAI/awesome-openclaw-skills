---
name: web-research
description: 通过 EvoLink API 进行网络搜索。返回包含标题、URL 和描述的清晰格式化结果。Powered by evolink.ai
metadata: {"clawdbot":{"emoji":"🔍","requires":{"bins":["bash","curl","jq"],"env":["EVOLINK_API_KEY"]},"primaryEnv":"EVOLINK_API_KEY"}}
---

# Web Search Assistant

通过 EvoLink API 进行网络搜索。返回包含标题、URL 和描述的清晰格式化结果。

Powered by [Evolink.ai](https://evolink.ai?utm_source=clawhub&utm_medium=skill&utm_campaign=web-search)

## 何时使用

当用户请求以下内容时使用此技能：
- 搜索信息或资源
- 查找当前或最近的在线信息
- 需要当前网络数据的研究
- 使用网络来源进行事实核查或验证
- 收集某个主题的 URL 和资源

## 搜索

```bash
{baseDir}/scripts/search.sh "查询"
{baseDir}/scripts/search.sh "查询" 20
```

## 选项

- `<query>`：搜索查询
- `<max_results>`：结果数量（默认：10）

## 配置

设置您的 EvoLink API 密钥：

```bash
export EVOLINK_API_KEY="your-evolink-api-key-here"
```

👉 [获取免费 API 密钥](https://evolink.ai/signup?utm_source=clawhub&utm_medium=skill&utm_campaign=web-search)

## 示例

```bash
bash scripts/search.sh "Claude Opus 4 features"
```

输出：
```
🔍 搜索中: Claude Opus 4 features

📄 Claude Opus 4: New Features and Capabilities
🔗 https://example.com/opus-4
📝 Comprehensive guide to Claude Opus 4's new features...

📄 What's New in Claude Opus 4
🔗 https://example.com/whats-new
📝 Latest updates and improvements in Claude Opus 4...
```

## 安全性

**凭据与网络**

调用 EvoLink API 需要 `EVOLINK_API_KEY`。您的搜索查询将发送到 `api.evolink.ai` 进行处理。EvoLink 在内部处理网络搜索并返回格式化的结果。

**文件访问**

此技能不读取或写入任何文件。

**网络访问**

此技能向以下地址发出网络请求：
- **EvoLink API** (`api.evolink.ai`) - 执行网络搜索

所有网络调用都通过 curl 执行，可以在脚本源代码中进行审计。

**持久性与权限**

此技能不修改其他技能或系统设置。不请求提升或持久权限。

## 链接

- [ClawHub](https://clawhub.ai/evolinkai/web-research)
- [API 参考](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=clawhub&utm_medium=skill&utm_campaign=web-search)
- [社区](https://discord.com/invite/5mGHfA24kn)
- [支持](mailto:support@evolink.ai)
