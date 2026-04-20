#!/usr/bin/env bash
set -euo pipefail

# Summarize — multi-format AI summarization via Evolink API
# Usage: bash summarize.sh <url-or-file> [custom-prompt]

INPUT="${1:?Usage: summarize.sh <url-or-file> [custom-prompt]}"
CUSTOM_PROMPT="${2:-}"

API_KEY="${EVOLINK_API_KEY:?Set EVOLINK_API_KEY first. Get one at https://evolink.ai/register}"
MODEL="${EVOLINK_MODEL:-claude-opus-4-6}"
API_URL="https://api.evolink.ai/v1/messages"

# --- Detect input type ---
detect_type() {
  case "$INPUT" in
    https://youtu.be/*|https://www.youtube.com/*|https://youtube.com/*)
      echo "youtube" ;;
    http://*|https://*)
      echo "url" ;;
    *.pdf)
      echo "pdf" ;;
    *.mp3|*.wav|*.m4a|*.ogg|*.flac)
      echo "audio" ;;
    *.mp4|*.webm|*.mkv|*.avi|*.mov)
      echo "video" ;;
    *)
      echo "text" ;;
  esac
}

TYPE=$(detect_type)

# --- Security check for local files ---
if [[ "$INPUT" != http* && "$TYPE" != "youtube" ]]; then
    # 1. Resolve absolute path (realpath -e: file MUST exist, resolves all symlinks)
    FILE_PATH=$(realpath -e "$INPUT" 2>/dev/null)
    if [ -z "$FILE_PATH" ]; then
        echo "Error: File not found or path contains broken symlinks: $INPUT" >&2
        exit 1
    fi

    # 2. Reject symlinks
    if [ -L "$INPUT" ]; then
        echo "Error: Symlinks are not allowed for security. Use the actual file path." >&2
        exit 1
    fi

    # 3. Scope check with trailing slash to prevent prefix bypass
    SAFE_DIR="${SUMMARIZE_SAFE_DIR:-$HOME/.openclaw/workspace}"
    SAFE_DIR="${SAFE_DIR%/}/"
    if [[ "$FILE_PATH" != "$SAFE_DIR"* ]]; then
        echo "Error: Security violation. Access restricted to $SAFE_DIR" >&2
        exit 1
    fi

    # 4. Filename blacklist (sensitive system/config files)
    case "$(basename "$FILE_PATH")" in
        .env*|*.key|*.pem|*.p12|*.pfx|id_rsa*|authorized_keys|.bash_history|config.json|.ssh|shadow|passwd)
            echo "Error: Access to sensitive configuration files is blocked." >&2
            exit 1
            ;;
    esac

    # 5. File status checks
    if [ -f "$FILE_PATH" ]; then
        # 6. Get MIME type
        MIME=$(file --mime-type -b "$FILE_PATH" 2>/dev/null || echo "text/plain")
        SIZE=$(stat -c%s "$FILE_PATH")

        # 7. Tiered Size Limits (Security vs. UX)
        MAX_SIZE=5242880 # Default 5MB for text/config
        if [[ "$MIME" == "application/pdf" ]]; then
            MAX_SIZE=52428800 # 50MB for PDFs
        elif [[ "$MIME" =~ ^(video/|audio/) ]]; then
            MAX_SIZE=1073741824 # 1GB for Multi-media
        fi

        if [ "$SIZE" -gt "$MAX_SIZE" ]; then
            echo "Error: File size ($((SIZE/1024/1024))MB) exceeds the $MAX_SIZE bytes limit for $MIME." >&2
            exit 1
        fi
        
        # 8. MIME type validation (Reject unknown binary)
        if [[ ! "$MIME" =~ ^(text/|application/pdf|video/|audio/|inode/x-empty|application/json) ]]; then
            echo "Error: Unsupported or dangerous file type ($MIME)." >&2
            exit 1
        fi
    fi
fi

