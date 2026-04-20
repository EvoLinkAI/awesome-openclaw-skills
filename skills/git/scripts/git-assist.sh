#!/usr/bin/env bash
set -euo pipefail

# Git Assistant — AI-powered git workflow helper
# Usage: bash git-assist.sh <command> [options]
#
# Commands:
#   conventions                            — Conventional Commits quick reference
#   commit                                 — AI generate commit message from staged changes
#   review <message>                       — AI review commit message quality
#   changelog [--from <tag>]               — AI generate changelog from git log
#   release [--from <tag>] [--to <tag>]    — AI generate release notes between tags
#   pr                                     — AI generate PR description from branch diff

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
  command -v git &>/dev/null || err "git not found."
}

check_git_repo() {
  git rev-parse --is-inside-work-tree &>/dev/null || err "Not inside a git repository."
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
  response=$(curl -sS "$EVOLINK_API" \
    -H "Content-Type: application/json" \
    -H "x-api-key: $api_key" \
    -H "anthropic-version: 2023-06-01" \
    -d @"$tmp_payload" 2>&1)

  python3 -c "
import json, sys
try:
    data = json.loads(sys.argv[1])
    if 'content' in data and len(data['content']) > 0:
        print(data['content'][0].get('text', ''))
    elif 'error' in data:
        print('API Error: ' + data['error'].get('message', str(data['error'])), file=sys.stderr)
        sys.exit(1)
    else:
        print('Unexpected response format', file=sys.stderr)
        sys.exit(1)
except json.JSONDecodeError:
    print('Failed to parse API response', file=sys.stderr)
    sys.exit(1)
" "$response"
}

# --- Local Commands ---

cmd_conventions() {
  cat <<'EOF'
Conventional Commits Quick Reference
=====================================

Format:
  <type>(<scope>): <description>

  [optional body]

  [optional footer(s)]

Types:
  feat      New feature                          → MINOR version bump
  fix       Bug fix                              → PATCH version bump
  docs      Documentation only
  style     Formatting, semicolons, etc. (no code change)
  refactor  Code change that neither fixes nor adds
  perf      Performance improvement
  test      Adding or correcting tests
  build     Build system or external dependencies
  ci        CI configuration and scripts
  chore     Other changes (no src or test)
  revert    Reverts a previous commit

Breaking Changes:
  Add BREAKING CHANGE: in the footer, or append ! after the type:
    feat!: remove deprecated login endpoint

Scope:
  Optional, in parentheses: feat(auth): add OAuth2 support

Examples:
  fix(parser): handle empty input without crash
  feat(api): add pagination to /users endpoint
  docs: update README with new install steps
  refactor!: rename User model to Account

  feat(cart): add bulk discount calculation

  Implement tiered pricing for bulk orders.
  Discounts apply automatically at checkout.

  BREAKING CHANGE: cart total API response now includes discount_amount field

Rules:
  1. Use imperative mood: "add" not "added" or "adds"
  2. Don't capitalize the description
  3. No period at the end of the description
  4. Separate subject from body with a blank line
  5. Keep subject line under 72 characters
EOF
}

# --- AI Commands ---

cmd_commit() {
  check_deps
  check_git_repo

  local diff
  diff=$(git diff --cached --stat 2>/dev/null)

  if [ -z "$diff" ]; then
    err "No staged changes. Run 'git add' first."
  fi

  local full_diff
  full_diff=$(git diff --cached 2>/dev/null)

  # Truncate to 12000 chars
  full_diff="${full_diff:0:12000}"

  local staged_files
  staged_files=$(git diff --cached --name-only 2>/dev/null)

  echo "Analyzing staged changes..." >&2

  local prompt="You are an expert software engineer. Generate a git commit message following the Conventional Commits specification.

Analyze the staged changes below and produce a commit message.

Rules:
1. First line: <type>(<scope>): <description> — max 72 characters
2. Types: feat, fix, docs, style, refactor, perf, test, build, ci, chore, revert
3. Scope: the module or area affected (infer from file paths)
4. Description: imperative mood, lowercase, no period
5. If the change is non-trivial, add a body after a blank line explaining WHAT and WHY
6. If there are breaking changes, add: BREAKING CHANGE: <explanation>
7. Do NOT explain the format or add commentary — output ONLY the commit message

Staged files:
$staged_files

Diff statistics:
$diff"

  evolink_ai "$prompt" "$full_diff"
}

