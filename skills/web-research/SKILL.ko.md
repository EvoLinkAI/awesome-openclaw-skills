---
name: web-research
description: EvoLink API를 통한 웹 검색. 제목, URL, 설명이 포함된 깔끔하고 형식화된 결과를 반환합니다. Powered by evolink.ai
metadata: {"clawdbot":{"emoji":"🔍","requires":{"bins":["bash","curl","jq"],"env":["EVOLINK_API_KEY"]},"primaryEnv":"EVOLINK_API_KEY"}}
---

# Web Search Assistant

EvoLink API를 사용한 웹 검색. 제목, URL, 설명이 포함된 깔끔하고 형식화된 결과를 반환합니다.

Powered by [Evolink.ai](https://evolink.ai?utm_source=clawhub&utm_medium=skill&utm_campaign=web-search)

## 사용 시기

사용자가 다음을 요청할 때 이 스킬을 사용하세요:
- 정보 또는 리소스에 대한 웹 검색
- 최신 또는 최근 정보 온라인 검색
- 현재 웹 데이터가 필요한 연구
- 웹 소스를 사용한 팩트 체크 또는 검증
- 주제에 대한 URL 및 리소스 수집

## 검색

```bash
{baseDir}/scripts/search.sh "쿼리"
{baseDir}/scripts/search.sh "쿼리" 20
```

## 옵션

- `<query>`: 검색 쿼리
- `<max_results>`: 결과 수 (기본값: 10)

## 설정

EvoLink API 키를 설정하세요:

```bash
export EVOLINK_API_KEY="your-evolink-api-key-here"
```

👉 [무료 API 키 받기](https://evolink.ai/signup?utm_source=clawhub&utm_medium=skill&utm_campaign=web-search)

## 예제

```bash
bash scripts/search.sh "Claude Opus 4 features"
```

출력:
```
🔍 검색 중: Claude Opus 4 features

📄 Claude Opus 4: New Features and Capabilities
🔗 https://example.com/opus-4
📝 Comprehensive guide to Claude Opus 4's new features...

📄 What's New in Claude Opus 4
🔗 https://example.com/whats-new
📝 Latest updates and improvements in Claude Opus 4...
```

## 보안

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

## 링크

- [ClawHub](https://clawhub.ai/evolinkai/web-research)
- [API 참조](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=clawhub&utm_medium=skill&utm_campaign=web-search)
- [커뮤니티](https://discord.com/invite/5mGHfA24kn)
- [지원](mailto:support@evolink.ai)