# --- Extract content based on type ---
extract_content() {
  case "$TYPE" in
    url)
      if command -v markitdown &>/dev/null; then
        markitdown "$INPUT" 2>/dev/null
      else
        curl -sL "$INPUT" | sed 's/<[^>]*>//g' | head -500
      fi
      ;;
    youtube)
      if command -v yt-dlp &>/dev/null; then
        # Try subtitles first, fall back to audio transcription
        SUBS=$(yt-dlp --skip-download --write-auto-sub --sub-lang en --convert-subs srt -o "/tmp/yt_sub_$$" "$INPUT" 2>/dev/null && cat /tmp/yt_sub_$$.en.srt 2>/dev/null || echo "")
        rm -f /tmp/yt_sub_$$* 2>/dev/null
        if [ -n "$SUBS" ]; then
          echo "$SUBS"
        else
          echo "[YouTube video: $INPUT — subtitle extraction failed. Provide transcript manually.]"
        fi
      else
        echo "[YouTube video: $INPUT — install yt-dlp for auto-extraction.]"
      fi
      ;;
    pdf)
      if command -v markitdown &>/dev/null; then
        markitdown "$INPUT" 2>/dev/null
      elif command -v pdftotext &>/dev/null; then
        pdftotext "$INPUT" - 2>/dev/null | head -1000
      else
        echo "[PDF file: $INPUT — install markitdown or poppler-utils for extraction.]"
      fi
      ;;
    audio)
      if command -v whisper &>/dev/null; then
        whisper "$INPUT" --model base --output_format txt --output_dir /tmp 2>/dev/null
        BASENAME=$(basename "$INPUT" | sed 's/\.[^.]*$//')
        cat "/tmp/${BASENAME}.txt" 2>/dev/null
        rm -f "/tmp/${BASENAME}.txt" "/tmp/${BASENAME}.json" "/tmp/${BASENAME}.srt" "/tmp/${BASENAME}.vtt" "/tmp/${BASENAME}.tsv" 2>/dev/null
      else
        echo "[Audio file: $INPUT — install openai-whisper for transcription.]"
      fi
      ;;
    video)
      if command -v ffmpeg &>/dev/null && command -v whisper &>/dev/null; then
        TMPWAV="/tmp/summarize_audio_$$.wav"
        ffmpeg -i "$INPUT" -vn -acodec pcm_s16le -ar 16000 -ac 1 "$TMPWAV" -y 2>/dev/null
        whisper "$TMPWAV" --model base --output_format txt --output_dir /tmp 2>/dev/null
        cat "/tmp/summarize_audio_$$.txt" 2>/dev/null
        rm -f "$TMPWAV" "/tmp/summarize_audio_$$.txt"
      else
        echo "[Video file: $INPUT — install ffmpeg + openai-whisper for extraction.]"
      fi
      ;;
    text)
      if [ -f "$INPUT" ]; then
        head -1000 "$INPUT"
      else
        echo "$INPUT"
      fi
      ;;
  esac
}

CONTENT=$(extract_content)

if [ -z "$CONTENT" ]; then
  echo "Error: Could not extract content from $INPUT"
  exit 1
fi

# --- Build prompt ---
SYSTEM_PROMPT="You are an expert summarizer. Provide a clear, actionable summary with: 1) A TL;DR (2-3 sentences), 2) Key Takeaways (bullet points), 3) Action Items if applicable. Be concise and prioritize insights that lead to decisions."

if [ -n "$CUSTOM_PROMPT" ]; then
  USER_MSG="$CUSTOM_PROMPT\n\n---\n\n$CONTENT"
else
  USER_MSG="Summarize the following content:\n\n$CONTENT"
fi

# --- Escape for JSON ---
json_escape() {
  printf '%s' "$1" | python3 -c 'import json,sys; print(json.dumps(sys.stdin.read()))'
}

ESCAPED_SYSTEM=$(json_escape "$SYSTEM_PROMPT")
ESCAPED_USER=$(json_escape "$USER_MSG")

# --- Call Evolink API ---
RESPONSE=$(curl -s "$API_URL" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $API_KEY" \
  -d "{
    \"model\": \"$MODEL\",
    \"max_tokens\": 4096,
    \"system\": $ESCAPED_SYSTEM,
    \"messages\": [{\"role\": \"user\", \"content\": $ESCAPED_USER}]
  }")

# --- Extract and display result ---
echo "$RESPONSE" | python3 -c "
import json, sys
try:
    data = json.load(sys.stdin)
    if 'content' in data:
        for block in data['content']:
            if block.get('type') == 'text':
                print(block['text'])
    elif 'error' in data:
        print(f\"Error: {data['error'].get('message', 'Unknown error')}\", file=sys.stderr)
        sys.exit(1)
except Exception as e:
    print(f'Error parsing response: {e}', file=sys.stderr)
    sys.exit(1)
"
