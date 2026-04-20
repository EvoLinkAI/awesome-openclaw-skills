🌐 [English](README.md) | [日本語](README.ja.md) | 한국어 | [简体中文](README.zh-CN.md) | [Français](README.fr.md) | [Deutsch](README.de.md) | [Русский](README.ru.md) | [हिन्दी](README.hi.md) | [Türkçe](README.tr.md)

# Web Search Assistant

**EvoLink API를 사용한 AI 기반 웹 검색**

Powered by [Evolink.ai](https://evolink.ai?utm_source=github&utm_medium=skill&utm_campaign=web-search)

웹을 검색하고 제목, URL, 설명이 포함된 깔끔하고 형식화된 결과를 얻으세요.

## 🚀 빠른 시작

```bash
bash scripts/search.sh "AI coding assistants 2026"
bash scripts/search.sh "quantum computing breakthroughs" 20
```

## 🔑 설정

EvoLink API 키를 설정하세요:

```bash
export EVOLINK_API_KEY="your-evolink-api-key-here"
```

👉 [무료 API 키 받기](https://evolink.ai/signup?utm_source=github&utm_medium=skill&utm_campaign=web-search)

## 📖 사용법

### 기본 검색

```bash
bash scripts/search.sh "검색 쿼리"
```

상위 10개 결과를 반환합니다.

### 결과 수 제한

```bash
bash scripts/search.sh "검색 쿼리" 20
```

최대 결과 수를 지정합니다.

## 🔒 보안

**자격 증명 및 네트워크**

EvoLink API를 호출하려면 `EVOLINK_API_KEY`가 필요합니다. 검색 쿼리는 처리를 위해 `api.evolink.ai`로 전송됩니다. EvoLink는 내부적으로 웹 검색을 처리하고 형식화된 결과를 반환합니다.

**파일 액세스**

이 스킬은 파일을 읽거나 쓰지 않습니다.

**네트워크 액세스**

이 스킬은 다음에 네트워크 요청을 수행합니다:
- **EvoLink API** (`api.evolink.ai`) - 웹 검색 수행

모든 네트워크 호출은 curl을 통해 수행되며 스크립트 소스 코드에서 감사할 수 있습니다.

**지속성 및 권한**

이 스킬은 다른 스킬이나 시스템 설정을 수정하지 않습니다. 상승된 권한이나 지속적인 권한은 요청되지 않습니다.

## 📄 라이선스

MIT

## 🔗 링크

- [ClawHub](https://clawhub.ai/evolinkai/web-research)
- [API 참조](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=web-search)
- [커뮤니티](https://discord.com/invite/5mGHfA24kn)
- [지원](mailto:support@evolink.ai)
