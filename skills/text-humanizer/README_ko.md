# 텍스트 인간화 도구

[English](README.md) | [中文](README_zh.md) | [日本語](README_ja.md) | **한국어** | [Русский](README_ru.md) | [हिन्दी](README_hi.md) | [Deutsch](README_de.md) | [Français](README_fr.md) | [Italiano](README_it.md)

모든 텍스트에서 AI 작성 패턴을 제거합니다. 29개 이상의 언어를 지원합니다.

블로그 글, 이메일, 에세이, 보고서를 붙여넣으면 사람이 쓴 것처럼 자연스러운 버전을 돌려드립니다.

Powered by [Evolink.ai](https://evolink.ai?utm_source=github&utm_medium=skill&utm_campaign=humanize)

## 사용법

에이전트에게 말하세요:
- "Humanize this text"
- "이 텍스트를 자연스럽게 바꿔줘"
- "Make this sound more natural"
- "AI 느낌 좀 빼줘"

커맨드라인에서:

```bash
bash scripts/humanize.sh "draft.txt"
bash scripts/humanize.sh "draft.txt" "casual blog post"
echo "Your text here" | bash scripts/humanize.sh -
```

## 작동 방식

**레이어 1 — 패턴 스캐너**: 어휘, 구조, 어조, 포맷에 걸쳐 24가지 일반적인 AI 작성 패턴을 감지합니다.

**레이어 2 — 리라이터**: 표시된 문구를 자연스러운 대안으로 교체하고, 문장 리듬을 변경하며, 군더더기를 제거합니다.

**레이어 3 — 스타일 어댑터**: 맥락에 맞춰 어조를 조정합니다 — 블로그, 학술, 비즈니스 이메일, 캐주얼.

## 감지 패턴

| 카테고리 | 예시 |
|---|---|
| 채움 문구 | "또한", "주목할 만한 점은", "종합하면" |
| 홍보성 표현 | "획기적인", "혁신적인", "비할 데 없는" |
| 가짜 깊이 | "~을 보여주며... ~을 반영하며... ~을 부각시키며..." |
| 모호한 귀속 | "전문가들은", "업계 관계자에 따르면" |
| 구조적 특징 | 삼단 구성, 균일한 문장 길이, 정형화된 결론 |
| AI 빈출 어휘 | "핵심적인", "매우 중요한", "원활한", "강력한" |
| 챗봇 흔적 | "도움이 되셨길 바랍니다!", "궁금한 점이 있으시면" |

## 지원 언어

영어, 중국어, 일본어, 한국어, 러시아어, 힌디어, 독일어, 프랑스어, 이탈리아어, 스페인어, 포르투갈어, 네덜란드어, 폴란드어, 터키어, 아랍어 등 29개 이상의 언어.

언어를 자동으로 감지합니다. 별도 설정이 필요 없습니다.

## 예시

**변환 전** (AI 느낌이 강함):

> 이번 소프트웨어 업데이트는 혁신에 대한 회사의 확고한 의지를 여실히 보여주는 것입니다. 또한, 원활하고 직관적이며 강력한 사용자 경험을 제공하여 사용자가 효율적으로 목표를 달성할 수 있도록 보장합니다.

**변환 후**:

> 이번 업데이트에 일괄 처리, 단축키, 오프라인 모드가 추가됐다. 인터페이스도 쓰기 편해졌고, 대부분의 작업에서 클릭 수가 줄었다. 꽤 괜찮은 개선이다.

## 설정

1. [evolink.ai/signup](https://evolink.ai/signup?utm_source=github&utm_medium=readme&utm_campaign=text-humanizer-skill-for-openclaw?utm_source=github&utm_medium=skill&utm_campaign=humanize)에서 API 키를 발급받으세요
2. 환경 변수를 설정하세요:

```bash
export EVOLINK_API_KEY="your-key-here"
```

| 변수 | 기본값 | 설명 |
|---|---|---|
| `EVOLINK_API_KEY` | (필수) | Evolink API 키 |
| `EVOLINK_MODEL` | `claude-opus-4-6` | 처리 모델. [Evolink API](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=humanize)에서 지원하는 모든 모델로 전환 가능 |

## 보안

- **파일 접근**: 설정된 안전 디렉토리 내 파일만 허용
- **민감 파일 차단**: `.env`, `.ssh`, `config.json`, 개인키 등
- **크기 제한**: 텍스트 파일 5MB
- **MIME 검증**: 텍스트 파일만 허용
- 처리 후 데이터를 저장하지 않음

## 링크

- [소스 코드](https://github.com/EvoLinkAI/text-humanizer-skill-for-openclaw) — GitHub 저장소
- [API 문서 (EN)](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=humanize)
- [API 문서 (中文)](https://docs.evolink.ai/cn/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=humanize)
- [API 키 발급](https://evolink.ai/signup?utm_source=github&utm_medium=readme&utm_campaign=text-humanizer-skill-for-openclaw?utm_source=github&utm_medium=skill&utm_campaign=humanize) — 무료 가입

## 라이선스

MIT

Powered by [Evolink.ai](https://evolink.ai?utm_source=github&utm_medium=skill&utm_campaign=humanize)
