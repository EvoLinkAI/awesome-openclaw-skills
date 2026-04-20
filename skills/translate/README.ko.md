# Translate — AI 언어 번역 Skill (OpenClaw)

텍스트를 정확하게 번역하세요 — 서식을 유지하고, 복수형을 처리하며, 로케일에 맞춰 어조를 조정합니다. Powered by [EvoLink](https://evolink.ai/?utm_source=github&utm_medium=skill&utm_campaign=translate).

🌐 [English](README.md) | [简体中文](README.zh-CN.md) | [日本語](README.ja.md) | 한국어 | [Español](README.es.md) | [Français](README.fr.md) | [Deutsch](README.de.md) | [Türkçe](README.tr.md) | [Русский](README.ru.md)

---

## 이 Skill은 무엇인가요?

Translate는 고정밀 OpenClaw 번역 Skill입니다. 문맥을 이해하고, 복잡한 Markdown 서식을 유지하며, 문화적 차이에 따라 어조를 조정합니다.

[지금 설치 →](https://clawhub.ai/EvoLinkAI/evolink-translate)

---

## 서식 유지

- 코드 블록, HTML 태그, Markdown 구문 내의 콘텐츠는 번역하지 않습니다.
- `"{name}"`, `"{{variable}}"`, `"%s"`, `` 같은 자리 표시자를 그대로 유지합니다.
- Markdown 구조(헤더, 링크, 굵게/기울임꼴)를 유지합니다.
- JSON/XML 구조와 키를 유지하고 적절한 값만 번역합니다.

## 콘텐츠 규칙

- 번역 제외: 고유 명사, 브랜드 이름, 기술 용어, URL, 이메일 주소
- 번역 제외: 코드 조각, CSS 클래스, API 엔드포인트, 파일 확장자
- 로케일 변환이 필요하지 않은 경우 숫자, 날짜, ID의 원래 형식을 유지합니다.
- 용어 일관성 유지 — 반복되는 용어에 대한 용어집을 만듭니다.

## 언어별 처리

- **복수형**: 영어 패턴이 아닌, 대상 언어 규칙에 맞는 올바른 복수형을 사용합니다.
- **성별**: 성별이 있는 언어(스페인어/프랑스어/독일어)에서 명사와 형용사의 성 일치를 보장합니다.
- **격식**: 문맥에 따라 적절한 어조(tu/vous, tú/usted, du/Sie)를 선택합니다.
- **RTL 언어**: 아랍어/히브리어의 텍스트 방향을 고려하되, LTR 요소(URL, 숫자)는 유지합니다.

## 문화적 적응

- 직역이 아닌 관용구와 표현을 적응시킵니다.
- 문화적으로 적절할 경우 단위를 변환합니다(마일↔km, 화씨↔섭씨).
- 로케일 표준에 맞춰 날짜 형식을 조정합니다(MM/DD vs DD/MM vs DD.MM).
- 현지 통화 기호와 숫자 형식을 사용합니다(쉼표 vs 소수점).

## 문맥 인식

- 문맥에 기반하여 모호성 해소: "bank"(금융 vs 강둑), "mouse"(동물 vs 컴퓨터)
- 문서 어조 유지: 공식 비즈니스 vs 캐주얼 블로그 vs 기술 매뉴얼
- 대상 독자 고려: 어린이용 콘텐츠 vs 학술 논문 vs 마케팅 카피
- 단순한 자구적 의미가 아닌 원래의 의도와 감정적 뉘앙스를 유지합니다.

## 품질 관리

- 번역 전 전체 문맥을 읽어 의미를 파악합니다.
- 번역된 텍스트가 대상 언어에서 자연스럽게 읽히는지 확인합니다.
- 번역 후 모든 서식 요소가 기능하는지 검증합니다.
- 문서 전체에서 일관된 목소리와 용어를 보장합니다.

---

## 퀵 스타트



## 구성

- `EVOLINK_API_KEY`: API 액세스에 필수.
- `EVOLINK_MODEL`: 옵션. 기본값은 `claude-opus-4-6`입니다. 이 설정으로 모델을 전환할 수 있습니다(예: `claude-sonnet-4-6`, `gpt-5.4`).

[무료 API Key 받기 →](https://evolink.ai/signup?utm_source=github&utm_medium=skill&utm_campaign=translate)

---

## 링크

- [ClawHub](https://clawhub.ai/EvoLinkAI/evolink-translate)
- [API Reference](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=translate)
- [Community](https://discord.com/invite/clawd)
- [Support](mailto:support@evolink.ai)

---

## 라이선스
MIT
