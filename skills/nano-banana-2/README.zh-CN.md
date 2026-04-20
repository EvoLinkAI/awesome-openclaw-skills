# Nano Banana 2 — AI 图片生成 OpenClaw 技能包

<p align="center">
  <strong>Google Gemini 3.1 Flash 图片生成，一个 API Key — 快速、多功能、开箱即用。</strong>
</p>

<p align="center">
  <a href="#这是什么">介绍</a> •
  <a href="#安装">安装</a> •
  <a href="#获取-api-key">API Key</a> •
  <a href="#图片生成">生成</a> •
  <a href="https://evolink.ai/signup?utm_source=github&utm_medium=readme&utm_campaign=nano-banana-2-skill-for-openclaw">EvoLink</a>
</p>

<p align="center">
  <strong>🌐 Languages：</strong>
  <a href="README.md">English</a> |
  <a href="README.zh-CN.md">简体中文</a>
</p>

---

## 这是什么？

一套基于 [EvoLink](https://evolink.ai?utm_source=github&utm_medium=readme&utm_campaign=nano-banana-2-skill-for-openclaw) 的 [OpenClaw](https://github.com/openclaw/openclaw) 技能包。安装一个技能，你的 AI 代理就能使用 Google 最新的 Gemini 3.1 Flash 图片模型 — 快速文生图和图片编辑，全部通过一个 API 搞定。

| 技能 | 描述 | 供应商 |
|------|------|--------|
| **Nano Banana 2** | 文生图、图片编辑 | Google (Gemini 3.1 Flash) |

> 这是 [evolink-image](https://clawhub.ai/EvoLinkAI/evolink-image) 的聚焦版。安装完整版可获得 19 个图片模型、视频和音乐生成能力。

🚀 **[立即体验所有模型 →](https://evolink.ai/models?utm_source=github&utm_medium=readme&utm_campaign=nano-banana-2-skill-for-openclaw)**

---

## 安装

### 快速安装（推荐）

```bash
openclaw skills add https://github.com/EvoLinkAI/nano-banana-2-skill
```

完事。技能已可供代理使用。

### 手动安装

```bash
git clone https://github.com/EvoLinkAI/nano-banana-2-skill.git
cd nano-banana-2-skill
openclaw skills add .
```

---

## 获取 API Key

1. 在 [evolink.ai](https://evolink.ai/signup?utm_source=github&utm_medium=readme&utm_campaign=nano-banana-2-skill-for-openclaw) 注册
2. 进入 Dashboard → API Keys
3. 创建新 Key
4. 设置环境变量：

```bash
export EVOLINK_API_KEY=your_key_here
```

或者直接告诉你的 OpenClaw 代理：*"设置我的 EvoLink API key 为 ..."* — 它会搞定。

---

## 图片生成

通过与 OpenClaw 代理自然对话来生成和编辑 AI 图片。

### 能力

- **文生图** — 描述你想要的画面，生成图片
- **图片编辑** — 用参考图引导输出
- **多分辨率** — 1024×1024、1024×1536、1536×1024，以及自定义比例
- **批量生成** — 一次生成 1–4 张变体
- **多比例** — 1:1、16:9、9:16、4:3、3:4、2:3、3:2 等

### 为什么选 Nano Banana 2？

- **Google 最新架构** — 基于 Gemini 3.1 Flash，最新一代生成架构
- **快速生成** — 速度优化，不牺牲质量
- **多功能** — 通用图片创作，满足各种创意需求
- **强提示词理解** — 擅长遵循复杂、详细的描述

### 轻量版

`nano-banana-2-lite` [BETA] — 轻量版本，适合追求极致速度的快速迭代。

### 使用示例

直接和代理说话：

> "生成一幅山间日落的水彩画"

> "把这张照片编辑成复古胶片风格"

> "为一家咖啡店生成 4 个 logo 变体"

> "让这张图看起来更有电影感，加暖色调"

代理会引导你补充缺失信息并处理生成。

### 替代模型

| 模型 | 最佳用途 | 速度 |
|------|---------|------|
| `gpt-image-1.5` *（默认）* | 最新 OpenAI 生成 | 中等 |
| `gpt-4o-image` [BETA] | 最佳画质、复杂编辑 | 中等 |
| `z-image-turbo` | 快速迭代 | 极快 |
| `doubao-seedream-4.5` | 照片级真实感 | 中等 |
| `gemini-3-pro-image-preview` | Google Pro 生成 | 中等 |

### MCP 工具

| 工具 | 用途 |
|------|------|
| `generate_image` | 从文本或参考图创建/编辑 AI 图片 |
| `upload_file` | 上传本地图片用于编辑/参考 |
| `delete_file` | 删除已上传文件释放配额 |
| `list_files` | 查看已上传文件和存储配额 |
| `check_task` | 轮询生成进度并获取结果链接 |
| `list_models` | 浏览可用图片模型 |
| `estimate_cost` | 查询模型定价 |

### 参数

| 参数 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| `prompt` | string | — | 图片描述（必填） |
| `model` | enum | `gemini-3.1-flash-image-preview` | 使用的模型 |
| `size` | enum | `1024x1024` | 输出尺寸或比例 |
| `n` | integer | `1` | 生成数量（1–4） |
| `image_urls` | string[] | — | 图生图的参考图片（最多 14 张） |

---

## 配置 — MCP Server 桥接

为获得完整工具体验，桥接 MCP 服务器 `@evolinkai/evolink-media`（[npm](https://www.npmjs.com/package/@evolinkai/evolink-media)）：

**通过 mcporter：**

```bash
mcporter call --stdio "npx -y @evolinkai/evolink-media@latest" list_models
```

**或添加到 mcporter 配置：**

```json
{
  "evolink-media": {
    "transport": "stdio",
    "command": "npx",
    "args": ["-y", "@evolinkai/evolink-media@latest"],
    "env": { "EVOLINK_API_KEY": "your-key-here" }
  }
}
```

**直接安装（Claude Code）：**

```bash
claude mcp add evolink-media -e EVOLINK_API_KEY=your-key -- npx -y @evolinkai/evolink-media@latest
```

---

## 文件上传

图片编辑或参考工作流需要先上传图片：

1. 调用 `upload_file`，传入 `file_path`、`base64_data` 或 `file_url` → 获取 `file_url`（同步）
2. 将 `file_url` 作为 `generate_image` 的 `image_urls` 参数

**支持格式：** JPEG、PNG、GIF、WebP。最大 **100MB**。文件 **72 小时**后过期。配额：100 个文件（默认）/ 500 个（VIP）。

---

## 工作流

1. 如需要，先上传参考图片（通过 `upload_file`）
2. 调用 `generate_image` → 获取 `task_id`
3. 每 3–5 秒轮询 `check_task` 直到 `completed`
4. 下载结果链接（24 小时内有效）

---

## 脚本参考

技能包含 `scripts/evolink-image-gen.sh` 供命令行直接使用：

```bash
# 文生图
./scripts/evolink-image-gen.sh "山间日落水彩画" --size 1024x1536

# 带参考图编辑
./scripts/evolink-image-gen.sh "改成复古风格" --image "https://example.com/photo.jpg"

# 批量生成（4 张变体）
./scripts/evolink-image-gen.sh "咖啡店 logo 设计" --n 4

# 轻量版快速迭代
./scripts/evolink-image-gen.sh "抽象几何图案" --model nano-banana-2-lite
```

### API 参数

完整 API 文档见 [references/api-params.md](references/api-params.md)。

---

## 文件结构

```
.
├── README.md                    # English
├── README.zh-CN.md              # 本文件
├── SKILL.md                     # OpenClaw 技能定义
├── _meta.json                   # 技能元数据
├── references/
│   └── api-params.md            # 完整 API 参数文档
└── scripts/
    └── evolink-image-gen.sh     # 图片生成脚本
```

---

## 常见问题

| 问题 | 解决方案 |
|------|---------| 
| `jq: command not found` | 安装 jq：`apt install jq` / `brew install jq` |
| `curl: command not found` | 安装 curl：`apt install curl` / `brew install curl` |
| `401 Unauthorized` | 检查 `EVOLINK_API_KEY`，在 [evolink.ai/dashboard](https://evolink.ai/dashboard?utm_source=github&utm_medium=readme&utm_campaign=nano-banana-2-skill-for-openclaw) 确认 |
| `402 Payment Required` | 在 [evolink.ai/dashboard](https://evolink.ai/dashboard?utm_source=github&utm_medium=readme&utm_campaign=nano-banana-2-skill-for-openclaw) 充值 |
| 内容被拦截 | 名人/NSFW/暴力内容受限 — 修改提示词 |
| 生成超时 | 试试 `nano-banana-2-lite` 获得更快结果 |

---

## 更多技能

更多 EvoLink 技能正在开发中。关注更新或 [提出需求](https://github.com/EvoLinkAI/nano-banana-2-skill/issues)。

---

## 从 ClawHub 下载

你也可以直接从 ClawHub 安装此技能：

👉 **[在 ClawHub 下载 →](https://clawhub.ai/EvoLinkAI/evolink-nano-banana-2)**

---

## 许可证

MIT

---

<p align="center">
  由 <a href="https://evolink.ai/signup?utm_source=github&utm_medium=readme&utm_campaign=nano-banana-2-skill-for-openclaw"><strong>EvoLink</strong></a> 提供支持 — 统一 AI API 网关
</p>
