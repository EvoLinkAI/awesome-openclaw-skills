#!/usr/bin/env bash
#
# evolink-music-gen.sh — Generate AI music via EvoLink API
#
# Usage:
#   ./evolink-music-gen.sh "prompt" [options]
#
# Options:
#   --model <model>          Model to use (default: suno-v4)
#   --duration <seconds>     Target duration in seconds (30-240)
#   --vocal                  Generate with vocals (default)
#   --instrumental           Generate instrumental only
#   --custom                 Enable custom mode (lyrics + style control)
#   --title <title>          Song title (custom mode, max 80 chars)
#   --style <tags>           Style tags (custom mode, e.g. "pop, upbeat")
#   --gender <m|f>           Vocal gender (custom mode)
#   --negative <tags>        Styles to exclude
#   --poll                   Auto-poll until completion (default: true)
#   --no-poll                Return task_id immediately without polling
#
# Requires: curl, jq, EVOLINK_API_KEY environment variable
#
# Examples:
#   ./evolink-music-gen.sh "Cheerful pop song about summer" --vocal
#   ./evolink-music-gen.sh "Relaxing lo-fi beats" --instrumental --duration 120
#   ./evolink-music-gen.sh "[Verse] Walking... [Chorus] Here we go..." --custom --title "Road Song" --style "pop rock"

set -euo pipefail

# ─── Config ──────────────────────────────────────────────────────────────────

API_BASE="https://api.evolink.ai/v1"
POLL_INTERVAL=8
MAX_POLL_ATTEMPTS=40

# ─── Colors ──────────────────────────────────────────────────────────────────

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# ─── Helpers ─────────────────────────────────────────────────────────────────

info()  { echo -e "${BLUE}ℹ${NC} $*"; }
ok()    { echo -e "${GREEN}✔${NC} $*"; }
warn()  { echo -e "${YELLOW}⚠${NC} $*"; }
err()   { echo -e "${RED}✖${NC} $*" >&2; }
die()   { err "$@"; exit 1; }

usage() {
  head -28 "$0" | tail -24 | sed 's/^# \?//'
  exit 0
}

require_cmd() {
  command -v "$1" &>/dev/null || die "'$1' is required but not installed. Install it and try again."
}

# ─── Dependency Check ────────────────────────────────────────────────────────

require_cmd curl
require_cmd jq

[[ -z "${EVOLINK_API_KEY:-}" ]] && die "EVOLINK_API_KEY is not set. Get your key at https://evolink.ai"

# ─── Parse Arguments ─────────────────────────────────────────────────────────

PROMPT=""
MODEL="suno-v4"
DURATION=""
INSTRUMENTAL="false"
CUSTOM_MODE="false"
TITLE=""
STYLE=""
GENDER=""
NEGATIVE=""
AUTO_POLL=true

[[ $# -eq 0 ]] && usage

PROMPT="$1"
shift

while [[ $# -gt 0 ]]; do
  case "$1" in
    --model)          MODEL="$2"; shift 2 ;;
    --duration)       DURATION="$2"; shift 2 ;;
    --vocal)          INSTRUMENTAL="false"; shift ;;
    --instrumental)   INSTRUMENTAL="true"; shift ;;
    --custom)         CUSTOM_MODE="true"; shift ;;
    --title)          TITLE="$2"; shift 2 ;;
    --style)          STYLE="$2"; shift 2 ;;
    --gender)         GENDER="$2"; shift 2 ;;
    --negative)       NEGATIVE="$2"; shift 2 ;;
    --poll)           AUTO_POLL=true; shift ;;
    --no-poll)        AUTO_POLL=false; shift ;;
    --help|-h)        usage ;;
    *)                die "Unknown option: $1" ;;
  esac
done

[[ -z "$PROMPT" ]] && die "Prompt is required."

# ─── Build Request ───────────────────────────────────────────────────────────

JSON_PAYLOAD=$(jq -n \
  --arg prompt "$PROMPT" \
  --arg model "$MODEL" \
  --argjson custom_mode "$CUSTOM_MODE" \
  --argjson instrumental "$INSTRUMENTAL" \
  '{prompt: $prompt, model: $model, custom_mode: $custom_mode, instrumental: $instrumental}')

