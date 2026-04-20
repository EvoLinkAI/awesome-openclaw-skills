🌐 [English](README.md) | [日本語](README.ja.md) | [한국어](README.ko.md) | [Français](README.fr.md) | [Deutsch](README.de.md) | [Русский](README.ru.md) | [हिन्दी](README.hi.md) | [Türkçe](README.tr.md) | [中文](README.zh.md)

# 데이터 분석 어시스턴트

**EvoLink API를 활용한 AI 기반 데이터 분석**

[Evolink.ai](https://evolink.ai?utm_source=github&utm_medium=skill&utm_campaign=data-analysis) 제공

결정 우선 방법론과 통계적 엄밀성을 사용하여 CSV, Excel, JSON 파일을 분석합니다.

## 🚀 빠른 시작

```bash
bash scripts/analyze.sh sales_data.csv "최고 수익 동인은 무엇입니까?"
```

## 🔑 설정

API 키를 설정하세요:

```bash
export EVOLINK_API_KEY="your-key"
```

👉 [무료 API 키 받기](https://evolink.ai/signup?utm_source=github&utm_medium=skill&utm_campaign=data-analysis)

## 📖 사용법

### 기본 분석

```bash
bash scripts/analyze.sh <file_path> "<analysis_question>"
```

**지원되는 형식:**
- CSV (`.csv`)
- Excel (`.xlsx`, `.xls`)
- JSON (`.json`)

### 질문 예시

```bash
# 추세 분석
bash scripts/analyze.sh sales.csv "월별 수익 추세는 어떻습니까?"

# 비교
bash scripts/analyze.sh experiment.csv "변형 A가 B보다 유의미하게 나은가요?"

# 세분화
bash scripts/analyze.sh users.csv "어떤 사용자 세그먼트가 가장 높은 유지율을 보입니까?"

# 이상 감지
bash scripts/analyze.analyze.sh metrics.csv "지난 30일 동안 특이한 패턴이 있었습니까?"
```

## ⚙️ 구성

| 변수 | 기본값 | 필수 | 설명 |
|---|---|---|---|
| `EVOLINK_API_KEY` | — | 예 | Evolink API 키. [여기서 무료로 받기 →](https://evolink.ai/signup?utm_source=github&utm_medium=skill&utm_campaign=data-analysis) |
| `EVOLINK_MODEL` | `claude-opus-4-6` | 아니요 | 분석을 위한 모델. [Evolink API](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=data-analysis)에서 지원하는 모든 모델로 전환 가능 |
| `DATA_ANALYSIS_SAFE_DIR` | `$HOME/.openclaw/workspace` | 아니요 | 로컬 파일 접근이 허용된 디렉토리 |

필수 바이너리: `curl`, `jq`, `python3`, `file`.

## 🎯 핵심 원칙

**결정 없는 분석은 단순한 계산일 뿐입니다.**

이 기술은 다음을 강조합니다:
- 결정 우선 방법론
- 통계적 엄밀성 (표본 크기, 신뢰 구간, 효과 크기)
- 명확한 출력 표준 (통찰력 우선, 정량화된 불확실성)
- 명시적인 제한 사항 및 주의 사항

<h2>📊 작동 방식</h2>

1. **데이터 파일 읽기** (CSV/Excel/JSON)
2. 분석 질문과 함께 **EvoLink API로 전송**
3. 다음을 포함한 **구조화된 통찰력 반환**:
   - 주요 발견 사항
   - 통계적 신뢰도
   - 주의 사항 및 제한 사항
   - 권장되는 다음 단계

## 🔒 보안

**자격 증명 및 네트워크**

EvoLink API를 호출하려면 `EVOLINK_API_KEY`가 필요합니다. 귀하의 데이터 파일 내용과 분석 질문은 처리를 위해 `api.evolink.ai`로 전송됩니다. EvoLink는 데이터를 처리하고 분석 결과를 반환합니다. 처리 후 데이터는 저장되지 않습니다.

**파일 접근**

로컬 파일 시스템에서 지정된 데이터 파일을 읽습니다. 파일은 `DATA_ANALYSIS_SAFE_DIR` (기본값: `$HOME/.openclaw/workspace`) 내에 있어야 합니다. 스크립트는 파일 경로를 검증하고 보안을 위해 심볼릭 링크를 거부합니다.

파일 경로는 `realpath -e`를 통해 해결됩니다 (파일이 존재해야 하며 모든 심볼릭 링크를 해결합니다). 심볼릭 링크 입력은 명시적으로 거부됩니다。

민감한 파일은 이름으로 블랙리스트에 올라 있습니다: `.env*`, `*.key`, `*.pem`, `*.p12`, `*.pfx`, `id_rsa*`, `authorized_keys`, `config.json`, `.bash_history`, `.ssh`, `shadow`, `passwd`.

**파일 크기 제한**: 데이터 파일의 최대 50MB.

**MIME 유효성 검사**: `text/csv`, `text/plain`, `application/json`, `application/vnd.ms-excel`, `application/vnd.openxmlformats-officedocument.spreadsheetml.sheet`만 허용됩니다。

**네트워크 접근**

- **EvoLink API** (`api.evolink.ai`) - 데이터 전송 및 분석 수신

모든 네트워크 호출은 curl을 사용하며 스크립트 소스에서 감사할 수 있습니다。

**지속성 및 권한**

이 기술은 다른 기술이나 시스템 설정을 수정하지 않습니다. 상위 권한 또는 영구적인 권한을 요청하지 않습니다。

## 📄 라이선스

MIT

## 🔗 링크

- [API 참조](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=data-analysis)
- [커뮤니티](https://discord.com/invite/5mGHfA24kn)
- [지원](mailto:support@evolink.ai)
- [API 키 받기](https://evolink.ai/signup?utm_source=github&utm_medium=skill&utm_campaign=data-analysis) — 무료 가입

[EvoLink.ai](https://evolink.ai?utm_source=github&utm_medium=skill&utm_campaign=data-analysis) 제공
