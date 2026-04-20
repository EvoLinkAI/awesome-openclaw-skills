# Notion

🌐 [English](README.md) | [简体中文](README.zh-CN.md) | [日本語](README.ja.md) | 한국어 | [Español](README.es.md) | [Français](README.fr.md) | [Русский](README.ru.md)

이 스킬을 통해 에이전트는 Notion API를 사용하여 Notion 페이지 및 데이터베이스와 상호 작용할 수 있습니다. Evolink AI의 지능형 콘텐츠 처리 기능을 제공합니다.

## 빠른 시작
1. [notion.so/my-integrations](https://www.notion.so/my-integrations)에서 Notion 통합 생성
2. 내부 통합 토큰 복사
3. 통합과 페이지/데이터베이스 공유
4. `NOTION_API_KEY` 및 `EVOLINK_API_KEY` 구성
5. 설치: `clawhub install evolink-notion`

## 인증

Notion 토큰 내보내기:
```bash
export NOTION_API_KEY=secret_xxx
```

**중요**: 액세스하려는 페이지나 데이터베이스를 통합과 공유해야 합니다. 공유되지 않은 콘텐츠는 API에서 보이지 않습니다.

## 구성

- `NOTION_API_KEY`: Notion 통합 토큰
- `EVOLINK_API_KEY`: Evolink AI 서비스용 API 키. [evolink.ai/signup](https://evolink.ai/signup?utm_source=github&utm_medium=skill&utm_campaign=evolink-notion)에서 무료 키 받기

**모델 선택:**
- 기본 모델: `[REDACTED]`
- `EVOLINK_MODEL` 환경 변수로 모델 전환 가능

**왜 Evolink인가?** 이 스킬은 Evolink AI를 사용하여 Notion 콘텐츠를 지능적으로 처리하고 생성하여 더 나은 컨텍스트 이해와 콘텐츠 생성을 제공합니다.

## 사용법

### 페이지 작업

**페이지 읽기:**
```bash
notion-cli page get <page_id>
```

**콘텐츠 추가:**
```bash
notion-cli block append <page_id> --markdown "..."
```

**페이지 생성:**
```bash
notion-cli page create --parent <page_id> --title "..."
```

### 데이터베이스 작업

**스키마 확인:**
```bash
notion-cli db get <database_id>
```

**데이터베이스 쿼리:**
```bash
notion-cli db query <database_id> --filter <json> --sort <json>
```

## 보안

- Notion API에는 속도 제한이 있습니다
- 파괴적인 작업 전에 항상 확인하세요
- Evolink AI를 통해 처리되는 콘텐츠는 표준 데이터 개인정보 보호 관행을 따릅니다

## 라이선스
MIT License

## 링크
- [GitHub 저장소](https://clawhub.ai/EvoLinkAI/evolink-notion)
- [Evolink AI 문서](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=evolink-notion)
- [Notion API 문서](https://developers.notion.com)
- [커뮤니티 지원](https://discord.com/invite/5mGHfA24kn)
