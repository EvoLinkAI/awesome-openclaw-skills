#!/usr/bin/env bash
set -euo pipefail

# Subtitle Assistant — Download YouTube subtitles + AI summarize/translate
# Usage: bash subtitle.sh <command> [options]
#
# Commands:
#   download <url> [--lang <code>]          — Download subtitles to file
#   summarize <url|file> [--lang <code>]    — AI summarize subtitles
#   translate <url|file> --lang <language>  — AI translate subtitles
#   keypoints <url|file> [--lang <code>]    — AI extract key points
#   languages <url>                         — List available subtitle languages

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
EVOLINK_API="https://api.evolink.ai/v1/messages"

# --- Helpers ---
err() { echo "Error: $*" >&2; exit 1; }

to_native_path() {
  if [[ "$1" =~ ^/([a-zA-Z])/ ]]; then
    echo "${BASH_REMATCH[1]}:/${1:3}"
  else
    echo "$1"
  fi
}

check_deps() {
  command -v python3 &>/dev/null || err "python3 not found."
  command -v curl &>/dev/null || err "curl not found."
}

check_ytdlp() {
  command -v yt-dlp &>/dev/null || err "yt-dlp not found. Install: pip install yt-dlp"
}

is_url() {
  [[ "$1" =~ ^https?:// ]] || [[ "$1" =~ ^www\. ]]
}

read_file() {
  local file="$1"
  [ -f "$file" ] || err "File not found: $file"
  cat "$file"
}

evolink_ai() {
  local prompt="$1"
  local content="$2"

  local api_key="${EVOLINK_API_KEY:?Set EVOLINK_API_KEY for AI features. Get one at https://evolink.ai/signup}"
  local model="${EVOLINK_MODEL:-claude-opus-4-6}"

  local tmp_prompt tmp_content tmp_payload
  tmp_prompt=$(mktemp)
  tmp_content=$(mktemp)
  tmp_payload=$(mktemp)
  trap "rm -f '$tmp_prompt' '$tmp_content' '$tmp_payload'" EXIT

  printf '%s' "$prompt" > "$tmp_prompt"
  printf '%s' "$content" > "$tmp_content"

  local native_prompt native_content native_payload
  native_prompt=$(to_native_path "$tmp_prompt")
  native_content=$(to_native_path "$tmp_content")
  native_payload=$(to_native_path "$tmp_payload")

  python3 -c "
import json, sys

with open(sys.argv[1], 'r', encoding='utf-8') as f:
    prompt = f.read()
with open(sys.argv[2], 'r', encoding='utf-8') as f:
    content = f.read()

data = {
    'model': sys.argv[4],
    'max_tokens': 4096,
    'messages': [
        {
            'role': 'user',
            'content': prompt + '\n\n' + content
        }
    ]
}
with open(sys.argv[3], 'w', encoding='utf-8') as f:
    json.dump(data, f)
" "$native_prompt" "$native_content" "$native_payload" "$model"

  local response
  response=$(curl -s -X POST "$EVOLINK_API" \
    -H "Authorization: Bearer $api_key" \
    -H "Content-Type: application/json" \
    -d "@$tmp_payload")

  echo "$response" | python3 -c "
import json, sys
data = json.load(sys.stdin)
if 'content' in data:
    for block in data['content']:
        if block.get('type') == 'text':
            print(block['text'])
elif 'error' in data:
    print(f\"AI Error: {data['error'].get('message', str(data['error']))}\", file=sys.stderr)
else:
    print(json.dumps(data, indent=2))
"
}

# --- Subtitle download ---

download_subtitle() {
  local url="$1"
  local lang="${2:-en}"
  local output_dir="sub_temp"

  check_ytdlp
  mkdir -p "$output_dir"

  echo "Fetching subtitles (lang: $lang)..." >&2

  # Try manual subtitles first, then auto-generated
  local outfile
  outfile=$(yt-dlp \
    --write-sub --write-auto-sub \
    --sub-lang "$lang" \
    --sub-format "vtt/srt/best" \
    --skip-download \
    --convert-subs srt \
    -o "$output_dir/%(id)s.%(ext)s" \
    --print after_move:filepath \
    "$url" 2>/dev/null | grep -E '\.(srt|vtt)$' | head -1)

  # If --print didn't work, find the file
  if [ -z "$outfile" ]; then
    outfile=$(find "$output_dir" -name "*.srt" -newer "$output_dir" 2>/dev/null | head -1)
    if [ -z "$outfile" ]; then
      outfile=$(find "$output_dir" -name "*.vtt" -newer "$output_dir" 2>/dev/null | head -1)
    fi
  fi

  if [ -z "$outfile" ] || [ ! -f "$outfile" ]; then
    err "No subtitles found for language '$lang'. Try: subtitle.sh languages <url>"
  fi

  # Clean SRT: strip timestamps and sequence numbers, keep text
  local cleaned="${outfile%.srt}.txt"
  if [[ "$outfile" == *.srt ]]; then
    python3 -c "
import re, sys
with open(sys.argv[1], 'r', encoding='utf-8', errors='replace') as f:
    content = f.read()
# Remove sequence numbers, timestamps, and blank lines
lines = []
for line in content.split('\n'):
    line = line.strip()
    if not line:
        continue
    if re.match(r'^\d+$', line):
        continue
    if re.match(r'\d{2}:\d{2}:\d{2}', line):
        continue
    # Remove SRT tags
    line = re.sub(r'<[^>]+>', '', line)
    if line and line not in lines[-1:]:
        lines.append(line)
with open(sys.argv[2], 'w', encoding='utf-8') as f:
    f.write('\n'.join(lines))
" "$outfile" "$cleaned"
    echo "$cleaned"
  else
    echo "$outfile"
  fi
}

get_subtitle_text() {
  local source="$1"
  local lang="${2:-en}"

  if is_url "$source"; then
    local subfile
    subfile=$(download_subtitle "$source" "$lang")
    read_file "$subfile"
  else
    read_file "$source"
  fi
}

# --- Commands ---

cmd_download() {
  local url=""
  local lang="en"

  while [[ $# -gt 0 ]]; do
    case "$1" in
      --lang) lang="${2:?Missing language code}"; shift 2 ;;
      -*) err "Unknown option: $1" ;;
      *) url="$1"; shift ;;
    esac
  done

  [ -z "$url" ] && err "Usage: subtitle.sh download <youtube-url> [--lang <code>]"

  local subfile
  subfile=$(download_subtitle "$url" "$lang")
  echo "Subtitles saved to: $subfile"
  echo ""
  echo "Preview (first 10 lines):"
  head -10 "$subfile"
}

cmd_languages() {
  local url="${1:?Usage: subtitle.sh languages <youtube-url>}"
  check_ytdlp

  echo "Available subtitles:" >&2
  yt-dlp --list-subs "$url" 2>/dev/null | grep -E '^\w{2}' || echo "No subtitles found."
}

cmd_summarize() {
  local source=""
  local lang="en"

  while [[ $# -gt 0 ]]; do
    case "$1" in
      --lang) lang="${2:?Missing language code}"; shift 2 ;;
      -*) err "Unknown option: $1" ;;
      *) source="$1"; shift ;;
    esac
  done

  [ -z "$source" ] && err "Usage: subtitle.sh summarize <youtube-url|subtitle-file> [--lang <code>]"
  check_deps

  echo "Getting subtitles..." >&2
  local text
  text=$(get_subtitle_text "$source" "$lang")
  local truncated
  truncated=$(echo "$text" | head -c 12000)

  echo "Generating summary..." >&2
  evolink_ai "You are an expert content analyst. Summarize this video transcript:

1. **Title/Topic** — What is this video about, in one sentence.
2. **Summary** — A comprehensive 3-5 paragraph summary covering all major points.
3. **Key Takeaways** — Bullet list of the most important insights or facts.
4. **Notable Quotes** — Any memorable or significant statements (if any).

Be thorough but concise. Preserve technical details and specific data points." "VIDEO TRANSCRIPT:
$truncated"
}

cmd_translate() {
  local source=""
  local sub_lang="en"
  local target_lang=""

  while [[ $# -gt 0 ]]; do
    case "$1" in
      --lang) target_lang="${2:?Missing target language}"; shift 2 ;;
      --sub-lang) sub_lang="${2:?Missing subtitle language}"; shift 2 ;;
      -*) err "Unknown option: $1" ;;
      *) source="$1"; shift ;;
    esac
  done

  [ -z "$source" ] && err "Usage: subtitle.sh translate <youtube-url|file> --lang <target-language>"
  [ -z "$target_lang" ] && err "Missing --lang. Specify target language (e.g., --lang zh, --lang ja)"
  check_deps

  echo "Getting subtitles..." >&2
  local text
  text=$(get_subtitle_text "$source" "$sub_lang")
  local truncated
  truncated=$(echo "$text" | head -c 12000)

  echo "Translating..." >&2
  evolink_ai "You are a professional translator. Translate this video transcript to $target_lang.

