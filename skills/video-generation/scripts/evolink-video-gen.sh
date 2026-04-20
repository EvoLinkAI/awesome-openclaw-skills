#!/usr/bin/env bash
#
# evolink-video-gen.sh — Generate AI videos via EvoLink API
#
# Usage:
#   ./evolink-video-gen.sh "prompt" [options]
#
# Options:
#   --model <model>          Model to use (default: seedance-1.5-pro)
#   --duration <seconds>     Video duration in seconds
#   --quality <quality>      480p / 720p / 1080p / 4k
#   --aspect-ratio <ratio>   16:9 / 9:16 / 1:1 / 4:3 / 3:4 / 21:9
#   --image <url>            Reference image URL for image-to-video
#   --no-audio               Disable audio generation
#   --poll                   Auto-poll until completion (default: true)
#   --no-poll                Return task_id immediately without polling
#
# Requires: curl, jq, EVOLINK_API_KEY environment variable
#
# Examples:
#   ./evolink-video-gen.sh "Serene mountain dawn" --duration 5 --quality 720p
#   ./evolink-video-gen.sh "Ocean waves" --image "https://example.com/beach.jpg" --duration 8
#   ./evolink-video-gen.sh "Dancing particles" --aspect-ratio 9:16 --model sora-2-preview

set -euo pipefail

# ─── Config ──────────────────────────────────────────────────────────────────

API_BASE="https://api.evolink.ai/api/v1"
POLL_INTERVAL=15
MAX_POLL_ATTEMPTS=60

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
MODEL="seedance-1.5-pro"
DURATION=""
QUALITY=""
ASPECT_RATIO=""
IMAGE_URL=""
GENERATE_AUDIO="true"
AUTO_POLL=true

[[ $# -eq 0 ]] && usage

PROMPT="$1"
shift

while [[ $# -gt 0 ]]; do
  case "$1" in
    --model)         MODEL="$2"; shift 2 ;;
    --duration)      DURATION="$2"; shift 2 ;;
    --quality)       QUALITY="$2"; shift 2 ;;
    --aspect-ratio)  ASPECT_RATIO="$2"; shift 2 ;;
    --image)         IMAGE_URL="$2"; shift 2 ;;
    --no-audio)      GENERATE_AUDIO="false"; shift ;;
    --poll)          AUTO_POLL=true; shift ;;
    --no-poll)       AUTO_POLL=false; shift ;;
    --help|-h)       usage ;;
    *)               die "Unknown option: $1" ;;
  esac
done

[[ -z "$PROMPT" ]] && die "Prompt is required."

# ─── Build Request ───────────────────────────────────────────────────────────

JSON_PAYLOAD=$(jq -n \
  --arg prompt "$PROMPT" \
  --arg model "$MODEL" \
  --arg generate_audio "$GENERATE_AUDIO" \
  '{prompt: $prompt, model: $model, generate_audio: ($generate_audio == "true")}')

[[ -n "$DURATION" ]]     && JSON_PAYLOAD=$(echo "$JSON_PAYLOAD" | jq --argjson d "$DURATION" '. + {duration: $d}')
[[ -n "$QUALITY" ]]      && JSON_PAYLOAD=$(echo "$JSON_PAYLOAD" | jq --arg q "$QUALITY" '. + {quality: $q}')
[[ -n "$ASPECT_RATIO" ]] && JSON_PAYLOAD=$(echo "$JSON_PAYLOAD" | jq --arg ar "$ASPECT_RATIO" '. + {aspect_ratio: $ar}')
[[ -n "$IMAGE_URL" ]]    && JSON_PAYLOAD=$(echo "$JSON_PAYLOAD" | jq --arg img "$IMAGE_URL" '. + {image_urls: [$img]}')

# ─── Submit Generation ───────────────────────────────────────────────────────

info "Generating video with ${MODEL}..."
info "Prompt: \"${PROMPT}\""
[[ -n "$IMAGE_URL" ]] && info "Reference image: ${IMAGE_URL}"

RESPONSE=$(curl -s -w "\n%{http_code}" \
  -X POST "${API_BASE}/video/generate" \
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
    -X GET "${API_BASE}/video/task/${TASK_ID}" \
    -H "Authorization: Bearer ${EVOLINK_API_KEY}")

  STATUS=$(echo "$POLL_RESPONSE" | jq -r '.status // "unknown"')

  case "$STATUS" in
    completed|success)
      RESULT_URL=$(echo "$POLL_RESPONSE" | jq -r '.result_url // .video_url // .url // empty')
      echo ""
      ok "Video generated successfully!"
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