[[ -n "$DURATION" ]] && JSON_PAYLOAD=$(echo "$JSON_PAYLOAD" | jq --argjson d "$DURATION" '. + {duration: $d}')
[[ -n "$TITLE" ]]    && JSON_PAYLOAD=$(echo "$JSON_PAYLOAD" | jq --arg t "$TITLE" '. + {title: $t}')
[[ -n "$STYLE" ]]    && JSON_PAYLOAD=$(echo "$JSON_PAYLOAD" | jq --arg s "$STYLE" '. + {style: $s}')
[[ -n "$GENDER" ]]   && JSON_PAYLOAD=$(echo "$JSON_PAYLOAD" | jq --arg g "$GENDER" '. + {vocal_gender: $g}')
[[ -n "$NEGATIVE" ]] && JSON_PAYLOAD=$(echo "$JSON_PAYLOAD" | jq --arg n "$NEGATIVE" '. + {negative_tags: $n}')

# ─── Submit Generation ───────────────────────────────────────────────────────

info "Generating music with ${MODEL}..."
info "Prompt: \"${PROMPT}\""
info "Mode: $([ "$CUSTOM_MODE" = "true" ] && echo "Custom" || echo "Simple") | $([ "$INSTRUMENTAL" = "true" ] && echo "Instrumental" || echo "Vocal")"
[[ -n "$STYLE" ]] && info "Style: ${STYLE}"
[[ -n "$TITLE" ]] && info "Title: ${TITLE}"

RESPONSE=$(curl -s -w "\n%{http_code}" \
  -X POST "${API_BASE}/music/generate" \
  -H "Authorization: Bearer ${EVOLINK_API_KEY}" \
  -H "Content-Type: application/json" \
  -d "$JSON_PAYLOAD")

HTTP_CODE=$(echo "$RESPONSE" | tail -1)
BODY=$(echo "$RESPONSE" | sed '$d')

case "$HTTP_CODE" in
  200|201) ;;
  401) die "Unauthorized. Check your EVOLINK_API_KEY." ;;
  402) die "Payment required. Top up at https://evolink.ai/dashboard" ;;
  429) die "Rate limited. Please wait and try again." ;;
  *)   die "API error (HTTP ${HTTP_CODE}): $(echo "$BODY" | jq -r '.message // .error // "Unknown error"' 2>/dev/null || echo "$BODY")" ;;
esac

TASK_ID=$(echo "$BODY" | jq -r '.task_id // .id // empty')
[[ -z "$TASK_ID" ]] && die "No task_id in response: $BODY"

ok "Task submitted: ${TASK_ID}"

# ─── Poll for Completion ─────────────────────────────────────────────────────

if ! $AUTO_POLL; then
  echo "$TASK_ID"
  exit 0
fi

info "Polling for completion (every ${POLL_INTERVAL}s, max ${MAX_POLL_ATTEMPTS} attempts)..."

for ((i=1; i<=MAX_POLL_ATTEMPTS; i++)); do
  sleep "$POLL_INTERVAL"

  POLL_RESPONSE=$(curl -s \
    -X GET "${API_BASE}/music/task/${TASK_ID}" \
    -H "Authorization: Bearer ${EVOLINK_API_KEY}")

  STATUS=$(echo "$POLL_RESPONSE" | jq -r '.status // "unknown"')

  case "$STATUS" in
    completed|success)
      RESULT_URL=$(echo "$POLL_RESPONSE" | jq -r '.result_url // .audio_url // .url // empty')
      echo ""
      ok "Music generated successfully!"
      [[ -n "$RESULT_URL" ]] && ok "Download URL: ${RESULT_URL}"
      warn "URL expires in 24 hours."
      exit 0
      ;;
    failed|error)
      ERROR_MSG=$(echo "$POLL_RESPONSE" | jq -r '.message // .error // "Unknown error"')
      die "Generation failed: ${ERROR_MSG}"
      ;;
    pending|processing|queued)
      printf "\r  ⏳ Status: %-12s (attempt %d/%d)" "$STATUS" "$i" "$MAX_POLL_ATTEMPTS"
      ;;
    *)
      warn "Unknown status: ${STATUS}"
      ;;
  esac
done

echo ""
die "Timed out after $((MAX_POLL_ATTEMPTS * POLL_INTERVAL))s. Check task manually: ${TASK_ID}"
