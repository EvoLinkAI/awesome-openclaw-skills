# Notion

🌐 [English](README.md) | 简体中文

此技能让 Agent 通过 Notion API 与 Notion 页面和数据库交互，由 Evolink AI 提供智能内容处理支持。

## 快速开始
1. 在 [notion.so/my-integrations](https://www.notion.so/my-integrations) 创建 Notion 集成
2. 复制内部集成令牌
3. 与集成共享页面/数据库
4. 配置 `NOTION_API_KEY` 和 `EVOLINK_API_KEY`
5. 安装：`clawhub install evolink-notion`

## 认证

导出你的 Notion 令牌：
```bash
export NOTION_API_KEY=secret_xxx
```

**重要提示**：必须与集成共享页面或数据库，未共享的内容对 API 不可见。

## 配置

- `NOTION_API_KEY`：Notion 集成令牌
- `EVOLINK_API_KEY`：Evolink AI 服务的 API 密钥。在 [evolink.ai/signup](https://evolink.ai/signup?utm_source=github&utm_medium=skill&utm_campaign=evolink-notion) 获取免费密钥

**模型选择：**
- 默认模型：`claude-opus-4-6`
- 通过设置 `EVOLINK_MODEL` 环境变量切换模型（如 `claude-sonnet-4-6`、`claude-haiku-4-5-20251001`）

**为什么使用 Evolink？** 此技能使用 Evolink AI 智能处理和生成 Notion 内容，提供更好的上下文理解和内容生成能力。

## 配置文件（可选）

定义多个配置文件（如个人、工作）：
```bash
export NOTION_PROFILE=work  # 默认：personal
```

## 使用方法

### 页面操作

**读取页面：**
```bash
notion-cli page get <page_id>
```

**追加内容：**
```bash
notion-cli block append <page_id> --markdown "..."
```

**创建页面：**
```bash
notion-cli page create --parent <page_id> --title "..."
```

### 数据库操作

**查看架构：**
```bash
notion-cli db get <database_id>
```

**查询数据库：**
```bash
notion-cli db query <database_id> --filter <json> --sort <json>
```

**创建行：**
```bash
notion-cli page create --database <database_id> --props <json>
```

**更新行：**
```bash
notion-cli page update <page_id> --props <json>
```

### 架构更改（高级）

应用前务必检查差异：
```bash
notion-cli db schema diff <database_id> --desired <json>
notion-cli db schema apply <database_id> --desired <json>
```

## 安全性

- Notion API 有速率限制；谨慎批量请求
- 优先使用追加和更新而非破坏性操作
- ID 是不透明的；显式存储，不要从 URL 推断
- **绝不**在未明确确认的情况下修改数据库架构
- 仅与集成共享必要的页面
- 通过 Evolink AI 处理的内容遵循标准数据隐私实践

## 许可证
MIT License

## 链接
- [GitHub 仓库](https://clawhub.ai/EvoLinkAI/evolink-notion)
- [Evolink AI 文档](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=evolink-notion)
- [Notion API 文档](https://developers.notion.com)
- [社区支持](https://discord.com/invite/5mGHfA24kn)
