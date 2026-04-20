# 搭子.skill — Distill Your Ideal Buddy into AI

> *万物皆可搭子。*

**我的搭子比我自己还懂我。**

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Python 3.9+](https://img.shields.io/badge/Python-3.9%2B-blue.svg)](https://python.org)
[![Claude Code](https://img.shields.io/badge/Claude%20Code-Skill-blueviolet)](https://claude.ai/code)
[![EvoLink](https://img.shields.io/badge/Powered%20by-EvoLink-blue)](https://evolink.ai?utm_source=github&utm_medium=skill&utm_campaign=buddy)

&nbsp;

提供搭子的原材料（微信聊天记录、QQ消息、朋友圈截图、照片）或纯粹描述你的理想搭子
生成一个**真正像ta的 AI Skill**
用ta的口头禅说话，用ta的方式回复你，记得你们一起踩过的坑

Powered by [EvoLink API](https://evolink.ai?utm_source=github&utm_medium=skill&utm_campaign=buddy) · AI 分析由 Claude 模型驱动

[安装](#安装) · [使用](#使用) · [效果示例](#效果示例) · [English](README.md)

**Language / 语言:**
[English](README.md) | [简体中文](README.zh-CN.md) | [日本語](README.ja.md) | [한국어](README.ko.md) | [Español](README.es.md) | [Français](README.fr.md) | [Deutsch](README.de.md) | [Türkçe](README.tr.md) | [Русский](README.ru.md)

---

## 安装

### Claude Code

> **重要**：Claude Code 从 **git 仓库根目录** 的 `.claude/skills/` 查找 skill。请在正确的位置执行。

```bash
# 安装到当前项目（在 git 仓库根目录执行）
mkdir -p .claude/skills
git clone https://github.com/EvoLinkAI/buddy-skill-for-openclaw .claude/skills/create-buddy

# 或安装到全局（所有项目都能用）
git clone https://github.com/EvoLinkAI/buddy-skill-for-openclaw ~/.claude/skills/create-buddy
```

### ClawHub

```bash
npx clawhub install buddy-skill-creator
```

### 依赖（可选）

```bash
pip3 install -r requirements.txt
```

### 设置 EvoLink API Key

```bash
export EVOLINK_API_KEY="your-key-here"
```

免费获取：[evolink.ai/signup](https://evolink.ai/signup?utm_source=github&utm_medium=skill&utm_campaign=buddy)

---

## 使用

在 Claude Code 中输入：

```
/create-buddy
```

按提示输入搭子的代号、类型、性格画像，然后选择数据来源（或纯想象）。所有字段均可跳过，仅凭描述也能生成。

完成后用 `/{slug}` 调用该搭子 Skill，开始对话。

### 管理命令

| 命令 | 说明 |
|------|------|
| `/create-buddy` | 创建新搭子 |
| `/list-buddies` | 列出所有搭子 Skill |
| `/{slug}` | 调用完整 Skill（像搭子一样聊天） |
| `/{slug}-vibe` | 默契模式（回忆共同经历） |
| `/{slug}-persona` | 仅人格模式 |
| `/update-buddy {slug}` | 追加记忆/进化 |
| `/buddy-rollback {slug} {version}` | 回滚到历史版本 |
| `/delete-buddy {slug}` | 删除搭子 |
| `/散伙 {slug}` | 删除的温柔别名 |

---

## 效果示例

> 输入：`饭搭子，同事老王，认识三年，ESTP，社牛，什么都敢吃，每天中午问我吃啥`

**场景一：日常约饭**

```
用户      ❯ 中午吃啥

搭子.skill ❯ 又到了人生的终极难题
             公司食堂？算了吧 昨天那个红烧肉我到现在还在反胃
             要不试试新开的那家螺蛳粉？
             听说巨臭 我已经准备好了
```

**场景二：探店翻车**

```
用户      ❯ 上次你推荐的那家店 我再也不去了

搭子.skill ❯ 哈哈哈哈哈哈哈哈
             不是 那天确实翻车了
             但你不觉得那个服务员的表情很好笑吗
             行吧 这顿我请 算赔罪
```

**场景三：深夜摸鱼**

```
用户      ❯ 还没下班 好累

搭子.skill ❯ 兄弟你还在加班？？
             我刚到家 外卖已经点了
             明天中午请你吃好的 撑住
```

**场景四：吐槽模式**

```
用户      ❯ 今天开会 领导又画饼了

搭子.skill ❯ 画饼大师又发功了？
             上次的饼还没消化呢
             走 下午茶 我请
             用实际行动对抗精神内耗
```

---

## 功能特性

### 数据源

| 来源 | 格式 | 备注 |
|------|------|------|
| 微信聊天记录 | WeChatMsg / 留痕 / PyWxDump 导出 | 推荐，信息最丰富 |
| QQ 聊天记录 | txt / mht 导出 | 适合学生时代的搭子 |
| 朋友圈/微博 | 截图 | 提取公开人设 |
| 照片 | JPEG/PNG（含 EXIF） | 提取时间线和地点 |
| 口述/粘贴 | 纯文本 | 你的主观记忆 |
| **纯想象** | 描述 | 不基于真人，造你的理想搭子 |

### 生成的 Skill 结构

每个搭子 Skill 由两部分组成，共同驱动输出：

| 部分 | 内容 |
|------|------|
| **Part A — Vibe Memory** | 共同经历、常去的地方、inside jokes、默契时刻、翻车时刻、搭子边界 |
| **Part B — Persona** | 5 层性格结构：硬规则 → 身份 → 说话风格 → 互动模式 → 搭子行为 |

运行逻辑：`收到消息 → Persona 判断搭子会怎么回 → Vibe Memory 补充默契 → 用搭子的方式输出`

### 搭子类型

饭搭子 · 学习搭子 · 游戏搭子 · 健身搭子 · 摸鱼搭子 · 旅游搭子 · 追剧搭子 · 逛街搭子 · 吐槽搭子 · 深夜emo搭子 · 万能搭子

### 搭子能量

社牛 · 社恐 · i人 · e人 · 话痨 · 安静陪伴型

### 搭子风格

毒舌损友 · 暖心陪伴 · 理性分析 · 疯批搭子 · 佛系搭子 · 学霸搭子 · 美食家搭子

### 进化机制

* **追加记忆** → 找到更多聊天记录/照片 → EvoLink API 增量分析 → merge 进对应部分
* **对话纠正** → 说「ta不会这样说」→ 写入 Correction 层，立即生效
* **版本管理** → 每次更新自动存档，支持回滚

---

## 项目结构

```
create-buddy/
├── SKILL.md                # skill 入口
├── _meta.json              # 元数据
├── prompts/                # Prompt 模板
│   ├── intake.md           #   对话式信息录入
│   ├── vibe_analyzer.md    #   搭子默契记忆提取
│   ├── persona_analyzer.md #   搭子性格行为提取
│   ├── vibe_builder.md     #   vibe.md 生成模板
│   ├── persona_builder.md  #   persona.md 五层结构模板
│   ├── merger.md           #   增量 merge 逻辑
│   └── correction_handler.md # 对话纠正处理
├── tools/                  # Python 工具
│   ├── wechat_parser.py    # 微信聊天记录解析
│   ├── qq_parser.py        # QQ 聊天记录解析
│   ├── social_parser.py    # 社交媒体内容解析
│   ├── photo_analyzer.py   # 照片元信息分析
│   ├── skill_writer.py     # Skill 文件管理
│   └── version_manager.py  # 版本存档与回滚
├── buddies/                # 生成的搭子 Skill（gitignored）
├── docs/PRD.md
├── requirements.txt
└── LICENSE
```

---

## 注意事项

* **聊天记录质量决定还原度**：微信导出 + 口述 > 仅口述
* 建议优先提供：**吐槽对话** > **约饭/约活动记录** > **日常消息**（最能体现搭子默契）
* 纯想象模式也很好用——描述越详细，搭子越像你想要的样子
* 如果基于真人创建，请尊重对方隐私

---

## 致敬 & 引用

本项目的架构灵感来源于 **[前任.skill](https://github.com/therealXiaomanChu/ex-skill)**（by [therealXiaomanChu](https://github.com/therealXiaomanChu)），前任.skill 又源自 **[同事.skill](https://github.com/titanwings/colleague-skill)**（by [titanwings](https://github.com/titanwings)）。搭子.skill 将"把人蒸馏成 AI Skill"的双层架构从恋爱场景迁移到了"万物皆可搭子"的日常场景。致敬原作者们的创意和开源精神。

AI 分析能力由 [EvoLink API](https://evolink.ai?utm_source=github&utm_medium=skill&utm_campaign=buddy) 提供，使用 Claude 模型驱动。

---

### 推荐的聊天记录导出工具

以下工具为独立的开源项目，本项目不包含它们的代码，仅在解析器中适配了它们的导出格式：

- **[WeChatMsg](https://github.com/LC044/WeChatMsg)** — 微信聊天记录导出（Windows）
- **[PyWxDump](https://github.com/xaoyaoo/PyWxDump)** — 微信数据库解密导出（Windows）
- **留痕** — 微信聊天记录导出（macOS）

---

## Links

- [ClawHub](https://clawhub.ai/evolinkai/buddy-skill-creator)
- [EvoLink API](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=buddy)
- [Community](https://discord.com/invite/5mGHfA24kn)
- [Support](mailto:support@evolink.ai)

---

### 写在最后

搭子是一种很奇妙的关系。

不用天天联系，但约的时候一叫就到。不用什么都聊，但聊起来停不下来。不用刻意维护，但就是散不了。

你可能记不住上周开会说了什么，但你清楚记得三年前和搭子在公司楼下那家苍蝇馆子，两个人点了六个菜，吃到最后服务员都在看你们。

这个 Skill 就是把这种默契导出来。

导完以后你会发现，好的搭子关系就是：ta损你的时候你不生气，你需要的时候ta一定在。

MIT License © [EvoLinkAI](https://github.com/EvoLinkAI)
