# Evolink Video — AI 视频生成 OpenClaw 技能包

<p align="center">
  <strong>37 个视频模型，一个 API Key — Sora、Kling、Veo 3、Seedance、Hailuo、WAN、Grok。</strong>
</p>

<p align="center">
  <a href="#这是什么">介绍</a> •
  <a href="#安装">安装</a> •
  <a href="#获取-api-key">API Key</a> •
  <a href="#视频生成">生成</a> •
  <a href="https://evolink.ai/signup?utm_source=github&utm_medium=readme&utm_campaign=video-generation-skill-for-openclaw">EvoLink</a>
</p>

<p align="center">
  <strong>🌐 Languages：</strong>
  <a href="README.md">English</a> |
  <a href="README.zh-CN.md">简体中文</a>
</p>

---

## 这是什么？

一套基于 [EvoLink](https://evolink.ai?utm_source=github&utm_medium=readme&utm_campaign=video-generation) 的 [OpenClaw](https://github.com/openclaw/openclaw) 技能包。安装一个技能，你的 AI 代理就能调用 **37 个视频模型**，覆盖全球顶级供应商 — 全部通过一个 API 搞定。

| 技能 | 描述 | 供应商 |
|------|------|--------|
| **Evolink Video** | 文生视频、图生视频、首尾帧、视频编辑、音频生成 | Sora、Kling、Veo 3、Seedance、Hailuo、WAN、Grok |

> 这是 [evolink-media](https://clawhub.ai/EvoLinkAI/evolink-media) 的视频子集。安装完整版可获得图片和音乐生成能力。

🚀 **[立即体验所有模型 →](https://evolink.ai/models?utm_source=github&utm_medium=readme&utm_campaign=video-generation)**

更多技能即将推出。

---

## 安装

### 快速安装（推荐）

```bash
openclaw skills add https://github.com/EvoLinkAI/video-generation-skill-for-openclaw
```

完事。技能已可供代理使用。

### 手动安装

```bash
git clone https://github.com/EvoLinkAI/video-generation-skill-for-openclaw.git
cd video-generation-skill-for-openclaw
openclaw skills add .
```

---

## 获取 API Key

1. 在 [evolink.ai](https://evolink.ai/signup?utm_source=github&utm_medium=readme&utm_campaign=video-generation-skill-for-openclaw) 注册
2. 进入 Dashboard → API Keys
3. 创建新 Key
4. 设置环境变量：

```bash
export EVOLINK_API_KEY=your_key_here
```

或者直接告诉你的 OpenClaw 代理：*"设置我的 EvoLink API key 为 ..."* — 它会搞定。

---

## 视频生成

通过与 OpenClaw 代理自然对话来生成 AI 视频。

### 能力

- **文生视频** — 描述场景，生成视频
- **图生视频** — 提供参考图引导输出
- **首尾帧控制** — 定义起始和结束画面，精准掌控
- **视频编辑** — 编辑和变换已有视频
- **自动配音** — 同步语音、音效、背景音乐
- **多分辨率** — 480p、720p、1080p、4K
- **灵活时长** — 3–15 秒（视模型而定）
- **多比例** — 16:9、9:16、1:1、4:3、3:4、21:9

### 使用示例

直接和代理说话：

> "生成一个 5 秒的猫弹钢琴视频"

> "创建一个海上日落的电影级画面，1080p，16:9"

> "用这张图作为参考，生成一个 8 秒的动画视频"

> "把这个视频编辑成梦幻慢动作效果"

代理会引导你补充缺失信息并处理生成。

### 模型（37 个）

#### 精选推荐

| 模型 | 最佳用途 | 特性 |
|------|---------|------|
| `seedance-1.5-pro` *（默认）* | 图生视频、首尾帧 | i2v, 4–12s, 1080p, 音频 |
| `sora-2-preview` | 电影级预览 | t2v, i2v, 1080p |
| `kling-o3-text-to-video` | 文生视频, 1080p | t2v, 3–15s |
| `veo-3.1-generate-preview` | Google 视频预览 | t2v, 1080p |
| `MiniMax-Hailuo-2.3` | 高质量视频 | t2v, 1080p |
| `wan2.6-text-to-video` | 阿里巴巴最新文生视频 | t2v |
| `sora-2` [BETA] | 电影感、提示词还原度 | t2v, i2v, 1080p |
| `veo3.1-pro` [BETA] | 顶级画质 + 音频 | t2v, 1080p, 音频 |

#### 稳定模型（26 个）

`seedance-1.5-pro`, `seedance-2.0`, `doubao-seedance-1.0-pro-fast`, `sora-2-preview`, `kling-o3-text-to-video`, `kling-o3-image-to-video`, `kling-o3-reference-to-video`, `kling-o3-video-edit`, `kling-v3-text-to-video`, `kling-v3-image-to-video`, `kling-o1-image-to-video`, `kling-o1-video-edit`, `kling-o1-video-edit-fast`, `kling-custom-element`, `veo-3.1-generate-preview`, `veo-3.1-fast-generate-preview`, `MiniMax-Hailuo-2.3`, `MiniMax-Hailuo-2.3-Fast`, `MiniMax-Hailuo-02`, `wan2.5-t2v-preview`, `wan2.5-i2v-preview`, `wan2.5-text-to-video`, `wan2.5-image-to-video`, `wan2.6-text-to-video`, `wan2.6-image-to-video`, `wan2.6-reference-video`

#### 测试模型（11 个）

`sora-2`, `sora-2-pro`, `sora-2-beta-max`, `sora-character`, `veo3.1-pro`, `veo3.1-fast`, `veo3.1-fast-extend`, `veo3`, `veo3-fast`, `grok-imagine-text-to-video`, `grok-imagine-image-to-video`

### MCP 工具

| 工具 | 用途 |
|------|------|
| `generate_video` | 从文本或图片创建 AI 视频 |
| `upload_file` | 上传本地图片用于图生视频 |
| `delete_file` | 删除已上传文件释放配额 |
| `list_files` | 查看已上传文件和存储配额 |
| `check_task` | 轮询生成进度并获取结果链接 |
| `list_models` | 浏览可用视频模型 |
| `estimate_cost` | 查询模型定价 |

### 参数

| 参数 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| `prompt` | string | — | 视频描述（必填） |
| `model` | enum | `seedance-1.5-pro` | 使用的模型 |
| `duration` | integer | 模型默认 | 时长（秒） |
| `aspect_ratio` | enum | `16:9` | `16:9`、`9:16`、`1:1`、`4:3`、`3:4`、`21:9` |
| `quality` | enum | 模型默认 | `480p` / `720p` / `1080p` / `4k` |
| `image_urls` | string[] | — | 图生视频的参考图片 |
| `generate_audio` | boolean | 模型默认 | 自动生成音频 |

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

图生视频需要先上传参考图片：

1. 调用 `upload_file`，传入 `file_path`、`base64_data` 或 `file_url` → 获取 `file_url`（同步）
2. 将 `file_url` 作为 `generate_video` 的 `image_urls` 参数

**支持格式：** JPEG、PNG、GIF、WebP。最大 **100MB**。文件 **72 小时**后过期。配额：100 个文件（默认）/ 500 个（VIP）。

---

## 工作流

1. 如需要，先上传参考图片（通过 `upload_file`）
2. 调用 `generate_video` → 获取 `task_id`
3. 每 10–15 秒轮询 `check_task` 直到 `completed`
4. 下载结果链接（24 小时内有效）

---

## 脚本参考

技能包含 `scripts/evolink-video-gen.sh` 供命令行直接使用：

```bash
# 文生视频
./scripts/evolink-video-gen.sh "宁静的山间黎明景色" --duration 5 --quality 720p

# 带参考图
./scripts/evolink-video-gen.sh "轻柔的海浪" --image "https://example.com/beach.jpg" --duration 8 --quality 1080p

# 竖版（社交媒体）
./scripts/evolink-video-gen.sh "舞动的粒子" --aspect-ratio 9:16 --duration 4 --quality 720p

# 指定模型
./scripts/evolink-video-gen.sh "电影级飙车场景" --model sora-2-preview --duration 10 --quality 1080p

# 无音频
./scripts/evolink-video-gen.sh "抽象艺术动画" --duration 6 --quality 720p --no-audio
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
    └── evolink-video-gen.sh     # 视频生成脚本
```

---

## 常见问题

| 问题 | 解决方案 |
|------|---------|
| `jq: command not found` | 安装 jq：`apt install jq` / `brew install jq` |
| `curl: command not found` | 安装 curl：`apt install curl` / `brew install curl` |
| `401 Unauthorized` | 检查 `EVOLINK_API_KEY`，在 [evolink.ai/dashboard](https://evolink.ai/dashboard?utm_source=github&utm_medium=readme&utm_campaign=video-generation) 确认 |
| `402 Payment Required` | 在 [evolink.ai/dashboard](https://evolink.ai/dashboard?utm_source=github&utm_medium=readme&utm_campaign=video-generation) 充值 |
| 内容被拦截 | 真实人脸受限 — 修改提示词 |
| 生成超时 | 视频生成需 30–180 秒，先试低分辨率 |
| 模型不可用 | 测试模型可能有限制 — 换用稳定模型 |

---

## 更多技能

更多 EvoLink 技能正在开发中。关注更新或 [提出需求](https://github.com/EvoLinkAI/video-generation-skill-for-openclaw/issues)。

---

## 从 ClawHub 下载

你也可以直接从 ClawHub 安装此技能：

👉 **[在 ClawHub 下载 →](https://clawhub.ai/EvoLinkAI/evolink-video)**

---

## 许可证

MIT

---

<p align="center">
  由 <a href="https://evolink.ai/signup?utm_source=github&utm_medium=readme&utm_campaign=video-generation-skill-for-openclaw"><strong>EvoLink</strong></a> 提供支持 — 统一 AI API 网关
</p>
