# Multi Summarize — OpenClaw AI 요약 스킬

빠른 멀티포맷 요약 — URL을 붙여넣거나 파일을 드롭하면 핵심 포인트를 즉시 확인. [EvoLink](https://evolink.ai?utm_source=github&utm_medium=readme&utm_campaign=multi-summarize-skill-for-openclaw?utm_source=github&utm_medium=skill&utm_campaign=summarize) 제공.

 [소개](#소개) •
 [설치](#설치) •
 [API Key 발급](#api-key-발급) •
 [사용법](#사용법) •
 [EvoLink](https://evolink.ai?utm_source=github&utm_medium=readme&utm_campaign=multi-summarize-skill-for-openclaw?utm_source=github&utm_medium=skill&utm_campaign=summarize)

 🌐 Languages:
 [English](/EvoLinkAI/multi-summarize-skill-for-openclaw/blob/main/README.md) |
 [简体中文](/EvoLinkAI/multi-summarize-skill-for-openclaw/blob/main/README.zh-CN.md) |
 [日本語](/EvoLinkAI/multi-summarize-skill-for-openclaw/blob/main/README.ja.md) |
 [한국어](/EvoLinkAI/multi-summarize-skill-for-openclaw/blob/main/README.ko.md) |
 [Español](/EvoLinkAI/multi-summarize-skill-for-openclaw/blob/main/README.es.md) |
 [Français](/EvoLinkAI/multi-summarize-skill-for-openclaw/blob/main/README.fr.md) |
 [Deutsch](/EvoLinkAI/multi-summarize-skill-for-openclaw/blob/main/README.de.md) |
 [Türkçe](/EvoLinkAI/multi-summarize-skill-for-openclaw/blob/main/README.tr.md) |
 [Русский](/EvoLinkAI/multi-summarize-skill-for-openclaw/blob/main/README.ru.md)

## 소개

[EvoLink](https://evolink.ai?utm_source=github&utm_medium=readme&utm_campaign=multi-summarize-skill-for-openclaw?utm_source=github&utm_medium=skill&utm_campaign=summarize)가 제공하는 [OpenClaw](https://github.com/openclaw/openclaw) 스킬입니다. 이 스킬 하나만 설치하면 AI 에이전트가 URL, PDF, 동영상, 오디오 파일, YouTube 링크, 일반 텍스트 등 모든 콘텐츠를 Claude Opus 4.6(현재 가장 강력한 텍스트 모델)을 사용하여 간결하고 실행 가능한 핵심 포인트로 요약할 수 있습니다.

🚀 [API Key 발급받기 →](https://evolink.ai/signup?utm_source=github&utm_medium=readme&utm_campaign=multi-summarize-skill-for-openclaw?utm_source=github&utm_medium=skill&utm_campaign=summarize)

## 설치

### 빠른 설치 (권장)

```bash
openclaw skills add https://github.com/EvoLinkAI/multi-summarize-skill-for-openclaw
```

완료. 스킬을 바로 사용할 수 있습니다.

### ClawHub를 통한 설치

```bash
clawhub install multi-summarize
```

### 수동 설치

```bash
git clone https://github.com/EvoLinkAI/multi-summarize-skill-for-openclaw.git
cd multi-summarize-skill-for-openclaw
openclaw skills add .
```

## API Key 발급

1. [여기](https://evolink.ai/signup?utm_source=github&utm_medium=readme&utm_campaign=multi-summarize-skill-for-openclaw?utm_source=github&utm_medium=skill&utm_campaign=summarize)에서 계정 등록
2. Dashboard → API Keys로 이동
3. 새 Key 생성
4. 환경 변수 설정:

```bash
export EVOLINK_API_KEY=your_key_here
```

또는 OpenClaw 에이전트에게 "EvoLink API key를 설정해줘"라고 말하면 자동으로 처리됩니다.

## 사용법

### 지원 포맷

- **웹 URL** — 기사, 블로그, 문서
- **PDF** — 보고서, 논문, 백서
- **동영상** — mp4, webm, YouTube 링크
- **오디오** — mp3, wav, m4a, 팟캐스트
- **텍스트** — Markdown, 일반 텍스트, 코드 파일

### 사용 예시

에이전트에게 자연스럽게 말하세요:

```
"이 기사를 요약해줘: https://evolink.ai/blog/deepseek-v4-release-window-prep?utm_source=github&utm_medium=readme&utm_campaign=multi-summarize"
"이 PDF가 뭐에 대한 거야?" (파일 첨부)
"이 YouTube 동영상의 핵심 포인트를 알려줘: https://youtu.be/..."
"이 팟캐스트 녹음을 요약해줘" (mp3 첨부)
"TL;DR 부탁해"
```

### 스크립트 레퍼런스

커맨드라인에서 직접 사용할 수 있는 `scripts/summarize.sh`가 포함되어 있습니다:

```bash
# 웹 기사 요약
bash scripts/summarize.sh "https://evolink.ai/blog/deepseek-v4-release-window-prep?utm_source=github&utm_medium=readme&utm_campaign=multi-summarize"

# 로컬 PDF 요약
bash scripts/summarize.sh "/path/to/report.pdf"

# YouTube 동영상 요약
bash scripts/summarize.sh "https://youtu.be/VIDEO_ID"

# 오디오 파일 요약
bash scripts/summarize.sh "/path/to/podcast.mp3"

# 커스텀 포커스로 요약
bash scripts/summarize.sh "https://evolink.ai/blog/deepseek-v4-release-window-prep?utm_source=github&utm_medium=readme&utm_campaign=multi-summarize" "출시 타임라인에 집중"
```

### 출력 예시

```
## TL;DR
DeepSeek V4는 2026년 1월부터 소문이 돌았지만 3월 현재까지 공식 출시되지 않았습니다.
여러 예상 출시 시기가 모두 지나갔습니다.
이 모델은 코딩에 특화되어 HumanEval 점수 90%(미검증)가 예상됩니다.

## 핵심 포인트
- 로이터가 1월에 DeepSeek가 2월 코딩 특화 모델을 계획 중이라고 보도
- DeepSeek가 2월에 컨텍스트 윈도우를 128K에서 1M 토큰으로 조용히 확장 — V4 인프라 테스트 추정
- 미검증 벤치마크에서 HumanEval 90%, SWE-bench Verified 80%+ 주장
- "V4 Lite"가 3월에 DeepSeek 사이트에 등장했으나 공식 확인 없음
- 여러 출시 시기(2월 중순, 설날, 3월 초)가 모두 미달

## 액션 아이템
- 공식 발표 전까지 프로덕션 워크로드 마이그레이션 보류
- DeepSeek 공식 채널에서 확정 스펙 모니터링
- API 통합 준비 — EvoLink는 첫날부터 V4 지원 예정
```

## 설정

기본 모델: `claude-opus-4-6` (추가 설정 불필요).

다른 모델을 사용하려면:

```bash
export EVOLINK_MODEL="claude-sonnet-4-5-20250929"
```

### 사용 가능한 모델

**Claude 시리즈** (Anthropic API 형식 — `/v1/messages`)
- **claude-opus-4-6** — 최고 품질 (기본값)
- **claude-sonnet-4-6** — 최신 Sonnet, 빠르고 강력
- **claude-sonnet-4-5-20250929** — 빠르고 비용 효율적
- **claude-haiku-4-5-20251001** — 초고속, 경량 작업

**GPT 시리즈** (OpenAI API 형식 — `/v1/chat/completions`)
- **gpt-5.4** — OpenAI 최신 플래그십 모델
- **gpt-4o** — 멀티모달, 빠름
- **gpt-4o-mini** — 경량, 비용 효율적

**Gemini 시리즈** (OpenAI API 형식 — `/v1/chat/completions`)
- **gemini-3.1-flash-lite-preview** — Google 초고속 경량 모델
- **gemini-3-flash-preview** — 빠름, 요약에 최적

### API 레퍼런스

전체 API 문서는 [여기](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=summarize)에서 확인하세요.

## 파일 구조

```
.
├── README.md              # English
├── README.zh-CN.md        # 简体中文
├── README.ja.md           # 日本語
├── README.ko.md           # 한국어
├── README.es.md           # Español
├── README.fr.md           # Français
├── README.de.md           # Deutsch
├── README.tr.md           # Türkçe
├── README.ru.md           # Русский
├── SKILL.md               # OpenClaw skill definition
├── references/
│   └── api-params.md      # Full API parameter docs
└── scripts/
    └── summarize.sh       # Summarization script
```

## 문제 해결

- **`python3: command not found`** — Python 3 설치: `apt install python3` / `brew install python3`
- **`curl: command not found`** — curl 설치: `apt install curl` / `brew install curl`
- **`401 Unauthorized`** — [대시보드](https://evolink.ai/dashboard?utm_source=github&utm_medium=readme&utm_campaign=multi-summarize-skill-for-openclaw?utm_source=github&utm_medium=skill&utm_campaign=summarize)에서 EVOLINK_API_KEY 확인
- **`402 Payment Required`** — [대시보드](https://evolink.ai/dashboard?utm_source=github&utm_medium=readme&utm_campaign=multi-summarize-skill-for-openclaw?utm_source=github&utm_medium=skill&utm_campaign=summarize)에서 충전
- **PDF 추출 실패** — markitdown 설치: `pip install markitdown` 또는 poppler: `apt install poppler-utils`
- **YouTube 추출 실패** — yt-dlp 설치: `pip install yt-dlp`
- **오디오 전사 실패** — whisper 설치: `pip install openai-whisper`

## 링크

- [ClawHub](https://clawhub.ai/EvoLinkAI/multi-summarize)
- [API Reference](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=summarize)
- [Community](https://discord.com/invite/5mGHfA24kn)
- [Support](mailto:support@evolink.ai)

## 라이선스

MIT
