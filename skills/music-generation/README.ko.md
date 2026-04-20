# Evolink Music — OpenClaw용 AI 음악 생성 스킬

<p align="center">
  <strong>5개 음악 모델, 하나의 API 키 — Suno v4, v4.5, v5. 텍스트-투-뮤직, 커스텀 가사, 인스트루먼탈.</strong>
</p>

<p align="center">
  <a href="#이것은-무엇인가요">개요</a> •
  <a href="#설치">설치</a> •
  <a href="#api-key-받기">API Key</a> •
  <a href="#음악-생성">생성</a> •
  <a href="https://evolink.ai/signup?utm_source=github&utm_medium=readme&utm_campaign=music-generation-skill-for-openclaw">EvoLink</a>
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

[EvoLink](https://evolink.ai?utm_source=github&utm_medium=readme&utm_campaign=music-generation) 제공 [OpenClaw](https://github.com/openclaw/openclaw) 스킬입니다. 하나의 스킬을 설치하면 AI 에이전트가 음악 스튜디오로 변신 — **5개의 Suno 모델**로 노래, 인스트루먼탈, 맞춤 작곡을 생성할 수 있습니다. 모두 단일 API로.

| 스킬 | 설명 | 모델 |
|------|------|------|
| **Evolink Music** | 텍스트-투-뮤직, 커스텀 가사, 인스트루먼탈, 보컬 컨트롤 | Suno v4, v4.5, v4.5plus, v4.5all, v5 |

📚 **완전한 가이드**: 스타일, 장르, 분위기, 구조를 완전히 제어하는 음악 생성.

---

## 설치

### 빠른 설치 (권장)

```bash
openclaw skills add https://github.com/EvoLinkAI/music-generation-skill-for-openclaw
```

완료! 스킬이 에이전트에서 사용 가능합니다.

### 수동 설치

```bash
git clone https://github.com/EvoLinkAI/music-generation-skill-for-openclaw.git
cd music-generation-skill-for-openclaw
openclaw skills add .
```

---

## API Key 받기

1. [evolink.ai](https://evolink.ai/signup?utm_source=github&utm_medium=readme&utm_campaign=music-generation-skill-for-openclaw)utm_medium=readme[evolink.ai](https://evolink.ai/signup?utm_source=github&utm_medium=readme&utm_campaign=music-generation-skill-for-openclaw)utm_campaign=music-generation-skill-for-openclaw)에서 가입
2. Dashboard → API Keys로 이동
3. 새 API key 생성
4. 환경 변수에 설정:

```bash
export EVOLINK_API_KEY=your_key_here
```

---

## 음악 생성

### 사용 가능한 모델

| 모델 | 설명 | 사용 사례 |
|------|------|----------|
| **suno-v4** | 안정 버전, 빠른 생성 | 팝, 일렉트로닉, 록 |
| **suno-v4.5** | 더 높은 품질, 더 풍부한 디테일 | 프로페셔널 제작 |
| **suno-v4.5plus** | 최고 품질, 프리미엄 오디오 | 상업적 릴리스 |
| **suno-v4.5all** | 완전한 다용도성 | 모든 장르 |
| **suno-v5** | 최신 버전, 고급 기능 | 크리에이티브 실험 |

### 기능

- **5개 모델** — 다양한 기능
- **스타일 컨트롤** — 장르, 분위기, 템포, 강도
- **커스텀 가사** — 직접 작성하거나 AI 생성
- **인스트루먼탈 모드** — 보컬 없는 음악
- **보컬 컨트롤** — 보이스 타입과 음역 조정

### 사용 예시

에이전트에게 말하기만 하면 됩니다:

> "어쿠스틱 기타로 여름에 대한 경쾌한 팝송 생성해줘"

> "편안한 분위기의 재즈 인스트루먼탈, 3분간 만들어줘"

> "로드트립에 대한 커스텀 가사가 있는 록송을 작성해줘"

---

## 문제 해결

| 문제 | 해결책 |
|------|--------|
| `401 Unauthorized` | [evolink.ai/dashboard](https://evolink.ai/dashboard?utm_source=github&utm_medium=readme&utm_campaign=music-generation)에서 `EVOLINK_API_KEY` 확인 |
| `402 Payment Required` | [evolink.ai/dashboard](https://evolink.ai/dashboard?utm_source=github&utm_medium=readme&utm_campaign=music-generation)에서 크레딧 추가 |
| `429 Rate Limited` | 요청过多 — 잠시 기다려주세요 |

---

## 라이선스

MIT

---

<p align="center">
  Powered by <a href="https://evolink.ai/signup?utm_source=github&utm_medium=readme&utm_campaign=music-generation-skill-for-openclaw"><strong>EvoLink</strong></a> — Unified AI API Gateway
</p>
