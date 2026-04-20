#!/usr/bin/env bash
set -euo pipefail

# Content Rewriter — Rewrite content for different platforms and tones with AI
# Usage: bash rewriter.sh <command> [options]
#
# Commands:
#   platforms                          — List supported platforms
#   tones                              — List supported tones
#   rewrite <file> --platform <p> [--tone <t>]  — Rewrite for a platform
#   batch <file> --platforms <p1,p2>   — Batch rewrite for multiple platforms
#   score <file>                       — AI quality score
#   translate <file> --lang <language> — AI translation

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

  # Write prompt and content to files — never embed in code strings
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

# --- Platform Rules ---

get_platform_prompt() {
  local platform="$1"
  case "$platform" in
    twitter)
      echo "You are a Twitter/X copywriter. Rewrite the content as a tweet or thread.
Rules:
- Single tweet: max 280 characters. If content is complex, use a thread (each tweet max 280 chars).
- Hook in the first line — make people stop scrolling.
- Use 1-3 relevant hashtags at the end.
- Be punchy, direct, and conversational.
- Use line breaks for readability." ;;
    linkedin)
      echo "You are a LinkedIn content strategist. Rewrite the content as a LinkedIn post.
Rules:
- Max 3000 characters.
- Open with a bold hook or surprising statement.
- Use short paragraphs (1-2 sentences each) with line breaks between.
- Professional but personable tone.
- Tell a story or share a lesson.
- End with a clear call-to-action or question.
- No hashtags in body, add 3-5 at the very end." ;;
    blog)
      echo "You are an SEO-focused blog writer. Rewrite the content as a blog post.
Rules:
- Use a compelling H1 title with target keyword.
- Structure with H2 and H3 subheadings.
- Include an intro paragraph that hooks the reader and previews the content.
- Use bullet points and numbered lists where appropriate.
- Write in an expert, authoritative tone.
- Aim for 800-1500 words.
- Include a conclusion with key takeaways.
- Suggest a meta description (under 160 chars) at the end." ;;
    email)
      echo "You are an email copywriter. Rewrite the content as a professional email.
Rules:
- Write a clear, compelling subject line.
- Keep paragraphs short (2-3 sentences max).
- Use bullet points for key information.
- Scannable format — the reader should get the point in 10 seconds.
- Include a single, clear call-to-action.
- Professional sign-off.
- Total length: 150-300 words." ;;
    medium)
      echo "You are a Medium article writer. Rewrite the content as a Medium post.
Rules:
- Engaging, narrative-driven title.
- First-person perspective encouraged.
- Use storytelling structure: hook, context, insight, takeaway.
- Mix short and longer paragraphs for rhythm.
- Include pull quotes or bold statements for emphasis.
- Add relevant subheadings every 3-4 paragraphs.
- 1000-2000 words.
- End with a reflective conclusion." ;;
    reddit)
      echo "You are writing a Reddit post. Rewrite the content for a Reddit audience.
Rules:
- Start with a clear, descriptive title (no clickbait — Redditors hate that).
- Add a TL;DR at the top or bottom.
- Conversational, authentic tone. No marketing speak.
- Be direct and honest — include caveats and limitations.
- Use markdown formatting (bold, bullet points).
- Anticipate questions and address them.
- Keep it concise but thorough." ;;
    producthunt)
      echo "You are writing a Product Hunt launch post. Rewrite the content as a PH description.
Rules:
- Tagline: max 60 characters, punchy and clear.
- Description: 3-5 short paragraphs.
- Lead with the problem you solve.
- List 3-5 key features with emoji bullets.
- Include social proof or metrics if available.
- End with a clear CTA.
- Tone: enthusiastic but not hypey." ;;
    wechat)
      echo "You are a WeChat Official Account content writer. Rewrite for a Chinese WeChat audience.
Rules:
- Write entirely in Chinese (Simplified).
- Title: punchy, under 30 characters, can use numbers or questions.
- Short paragraphs (1-3 sentences each) — mobile reading experience.
- Use bold for emphasis on key phrases.
- Conversational and accessible, not overly formal.
- Include section breaks for visual breathing room.
- End with a call-to-action (follow, share, comment).
- 800-1500 characters." ;;
    *)
      err "Unknown platform: $platform. Run 'rewriter.sh platforms' for the list." ;;
  esac
}

# --- Commands ---

cmd_platforms() {
  echo "Supported Platforms:"
  echo ""
  echo "  twitter       280 chars, punchy hooks, hashtags"
  echo "  linkedin      3000 chars, professional storytelling, CTA"
  echo "  blog          Long-form, SEO-optimized, H2/H3 structure"
  echo "  email         Scannable, clear subject line, single CTA"
  echo "  medium        Narrative-driven, first-person, 1000-2000 words"
  echo "  reddit        Honest, no-BS tone, TL;DR, community-friendly"
  echo "  producthunt   Launch description, problem-solution, emoji bullets"
  echo "  wechat        Chinese, short paragraphs, mobile-optimized"
}

cmd_tones() {
  echo "Supported Tones:"
  echo ""
  echo "  professional   Formal, polished, corporate-appropriate"
  echo "  casual         Relaxed, friendly, approachable"
  echo "  humorous       Witty, fun, uses humor to engage"
  echo "  inspirational  Motivating, uplifting, empowering"
  echo "  educational    Clear, explanatory, teaching-focused"
  echo "  persuasive     Compelling, action-driving, benefit-focused"
  echo "  technical      Precise, detailed, jargon-appropriate"
  echo "  storytelling   Narrative-driven, emotional, personal"
}

