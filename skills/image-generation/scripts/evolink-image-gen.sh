#!/usr/bin/env bash
#
# evolink-image-gen.sh — Generate AI images via EvoLink API
#
# Usage:
#   ./evolink-image-gen.sh "prompt" [options]
#
# Options:
#   --model <model>          Model to use (default: gpt-image-1.5)
#   --size <size>            Output size (default: 1024x1024)
#   --n <count>              Number of images, 1-4 (default: 1)
#   --image <url>            Reference image URL for image-to-image
#   --mask <url>             Mask URL for inpainting (gpt-4o-image only)
#   --poll                   Auto-poll until completion (default: true)
#   --no-poll                Return task_id immediately without polling
#
# Requires: curl, jq, EVOLINK_API_KEY environment variable
#
# Examples:
#   ./evolink-image-gen.sh "Watercolor mountain sunset" --size 1024x1536
#   ./evolink-image-gen.sh "Make it vintage" --image "https://example.com/photo.jpg"
#   ./evolink-image-gen.sh "Coffee shop logo" --n 4 --model z-image-turbo

set -euo pipefail

# ─── Config ──────────────────────────────────────────────────────────────────

API_BASE="https://api.evolink.ai/v1"
POLL_INTERVAL=4
MAX_POLL_ATTEMPTS=75

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
  head -24 "$0" | tail -20 | sed 's/^# \?//'
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
MODEL="gpt-image-1.5"
SIZE="1024x1024"
NUM_IMAGES=1
IMAGE_URL=""
MASK_URL=""
AUTO_POLL=true

[[ $# -eq 0 ]] && usage

PROMPT="$1"
shift

while [[ $# -gt 0 ]]; do
  case "$1" in
    --model)    MODEL="$2"; shift 2 ;;
    --size)     SIZE="$2"; shift 2 ;;
    --n)        NUM_IMAGES="$2"; shift 2 ;;
    --image)    IMAGE_URL="$2"; shift 2 ;;
    --mask)     MASK_URL="$2"; shift 2 ;;
    --poll)     AUTO_POLL=true; shift ;;
    --no-poll)  AUTO_POLL=false; shift ;;
    --help|-h)  usage ;;
    *)          die "Unknown option: $1" ;;
  esac
done

[[ -z "$PROMPT" ]] && die "Prompt is required."

# ─── Build Request ───────────────────────────────────────────────────────────

JSON_PAYLOAD=$(jq -n \
  --arg prompt "$PROMPT" \
  --arg model "$MODEL" \
  --arg size "$SIZE" \
  --argjson n "$NUM_IMAGES" \
  '{prompt: $prompt, model: $model, size: $size, n: $n}')

[[ -n "$IMAGE_URL" ]] && JSON_PAYLOAD=$(echo "$JSON_PAYLOAD" | jq --arg img "$IMAGE_URL" '. + {image_urls: [$img]}')
[[ -n "$MASK_URL" ]]  && JSON_PAYLOAD=$(echo "$JSON_PAYLOAD" | jq --arg mask "$MASK_URL" '. + {mask_url: $mask}')

# ─── Submit Generation ───────────────────────────────────────────────────────

info "Generating image with ${MODEL}..."
info "Prompt: \"${PROMPT}\""
info "Size: ${SIZE} | Count: ${NUM_IMAGES}"
[[ -n "$IMAGE_URL" ]] && info "Reference image: ${IMAGE_URL}"
[[ -n "$MASK_URL" ]]  && info "Mask: ${MASK_URL}"

RESPONSE=$(curl -s -w "\n%{http_code}" \
  -X POST "${API_BASE}/images/generations" \
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
    -X GET "${API_BASE}/tasks/${TASK_ID}" \
    -H "Authorization: Bearer ${EVOLINK_API_KEY}")

  STATUS=$(echo "$POLL_RESPONSE" | jq -r '.status // "unknown"')

  case "$STATUS" in
    completed|success)
      URLS=$(echo "$POLL_RESPONSE" | jq -r '.result_urls // .urls // .data // empty | if type == "array" then .[] else . end' 2>/dev/null)
      echo ""
      ok "Image(s) generated successfully!"
      if [[ -n "$URLS" ]]; then
        echo "$URLS" | while read -r url; do
          [[ -n "$url" ]] && ok "Download: ${url}"
        done
      else
        ok "Result: $(echo "$POLL_RESPONSE" | jq -c '.result // .data // .')"
      fi
      warn "URLs expire in 24 hours."
      exit 0
      ;;
    failed|error)
      ERROR_MSG=$(echo "$POLL_RESPONSE" | jq -r '.message // .error // .error_code // "Unknown error"')
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