cmd_review() {
  local message="${1:-}"
  [ -n "$message" ] || err "Usage: bash git-assist.sh review \"your commit message\""

  check_deps

  echo "Reviewing commit message..." >&2

  local prompt="You are a code review expert specializing in git commit quality. Review this commit message against the Conventional Commits specification and general best practices.

Score it 1-10 and check:
1. Has a valid type prefix (feat, fix, docs, style, refactor, perf, test, build, ci, chore, revert)
2. Has a scope (optional but recommended)
3. Description is imperative mood, lowercase, no period, under 72 chars
4. Body (if present) explains what and why, not how
5. Breaking changes are properly noted
6. Message is specific enough to understand the change without reading code
7. No vague words (fix stuff, update things, misc changes)

For each check, mark as:
  [PASS] — meets the standard
  [FAIL] — violates the standard
  [WARN] — could be improved

End with a suggested rewrite if the score is below 8.

Format:
  Score: X/10
  (checks)
  Suggested rewrite: (if needed)"

  evolink_ai "$prompt" "Commit message to review: $message"
}

cmd_changelog() {
  check_deps
  check_git_repo

  local from_tag=""
  while [[ $# -gt 0 ]]; do
    case "$1" in
      --from) from_tag="${2:-}"; shift 2 ;;
      *) shift ;;
    esac
  done

  local log_cmd="git log --oneline --no-merges"
  if [ -n "$from_tag" ]; then
    git rev-parse "$from_tag" &>/dev/null || err "Tag not found: $from_tag"
    log_cmd="$log_cmd ${from_tag}..HEAD"
  else
    log_cmd="$log_cmd -50"
  fi

  local log_output
  log_output=$(eval "$log_cmd" 2>/dev/null)

  if [ -z "$log_output" ]; then
    err "No commits found${from_tag:+ since $from_tag}."
  fi

  # Truncate
  log_output="${log_output:0:12000}"

  echo "Generating changelog..." >&2

  local prompt="You are a technical writer. Generate a clean, professional changelog from these git commits.

Rules:
1. Group commits by type: Features, Bug Fixes, Performance, Documentation, Other
2. Rewrite each entry to be user-facing and clear (not developer shorthand)
3. Remove commit hashes — this is for users, not developers
4. Use bullet points within each group
5. If commits follow Conventional Commits format, use the type to categorize
6. If commits don't follow conventions, infer the category from the message
7. Skip trivial commits (typo fixes, merge commits, version bumps) unless significant
8. Output in Markdown format

${from_tag:+Changes since: $from_tag}"

  evolink_ai "$prompt" "$log_output"
}

cmd_release() {
  check_deps
  check_git_repo

  local from_tag="" to_tag="HEAD"
  while [[ $# -gt 0 ]]; do
    case "$1" in
      --from) from_tag="${2:-}"; shift 2 ;;
      --to) to_tag="${2:-HEAD}"; shift 2 ;;
      *) shift ;;
    esac
  done

  if [ -z "$from_tag" ]; then
    from_tag=$(git describe --tags --abbrev=0 2>/dev/null || echo "")
    [ -n "$from_tag" ] || err "No tags found. Use --from <tag> to specify a starting point."
  fi

  git rev-parse "$from_tag" &>/dev/null || err "Tag not found: $from_tag"

  local log_output
  log_output=$(git log --oneline --no-merges "${from_tag}..${to_tag}" 2>/dev/null)

  if [ -z "$log_output" ]; then
    err "No commits found between $from_tag and $to_tag."
  fi

  local diff_stat
  diff_stat=$(git diff --stat "${from_tag}..${to_tag}" 2>/dev/null | tail -1)

  log_output="${log_output:0:12000}"

  echo "Generating release notes ($from_tag → $to_tag)..." >&2

  local prompt="You are a developer relations writer. Generate professional release notes for a software release.

