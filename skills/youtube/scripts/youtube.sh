#!/usr/bin/env bash
set -euo pipefail

# YouTube Assistant — Fetch transcripts, metadata, and analyze videos with AI
# Usage: bash youtube.sh <command> [options]
#
# Commands:
#   transcript <URL> [--lang LANG]     — Get video transcript (cleaned text)
#   info <URL>                         — Get video metadata
#   channel <CHANNEL_URL> [limit]      — List channel videos
#   search <query> [limit]             — Search YouTube
#   ai-summary <URL>                   — AI-summarize video content
#   ai-takeaways <URL>                 — Extract key takeaways
#   ai-compare <URL1> <URL2> [URL3..]  — Compare multiple videos
#   ai-ask <URL> <question>            — Ask about a video

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
EVOLINK_API="https://api.evolink.ai/v1/messages"

# --- Helpers ---
err() { echo "Error: $*" >&2; exit 1; }

# Convert Git Bash paths (/c/Users/...) to native paths (C:/Users/...) for Python
to_native_path() {
  if [[ "$1" =~ ^/([a-zA-Z])/ ]]; then
    echo "${BASH_REMATCH[1]}:/${1:3}"
  else
    echo "$1"
  fi
}

# Check yt-dlp is installed
check_deps() {
  command -v yt-dlp &>/dev/null || err "yt-dlp not found. Install: pip install yt-dlp"
  command -v python3 &>/dev/null || err "python3 not found."
  command -v curl &>/dev/null || err "curl not found."
}

# Extract video ID from various YouTube URL formats
extract_video_id() {
  local url="$1"
  python3 -c "
import re, sys
url = '''$url'''.strip()
patterns = [
    r'(?:youtube\.com/watch\?v=|youtu\.be/|youtube\.com/embed/|youtube\.com/v/|youtube\.com/shorts/)([a-zA-Z0-9_-]{11})',
    r'^([a-zA-Z0-9_-]{11})$'
]
for p in patterns:
    m = re.search(p, url)
    if m:
        print(m.group(1))
        sys.exit(0)
print('')
" | tr -d '\r'
}

# Get transcript using yt-dlp
get_transcript() {
  local url="$1"
  local lang="${2:-en}"
  local tmpdir
  tmpdir=$(mktemp -d)
  trap "rm -rf '$tmpdir'" RETURN

  # Try manual subtitles first, then auto-generated
  local sub_file=""

  # Try manual subs
  yt-dlp --skip-download --write-sub --sub-lang "$lang" \
    --sub-format vtt -o "$tmpdir/sub" "$url" 2>/dev/null || true

  sub_file=$(find "$tmpdir" -name "*.vtt" 2>/dev/null | head -1)

  # Fallback to auto subs
  if [ -z "$sub_file" ]; then
    yt-dlp --skip-download --write-auto-sub --sub-lang "$lang" \
      --sub-format vtt -o "$tmpdir/sub" "$url" 2>/dev/null || true
    sub_file=$(find "$tmpdir" -name "*.vtt" 2>/dev/null | head -1)
  fi

  # Try without language filter (any available sub)
  if [ -z "$sub_file" ]; then
    yt-dlp --skip-download --write-auto-sub \
      --sub-format vtt -o "$tmpdir/sub" "$url" 2>/dev/null || true
    sub_file=$(find "$tmpdir" -name "*.vtt" 2>/dev/null | head -1)
  fi

  if [ -z "$sub_file" ]; then
    err "No subtitles available for this video. Try a different language with --lang."
  fi

  local native_sub
  native_sub=$(to_native_path "$sub_file")

  # Clean VTT to plain text
  python3 -c "
import re

with open('$native_sub', 'r', encoding='utf-8') as f:
    content = f.read()

# Remove VTT header
content = re.sub(r'^WEBVTT.*?\n\n', '', content, flags=re.DOTALL)

# Remove timestamps and position info
content = re.sub(r'\d{2}:\d{2}:\d{2}\.\d{3}\s*-->\s*\d{2}:\d{2}:\d{2}\.\d{3}.*\n', '', content)

# Remove HTML tags
content = re.sub(r'<[^>]+>', '', content)

# Remove duplicate lines (yt auto-subs repeat lines)
seen = []
for line in content.strip().split('\n'):
    line = line.strip()
    if line and line not in seen[-3:] if seen else True:
        seen.append(line)

# Join into paragraphs
text = ' '.join(seen)
# Clean extra whitespace
text = re.sub(r'\s+', ' ', text).strip()
print(text)
" | tr -d '\r'
}

