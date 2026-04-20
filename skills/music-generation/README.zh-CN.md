# Evolink Music — AI 音乐生成 OpenClaw 技能包

<p align="center">
  <strong>5 个音乐模型，一个 API Key — Suno v4、v4.5、v5。文字生成音乐、自定义歌词、纯音乐。</strong>
</p>

<p align="center">
  <a href="#这是什么">介绍</a> •
  <a href="#安装">安装</a> •
  <a href="#获取-api-key">API Key</a> •
  <a href="#音乐生成">生成</a> •
  <a href="https://evolink.ai/signup?utm_source=github&utm_medium=readme&utm_campaign=music-generation-skill-for-openclaw">EvoLink</a>
</p>

<p align="center">
  <strong>🌐 Languages：</strong>
  <a href="README.md">English</a> |
  <a href="README.zh-CN.md">简体中文</a>
</p>

---

## 这是什么？

一套基于 [EvoLink](https://evolink.ai?utm_source=github&utm_medium=readme&utm_campaign=music-generation) 的 [OpenClaw](https://github.com/openclaw/openclaw) 技能包。安装一个技能，你的 AI 代理就变成一个音乐工作室 — **5 个 Suno 模型**，生成歌曲、纯音乐和自定义作曲，全部通过一个 API 搞定。

| 技能 | 描述 | 模型 |
|------|------|------|
| **Evolink Music** | 文字生成音乐、自定义歌词、纯音乐、人声控制 | Suno v4、v4.5、v4.5plus、v4.5all、v5 |

> 这是 [evolink-media](https://clawhub.ai/EvoLinkAI/evolink-media) 的音乐子集。安装完整版可获得视频和图片生成能力。

🚀 **[立即体验所有模型 →](https://evolink.ai/models?utm_source=github&utm_medium=readme&utm_campaign=music-generation)**

更多技能即将推出。

---

## 安装

### 快速安装（推荐）

```bash
openclaw skills add https://github.com/EvoLinkAI/music-generation-skill-for-openclaw
```

完事。技能已可供代理使用。

### 手动安装

```bash
git clone https://github.com/EvoLinkAI/music-generation-skill-for-openclaw.git
cd music-generation-skill-for-openclaw
openclaw skills add .
```

---

## 获取 API Key

1. 在 [evolink.ai](https://evolink.ai/signup?utm_source=github&utm_medium=readme&utm_campaign=music-generation-skill-for-openclaw)utm_medium=readme[evolink.ai](https://evolink.ai/signup?utm_source=github&utm_medium=readme&utm_campaign=music-generation-skill-for-openclaw)utm_campaign=music-generation-skill-for-openclaw) 注册
2. 进入 Dashboard → API Keys
3. 创建新 Key
4. 设置环境变量：

```bash
export EVOLINK_API_KEY=your_key_here
```

或者直接告诉你的 OpenClaw 代理：*"设置我的 EvoLink API key 为 ..."* — 它会搞定。

---

## 音乐生成

通过与 OpenClaw 代理自然对话来生成 AI 音乐和歌曲。

### 两种模式

#### 简单模式（`custom_mode: false`）

描述你想要的 — AI 自动写歌词、选风格。

> "生成一首关于夏日公路旅行的欢快流行歌"

> "创建一段 2 分钟的放松 lo-fi 纯音乐"

#### 自定义模式（`custom_mode: true`）

你来掌控一切：歌词、风格、标题、人声性别。

> "写一首摇滚抒情曲，标题叫'午夜雨'，歌词：
> [Verse] 走在空旷的街头…
> [Chorus] 午夜的雨不停地落下…"

> "创建一段爵士纯音乐，smooth jazz 风格，120 BPM，3 分钟"

### 能力

- **文字生成音乐** — 描述风格、情绪或场景，生成歌曲
- **自定义歌词** — 用 `[Verse]`、`[Chorus]`、`[Bridge]` 标签写歌词
- **纯音乐** — 无人声纯音乐
- **人声控制** — 选择男声或女声
- **风格标签** — 控制曲风、情绪、节奏
- **排除标签** — 排除不想要的风格
- **灵活时长** — 30–240 秒（视模型而定）

### 模型（5 个，均为 BETA）

| 模型 | 质量 | 最长时长 | 说明 |
|------|------|---------|------|
| `suno-v4` *（默认）* | 良好 | 120s | 均衡、经济 |
| `suno-v4.5` | 更好 | 240s | 风格控制 |
| `suno-v4.5plus` | 更好 | 240s | 扩展功能 |
| `suno-v4.5all` | 更好 | 240s | 全部 v4.5 功能 |
| `suno-v5` | 最佳 | 240s | 录音室级输出 |

### MCP 工具

| 工具 | 用途 |
|------|------|
| `generate_music` | 创建 AI 音乐或歌曲 |
| `upload_file` | 上传音频文件用于参考或续写 |
| `delete_file` | 删除已上传文件释放配额 |
| `list_files` | 查看已上传文件和存储配额 |
| `check_task` | 轮询生成进度并获取结果链接 |
| `list_models` | 浏览可用音乐模型 |
| `estimate_cost` | 查询模型定价 |

### 参数

| 参数 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| `prompt` | string | — | 描述或歌词（必填） |
| `custom_mode` | boolean | — | 简单/自定义模式（必填） |
| `instrumental` | boolean | — | 纯音乐或带人声（必填） |
| `model` | enum | `suno-v4` | 使用的模型 |
| `duration` | integer | 模型决定 | 目标时长（30–240 秒） |
| `style` | string | — | 曲风/情绪/节奏标签（自定义模式） |
| `title` | string | — | 歌曲标题（自定义模式，最长 80 字符） |
| `negative_tags` | string | — | 排除的风格 |
| `vocal_gender` | enum | — | `m` 或 `f`（自定义模式） |

---

## 文件上传

上传音频文件用于音乐续写或混音：

1. 调用 `upload_file`，传入 `file_path`、`base64_data` 或 `file_url` → 获取 `file_url`（同步）

**支持格式：** MP3、WAV、FLAC、AAC、OGG、M4A 等。最大 **100MB**。文件 **72 小时**后过期。配额：100 个文件（默认）/ 500 个（VIP）。

---

## 工作流

1. 设置 `custom_mode` + `instrumental`（均为必填，无默认值）
2. 调用 `generate_music` → 获取 `task_id`
3. 每 5–10 秒轮询 `check_task` 直到 `completed`
4. 下载结果链接（24 小时内有效）

---

## 脚本参考

技能包含 `scripts/evolink-music-gen.sh` 供命令行直接使用：

```bash
# 简单模式 — 描述并生成
./scripts/evolink-music-gen.sh "欢快的夏日流行歌" --vocal

# 简单纯音乐
./scripts/evolink-music-gen.sh "放松的 lo-fi 节拍" --instrumental

# 自定义模式 + 歌词
./scripts/evolink-music-gen.sh "[Verse] 走在路上… [Chorus] 我们再出发…" \
  --custom --title "在路上" --style "pop rock, upbeat" --vocal --gender f

# Suno v5 最佳质量
./scripts/evolink-music-gen.sh "史诗级管弦乐战斗主题曲" --instrumental --model suno-v5 --duration 180

# 排除风格
./scripts/evolink-music-gen.sh "一段 chill 电子音乐" --instrumental --negative "heavy metal, screaming"
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
    └── evolink-music-gen.sh     # 音乐生成脚本
```

---

## 常见问题

| 问题 | 解决方案 |
|------|---------|
| `jq: command not found` | 安装 jq：`apt install jq` / `brew install jq` |
| `curl: command not found` | 安装 curl：`apt install curl` / `brew install curl` |
| `401 Unauthorized` | 检查 `EVOLINK_API_KEY`，在 [evolink.ai/dashboard](https://evolink.ai/dashboard?utm_source=github&utm_medium=readme&utm_campaign=music-generation) 确认 |
| `402 Payment Required` | 在 [evolink.ai/dashboard](https://evolink.ai/dashboard?utm_source=github&utm_medium=readme&utm_campaign=music-generation) 充值 |
| 内容被拦截 | 部分歌词内容受限 — 修改提示词 |
| 生成超时 | 音乐生成需 30–120 秒，先试较短时长 |
| 缺少必填参数 | `custom_mode` 和 `instrumental` 都是必填项 — 需显式设置 |

---

## 更多技能

更多 EvoLink 技能正在开发中。关注更新或 [提出需求](https://github.com/EvoLinkAI/music-generation-skill-for-openclaw/issues)。

---

## 从 ClawHub 下载

你也可以直接从 ClawHub 安装此技能：

👉 **[在 ClawHub 下载 →](https://clawhub.ai/EvoLinkAI/evolink-music)**

---

## 许可证

MIT

---

<p align="center">
  由 <a href="https://evolink.ai/signup?utm_source=github&utm_medium=readme&utm_campaign=music-generation-skill-for-openclaw"><strong>EvoLink</strong></a> 提供支持 — 统一 AI API 网关
</p>