Rules:
- Produce a natural, fluent translation — not word-for-word.
- Preserve technical terms, proper nouns, and brand names.
- Keep paragraph structure similar to the original.
- If the transcript has speaker labels, preserve them.
- Output ONLY the translation, no commentary." "TRANSCRIPT TO TRANSLATE:
$truncated"
}

cmd_keypoints() {
  local source=""
  local lang="en"

  while [[ $# -gt 0 ]]; do
    case "$1" in
      --lang) lang="${2:?Missing language code}"; shift 2 ;;
      -*) err "Unknown option: $1" ;;
      *) source="$1"; shift ;;
    esac
  done

  [ -z "$source" ] && err "Usage: subtitle.sh keypoints <youtube-url|subtitle-file> [--lang <code>]"
  check_deps

  echo "Getting subtitles..." >&2
  local text
  text=$(get_subtitle_text "$source" "$lang")
  local truncated
  truncated=$(echo "$text" | head -c 12000)

  echo "Extracting key points..." >&2
  evolink_ai "You are an expert content analyst. Extract structured key points from this video transcript:

1. **Main Topic** — One sentence.
2. **Key Points** — Numbered list, each with a brief explanation (1-2 sentences).
3. **Action Items** — If the video suggests things to do, list them.
4. **Technical Details** — Any specific tools, technologies, numbers, or data mentioned.
5. **Timestamps** — If you can infer topic transitions, note approximate positions (early/mid/late in video).