# Get video metadata via yt-dlp JSON
get_metadata() {
  local url="$1"
  yt-dlp --skip-download --dump-json --no-warnings "$url" 2>/dev/null | python3 -c "
import json, sys

data = json.load(sys.stdin)

duration_s = data.get('duration', 0) or 0
hours = duration_s // 3600
mins = (duration_s % 3600) // 60
secs = duration_s % 60
duration = f'{hours}:{mins:02d}:{secs:02d}' if hours else f'{mins}:{secs:02d}'

views = data.get('view_count', 0) or 0
if views >= 1_000_000_000:
    views_str = f'{views/1_000_000_000:.1f}B'
elif views >= 1_000_000:
    views_str = f'{views/1_000_000:.1f}M'
elif views >= 1_000:
    views_str = f'{views/1_000:.1f}K'
else:
    views_str = str(views)

likes = data.get('like_count', 0) or 0
comments = data.get('comment_count', 0) or 0

print(f\"Title:       {data.get('title', 'N/A')}\")
print(f\"Channel:     {data.get('channel', data.get('uploader', 'N/A'))}\")
print(f\"Duration:    {duration}\")
print(f\"Views:       {views_str}\")
print(f\"Likes:       {likes:,}\")
print(f\"Comments:    {comments:,}\")
print(f\"Published:   {data.get('upload_date', 'N/A')[:4]}-{data.get('upload_date', 'N/A')[4:6]}-{data.get('upload_date', 'N/A')[6:]}\")
print(f\"Description: {(data.get('description', '') or '')[:200]}\")
tags = data.get('tags', []) or []
if tags:
    print(f\"Tags:        {', '.join(tags[:10])}\")
" | tr -d '\r'
}

# Get compact metadata for AI context
get_metadata_compact() {
  local url="$1"
  yt-dlp --skip-download --dump-json --no-warnings "$url" 2>/dev/null | python3 -c "
import json, sys
data = json.load(sys.stdin)
duration_s = data.get('duration', 0) or 0
mins = duration_s // 60
secs = duration_s % 60
print(f\"Title: {data.get('title', 'N/A')}\")
print(f\"Channel: {data.get('channel', data.get('uploader', 'N/A'))}\")
print(f\"Duration: {mins}:{secs:02d}\")
print(f\"Views: {data.get('view_count', 0):,}\")
print(f\"Published: {data.get('upload_date', 'N/A')}\")
" | tr -d '\r'
}

evolink_ai() {
  local prompt="$1"
  local content="$2"

  local api_key="${EVOLINK_API_KEY:?Set EVOLINK_API_KEY for AI features. Get one at https://evolink.ai/signup}"
  local model="${EVOLINK_MODEL:-claude-opus-4-6}"

  local tmpfile
  tmpfile=$(mktemp)
  trap "rm -f '$tmpfile'" EXIT

  local native_tmp
  native_tmp=$(to_native_path "$tmpfile")

  python3 -c "
import json
data = {
    'model': '$model',
    'max_tokens': 4096,
    'messages': [
        {
            'role': 'user',
            'content': '''$prompt

$content'''
        }
    ]
}
with open('$native_tmp', 'w') as f:
    json.dump(data, f)
"

  local response
  response=$(curl -s -X POST "$EVOLINK_API" \
    -H "Authorization: Bearer $api_key" \
    -H "Content-Type: application/json" \
    -d "@$tmpfile")

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

# --- Commands ---

cmd_transcript() {
  local url="${1:?Usage: youtube.sh transcript <URL> [--lang LANG]}"
  local lang="en"

  shift
  while [[ $# -gt 0 ]]; do
    case "$1" in
      --lang) lang="${2:?Missing language code}"; shift 2 ;;
      *) shift ;;
    esac
  done

  check_deps

  local video_id
  video_id=$(extract_video_id "$url") || exit 1
  [ -z "$video_id" ] && err "Could not extract video ID from: $url"

  echo "Fetching transcript (lang: $lang)..." >&2
  get_transcript "$url" "$lang"
}

cmd_info() {
  local url="${1:?Usage: youtube.sh info <URL>}"
  check_deps

  local video_id
  video_id=$(extract_video_id "$url") || exit 1
  [ -z "$video_id" ] && err "Could not extract video ID from: $url"

  get_metadata "$url"
}

cmd_channel() {
  local channel_url="${1:?Usage: youtube.sh channel <CHANNEL_URL> [limit]}"
  local limit="${2:-10}"
  check_deps

  echo "Fetching channel videos..." >&2

  yt-dlp --flat-playlist --dump-json --no-warnings \
    --playlist-end "$limit" "$channel_url" 2>/dev/null | python3 -c "
import json, sys

videos = []
for line in sys.stdin:
    line = line.strip()
    if line:
        videos.append(json.loads(line))

if not videos:
    print('No videos found.')
    sys.exit(0)

print(f'Found {len(videos)} videos:')
print()
for i, v in enumerate(videos, 1):
    duration = v.get('duration', 0) or 0
    mins = duration // 60
    secs = duration % 60
    dur_str = f'{mins}:{secs:02d}'
    views = v.get('view_count', 0) or 0
    if views >= 1_000_000:
        views_str = f'{views/1_000_000:.1f}M'
    elif views >= 1_000:
        views_str = f'{views/1_000:.1f}K'
    else:
        views_str = str(views)
    vid_id = v.get('id', '')
    title = (v.get('title', 'N/A') or 'N/A')[:60]
    print(f'  {i:>3}. [{dur_str:>7}] {title:<62} {views_str:>8} views')
    print(f'       https://www.youtube.com/watch?v={vid_id}')
    print()
" | tr -d '\r'
}

cmd_search() {
  local query="${1:?Usage: youtube.sh search <query> [limit]}"
  local limit="${2:-5}"
  check_deps

  echo "Searching YouTube: $query..." >&2

  yt-dlp --flat-playlist --dump-json --no-warnings \
    --playlist-end "$limit" "ytsearch${limit}:${query}" 2>/dev/null | python3 -c "
import json, sys

videos = []
for line in sys.stdin:
    line = line.strip()
    if line:
        videos.append(json.loads(line))

if not videos:
    print('No results found.')
    sys.exit(0)

print(f'Found {len(videos)} results:')
print()
for i, v in enumerate(videos, 1):
    duration = v.get('duration', 0) or 0
    mins = duration // 60
    secs = duration % 60
    dur_str = f'{mins}:{secs:02d}'
    views = v.get('view_count', 0) or 0
    if views >= 1_000_000:
        views_str = f'{views/1_000_000:.1f}M'
    elif views >= 1_000:
        views_str = f'{views/1_000:.1f}K'
    else:
        views_str = str(views)
    channel = (v.get('channel', v.get('uploader', 'N/A')) or 'N/A')[:20]
    vid_id = v.get('id', '')
    title = (v.get('title', 'N/A') or 'N/A')[:55]
    print(f'  {i}. [{dur_str:>7}] {title:<57} {views_str:>8} views')
    print(f'     Channel: {channel}')
    print(f'     https://www.youtube.com/watch?v={vid_id}')
    print()
" | tr -d '\r'
}

# --- AI Commands ---

cmd_ai_summary() {
  local url="${1:?Usage: youtube.sh ai-summary <URL>}"
  check_deps

  echo "Fetching video info..." >&2
  local metadata
  metadata=$(get_metadata_compact "$url") || exit 1

  echo "Fetching transcript..." >&2
  local transcript
  transcript=$(get_transcript "$url" "en") || exit 1

  # Truncate very long transcripts
  local truncated
  truncated=$(echo "$transcript" | head -c 12000)

  echo "Generating AI summary..." >&2
  evolink_ai "You are a YouTube video analyst. Summarize the following video concisely and clearly. Include:

1. Overview (2-3 sentences)
2. Key Points (bullet list)
3. Topics Covered (numbered list)
4. Target Audience

Format with clear sections. Start with the video title and metadata." "VIDEO METADATA:
$metadata

TRANSCRIPT:
$truncated"
}

cmd_ai_takeaways() {
  local url="${1:?Usage: youtube.sh ai-takeaways <URL>}"
  check_deps

  echo "Fetching video info..." >&2
  local metadata
  metadata=$(get_metadata_compact "$url") || exit 1

  echo "Fetching transcript..." >&2
  local transcript
  transcript=$(get_transcript "$url" "en") || exit 1

  local truncated
  truncated=$(echo "$transcript" | head -c 12000)

  echo "Extracting takeaways..." >&2
  evolink_ai "You are a content analyst. Extract the key takeaways from this YouTube video. Include:

1. Main Thesis (1 sentence)
2. Key Takeaways (5-10 actionable bullet points)
3. Notable Quotes (if any, with approximate timestamps)
4. Action Items (what should the viewer do after watching?)

Be specific and actionable. No fluff." "VIDEO METADATA:
$metadata

TRANSCRIPT:
$truncated"
}

cmd_ai_compare() {
  if [ $# -lt 2 ]; then
    err "Usage: youtube.sh ai-compare <URL1> <URL2> [URL3...]"
  fi

  check_deps

  local all_content=""
  local idx=1

  for url in "$@"; do
    echo "Fetching video $idx: $url..." >&2
    local metadata
    metadata=$(get_metadata_compact "$url") || { echo "Warning: Could not fetch metadata for $url" >&2; continue; }

    local transcript
    transcript=$(get_transcript "$url" "en") || { echo "Warning: No transcript for $url" >&2; continue; }

    local truncated
    truncated=$(echo "$transcript" | head -c 6000)

    all_content+="
--- VIDEO $idx ---
$metadata

TRANSCRIPT (excerpt):
$truncated
"
    idx=$((idx + 1))
  done

  [ -z "$all_content" ] && err "Could not fetch any video content."

  echo "Comparing videos..." >&2
  evolink_ai "You are a content analyst. Compare the following YouTube videos. Include:

1. Overview of each video (1-2 sentences each)
2. Common Themes (what they share)
3. Key Differences (where they disagree or take different approaches)
4. Strengths of Each (what each does best)
5. Recommendation (which to watch for what purpose)

Be concise and insightful." "$all_content"
}

cmd_ai_ask() {
  local url="${1:?Usage: youtube.sh ai-ask <URL> <question>}"
  local question="${2:?Missing question}"
  check_deps

  echo "Fetching video info..." >&2
  local metadata
  metadata=$(get_metadata_compact "$url") || exit 1

  echo "Fetching transcript..." >&2
  local transcript
  transcript=$(get_transcript "$url" "en") || exit 1

  local truncated
  truncated=$(echo "$transcript" | head -c 12000)

  echo "Analyzing..." >&2
  evolink_ai "You are a helpful assistant answering questions about a YouTube video based on its transcript. Answer the user's question accurately based only on the video content. If the answer is not in the transcript, say so.

USER QUESTION: $question" "VIDEO METADATA:
$metadata

TRANSCRIPT:
$truncated"
}

# --- Main ---
COMMAND="${1:-help}"
shift || true

case "$COMMAND" in
  transcript)     cmd_transcript "$@" ;;
  info)           cmd_info "$@" ;;
  channel)        cmd_channel "$@" ;;
  search)         cmd_search "$@" ;;
  ai-summary)     cmd_ai_summary "$@" ;;
  ai-takeaways)   cmd_ai_takeaways "$@" ;;
  ai-compare)     cmd_ai_compare "$@" ;;
  ai-ask)         cmd_ai_ask "$@" ;;
  help|*)
    echo "YouTube Assistant — Fetch transcripts and analyze videos with AI"
    echo ""
    echo "Usage: bash youtube.sh <command> [options]"
    echo ""
    echo "Core Commands:"
    echo "  transcript <URL> [--lang LANG]    Get video transcript (cleaned text)"
    echo "  info <URL>                        Get video metadata"
    echo "  channel <CHANNEL_URL> [limit]     List channel videos"
    echo "  search <query> [limit]            Search YouTube"
    echo ""
    echo "AI Commands (requires EVOLINK_API_KEY):"
    echo "  ai-summary <URL>                  Summarize video content"
    echo "  ai-takeaways <URL>                Extract key takeaways"
    echo "  ai-compare <URL1> <URL2> [...]    Compare multiple videos"
    echo "  ai-ask <URL> <question>           Ask about a video"
    echo ""
    echo "Get a free EvoLink API key: https://evolink.ai/signup"
    ;;
esac
