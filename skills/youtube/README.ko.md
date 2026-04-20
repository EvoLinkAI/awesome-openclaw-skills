# YouTube Assistant — AI 기반 YouTube 동영상 자막 추출 및 분석

> *더 똑똑하게, 더 짧게.*

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![EvoLink](https://img.shields.io/badge/Powered%20by-EvoLink-blue)](https://evolink.ai?utm_source=github&utm_medium=skill&utm_campaign=youtube)

YouTube 동영상 자막, 메타데이터, 채널 정보를 가져옵니다. AI 기반 콘텐츠 요약, 핵심 포인트 추출, 다중 동영상 비교 분석, 동영상 Q&A 기능을 제공합니다.

[EvoLink API](https://evolink.ai?utm_source=github&utm_medium=skill&utm_campaign=youtube)

**Language / 언어:**
[English](README.md) | [简体中文](README.zh-CN.md) | [日本語](README.ja.md) | [한국어](README.ko.md) | [Español](README.es.md) | [Français](README.fr.md) | [Deutsch](README.de.md) | [Türkçe](README.tr.md) | [Русский](README.ru.md)

## 설치

```bash
# yt-dlp 설치 (필수)
pip install yt-dlp

# Skill 설치
mkdir -p .claude/skills
git clone https://github.com/EvoLinkAI/youtube-skill-for-openclaw .claude/skills/youtube-assistant
export EVOLINK_API_KEY="your-key-here"
```

무료 API 키: [evolink.ai/signup](https://evolink.ai/signup?utm_source=github&utm_medium=skill&utm_campaign=youtube)

## 사용법

```bash
# 동영상 자막 가져오기
bash scripts/youtube.sh transcript "https://www.youtube.com/watch?v=VIDEO_ID"

# 동영상 메타데이터 가져오기
bash scripts/youtube.sh info "https://www.youtube.com/watch?v=VIDEO_ID"

# AI 동영상 요약
bash scripts/youtube.sh ai-summary "https://www.youtube.com/watch?v=VIDEO_ID"
```

### 명령어

| 명령어 | 설명 |
|--------|------|
| `transcript <URL> [--lang]` | 정제된 동영상 자막 가져오기 |
| `info <URL>` | 동영상 메타데이터 가져오기 |
| `channel <URL> [limit]` | 채널 최신 동영상 목록 |
| `search <query> [limit]` | YouTube 검색 |
| `ai-summary <URL>` | AI 동영상 요약 |
| `ai-takeaways <URL>` | 핵심 포인트 추출 |
| `ai-compare <URL1> <URL2>` | 다중 동영상 비교 분석 |
| `ai-ask <URL> <question>` | 동영상 내용에 대해 질문 |

## 특징

- 모든 YouTube 동영상에서 자막 추출 (수동 + 자동 생성)
- 동영상 메타데이터: 제목, 재생 시간, 조회수, 좋아요, 설명, 태그
- 채널 탐색 및 YouTube 검색
- AI 기반: 요약, 포인트 추출, 동영상 비교, Q&A
- 다국어 자막 지원
- EvoLink API 통합 (Claude 모델)

## 링크

- [ClawHub](https://clawhub.ai/evolinkai/youtube-assistant)
- [EvoLink API](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=youtube)
- [커뮤니티](https://discord.com/invite/5mGHfA24kn)

MIT License © [EvoLinkAI](https://github.com/EvoLinkAI)
