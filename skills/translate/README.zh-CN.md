# Translate — AI 语言翻译 Skill (OpenClaw)

准确翻译文本 — 保留格式，处理复数，并根据语境调整语调。Powered by [EvoLink](https://evolink.ai/?utm_source=github&utm_medium=skill&utm_campaign=translate).

🌐 [English](README.md) | 简体中文 | [日本語](README.ja.md) | [한국어](README.ko.md) | [Español](README.es.md) | [Français](README.fr.md) | [Deutsch](README.de.md) | [Türkçe](README.tr.md) | [Русский](README.ru.md)

---

## 什么是这个 Skill？

Translate 是一个高精度 OpenClaw 翻译 Skill。它能够理解上下文，保留复杂的 Markdown 格式，并根据文化细微差别进行语调适配。

[立即安装 →](https://clawhub.ai/EvoLinkAI/evolink-translate)

---

## 格式保留

- 绝不翻译代码块、HTML 标签或 Markdown 语法内的内容
- 准确保留占位符，如 `"{name}"`, `"{{variable}}"`, `"%s"`, ``
- 保持 Markdown 结构完整：标题、链接、加粗/斜体格式
- 保持 JSON/XML 结构和键名 — 仅翻译合适的值

## 内容规则

- 不翻译：专有名词、品牌名称、技术术语、URL、电子邮件地址
- 不翻译：代码片段、CSS 类、API 端点、文件扩展名
- 除非有本地化需要，否则保持数字、日期和 ID 的原始格式
- 保持术语一致性 — 为重复出现的术语建立词汇表

## 语言特定处理

- **复数**: 根据目标语言的规则使用正确的复数形式（而非英语模式）
- **性别**: 确保语法性语言（西班牙语/法语/德语）中的名词-形容词性一致
- **正式程度**: 根据上下文选择适当的语体（tu/vous, tú/usted, du/Sie）
- **RTL 语言**: 考虑阿拉伯语/希伯来语的文字方向，但保持 LTR 元素（URL、数字）

## 文化适应

- 适应习语和表达，而非字面翻译
- 在文化合适时进行单位转换（英里↔公里，华氏度↔摄氏度）
- 根据地区标准调整日期格式（MM/DD 与 DD/MM 与 DD.MM）
- 使用当地货币符号和数字格式（逗号与小数点）

## 上下文感知

- 根据上下文消歧：“bank”（金融 vs 河岸），“mouse”（动物 vs 电脑）
- 保持文档语调：正式商务 vs 休闲博客 vs 技术手册
- 考虑目标受众：儿童内容 vs 学术论文 vs 营销文案
- 保留原始意图和情感细微差别，而非仅字面含义

## 质量控制

- 翻译前通读全文，理解含义
- 检查翻译文本在目标语言中是否自然流畅
- 验证翻译后所有格式元素依然有效
- 确保整个文档的语体和术语一致

---

## 快速开始



## 配置

- `EVOLINK_API_KEY`: API 访问必备。
- `EVOLINK_MODEL`: 可选。默认 `claude-opus-4-6`。您可以通过此项切换模型（例如 `claude-sonnet-4-6`, `gpt-5.4`）。

[在此获取免费 API Key →](https://evolink.ai/signup?utm_source=github&utm_medium=skill&utm_campaign=translate)

---

## 链接

- [ClawHub](https://clawhub.ai/EvoLinkAI/evolink-translate)
- [API Reference](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=translate)
- [Community](https://discord.com/invite/clawd)
- [Support](mailto:support@evolink.ai)

---

## 许可证
MIT
