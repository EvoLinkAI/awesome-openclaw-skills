# Slack Assistant — Claude Code용 OpenClaw 스킬

스마트 AI 기능이 탑재된 Slack API 통합 — 메시지 전송, 채널 읽기, 대화 검색, 워크스페이스 관리를 Claude 기반 요약 및 초안 기능과 함께 제공합니다. [evolink.ai](https://evolink.ai?utm_source=github&utm_medium=skill&utm_campaign=slack) 제공

[이것은 무엇인가요?](#이것은-무엇인가요) | [설치](#설치) | [설정 가이드](#설정-가이드) | [사용법](#사용법) | [EvoLink](https://evolink.ai?utm_source=github&utm_medium=skill&utm_campaign=slack)

**Language / 언어:**
[English](README.md) | [简体中文](README.zh-CN.md) | [日本語](README.ja.md) | [한국어](README.ko.md) | [Español](README.es.md) | [Français](README.fr.md) | [Deutsch](README.de.md) | [Türkçe](README.tr.md) | [Русский](README.ru.md)

## 이것은 무엇인가요?

Claude Code를 Slack 워크스페이스에 연결하는 [OpenClaw](https://clawhub.ai) 스킬입니다. Claude에게 말하기만 하면 됩니다:

- "#general에 메시지 보내줘"
- "#engineering에서 무슨 일이 있어?"
- "#product의 최근 50개 메시지를 요약해줘"
- "그 스레드에 답장 초안 작성해줘"

## 설치

### 방법 1: ClawHub (추천)
```bash
npx clawhub install slack-assistant
```

### 방법 2: npm
```bash
npx evolinkai-slack-assistant
```

### 방법 3: 수동 설치
```bash
git clone https://github.com/EvoLinkAI/slack-skill-for-openclaw.git
cp -r slack-skill-for-openclaw /path/to/your/skills/slack-assistant/
```

## 설정 가이드

### 1. Slack 앱 생성

1. [api.slack.com/apps](https://api.slack.com/apps)에 접속
2. **Create New App** > **From scratch** 클릭
3. 앱 이름을 지정하고 워크스페이스 선택
4. **OAuth & Permissions** > **Bot Token Scopes**로 이동
5. 다음 스코프 추가:
   - `channels:read`, `channels:write`, `channels:history`, `channels:manage`
   - `chat:write`
   - `files:read`, `files:write`
   - `groups:read`, `groups:write`, `groups:history`
   - `im:read`, `im:write`, `im:history`
   - `mpim:read`, `mpim:write`, `mpim:history`
   - `search:read`
   - `users:read`, `users:read.email`
   - `reactions:read`, `reactions:write`
6. **Install to Workspace** 클릭 후 승인
7. **Bot User OAuth Token** 복사 (`xoxb-`로 시작)

### 2. 인증 정보 설정

```bash
mkdir -p ~/.slack-skill
echo '{"bot_token": "xoxb-your-token-here"}' > ~/.slack-skill/credentials.json
chmod 600 ~/.slack-skill/credentials.json
```

### 3. (선택) AI 기능 활성화

```bash
export EVOLINK_API_KEY="your-key-here"
```

[evolink.ai/signup](https://evolink.ai/signup?utm_source=github&utm_medium=skill&utm_campaign=slack)에서 무료 API 키 발급

## 사용법

### 기본 작업

```bash
bash scripts/slack.sh channels
bash scripts/slack.sh list "#general" 20
bash scripts/slack.sh send "#general" "안녕하세요!"
bash scripts/slack.sh search "배포"
bash scripts/slack.sh read CHANNEL_ID 1234567890.123456
bash scripts/slack.sh reply CHANNEL_ID 1234567890.123456 "감사합니다!"
```

### AI 기능

```bash
bash scripts/slack.sh ai-summary "#engineering" 50
bash scripts/slack.sh ai-reply CHANNEL_ID 1234567890.123456
bash scripts/slack.sh ai-prioritize "#general" 30
```

### 채널 관리

```bash
bash scripts/slack.sh create-channel "new-project" --private
bash scripts/slack.sh invite "#new-project" "@alice"
bash scripts/slack.sh upload "#general" ./report.pdf
```

## 설정

| 변수 | 기본값 | 설명 |
|---|---|---|
| `SLACK_SKILL_DIR` | `~/.slack-skill` | 설정 디렉토리 |
| `EVOLINK_API_KEY` | — | AI 기능용 API 키 ([발급](https://evolink.ai/signup?utm_source=github&utm_medium=skill&utm_campaign=slack)) |
| `EVOLINK_MODEL` | `claude-opus-4-6` | AI 모델 ([문서](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=slack)) |

## 링크

- [ClawHub](https://clawhub.ai/EvoLinkAI/slack-assistant)
- [Slack API 레퍼런스](https://api.slack.com/methods)
- [EvoLink API](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=slack)
- [커뮤니티](https://discord.com/invite/5mGHfA24kn)
- [지원](mailto:support@evolink.ai)

## 라이선스

MIT
