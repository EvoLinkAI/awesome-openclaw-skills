# 文本人性化工具

[English](README.md) | **中文** | [日本語](README_ja.md) | [한국어](README_ko.md) | [Русский](README_ru.md) | [हिन्दी](README_hi.md) | [Deutsch](README_de.md) | [Français](README_fr.md) | [Italiano](README_it.md)

去除任何文本中的 AI 写作痕迹。支持 29+ 种语言。

粘贴一篇博客、邮件、论文或报告，就能拿到一份读起来像真人写的干净版本。

Powered by [Evolink.ai](https://evolink.ai?utm_source=github&utm_medium=skill&utm_campaign=humanize)

## 使用方法

跟你的 Agent 说：
- "Humanize this text"
- "帮我去掉这段文字的 AI 味"
- "Make this sound more natural"
- "这篇文章 AI 感太重了，帮我改一下"

或通过命令行：

```bash
bash scripts/humanize.sh "draft.txt"
bash scripts/humanize.sh "draft.txt" "casual blog post"
echo "Your text here" | bash scripts/humanize.sh -
```

## 工作原理

**第一层 — 模式扫描**：检测 24 种常见 AI 写作模式，涵盖词汇、结构、语气和排版。

**第二层 — 改写**：用自然的表达替换被标记的短语，调整句子节奏，砍掉废话。

**第三层 — 风格适配**：根据场景匹配改写风格——博客、学术、商务邮件或日常聊天。

## 能检测的模式

| 类别 | 示例 |
|---|---|
| 填充短语 | "值得一提的是"、"此外"、"综上所述" |
| 宣传腔 | "开创性的"、"卓越的"、"无与伦比的" |
| 假深度 | 连续使用"彰显……体现……展示……" |
| 模糊归因 | "业内人士表示"、"有专家指出" |
| 结构痕迹 | 三段式排比、句子长度整齐划一、模板化结尾 |
| AI 高频词 | "赋能"、"抓手"、"打通"、"闭环"、"底层逻辑" |
| 聊天机器人痕迹 | "好的呢！"、"希望对您有帮助！" |

## 支持的语言

29+ 种语言，包括英语、中文、日语、韩语、俄语、印地语、德语、法语、意大利语、西班牙语、葡萄牙语、荷兰语、波兰语、土耳其语、阿拉伯语等。

自动检测语言，无需配置。

## 示例

**改写前**（AI 味重）：

> 此次软件更新充分彰显了公司对技术创新的坚定承诺与不懈追求。此外，它提供了一个无缝衔接、直觉化且稳健的用户体验——确保用户能够高效地达成目标。这不仅仅是一次更新，更是我们重新定义生产力的一次革命。

**改写后**：

> 这次更新加了批量处理、键盘快捷键和离线模式。界面更好用了，大部分操作比以前少点几下。整体算是一个实打实的改进。

## 配置

1. 在 [evolink.ai/signup](https://evolink.ai/signup?utm_source=github&utm_medium=readme&utm_campaign=text-humanizer-skill-for-openclaw?utm_source=github&utm_medium=skill&utm_campaign=humanize) 获取 API Key
2. 设置环境变量：

```bash
export EVOLINK_API_KEY="your-key-here"
```

| 变量 | 默认值 | 说明 |
|---|---|---|
| `EVOLINK_API_KEY` | （必填） | 你的 Evolink API Key |
| `EVOLINK_MODEL` | `claude-opus-4-6` | 处理模型。可切换为 [Evolink API](https://docs.evolink.ai/cn/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=humanize) 支持的任何模型 |

## 安全性

- **文件访问**：仅限配置的安全目录内的文件
- **敏感文件拦截**：`.env`、`.ssh`、`config.json`、私钥等
- **大小限制**：文本文件 5MB
- **类型校验**：仅接受文本文件
- 处理后不存储任何数据

## 链接

- [源代码](https://github.com/EvoLinkAI/text-humanizer-skill-for-openclaw) — GitHub 仓库
- [API 文档 (EN)](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=humanize) — API 参考
- [API 文档 (中文)](https://docs.evolink.ai/cn/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=humanize) — API 文档
- [获取 API Key](https://evolink.ai/signup?utm_source=github&utm_medium=readme&utm_campaign=text-humanizer-skill-for-openclaw?utm_source=github&utm_medium=skill&utm_campaign=humanize) — 免费注册

## 许可证

MIT

Powered by [Evolink.ai](https://evolink.ai?utm_source=github&utm_medium=skill&utm_campaign=humanize)
