#!/usr/bin/env bash
set -euo pipefail

# Slack Assistant — Send messages, read channels, search, and manage Slack with AI features
# Usage: bash slack.sh <command> [options]
#
# Commands:
#   channels                           — List channels
#   list <#channel> [limit]            — List recent messages in a channel
#   send <#channel|@user> <message>    — Send a message
#   reply <channel_id> <ts> <message>  — Reply in a thread
#   search <query>                     — Search messages
#   read <channel_id> <ts>             — Read a specific message and its thread
#   users                              — List workspace users
#   create-channel <name> [--private]  — Create a channel
#   invite <#channel> <@user>          — Invite user to channel
#   archive <#channel>                 — Archive a channel
#   upload <#channel> <file_path>      — Upload a file
#   react <channel_id> <ts> <emoji>    — Add reaction
#   profile                            — View bot profile
#   ai-summary <#channel> [limit]      — AI-summarize channel activity
#   ai-reply <channel_id> <ts>         — AI-draft a reply
#   ai-prioritize <#channel> [limit]   — AI-rank messages by importance

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
CONFIG_DIR="${SLACK_SKILL_DIR:-$HOME/.slack-skill}"
TOKEN_FILE="$CONFIG_DIR/token.json"
CREDENTIALS_FILE="$CONFIG_DIR/credentials.json"

SLACK_API="https://slack.com/api"
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

TOKEN_FILE_NATIVE=$(to_native_path "$TOKEN_FILE")
CREDENTIALS_FILE_NATIVE=$(to_native_path "$CREDENTIALS_FILE")

get_bot_token() {
  local token=""

  # Try token.json first
  if [ -f "$TOKEN_FILE" ]; then
    token=$(python3 -c "import json; f=open('$TOKEN_FILE_NATIVE'); print(json.load(f).get('bot_token',''))" | tr -d '\r')
  fi

  # Fall back to credentials.json
  if [ -z "$token" ] && [ -f "$CREDENTIALS_FILE" ]; then
    token=$(python3 -c "import json; f=open('$CREDENTIALS_FILE_NATIVE'); print(json.load(f).get('bot_token',''))" | tr -d '\r')
  fi

  [ -z "$token" ] && err "Not authenticated. Run: bash scripts/slack-auth.sh login"
  echo "$token"
}

slack_get() {
  local method="$1"
  shift
  local token
  token=$(get_bot_token) || exit 1
  curl -s -H "Authorization: Bearer $token" "$SLACK_API/$method" "$@"
}

slack_post() {
  local method="$1"
  local data="$2"
  local token
  token=$(get_bot_token) || exit 1
  curl -s -X POST \
    -H "Authorization: Bearer $token" \
    -H "Content-Type: application/json" \
    -d "$data" \
    "$SLACK_API/$method"
}

slack_post_form() {
  local method="$1"
  shift
  local token
  token=$(get_bot_token) || exit 1
  curl -s -X POST \
    -H "Authorization: Bearer $token" \
    "$SLACK_API/$method" "$@"
}

