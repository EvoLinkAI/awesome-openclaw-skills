# 搭子.skill — 이상적인 버디를 AI로 증류하기

> *모든 것이 버디가 될 수 있다.*

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![EvoLink](https://img.shields.io/badge/Powered%20by-EvoLink-blue)](https://evolink.ai?utm_source=github&utm_medium=skill&utm_campaign=buddy)

버디의 원자료(WeChat 채팅 기록, QQ 메시지, SNS 스크린샷, 사진)를 제공하거나 이상적인 버디를 순수하게 묘사하여 **진짜처럼 대화하는 AI Skill**을 생성합니다.

[EvoLink API](https://evolink.ai?utm_source=github&utm_medium=skill&utm_campaign=buddy) 제공

**Language / 언어:**
[English](README.md) | [简体中文](README.zh-CN.md) | [日本語](README.ja.md) | [한국어](README.ko.md) | [Español](README.es.md) | [Français](README.fr.md) | [Deutsch](README.de.md) | [Türkçe](README.tr.md) | [Русский](README.ru.md)

## 설치

```bash
mkdir -p .claude/skills
git clone https://github.com/EvoLinkAI/buddy-skill-for-openclaw .claude/skills/create-buddy
export EVOLINK_API_KEY="your-key-here"
```

[evolink.ai/signup](https://evolink.ai/signup?utm_source=github&utm_medium=skill&utm_campaign=buddy)에서 무료 API 키 발급

## 사용법

Claude Code에서 `/create-buddy` 입력. 3가지 질문에 답하고 자료를 가져오면(또는 순수 상상) 완성.

### 명령어

| 명령어 | 설명 |
|--------|------|
| `/create-buddy` | 새 버디 생성 |
| `/list-buddies` | 전체 버디 목록 |
| `/{slug}` | 버디와 채팅 |
| `/{slug}-vibe` | 추억 모드 |
| `/update-buddy {slug}` | 기억 추가 |
| `/delete-buddy {slug}` | 삭제 |

## 특징

- 다양한 데이터 소스: WeChat, QQ, 스크린샷, 사진, 순수 상상
- 버디 유형: 밥친구, 공부친구, 게임친구, 운동친구 등
- 이중 레이어 아키텍처: Vibe Memory + Persona
- 진화: 기억 추가, 응답 수정, 버전 관리
- AI 분석: EvoLink API (Claude 모델)

## 링크

- [ClawHub](https://clawhub.ai/evolinkai/buddy-skill-creator)
- [EvoLink API](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=buddy)
- [커뮤니티](https://discord.com/invite/5mGHfA24kn)

MIT License © [EvoLinkAI](https://github.com/EvoLinkAI)
