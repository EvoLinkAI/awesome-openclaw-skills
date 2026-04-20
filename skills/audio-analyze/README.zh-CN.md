# audio-analyze-skill-for-openclaw

使用 Gemini 3.1 Pro 准确地转录并分析音频/视频内容。[由 Evolink.ai 提供支持](https://evolink.ai/?utm_source=github&utm_medium=skill&utm_campaign=audio-analyze)

🌐 [English](README.md) | [日本語](README.ja.md) | [简体中文](README.zh-CN.md) | [한국어](README.ko.md) | [Español](README.es.md) | [Français](README.fr.md) | [Deutsch](README.de.md) | [Türkçe](README.tr.md) | [Русский](README.ru.md)

## 功能简介

使用 Gemini 3.1 Pro 自动转录并分析您的音频/视频文件。[获取免费 API Key →](https://evolink.ai/signup?utm_source=github&utm_medium=skill&utm_campaign=audio-analyze)

## 安装

### ClawHub 安装 (推荐)
```bash
openclaw skills add https://github.com/EvoLinkAI/audio-analyze-skill-for-openclaw
```

### 手动安装
```bash
git clone https://github.com/EvoLinkAI/audio-analyze-skill-for-openclaw
cd audio-analyze-skill-for-openclaw
pip install -r requirements.txt
```

## 配置

| 变量 | 说明 | 默认值 |
| :--- | :--- | :--- |
| `EVOLINK_API_KEY` | Evolink API Key | (必填) |
| `EVOLINK_MODEL` | 转录模型 | gemini-3.1-pro-preview-customtools |

*详细 API 配置和模型支持，请参考 [EvoLink API 文档](https://docs.evolink.ai/en/api-manual/language-series/gemini-3.1-pro-preview-customtools/openai-sdk/openai-sdk-quickstart?utm_source=github&utm_medium=skill&utm_campaign=audio-analyze)。*

## 使用说明

### 基础用法
```bash
export EVOLINK_API_KEY="您的密钥"
./scripts/transcribe.sh audio.mp3
```

### 高级用法
```bash
./scripts/transcribe.sh audio.mp3 --diarize --lang ja
```

### 输出示例
* **TL;DR**: 音频为测试用样本。
* **Key Takeaways**: 音质保真度高，频率响应清晰。
* **Action Items**: 上传至生产环境进行最终测试。

## 模型支持

- **Gemini 系列** (OpenAI API — `/v1/chat/completions`)

## 目录结构
```
.
├── README.md
├── SKILL.md
├── _meta.json
├── scripts/
│   └── transcribe.sh
└── references/
    └── api-params.md
```

## 故障排除

- **Argument list too long**: 处理大型音频时请使用临时文件。
- **API Key Error**: 请确保 `EVOLINK_API_KEY` 已设置。

## 相关链接

- [ClawHub](https://clawhub.ai/EvoLinkAI/audio-analyze)
- [API 参考](https://docs.evolink.ai/en/api-manual/language-series/gemini-3.1-pro-preview-customtools/openai-sdk/openai-sdk-quickstart?utm_source=github&utm_medium=skill&utm_campaign=audio-analyze)
- [社区](https://discord.com/invite/5mGHfA24kn)
- [技术支持](mailto:support@evolink.ai)

## 许可
MIT
