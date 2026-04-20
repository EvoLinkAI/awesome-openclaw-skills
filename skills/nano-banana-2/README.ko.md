# Nano Banana 2 — OpenClaw용 AI 이미지 생성 스킬

<p align="center">
  <strong>Google Gemini 3.1 Flash 이미지 생성, 하나의 API 키 — 빠르고, 다재다능하고, 바로 사용 가능.</strong>
</p>

<p align="center">
  <a href="#이것은-무엇인가요">개요</a> •
  <a href="#설치">설치</a> •
  <a href="#api-key-받기">API Key</a> •
  <a href="#이미지-생성">생성</a> •
  <a href="https://evolink.ai/signup?utm_source=github&utm_medium=readme&utm_campaign=nano-banana-2-skill-for-openclaw">EvoLink</a>
</p>

<p align="center">
  <strong>🌐 Languages:</strong>
  <a href="README.md">English</a> |
  <a href="README.zh-CN.md">简体中文</a> |
  <a href="README.es.md">Español</a> |
  <a href="README.ja.md">日本語</a> |
  <a href="README.ko.md">한국어</a> |
  <a href="README.fr.md">Français</a> |
  <a href="README.de.md">Deutsch</a> |
  <a href="README.tr.md">Türkçe</a> |
  <a href="README.zh-TW.md">繁體中文</a>
</p>

---

## 이것은 무엇인가요?

[EvoLink](https://evolink.ai?utm_source=github&utm_medium=readme&utm_campaign=nano-banana-2-skill-for-openclaw) 제공 [OpenClaw](https://github.com/openclaw/openclaw) 스킬입니다. 하나의 스킬을 설치하면 AI 에이전트가 Google의 Gemini 3.1 Flash 이미지 모델에 액세스 — 단일 API를 통해 빠른 텍스트-투-이미지 생성 및 이미지 편집이 가능합니다.

| 스킬 | 설명 | 제공자 |
|------|------|--------|
| **Nano Banana 2** | 텍스트-투-이미지, 이미지 편집 | Google (Gemini 3.1 Flash) |

📚 **집중 뷰**: [evolink-image](https://clawhub.ai/EvoLinkAI/evolink-image). 19개 이미지 모델, 비디오 및 음악용으로 전체 스킬을 설치하세요.

---

## 설치

### 빠른 설치 (권장)

```bash
openclaw skills add https://github.com/EvoLinkAI/Nano-banana-2-skill-for-openclaw
```

완료! 스킬이 에이전트에서 사용 가능합니다.

### 수동 설치

```bash
git clone https://github.com/EvoLinkAI/Nano-banana-2-skill-for-openclaw.git
cd Nano-banana-2-skill-for-openclaw
openclaw skills add .
```

---

## API Key 받기

1. [evolink.ai](https://evolink.ai/signup?utm_source=github&utm_medium=readme&utm_campaign=nano-banana-2-skill-for-openclaw)에서 가입
2. Dashboard → API Keys로 이동
3. 새 API 키 생성
4. 환경 변수에 설정:

```bash
export EVOLINK_API_KEY=your_key_here
```

---

## 이미지 생성

### 기능

- **빠른 생성** — Gemini 3.1 Flash로
- **텍스트-투-이미지** — 장면을 설명하면 이미지가 생성됩니다
- **이미지 편집** — 기존 이미지 수정
- **구조화된 응답** — 이미지 URL 및 분석이 포함된 JSON

### 사용 예시

에이전트에게 말하기만 하면 됩니다:

> "우주에서 우주비행사 고양이의 이미지를 생성해줘, 사실적인 스타일로"

> "이 이미지를 편집해서 배경을 열 대 항구로 변경해줘"

> "카페를 위한 미니멀한 로고를 만들어줘"

---

## 라이선스

MIT

---

<p align="center">
  Powered by <a href="https://evolink.ai/signup?utm_source=github&utm_medium=readme&utm_campaign=nano-banana-2-skill-for-openclaw"><strong>EvoLink</strong></a> — Unified AI API Gateway
</p>