Focus on actionable, specific information. Skip filler and repetition." "VIDEO TRANSCRIPT:
$truncated"
}

# --- Main ---
COMMAND="${1:-help}"
shift || true

case "$COMMAND" in
  download)     cmd_download "$@" ;;
  languages)    cmd_languages "$@" ;;
  summarize)    cmd_summarize "$@" ;;
  translate)    cmd_translate "$@" ;;
  keypoints)    cmd_keypoints "$@" ;;
  help|*)
    echo "Subtitle Assistant — Download YouTube subtitles + AI analysis"
    echo ""
    echo "Usage: bash subtitle.sh <command> [options]"
    echo ""
    echo "Download Commands (requires yt-dlp):"
    echo "  download <url> [--lang <code>]          Download subtitles to file"
    echo "  languages <url>                         List available languages"
    echo ""
    echo "AI Commands (requires EVOLINK_API_KEY + yt-dlp):"
    echo "  summarize <url|file> [--lang <code>]    Summarize video content"
    echo "  translate <url|file> --lang <language>   Translate subtitles"
    echo "  keypoints <url|file> [--lang <code>]    Extract key points"
    echo ""
    echo "Examples:"
    echo "  subtitle.sh download \"https://youtube.com/watch?v=...\" --lang en"
    echo "  subtitle.sh summarize \"https://youtube.com/watch?v=...\""
    echo "  subtitle.sh translate subtitles.txt --lang zh"
    echo ""
    echo "Install yt-dlp: pip install yt-dlp"
    echo "Get a free EvoLink API key: https://evolink.ai/signup"
    ;;
esac
