#!/usr/bin/env bash
set -euo pipefail

# Regex Assistant — AI-powered regular expression generation, explanation, and testing
# Usage: bash regex.sh <command> [options]
#
# Commands:
#   cheatsheet                               — Quick reference for regex syntax
#   generate "<description>" [--lang <lang>]  — AI generate regex from natural language
#   explain "<pattern>" [--lang <lang>]       — AI explain regex pattern in plain language
#   test "<pattern>" <file>                  — AI analyze matches and edge cases
#   debug "<pattern>" "<input>" "<expected>"  — AI diagnose why a regex fails
#   convert "<pattern>" --from <lang> --to <lang> — AI convert regex between languages

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
    json.dump(data, f, ensure_ascii=False)
" "$native_prompt" "$native_content" "$native_payload" "$model"

  local response
  response=$(curl -sS "$EVOLINK_API" \
    -H "Content-Type: application/json" \
    -H "x-api-key: $api_key" \
    -H "anthropic-version: 2023-06-01" \
    -d @"$tmp_payload")

  python3 -c "
import json, sys
try:
    data = json.loads(sys.argv[1])
    if 'content' in data:
        for block in data['content']:
            if block.get('type') == 'text':
                print(block['text'])
                break
    elif 'error' in data:
        print('API Error: ' + data['error'].get('message', str(data['error'])), file=sys.stderr)
        sys.exit(1)
    else:
        print('Unexpected response format', file=sys.stderr)
        sys.exit(1)
except Exception as e:
    print(f'Parse error: {e}', file=sys.stderr)
    sys.exit(1)
" "$response"
}

# --- Local Commands ---

cmd_cheatsheet() {
  cat <<'EOF'
Regex Quick Reference
=====================

Characters:
  .          Any character (except newline)
  \d         Digit [0-9]
  \D         Non-digit
  \w         Word character [a-zA-Z0-9_]
  \W         Non-word character
  \s         Whitespace (space, tab, newline)
  \S         Non-whitespace
  \b         Word boundary
  \B         Non-word boundary

Quantifiers:
  *          0 or more
  +          1 or more
  ?          0 or 1 (optional)
  {n}        Exactly n
  {n,}       n or more
  {n,m}      Between n and m
  *?  +?     Non-greedy (lazy) versions

Groups & References:
  (abc)      Capture group
  (?:abc)    Non-capturing group
  (?<name>)  Named capture group
  \1         Backreference to group 1
  (?=abc)    Positive lookahead
  (?!abc)    Negative lookahead
  (?<=abc)   Positive lookbehind
  (?<!abc)   Negative lookbehind

Character Classes:
  [abc]      Any of a, b, or c
  [^abc]     Not a, b, or c
  [a-z]      Range a to z
  [a-zA-Z]   Any letter

Anchors:
  ^          Start of string/line
  $          End of string/line

Flags:
  i          Case-insensitive
  g          Global (all matches)
  m          Multiline (^ and $ match line boundaries)
  s          Dotall (. matches newline)
  x          Verbose (ignore whitespace, allow comments)

Common Patterns:
  Email       [a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}
  URL         https?://[^\s]+
  IPv4        \d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}
  Phone (US)  \(?\d{3}\)?[-.\s]?\d{3}[-.\s]?\d{4}
  Date        \d{4}-\d{2}-\d{2}
  Hex color   #[0-9a-fA-F]{6}

Language Differences:
  Python      re.compile(r"pattern", re.IGNORECASE)
  JavaScript  /pattern/gi
  Go          regexp.MustCompile(`pattern`)
  Java        Pattern.compile("pattern", Pattern.CASE_INSENSITIVE)
  Rust        Regex::new(r"pattern")

Usage:
  bash regex.sh generate "match email addresses" --lang python
  bash regex.sh explain "\b\d{1,3}(\.\d{1,3}){3}\b"
  bash regex.sh test "\d+" data.txt
EOF
}

# --- AI Commands ---

cmd_generate() {
  [ $# -ge 1 ] || err "Usage: bash regex.sh generate \"<description>\" [--lang <lang>]"

  local description=""
  local lang="generic"

  while [ $# -gt 0 ]; do
    case "$1" in
      --lang) lang="${2:?Missing language value}"; shift 2 ;;
      *) description="$1"; shift ;;
    esac
  done

  [ -n "$description" ] || err "Missing description."

  check_deps
  echo "Generating regex pattern..." >&2

  local prompt="You are a regex expert. Generate a regular expression based on the user's description.

Language/flavor: $lang

Requirements:
1. Output the regex pattern first, on its own line
2. If a specific language was requested, show the complete usage code (import, compile, match)
3. Explain what each part of the pattern does
4. List 3-5 example strings that MATCH
5. List 3-5 example strings that DO NOT match
6. Note any edge cases or limitations
7. If the pattern uses features not available in all regex flavors, mention compatibility"

  evolink_ai "$prompt" "Description: $description
Language: $lang"
}