cmd_rewrite() {
  local file=""
  local platform=""
  local tone=""

  while [[ $# -gt 0 ]]; do
    case "$1" in
      --platform) platform="${2:?Missing platform}"; shift 2 ;;
      --tone) tone="${2:?Missing tone}"; shift 2 ;;
      -*) err "Unknown option: $1" ;;
      *) file="$1"; shift ;;
    esac
  done

  [ -z "$file" ] && err "Usage: rewriter.sh rewrite <file> --platform <platform> [--tone <tone>]"
  [ -z "$platform" ] && err "Missing --platform. Run 'rewriter.sh platforms' for options."

  check_deps

  echo "Reading content..." >&2
  local content
  content=$(read_file "$file")

  local truncated
  truncated=$(echo "$content" | head -c 12000)

  local platform_prompt
  platform_prompt=$(get_platform_prompt "$platform")

  local tone_instruction=""
  if [ -n "$tone" ]; then
    tone_instruction="

IMPORTANT: Apply a $tone tone throughout. Adjust word choice, sentence structure, and energy to match this tone while following the platform rules above."
  fi

  echo "Rewriting for $platform..." >&2
  evolink_ai "${platform_prompt}${tone_instruction}

Rewrite the following content according to the rules above. Output ONLY the rewritten content, no explanations." "ORIGINAL CONTENT:
$truncated"
}

cmd_batch() {
  local file=""
  local platforms=""

  while [[ $# -gt 0 ]]; do
    case "$1" in
      --platforms) platforms="${2:?Missing platforms}"; shift 2 ;;
      -*) err "Unknown option: $1" ;;
      *) file="$1"; shift ;;
    esac
  done

  [ -z "$file" ] && err "Usage: rewriter.sh batch <file> --platforms <p1,p2,p3>"
  [ -z "$platforms" ] && err "Missing --platforms."

  check_deps

  echo "Reading content..." >&2
  local content
  content=$(read_file "$file")

  local truncated
  truncated=$(echo "$content" | head -c 12000)

  IFS=',' read -ra platform_list <<< "$platforms"

  for p in "${platform_list[@]}"; do
    p=$(echo "$p" | tr -d ' ')
    echo "" >&2
    echo "=== Rewriting for: $p ===" >&2

    local platform_prompt
    platform_prompt=$(get_platform_prompt "$p")

    echo "--- $p ---"
    evolink_ai "${platform_prompt}

Rewrite the following content according to the rules above. Output ONLY the rewritten content, no explanations." "ORIGINAL CONTENT:
$truncated"
    echo ""
    echo "---"
    echo ""
  done
}

cmd_score() {
  local file="${1:?Usage: rewriter.sh score <file>}"
  check_deps

  echo "Reading content..." >&2
  local content
  content=$(read_file "$file")

  local truncated
  truncated=$(echo "$content" | head -c 12000)

  echo "Analyzing content quality..." >&2
  evolink_ai "You are a content quality analyst. Score the following content on these dimensions (1-10 each):

1. Readability — How easy is it to read and understand?
2. Engagement — How likely is a reader to finish and share it?
3. SEO Potential — How well-optimized for search engines?
4. Clarity — How clear and focused is the message?
5. Professionalism — How polished and credible does it feel?

For each dimension, give a score (1-10) and a one-sentence explanation.

Then provide:
- Overall Score (average of all 5)
- Top 3 specific improvements to make

Format as a clean, structured report." "CONTENT TO ANALYZE:
$truncated"
}

cmd_translate() {
  local file=""
  local lang=""

  while [[ $# -gt 0 ]]; do
    case "$1" in
      --lang) lang="${2:?Missing language}"; shift 2 ;;
      -*) err "Unknown option: $1" ;;
      *) file="$1"; shift ;;
    esac
  done

  [ -z "$file" ] && err "Usage: rewriter.sh translate <file> --lang <language>"
  [ -z "$lang" ] && err "Missing --lang."

  check_deps

  echo "Reading content..." >&2
  local content
  content=$(read_file "$file")

  local truncated
  truncated=$(echo "$content" | head -c 12000)

  echo "Translating to $lang..." >&2
  evolink_ai "You are a professional translator. Translate the following content into $lang.

Rules:
- Preserve the original tone, structure, and formatting.
- Adapt idioms and cultural references naturally — don't translate literally.
- Keep technical terms in their commonly used form in the target language.
- Maintain paragraph structure and any markdown formatting.
- Output ONLY the translation, no explanations or notes." "CONTENT TO TRANSLATE:
$truncated"
}

# --- Main ---
COMMAND="${1:-help}"
shift || true

case "$COMMAND" in
  platforms)    cmd_platforms ;;
  tones)        cmd_tones ;;
  rewrite)      cmd_rewrite "$@" ;;
  batch)        cmd_batch "$@" ;;
  score)        cmd_score "$@" ;;
  translate)    cmd_translate "$@" ;;
  help|*)
    echo "Content Rewriter — Rewrite content for any platform with AI"
    echo ""
    echo "Usage: bash rewriter.sh <command> [options]"
    echo ""
    echo "Info Commands:"
    echo "  platforms                          List supported platforms"
    echo "  tones                              List supported tones"
    echo ""
    echo "AI Commands (requires EVOLINK_API_KEY):"
    echo "  rewrite <file> --platform <p> [--tone <t>]  Rewrite for a platform"
    echo "  batch <file> --platforms <p1,p2,...>         Batch rewrite"
    echo "  score <file>                                Quality score"
    echo "  translate <file> --lang <language>           Translate"
    echo ""
    echo "Platforms: twitter, linkedin, blog, email, medium, reddit, producthunt, wechat"
    echo "Tones: professional, casual, humorous, inspirational, educational, persuasive, technical, storytelling"
    echo ""
    echo "Get a free EvoLink API key: https://evolink.ai/signup"
    ;;
esac
