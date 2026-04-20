# audio-analyze-skill-for-openclaw

Gemini 3.1 Pro를 사용하여 오디오/비디오 콘텐츠를 높은 정확도로 전사 및 분석합니다. [Powered by Evolink.ai](https://evolink.ai/?utm_source=github&utm_medium=skill&utm_campaign=audio-analyze)

🌐 [English](README.md) | [日本語](README.ja.md) | [简体中文](README.zh-CN.md) | [한국어](README.ko.md) | [Español](README.es.md) | [Français](README.fr.md) | [Deutsch](README.de.md) | [Türkçe](README.tr.md) | [Русский](README.ru.md)

## 이것은 무엇인가요?

Gemini 3.1 Pro를 사용하여 오디오/비디오 파일을 자동으로 전사하고 분석합니다. [무료 API 키 받기 →](https://evolink.ai/signup?utm_source=github&utm_medium=skill&utm_campaign=audio-analyze)

## 설치

### ClawHub를 통한 설치 (권장)

```bash
openclaw skills add https://github.com/EvoLinkAI/audio-analyze-skill-for-openclaw
```

### 수동 설치

```bash
git clone https://github.com/EvoLinkAI/audio-analyze-skill-for-openclaw
cd audio-analyze-skill-for-openclaw
pip install -r requirements.txt
```

## 구성

| 변수 | 설명 | 기본값 |
| :--- | :--- | :--- |
| `EVOLINK_API_KEY` | Evolink API 키 | (필수) |
| `EVOLINK_MODEL` | 전사 모델 | gemini-3.1-pro-preview-customtools |

*자세한 API 구성 및 모델 지원에 대해서는 [EvoLink API 문서](https://docs.evolink.ai/en/api-manual/language-series/gemini-3.1-pro-preview-customtools/openai-sdk/openai-sdk-quickstart?utm_source=github&utm_medium=skill&utm_campaign=audio-analyze)를 참조하세요.*

## 사용법

### 기본 사용법

```bash
export EVOLINK_API_KEY="your-key-here"
./scripts/transcribe.sh audio.mp3
```

### 고급 사용법

```bash
./scripts/transcribe.sh audio.mp3 --diarize --lang ja
```

### 출력 예시

* **TL;DR**: 오디오는 테스트용 샘플 트랙입니다.
* **주요 내용**: 고충실도 사운드, 명확한 주파수 응답.
* **실행 항목**: 최종 테스트를 위해 프로덕션에 업로드.

## 사용 가능한 모델

- **Gemini 시리즈** (OpenAI API — `/v1/chat/completions`)

## 파일 구조

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

## 문제 해결

- **Argument list too long**: 대용량 오디오 데이터에는 임시 파일을 사용하세요.
- **API Key Error**: `EVOLINK_API_KEY`가 내보내졌는지 확인하세요.

## 링크

- [ClawHub](https://clawhub.ai/EvoLinkAI/audio-analyze)
- [API 참조](https://docs.evolink.ai/en/api-manual/language-series/gemini-3.1-pro-preview-customtools/openai-sdk/openai-sdk-quickstart?utm_source=github&utm_medium=skill&utm_campaign=audio-analyze)
- [커뮤니티](https://discord.com/invite/5mGHfA24kn)
- [지원](mailto:support@evolink.ai)

## 라이선스

MIT
