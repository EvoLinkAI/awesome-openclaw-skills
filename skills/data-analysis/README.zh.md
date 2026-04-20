🌐 [English](README.md) | [日本語](README.ja.md) | [한국어](README.ko.md) | [Français](README.fr.md) | [Deutsch](README.de.md) | [Русский](README.ru.md) | [हिन्दी](README.hi.md) | [Türkçe](README.tr.md) | 中文

# 数据分析助手

**使用 EvoLink API 的 AI 驱动数据分析**

由 [Evolink.ai](https://evolink.ai?utm_source=github&utm_medium=skill&utm_campaign=data-analysis) 提供支持

使用决策优先方法和统计严谨性分析 CSV、Excel 和 JSON 文件。

## 🚀 快速开始

```bash
bash scripts/analyze.sh sales_data.csv "主要收入驱动因素是什么？"
```

## 🔑 配置

设置您的 API 密钥：

```bash
export EVOLINK_API_KEY="your-key"
```

👉 [获取免费 API 密钥](https://evolink.ai/signup?utm_source=github&utm_medium=skill&utm_campaign=data-analysis)

## 📖 使用方法

### 基础分析

```bash
bash scripts/analyze.sh <文件路径> "<分析问题>"
```

**支持的格式：**
- CSV (`.csv`)
- Excel (`.xlsx`, `.xls`)
- JSON (`.json`)

### 示例问题

```bash
# 趋势分析
bash scripts/analyze.sh sales.csv "月度收入趋势是什么？"

# 对比分析
bash scripts/analyze.sh experiment.csv "变体 A 是否明显优于 B？"

# 细分分析
bash scripts/analyze.sh users.csv "哪些用户细分群体的留存率最高？"

# 异常检测
bash scripts/analyze.sh metrics.csv "过去 30 天内是否有任何异常模式？"
```

## ⚙️ 配置

| 变量 | 默认值 | 必需 | 描述 |
|---|---|---|---|
| `EVOLINK_API_KEY` | — | 是 | 您的 Evolink API 密钥。[免费获取 →](https://evolink.ai/signup?utm_source=github&utm_medium=skill&utm_campaign=data-analysis) |
| `EVOLINK_MODEL` | `[REDACTED]` | 否 | 用于分析的模型。可切换到 [Evolink API](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=data-analysis) 支持的任何模型 |
| `DATA_ANALYSIS_SAFE_DIR` | `$HOME/.openclaw/workspace` | 否 | 本地文件访问的允许目录 |

所需二进制文件：`curl`、`jq`、`python3`、`file`。

## 🎯 核心原则

**没有决策的分析只是算术。**

本技能强调：
- 决策优先方法
- 统计严谨性（样本量、置信区间、效应量）
- 清晰的输出标准（洞察优先、量化不确定性）
- 明确的局限性和注意事项

## 📊 功能说明

1. **读取您的数据文件**（CSV/Excel/JSON）
2. **发送到 EvoLink API** 并附上您的分析问题
3. **返回结构化洞察**，包括：
   - 关键发现
   - 统计置信度
   - 注意事项和局限性
   - 建议的后续步骤

## 🔒 安全性

**凭证与网络**

需要 `EVOLINK_API_KEY` 来调用 EvoLink API。您的数据文件内容和分析问题将发送到 `api.evolink.ai` 进行处理。EvoLink 处理数据并返回分析结果。处理后不会存储数据。

**文件访问**

从本地文件系统读取指定的数据文件。文件必须位于 `DATA_ANALYSIS_SAFE_DIR`（默认：`$HOME/.openclaw/workspace`）内。脚本会验证文件路径并出于安全考虑拒绝符号链接。

文件路径通过 `realpath -e` 解析（要求文件存在，解析所有符号链接）。符号链接输入会被明确拒绝。

敏感文件按名称列入黑名单：`.env*`、`*.key`、`*.pem`、`*.p12`、`*.pfx`、`id_rsa*`、`authorized_keys`、`config.json`、`.bash_history`、`.ssh`、`shadow`、`passwd`。

**文件大小限制**：数据文件最大 50MB。

**MIME 验证**：仅接受 `text/csv`、`text/plain`、`application/json`、`application/vnd.ms-excel`、`application/vnd.openxmlformats-officedocument.spreadsheetml.sheet`。

**网络访问**

- **EvoLink API**（`api.evolink.ai`）- 发送数据并接收分析结果

所有网络调用都使用 curl，可在脚本源代码中审计。

**持久性与权限**

本技能不会修改其他技能或系统设置。不请求提升或持久权限。

## 📄 许可证

MIT

## 🔗 链接

- [API 参考](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=data-analysis)
- [社区](https://discord.com/invite/5mGHfA24kn)
- [支持](mailto:support@evolink.ai)
- [获取 API 密钥](https://evolink.ai/signup?utm_source=github&utm_medium=skill&utm_campaign=data-analysis) — 免费注册

由 [Evolink.ai](https://evolink.ai?utm_source=github&utm_medium=skill&utm_campaign=data-analysis) 提供支持
