# Gmail Assistant — OpenClaw AI 이메일 스킬

Gmail API와 AI 기반 요약, 스마트 답장 초안 작성, 받은편지함 우선순위 지정을 통합한 스킬입니다. [evolink.ai](https://evolink.ai?utm_source=github&utm_medium=skill&utm_campaign=gmail) 제공

[소개](#소개) | [설치](#설치) | [설정 가이드](#설정-가이드) | [사용법](#사용법) | [EvoLink](https://evolink.ai?utm_source=github&utm_medium=skill&utm_campaign=gmail)

**Language / 언어:**
[English](README.md) | [简体中文](README.zh-CN.md) | [日本語](README.ja.md) | [한국어](README.ko.md) | [Español](README.es.md) | [Français](README.fr.md) | [Deutsch](README.de.md) | [Türkçe](README.tr.md) | [Русский](README.ru.md)

## 소개

Gmail Assistant는 Gmail 계정을 AI 에이전트에 연결하는 OpenClaw 스킬입니다. 읽기, 전송, 검색, 라벨 관리, 보관 등 Gmail API 전체 기능을 제공하며, EvoLink를 통한 Claude 기반의 받은편지함 요약, 스마트 답장 초안 작성, 이메일 우선순위 지정 등 AI 기능도 지원합니다.

**핵심 Gmail 작업은 API 키 없이도 동작합니다.** AI 기능(요약, 초안 작성, 우선순위 지정)에는 선택적으로 EvoLink API 키가 필요합니다.

[무료 EvoLink API 키 발급받기](https://evolink.ai/signup?utm_source=github&utm_medium=skill&utm_campaign=gmail)

## 설치

### 빠른 설치

```bash
openclaw skills add https://github.com/EvoLinkAI/gmail-skill-for-openclaw
```

### ClawHub를 통한 설치

```bash
npx clawhub install evolinkai/gmail
```

### 수동 설치

```bash
git clone https://github.com/EvoLinkAI/gmail-skill-for-openclaw.git
cd gmail-skill-for-openclaw
```

## 설정 가이드

### Step 1: Google OAuth 자격 증명 만들기

1. [Google Cloud Console](https://console.cloud.google.com/)에 접속합니다
2. 새 프로젝트를 만들거나 기존 프로젝트를 선택합니다
3. **Gmail API**를 활성화합니다: API 및 서비스 > 라이브러리 > "Gmail API" 검색 > 사용 설정
4. OAuth 동의 화면을 구성합니다: API 및 서비스 > OAuth 동의 화면 > 외부 > 필수 항목 입력
5. OAuth 자격 증명을 만듭니다: API 및 서비스 > 사용자 인증 정보 > 사용자 인증 정보 만들기 > OAuth 클라이언트 ID > **데스크톱 앱**
6. `credentials.json` 파일을 다운로드합니다

### Step 2: 구성

```bash
# 자격 증명 파일 배치
mkdir -p ~/.gmail-skill
cp credentials.json ~/.gmail-skill/credentials.json
bash scripts/gmail-auth.sh setup
```

### Step 3: 인증

```bash
bash scripts/gmail-auth.sh login
```

브라우저에서 Google OAuth 동의 화면이 열립니다. 토큰은 `~/.gmail-skill/token.json`에 로컬 저장됩니다.

### Step 4: EvoLink API 키 설정 (선택 사항 — AI 기능용)

```bash
export EVOLINK_API_KEY="your-key-here"
```

[API 키 발급받기](https://evolink.ai/signup?utm_source=github&utm_medium=skill&utm_campaign=gmail)

## 사용법

### 핵심 명령어

```bash
# 최근 이메일 목록 보기
bash scripts/gmail.sh list

# 필터를 적용하여 목록 보기
bash scripts/gmail.sh list --query "is:unread" --max 20

# 특정 이메일 읽기
bash scripts/gmail.sh read MESSAGE_ID

# 이메일 보내기
bash scripts/gmail.sh send "to@example.com" "내일 회의" "안녕하세요, 오후 3시에 회의 가능하신가요?"

# 이메일에 답장하기
bash scripts/gmail.sh reply MESSAGE_ID "감사합니다, 참석하겠습니다."

# 이메일 검색
bash scripts/gmail.sh search "from:boss@company.com has:attachment"

# 라벨 목록 보기
bash scripts/gmail.sh labels

# 라벨 추가/제거
bash scripts/gmail.sh label MESSAGE_ID +STARRED
bash scripts/gmail.sh label MESSAGE_ID -UNREAD

# 별표 / 보관 / 휴지통
bash scripts/gmail.sh star MESSAGE_ID
bash scripts/gmail.sh archive MESSAGE_ID
bash scripts/gmail.sh trash MESSAGE_ID

# 전체 스레드 보기
bash scripts/gmail.sh thread THREAD_ID

# 계정 정보
bash scripts/gmail.sh profile
```

### AI 명령어 (EVOLINK_API_KEY 필요)

```bash
# 읽지 않은 이메일 요약
bash scripts/gmail.sh ai-summary

# 사용자 지정 쿼리로 요약
bash scripts/gmail.sh ai-summary --query "from:team@company.com after:2026/04/01" --max 15

# AI 답장 초안 작성
bash scripts/gmail.sh ai-reply MESSAGE_ID "정중하게 거절하고 다음 주를 제안해 주세요"

# 받은편지함 우선순위 지정
bash scripts/gmail.sh ai-prioritize --max 30
```

### 출력 예시

```
받은편지함 요약 (읽지 않은 이메일 5건):

1. [긴급] 프로젝트 마감일 변경 — 발신자: manager@company.com
   2분기 제품 출시 마감일이 4월 15일에서 4월 10일로 앞당겨졌습니다.
   필요 조치: 내일 업무 종료 시까지 스프린트 계획 업데이트.

2. 청구서 #4521 — 발신자: billing@vendor.com
   월간 SaaS 구독 청구서 $299. 마감일 4월 15일.
   필요 조치: 승인 또는 재무팀에 전달.

3. 금요일 팀 점심 — 발신자: hr@company.com
   금요일 오후 12시 30분 팀 빌딩 점심. 참석 여부 회신 요청.
   필요 조치: 참석 여부 답장.

4. 뉴스레터: AI Weekly — 발신자: newsletter@aiweekly.com
   낮은 우선순위. 주간 AI 뉴스 요약.
   필요 조치: 없음.

5. GitHub 알림 — 발신자: notifications@github.com
   PR #247이 main에 병합되었습니다. CI 통과.
   필요 조치: 없음.
```

## 구성

| 변수 | 기본값 | 필수 | 설명 |
|---|---|---|---|
| `credentials.json` | — | 예 (코어) | Google OAuth 클라이언트 자격 증명. [설정 가이드](#설정-가이드) 참조 |
| `EVOLINK_API_KEY` | — | 선택 (AI) | AI 기능용 EvoLink API 키. [무료로 받기](https://evolink.ai/signup?utm_source=github&utm_medium=skill&utm_campaign=gmail) |
| `EVOLINK_MODEL` | `claude-opus-4-6` | 아니오 | AI 처리 모델. [EvoLink API](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=gmail)에서 지원하는 모든 모델로 전환 가능 |
| `GMAIL_SKILL_DIR` | `~/.gmail-skill` | 아니오 | 자격 증명 및 토큰의 사용자 지정 저장 경로 |

필수 바이너리: `python3`, `curl`

## Gmail 쿼리 구문

- `is:unread` — 읽지 않은 메시지
- `is:starred` — 별표 표시된 메시지
- `from:user@example.com` — 특정 발신자의 메시지
- `to:user@example.com` — 특정 수신자에게 보낸 메시지
- `subject:keyword` — 제목에 키워드 포함
- `after:2026/01/01` — 특정 날짜 이후
- `before:2026/12/31` — 특정 날짜 이전
- `has:attachment` — 첨부파일 포함
- `label:work` — 특정 라벨 포함

## 파일 구조

```
.
├── README.md               # English (메인)
├── README.zh-CN.md         # 简体中文
├── README.ja.md            # 日本語
├── README.ko.md            # 한국어
├── README.es.md            # Español
├── README.fr.md            # Français
├── README.de.md            # Deutsch
├── README.tr.md            # Türkçe
├── README.ru.md            # Русский
├── SKILL.md                # OpenClaw 스킬 정의
├── _meta.json              # 스킬 메타데이터
├── LICENSE                 # MIT 라이선스
├── references/
│   └── api-params.md       # Gmail API 파라미터 레퍼런스
└── scripts/
    ├── gmail-auth.sh       # OAuth 인증 관리자
    └── gmail.sh            # Gmail 작업 + AI 기능
```

## 문제 해결

- **"Not authenticated"** — `bash scripts/gmail-auth.sh login`을 실행하여 인증하세요
- **"credentials.json not found"** — Google Cloud Console에서 OAuth 자격 증명을 다운로드하여 `~/.gmail-skill/credentials.json`에 배치하세요
- **"Token refresh failed"** — 갱신 토큰이 만료되었을 수 있습니다. `bash scripts/gmail-auth.sh login`을 다시 실행하세요
- **"Set EVOLINK_API_KEY"** — AI 기능에는 EvoLink API 키가 필요합니다. 핵심 Gmail 작업은 키 없이도 동작합니다
- **"Error 403: access_denied"** — Google Cloud 프로젝트에서 Gmail API가 활성화되어 있고 OAuth 동의 화면이 구성되어 있는지 확인하세요
- **토큰 보안** — 토큰은 `chmod 600` 권한으로 저장됩니다. 해당 사용자 계정만 읽을 수 있습니다

## 링크

- [ClawHub](https://clawhub.ai/EvoLinkAI/gmail-assistant)
- [API 레퍼런스](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=gmail)
- [커뮤니티](https://discord.com/invite/5mGHfA24kn)
- [지원](mailto:support@evolink.ai)

## 라이선스

MIT — 자세한 내용은 [LICENSE](LICENSE)를 참조하세요.
