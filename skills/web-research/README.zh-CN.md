🌐 [English](README.md) | [日本語](README.ja.md) | [한국어](README.ko.md) | 简体中文 | [Français](README.fr.md) | [Deutsch](README.de.md) | [Русский](README.ru.md) | [हिन्दी](README.hi.md) | [Türkçe](README.tr.md)

# Web Search Assistant

**使用 EvoLink API 的 AI 驱动网络搜索**

Powered by [Evolink.ai](https://evolink.ai?utm_source=github&utm_medium=skill&utm_campaign=web-search)

搜索网络并获取包含标题、URL 和描述的清晰格式化结果。

## 🚀 快速开始

```bash
bash scripts/search.sh "AI coding assistants 2026"
bash scripts/search.sh "quantum computing breakthroughs" 20
```

## 🔑 配置

设置您的 EvoLink API 密钥：

```bash
export EVOLINK_API_KEY="your-evolink-api-key-here"
```

👉 [获取免费 API 密钥](https://evolink.ai/signup?utm_source=github&utm_medium=skill&utm_campaign=web-search)

## 📖 使用方法

### 基本搜索

```bash
bash scripts/search.sh "搜索查询"
```

返回前 10 个结果。

### 限制结果数量

```bash
bash scripts/search.sh "搜索查询" 20
```

指定最大结果数量。

## 🔒 安全性

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

## 📄 许可证

MIT

## 🔗 链接

- [ClawHub](https://clawhub.ai/evolinkai/web-research)
- [API 参考](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=web-search)
- [社区](https://discord.com/invite/5mGHfA24kn)
- [支持](mailto:support@evolink.ai)