# Resolve #channel-name to channel ID
resolve_channel() {
  local input="$1"
  input="${input#\#}"  # strip leading #

  # If it looks like an ID already (starts with C, G, or D), use directly
  if [[ "$input" =~ ^[CGD][A-Z0-9]+$ ]]; then
    echo "$input"
    return
  fi

  # Look up by name
  local result
  result=$(slack_get "conversations.list" -G -d "limit=999" -d "types=public_channel,private_channel")
  local channel_id
  channel_id=$(echo "$result" | python3 -c "
import json, sys
data = json.load(sys.stdin)
for ch in data.get('channels', []):
    if ch['name'] == '$input':
        print(ch['id'])
        sys.exit(0)
print('')
" | tr -d '\r')

  [ -z "$channel_id" ] && err "Channel '#$input' not found"
  echo "$channel_id"
}

# Resolve @username to user ID
resolve_user() {
  local input="$1"
  input="${input#@}"  # strip leading @

  # If it looks like a user ID already
  if [[ "$input" =~ ^[UW][A-Z0-9]+$ ]]; then
    echo "$input"
    return
  fi

  local result
  result=$(slack_get "users.list" -G -d "limit=999")
  local user_id
  user_id=$(echo "$result" | python3 -c "
import json, sys
data = json.load(sys.stdin)
for u in data.get('members', []):
    if u.get('name') == '$input' or u.get('real_name','').lower() == '$input'.lower():
        print(u['id'])
        sys.exit(0)
print('')
" | tr -d '\r')

  [ -z "$user_id" ] && err "User '@$input' not found"
  echo "$user_id"
}

# Open a DM channel with a user
open_dm() {
  local user_id="$1"
  local result
  result=$(slack_post "conversations.open" "{\"users\": \"$user_id\"}")
  echo "$result" | python3 -c "
import json, sys
data = json.load(sys.stdin)
if data.get('ok'):
    print(data['channel']['id'])
else:
    print('')
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
with open('$tmpfile', 'w') as f:
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

cmd_channels() {
  local result
  result=$(slack_get "conversations.list" -G -d "limit=200" -d "types=public_channel,private_channel")

  echo "$result" | python3 -c "
import json, sys
data = json.load(sys.stdin)
if not data.get('ok'):
    print(f\"Error: {data.get('error', 'unknown')}\")
    sys.exit(1)
channels = data.get('channels', [])
print(f'Found {len(channels)} channels:')
print()
for ch in sorted(channels, key=lambda x: x['name']):
    private = '🔒' if ch.get('is_private') else '  '
    members = ch.get('num_members', 0)
    purpose = ch.get('purpose', {}).get('value', '')[:40]
    print(f\"  {private} #{ch['name']:<30} {ch['id']:<12} ({members} members)  {purpose}\")
"
}

cmd_list() {
  local channel_input="${1:?Usage: slack.sh list <#channel> [limit]}"
  local limit="${2:-10}"

  local channel_id
  channel_id=$(resolve_channel "$channel_input") || exit 1

  local result
  result=$(slack_get "conversations.history" -G -d "channel=$channel_id" -d "limit=$limit")

  echo "$result" | python3 -c "
import json, sys
data = json.load(sys.stdin)
if not data.get('ok'):
    print(f\"Error: {data.get('error', 'unknown')}\")
    sys.exit(1)
messages = data.get('messages', [])
if not messages:
    print('No messages found.')
    sys.exit(0)
print(f'Last {len(messages)} messages:')
print()
for msg in reversed(messages):
    user = msg.get('user', msg.get('bot_id', 'unknown'))
    text = msg.get('text', '')[:100]
    ts = msg.get('ts', '')
    thread = ' [thread]' if msg.get('thread_ts') and msg.get('reply_count', 0) > 0 else ''
    replies = f' ({msg[\"reply_count\"]} replies)' if msg.get('reply_count', 0) > 0 else ''
    print(f\"  [{ts}] <{user}>{thread}{replies}\")
    print(f\"    {text}\")
    print()
"
}

cmd_send() {
  local target="${1:?Usage: slack.sh send <#channel|@user> <message>}"
  local message="${2:?Missing message text}"

  local channel_id

  if [[ "$target" == @* ]]; then
    # DM to user
    local user_id
    user_id=$(resolve_user "$target") || exit 1
    channel_id=$(open_dm "$user_id") || exit 1
    [ -z "$channel_id" ] && err "Could not open DM with $target"
  else
    channel_id=$(resolve_channel "$target") || exit 1
  fi

  local result
  result=$(slack_post "chat.postMessage" "{\"channel\": \"$channel_id\", \"text\": \"$message\"}")

  local ok
  ok=$(echo "$result" | python3 -c "import json,sys; print(json.load(sys.stdin).get('ok',''))" | tr -d '\r')

  if [ "$ok" = "True" ]; then
    local ts
    ts=$(echo "$result" | python3 -c "import json,sys; print(json.load(sys.stdin).get('ts',''))" | tr -d '\r')
    echo "Message sent to $target (ts: $ts)"
  else
    local error
    error=$(echo "$result" | python3 -c "import json,sys; print(json.load(sys.stdin).get('error','unknown'))" | tr -d '\r')
    err "Failed to send message: $error"
  fi
}

cmd_reply() {
  local channel_id="${1:?Usage: slack.sh reply <channel_id> <thread_ts> <message>}"
  local thread_ts="${2:?Missing thread timestamp}"
  local message="${3:?Missing reply message}"

  local result
  result=$(slack_post "chat.postMessage" "{\"channel\": \"$channel_id\", \"text\": \"$message\", \"thread_ts\": \"$thread_ts\"}")

  local ok
  ok=$(echo "$result" | python3 -c "import json,sys; print(json.load(sys.stdin).get('ok',''))" | tr -d '\r')

  if [ "$ok" = "True" ]; then
    echo "Reply sent in thread $thread_ts"
  else
    local error
    error=$(echo "$result" | python3 -c "import json,sys; print(json.load(sys.stdin).get('error','unknown'))" | tr -d '\r')
    err "Failed to send reply: $error"
  fi
}

cmd_search() {
  local query="${1:?Usage: slack.sh search <query>}"

  local token
  token=$(get_bot_token) || exit 1

  # search.messages requires user token in some cases, try with bot token first
  local result
  result=$(curl -s -H "Authorization: Bearer $token" "$SLACK_API/search.messages" -G \
    --data-urlencode "query=$query" \
    -d "count=20" \
    -d "sort=timestamp" \
    -d "sort_dir=desc")

  echo "$result" | python3 -c "
import json, sys
data = json.load(sys.stdin)
if not data.get('ok'):
    print(f\"Error: {data.get('error', 'unknown')}\")
    print('Note: search.messages may require a User Token instead of Bot Token.')
    sys.exit(1)
matches = data.get('messages', {}).get('matches', [])
total = data.get('messages', {}).get('total', 0)
print(f'Found {total} results (showing {len(matches)}):')
print()
for msg in matches:
    channel_name = msg.get('channel', {}).get('name', 'unknown')
    user = msg.get('username', msg.get('user', 'unknown'))
    text = msg.get('text', '')[:100]
    ts = msg.get('ts', '')
    print(f\"  #{channel_name} | <{user}> [{ts}]\")
    print(f\"    {text}\")
    print()
"
}

cmd_read() {
  local channel_id="${1:?Usage: slack.sh read <channel_id> <message_ts>}"
  local message_ts="${2:?Missing message timestamp}"

  # Get the message and its thread
  local result
  result=$(slack_get "conversations.replies" -G -d "channel=$channel_id" -d "ts=$message_ts" -d "limit=50")

  echo "$result" | python3 -c "
import json, sys
data = json.load(sys.stdin)
if not data.get('ok'):
    print(f\"Error: {data.get('error', 'unknown')}\")
    sys.exit(1)
messages = data.get('messages', [])
if not messages:
    print('Message not found.')
    sys.exit(0)
print(f'Thread ({len(messages)} messages):')
print('=' * 60)
for msg in messages:
    user = msg.get('user', msg.get('bot_id', 'unknown'))
    text = msg.get('text', '')
    ts = msg.get('ts', '')
    print(f\"From: {user}\")
    print(f\"Time: {ts}\")
    print('---')
    print(text[:3000])
    print('-' * 60)
"
}

cmd_users() {
  local result
  result=$(slack_get "users.list" -G -d "limit=200")

  echo "$result" | python3 -c "
import json, sys
data = json.load(sys.stdin)
if not data.get('ok'):
    print(f\"Error: {data.get('error', 'unknown')}\")
    sys.exit(1)
members = [m for m in data.get('members', []) if not m.get('deleted') and not m.get('is_bot') and m.get('id') != 'USLACKBOT']
print(f'Found {len(members)} active users:')
print()
for m in sorted(members, key=lambda x: x.get('real_name', '')):
    status = m.get('profile', {}).get('status_emoji', '')
    print(f\"  @{m.get('name',''):<20} {m.get('real_name',''):<25} {m['id']:<12} {status}\")
"
}

cmd_create_channel() {
  local name="${1:?Usage: slack.sh create-channel <name> [--private]}"
  local is_private="false"

  if [ "${2:-}" = "--private" ]; then
    is_private="true"
  fi

  local result
  result=$(slack_post "conversations.create" "{\"name\": \"$name\", \"is_private\": $is_private}")

  local ok
  ok=$(echo "$result" | python3 -c "import json,sys; print(json.load(sys.stdin).get('ok',''))" | tr -d '\r')

  if [ "$ok" = "True" ]; then
    local channel_id
    channel_id=$(echo "$result" | python3 -c "import json,sys; print(json.load(sys.stdin)['channel']['id'])" | tr -d '\r')
    echo "Channel #$name created ($channel_id)"
  else
    local error
    error=$(echo "$result" | python3 -c "import json,sys; print(json.load(sys.stdin).get('error','unknown'))" | tr -d '\r')
    err "Failed to create channel: $error"
  fi
}

cmd_invite() {
  local channel_input="${1:?Usage: slack.sh invite <#channel> <@user>}"
  local user_input="${2:?Missing user}"

  local channel_id user_id
  channel_id=$(resolve_channel "$channel_input") || exit 1
  user_id=$(resolve_user "$user_input") || exit 1

  local result
  result=$(slack_post "conversations.invite" "{\"channel\": \"$channel_id\", \"users\": \"$user_id\"}")

  local ok
  ok=$(echo "$result" | python3 -c "import json,sys; print(json.load(sys.stdin).get('ok',''))" | tr -d '\r')

  if [ "$ok" = "True" ]; then
    echo "Invited $user_input to $channel_input"
  else
    local error
    error=$(echo "$result" | python3 -c "import json,sys; print(json.load(sys.stdin).get('error','unknown'))" | tr -d '\r')
    err "Failed to invite: $error"
  fi
}

cmd_archive() {
  local channel_input="${1:?Usage: slack.sh archive <#channel>}"

  local channel_id
  channel_id=$(resolve_channel "$channel_input") || exit 1

  local result
  result=$(slack_post "conversations.archive" "{\"channel\": \"$channel_id\"}")

  local ok
  ok=$(echo "$result" | python3 -c "import json,sys; print(json.load(sys.stdin).get('ok',''))" | tr -d '\r')

  if [ "$ok" = "True" ]; then
    echo "Archived $channel_input"
  else
    local error
    error=$(echo "$result" | python3 -c "import json,sys; print(json.load(sys.stdin).get('error','unknown'))" | tr -d '\r')
    err "Failed to archive: $error"
  fi
}

cmd_upload() {
  local channel_input="${1:?Usage: slack.sh upload <#channel> <file_path>}"
  local file_path="${2:?Missing file path}"

  [ -f "$file_path" ] || err "File not found: $file_path"

  local channel_id
  channel_id=$(resolve_channel "$channel_input") || exit 1

  local filename
  filename=$(basename "$file_path")

  local result
  result=$(slack_post_form "files.upload" \
    -F "channels=$channel_id" \
    -F "file=@$file_path" \
    -F "filename=$filename")

  local ok
  ok=$(echo "$result" | python3 -c "import json,sys; print(json.load(sys.stdin).get('ok',''))" | tr -d '\r')

  if [ "$ok" = "True" ]; then
    echo "Uploaded $filename to $channel_input"
  else
    local error
    error=$(echo "$result" | python3 -c "import json,sys; print(json.load(sys.stdin).get('error','unknown'))" | tr -d '\r')
    err "Failed to upload: $error"
  fi
}

cmd_react() {
  local channel_id="${1:?Usage: slack.sh react <channel_id> <timestamp> <emoji>}"
  local timestamp="${2:?Missing message timestamp}"
  local emoji="${3:?Missing emoji name (without colons)}"

  local result
  result=$(slack_post "reactions.add" "{\"channel\": \"$channel_id\", \"timestamp\": \"$timestamp\", \"name\": \"$emoji\"}")

  local ok
  ok=$(echo "$result" | python3 -c "import json,sys; print(json.load(sys.stdin).get('ok',''))" | tr -d '\r')

  if [ "$ok" = "True" ]; then
    echo "Added :$emoji: reaction"
  else
    local error
    error=$(echo "$result" | python3 -c "import json,sys; print(json.load(sys.stdin).get('error','unknown'))" | tr -d '\r')
    err "Failed to add reaction: $error"
  fi
}

cmd_profile() {
  local token
  token=$(get_bot_token) || exit 1
  local result
  result=$(curl -s -H "Authorization: Bearer $token" "$SLACK_API/auth.test")

  echo "$result" | python3 -c "
import json, sys
data = json.load(sys.stdin)
if not data.get('ok'):
    print(f\"Error: {data.get('error', 'unknown')}\")
    sys.exit(1)
print(f\"User:      {data.get('user', 'N/A')}\")
print(f\"User ID:   {data.get('user_id', 'N/A')}\")
print(f\"Team:      {data.get('team', 'N/A')}\")
print(f\"Team ID:   {data.get('team_id', 'N/A')}\")
print(f\"URL:       {data.get('url', 'N/A')}\")
"
}

# --- AI Commands ---

cmd_ai_summary() {
  local channel_input="${1:?Usage: slack.sh ai-summary <#channel> [limit]}"
  local limit="${2:-50}"

  local channel_id
  channel_id=$(resolve_channel "$channel_input") || exit 1

  echo "Fetching messages from $channel_input..."

  local result
  result=$(slack_get "conversations.history" -G -d "channel=$channel_id" -d "limit=$limit")

  local msg_content
  msg_content=$(echo "$result" | python3 -c "
import json, sys
data = json.load(sys.stdin)
if not data.get('ok'):
    print(f\"Error: {data.get('error', 'unknown')}\", file=sys.stderr)
    sys.exit(1)
messages = data.get('messages', [])
if not messages:
    print('No messages found.')
    sys.exit(0)
lines = []
for msg in reversed(messages):
    user = msg.get('user', msg.get('bot_id', 'unknown'))
    text = msg.get('text', '')[:500]
    ts = msg.get('ts', '')
    replies = msg.get('reply_count', 0)
    thread = f' [{replies} replies]' if replies > 0 else ''
    lines.append(f'<{user}> [{ts}]{thread}: {text}')
print('\n'.join(lines))
" | tr -d '\r')

  [ -z "$msg_content" ] && { echo "No messages to summarize."; return; }

  echo "Generating AI summary..."
  evolink_ai "You are a Slack channel analyst. Summarize the following channel conversation concisely. Include:
1. Key topics discussed (with participant names)
2. Decisions made
3. Action items (who needs to do what)
4. Overall sentiment/tone

Format with clear sections and bullet points." "$msg_content"
}

cmd_ai_reply() {
  local channel_id="${1:?Usage: slack.sh ai-reply <channel_id> <message_ts>}"
  local message_ts="${2:?Missing message timestamp}"

  echo "Reading thread..."
  local result
  result=$(slack_get "conversations.replies" -G -d "channel=$channel_id" -d "ts=$message_ts" -d "limit=20")

  local thread_content
  thread_content=$(echo "$result" | python3 -c "
import json, sys
data = json.load(sys.stdin)
if not data.get('ok'):
    print(f\"Error: {data.get('error', 'unknown')}\", file=sys.stderr)
    sys.exit(1)
messages = data.get('messages', [])
lines = []
for msg in messages:
    user = msg.get('user', msg.get('bot_id', 'unknown'))
    text = msg.get('text', '')[:1000]
    lines.append(f'<{user}>: {text}')
print('\n'.join(lines))
" | tr -d '\r')

  [ -z "$thread_content" ] && { echo "No messages found."; return; }

  echo "Generating AI reply draft..."
  evolink_ai "You are a professional Slack communicator. Draft a helpful, concise reply to the following Slack thread. Match the tone of the conversation (casual if casual, formal if formal). Write only the reply text, no metadata." "$thread_content"
}

cmd_ai_prioritize() {
  local channel_input="${1:?Usage: slack.sh ai-prioritize <#channel> [limit]}"
  local limit="${2:-30}"

  local channel_id
  channel_id=$(resolve_channel "$channel_input") || exit 1

  echo "Fetching messages from $channel_input..."

  local result
  result=$(slack_get "conversations.history" -G -d "channel=$channel_id" -d "limit=$limit")

  local msg_content
  msg_content=$(echo "$result" | python3 -c "
import json, sys
data = json.load(sys.stdin)
if not data.get('ok'):
    print(f\"Error: {data.get('error', 'unknown')}\", file=sys.stderr)
    sys.exit(1)
messages = data.get('messages', [])
lines = []
for i, msg in enumerate(reversed(messages), 1):
    user = msg.get('user', msg.get('bot_id', 'unknown'))
    text = msg.get('text', '')[:300]
    ts = msg.get('ts', '')
    replies = msg.get('reply_count', 0)
    reactions = sum(r.get('count', 0) for r in msg.get('reactions', []))
    lines.append(f'{i}. <{user}> [{ts}] (replies:{replies}, reactions:{reactions}): {text}')
print('\n'.join(lines))
" | tr -d '\r')

  [ -z "$msg_content" ] && { echo "No messages found."; return; }

  echo "Analyzing priority..."
  evolink_ai "You are a Slack message triage assistant. Rank the following messages by importance and urgency. Group them into:
- URGENT: Needs immediate response
- IMPORTANT: Should respond today
- NORMAL: Can wait
- FYI: Informational only

For each message, explain why in one sentence. Consider reply counts and reaction counts as engagement signals." "$msg_content"
}

# --- Main ---
COMMAND="${1:-help}"
shift || true

case "$COMMAND" in
  channels)        cmd_channels ;;
  list)            cmd_list "$@" ;;
  send)            cmd_send "$@" ;;
  reply)           cmd_reply "$@" ;;
  search)          cmd_search "$@" ;;
  read)            cmd_read "$@" ;;
  users)           cmd_users ;;
  create-channel)  cmd_create_channel "$@" ;;
  invite)          cmd_invite "$@" ;;
  archive)         cmd_archive "$@" ;;
  upload)          cmd_upload "$@" ;;
  react)           cmd_react "$@" ;;
  profile)         cmd_profile ;;
  ai-summary)      cmd_ai_summary "$@" ;;
  ai-reply)        cmd_ai_reply "$@" ;;
  ai-prioritize)   cmd_ai_prioritize "$@" ;;
  help|*)
    echo "Slack Assistant — Send, read, search, and manage Slack with AI"
    echo ""
    echo "Usage: bash slack.sh <command> [options]"
    echo ""
    echo "Core Commands:"
    echo "  channels                          List all channels"
    echo "  list <#channel> [limit]           List recent messages"
    echo "  send <#channel|@user> <message>   Send a message"
    echo "  reply <chan_id> <ts> <message>     Reply in a thread"
    echo "  search <query>                    Search messages"
    echo "  read <channel_id> <ts>            Read message/thread"
    echo "  users                             List workspace users"
    echo "  create-channel <name> [--private] Create a channel"
    echo "  invite <#channel> <@user>         Invite user to channel"
    echo "  archive <#channel>                Archive a channel"
    echo "  upload <#channel> <file_path>     Upload a file"
    echo "  react <chan_id> <ts> <emoji>       Add emoji reaction"
    echo "  profile                           View bot profile"
    echo ""
    echo "AI Commands (requires EVOLINK_API_KEY):"
    echo "  ai-summary <#channel> [limit]     Summarize channel activity"
    echo "  ai-reply <chan_id> <ts>            Draft a reply with AI"
    echo "  ai-prioritize <#channel> [limit]  Rank messages by importance"
    ;;
esac