cmd_explain() {
  [ $# -ge 1 ] || err "Usage: bash regex.sh explain \"<pattern>\" [--lang <lang>]"

  local pattern=""
  local lang="generic"

  while [ $# -gt 0 ]; do
    case "$1" in
      --lang) lang="${2:?Missing language value}"; shift 2 ;;
      *) pattern="$1"; shift ;;
    esac
  done

  [ -n "$pattern" ] || err "Missing pattern."

  check_deps
  echo "Explaining regex pattern..." >&2

  local prompt="You are a regex expert. Explain the following regular expression in clear, plain language.

Requirements:
1. Give a one-sentence summary of what the pattern matches
2. Break down each component of the pattern with an explanation
3. Show a visual breakdown (character by character or group by group)
4. List 3 example strings that match and 3 that don't
5. Note any potential issues (catastrophic backtracking, over-matching, under-matching)
6. If a language is specified, note any flavor-specific behavior"

  evolink_ai "$prompt" "Pattern: $pattern
Language flavor: $lang"
}

cmd_test() {
  [ $# -ge 2 ] || err "Usage: bash regex.sh test \"<pattern>\" <file>"

  local pattern="$1"
  local file="$2"

  check_deps
  local content
  content=$(read_file "$file")
  content="${content:0:8000}"

  echo "Testing regex against file content..." >&2

  local prompt="You are a regex testing expert. Test the given pattern against the provided text content.

Requirements:
1. List all matches found (show line number, matched text, and capture groups if any)
2. Show total match count
3. Identify any false positives (matches that probably shouldn't match based on the pattern's likely intent)
4. Identify potential false negatives (text that looks like it should match but doesn't)
5. Suggest pattern improvements if issues are found
6. Rate the pattern's precision for this input: High / Medium / Low"

  evolink_ai "$prompt" "Pattern: $pattern

Test content:
$content"
}

cmd_debug() {
  [ $# -ge 3 ] || err "Usage: bash regex.sh debug \"<pattern>\" \"<input>\" \"<expected>\""

  local pattern="$1"
  local input="$2"
  local expected="$3"

  check_deps
  echo "Debugging regex..." >&2

  local prompt="You are a regex debugging expert. The user has a regex pattern that isn't working as expected. Diagnose the issue and provide a fix.

Requirements:
1. Explain WHY the current pattern fails on the given input
2. Walk through the regex engine's matching process step by step
3. Identify the specific part of the pattern causing the failure
4. Provide a corrected pattern that produces the expected result
5. Test the corrected pattern against the input to verify
6. Explain what changed and why the fix works
7. List any other inputs that might still fail with the corrected pattern"

  evolink_ai "$prompt" "Pattern: $pattern
Input: $input
Expected behavior: $expected"
}

cmd_convert() {
  [ $# -ge 1 ] || err "Usage: bash regex.sh convert \"<pattern>\" --from <lang> --to <lang>"

  local pattern=""
  local from_lang=""
  local to_lang=""

  while [ $# -gt 0 ]; do
    case "$1" in
      --from) from_lang="${2:?Missing source language}"; shift 2 ;;
      --to)   to_lang="${2:?Missing target language}"; shift 2 ;;
      *) pattern="$1"; shift ;;
    esac
  done

  [ -n "$pattern" ] || err "Missing pattern."
  [ -n "$from_lang" ] || err "Missing --from <lang>"
  [ -n "$to_lang" ] || err "Missing --to <lang>"

  check_deps
  echo "Converting regex from $from_lang to $to_lang..." >&2

  local prompt="You are a regex cross-language conversion expert. Convert the given regex pattern from one language/flavor to another.

Requirements:
1. Show the original pattern and its meaning
2. Show the converted pattern for the target language
3. Provide complete, runnable code in the target language (import, compile, match example)
4. List any features that don't translate directly and how you handled them
   - Lookbehind limitations (JS doesn't support variable-length lookbehind)
   - Named group syntax differences (Python: (?P<name>), JS: (?<name>))
   - Flag differences (Python: re.DOTALL, JS: /s flag)
   - Unicode property support differences
5. Note any behavioral differences between the two flavors
6. Provide a test case that works in both languages"

  evolink_ai "$prompt" "Pattern: $pattern
Source language: $from_lang
Target language: $to_lang"
}

# --- Main ---
COMMAND="${1:-help}"
shift || true

case "$COMMAND" in
  cheatsheet)  cmd_cheatsheet ;;
  generate)    cmd_generate "$@" ;;
  explain)     cmd_explain "$@" ;;
  test)        cmd_test "$@" ;;
  debug)       cmd_debug "$@" ;;
  convert)     cmd_convert "$@" ;;
  help|*)
    echo "Regex Assistant — AI-powered regular expression generation, explanation, and testing"
    echo ""
    echo "Usage: bash regex.sh <command> [options]"
    echo ""
    echo "Local Commands (no API key needed):"
    echo "  cheatsheet                               Regex syntax quick reference"
    echo ""
    echo "AI Commands (requires EVOLINK_API_KEY):"
    echo "  generate \"<description>\" [--lang <lang>]  AI generate regex from description"
    echo "  explain \"<pattern>\" [--lang <lang>]       AI explain regex in plain language"
    echo "  test \"<pattern>\" <file>                   AI analyze matches and edge cases"
    echo "  debug \"<pattern>\" \"<input>\" \"<expected>\"   AI diagnose regex failures"
    echo "  convert \"<pattern>\" --from <l> --to <l>   AI convert regex between languages"
    echo ""
    echo "Languages: python, javascript, go, java, rust, php, ruby, csharp, perl"
    echo ""
    echo "Get a free EvoLink API key: https://evolink.ai/signup"
    ;;
esac