Context:
- From: $from_tag
- To: $to_tag
- Stats: $diff_stat

Rules:
1. Start with a brief summary paragraph (2-3 sentences) highlighting the most important changes
2. Group into sections: Highlights, New Features, Bug Fixes, Improvements, Breaking Changes
3. Only include sections that have content
4. Each item should be a clear, user-facing description
5. For breaking changes, explain what users need to do to migrate
6. End with an upgrade instructions section if there are breaking changes
7. Output in Markdown format
8. Tone: professional but approachable"

  evolink_ai "$prompt" "$log_output"
}

cmd_pr() {
  check_deps
  check_git_repo

  local current_branch
  current_branch=$(git branch --show-current 2>/dev/null)
  [ -n "$current_branch" ] || err "Not on a branch (detached HEAD)."

  local base_branch
  base_branch=$(git rev-parse --abbrev-ref origin/HEAD 2>/dev/null | sed 's|origin/||' || echo "main")

  local diff_output
  diff_output=$(git diff "${base_branch}...${current_branch}" --stat 2>/dev/null || git diff "main...${current_branch}" --stat 2>/dev/null || git diff "master...${current_branch}" --stat 2>/dev/null || echo "")

  if [ -z "$diff_output" ]; then
    err "No diff found between $base_branch and $current_branch. Are you on a feature branch?"
  fi

  local full_diff
  full_diff=$(git diff "${base_branch}...${current_branch}" 2>/dev/null || git diff "main...${current_branch}" 2>/dev/null || git diff "master...${current_branch}" 2>/dev/null || echo "")
  full_diff="${full_diff:0:12000}"

  local commit_log
  commit_log=$(git log --oneline "${base_branch}..${current_branch}" 2>/dev/null || git log --oneline "main..${current_branch}" 2>/dev/null || git log --oneline "master..${current_branch}" 2>/dev/null || echo "")

  echo "Generating PR description ($current_branch → $base_branch)..." >&2

  local prompt="You are a senior engineer writing a pull request description. Generate a clear, professional PR description.

Branch: $current_branch → $base_branch

Rules:
1. Start with a one-line summary (## Summary)
2. Add a ## Changes section with bullet points of what changed
3. Add a ## Why section explaining the motivation
4. If there are breaking changes, add a ## Breaking Changes section
5. Add a ## Testing section suggesting what to test
6. Keep it concise — reviewers are busy
7. Output in Markdown format (GitHub-flavored)

Commits on this branch:
$commit_log

Diff statistics:
$diff_output"

  evolink_ai "$prompt" "$full_diff"
}

# --- Main ---
COMMAND="${1:-help}"
shift || true

case "$COMMAND" in
  conventions) cmd_conventions ;;
  commit)      cmd_commit ;;
  review)      cmd_review "$@" ;;
  changelog)   cmd_changelog "$@" ;;
  release)     cmd_release "$@" ;;
  pr)          cmd_pr ;;
  help|*)
    echo "Git Assistant — AI-powered git workflow helper"
    echo ""
    echo "Usage: bash git-assist.sh <command> [options]"
    echo ""
    echo "Local Commands (no API key needed):"
    echo "  conventions                            Conventional Commits quick reference"
    echo ""
    echo "AI Commands (requires EVOLINK_API_KEY):"
    echo "  commit                                 AI generate commit message from staged changes"
    echo "  review <message>                       AI review commit message quality"
    echo "  changelog [--from <tag>]               AI generate changelog from git log"
    echo "  release [--from <tag>] [--to <tag>]    AI generate release notes between tags"
    echo "  pr                                     AI generate PR description from branch diff"
    echo ""
    echo "Get a free EvoLink API key: https://evolink.ai/signup"
    ;;
esac
