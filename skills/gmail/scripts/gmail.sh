#!/usr/bin/env bash
set -euo pipefail

# Gmail Assistant — Read, send, search, and manage Gmail with AI features
# Usage: bash gmail.sh <command> [options]
#
# Commands:
#   list [--query Q] [--max N]        — List messages
#   read <message_id>                 — Read a message
#   send <to> <subject> <body>        — Send an email
#   reply <message_id> <body>         — Reply to a message
#   search <query> [--max N]          — Search messages
#   labels                            — List labels
#   label <message_id> <+add/-remove> — Modify labels
#   star <message_id>                 — Star a message
#   unstar <message_id>               — Unstar a message
#   archive <message_id>              — Archive a message
#   trash <message_id>                — Trash a message
#   thread <thread_id>                — View a thread
#   profile                           — View account profile
#   ai-summary [--query Q] [--max N]  — AI-summarize emails
#   ai-reply <message_id> <prompt>    — AI-draft a reply
#   ai-prioritize [--max N]           — AI-rank emails by importance

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
CONFIG_DIR="${GMAIL_SKILL_DIR:-$HOME/.gmail-skill}"
TOKEN_FILE="$CONFIG_DIR/token.json"
CREDENTIALS_FILE="$CONFIG_DIR/credentials.json"

GMAIL_API="https://gmail.googleapis.com/gmail/v1/users/me"
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

get_access_token() {
  [ -f "$TOKEN_FILE" ] || err "Not authenticated. Run: bash scripts/gmail-auth.sh login"

  CREATED=$(python3 -c "import json; f=open('$TOKEN_FILE_NATIVE'); d=json.load(f); print(d.get('created_at',0))")
  EXPIRES=$(python3 -c "import json; f=open('$TOKEN_FILE_NATIVE'); d=json.load(f); print(d.get('expires_in',3600))")
  NOW=$(date +%s)

  if [ $((CREATED + EXPIRES)) -lt "$NOW" ]; then
    bash "$SCRIPT_DIR/gmail-auth.sh" refresh >/dev/null 2>&1
  fi

  python3 -c "import json; f=open('$TOKEN_FILE_NATIVE'); print(json.load(f)['access_token'])"
}

gmail_get() {
  local endpoint="$1"
  local token
  token=$(get_access_token) || exit 1
  curl -s -H "Authorization: Bearer $token" "$GMAIL_API$endpoint"
}

gmail_post() {
  local endpoint="$1"
  local data="$2"
  local token
  token=$(get_access_token) || exit 1
  curl -s -X POST \
    -H "Authorization: Bearer $token" \
    -H "Content-Type: application/json" \
    -d "$data" \
    "$GMAIL_API$endpoint"
}

parse_message() {
  python3 -c "
import json, sys, base64

data = json.load(sys.stdin)

headers = {}
for h in data.get('payload', {}).get('headers', []):
    headers[h['name'].lower()] = h['value']

print(f\"From:    {headers.get('from', 'N/A')}\")
print(f\"To:      {headers.get('to', 'N/A')}\")
print(f\"Date:    {headers.get('date', 'N/A')}\")
print(f\"Subject: {headers.get('subject', 'N/A')}\")
print('---')

def get_body(payload):
    if 'body' in payload and payload['body'].get('data'):
        return base64.urlsafe_b64decode(payload['body']['data']).decode('utf-8', errors='replace')
    if 'parts' in payload:
        for part in payload['parts']:
            if part.get('mimeType') == 'text/plain' and part.get('body', {}).get('data'):
                return base64.urlsafe_b64decode(part['body']['data']).decode('utf-8', errors='replace')
        for part in payload['parts']:
            if part.get('mimeType') == 'text/html' and part.get('body', {}).get('data'):
                return base64.urlsafe_b64decode(part['body']['data']).decode('utf-8', errors='replace')
        for part in payload['parts']:
            if 'parts' in part:
                result = get_body(part)
                if result:
                    return result
    return ''

body = get_body(data.get('payload', {}))
print(body[:5000] if body else '(no body)')
"
}

encode_email() {
  local to="$1" subject="$2" body="$3" in_reply_to="${4:-}" references="${5:-}" thread_id="${6:-}"

  python3 -c "
import base64, email.mime.text

msg = email.mime.text.MIMEText('$body')
msg['to'] = '$to'
msg['subject'] = '$subject'
if '$in_reply_to':
    msg['In-Reply-To'] = '$in_reply_to'
    msg['References'] = '$references'

raw = base64.urlsafe_b64encode(msg.as_bytes()).decode()
print(raw)
"
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

cmd_list() {
  local query="" max_results="10"

  while [[ $# -gt 0 ]]; do
    case "$1" in
      --query) query="$2"; shift 2 ;;
      --max)   max_results="$2"; shift 2 ;;
      *)       shift ;;
    esac
  done

  local endpoint="/messages?maxResults=$max_results"
  [ -n "$query" ] && endpoint="$endpoint&q=$(python3 -c "import urllib.parse; print(urllib.parse.quote('$query'))")"

  local result
  result=$(gmail_get "$endpoint")

  echo "$result" | python3 -c "
import json, sys
data = json.load(sys.stdin)
messages = data.get('messages', [])
if not messages:
    print('No messages found.')
    sys.exit(0)
print(f'Found {len(messages)} messages:')
print()
for msg in messages:
    print(f\"  ID: {msg['id']}  Thread: {msg['threadId']}\")
"

  # Get preview for first 5 messages
  local msg_ids
  msg_ids=$(echo "$result" | python3 -c "
import json, sys
data = json.load(sys.stdin)
messages = data.get('messages', [])
for m in messages[:5]:
    print(m['id'])
" 2>/dev/null | tr -d '\r')

  [ -z "$msg_ids" ] && return

  echo ""
  for mid in $msg_ids; do
    gmail_get "/messages/$mid?format=metadata&metadataHeaders=From&metadataHeaders=Subject&metadataHeaders=Date" | python3 -c "
import json, sys
data = json.load(sys.stdin)
headers = {h['name']: h['value'] for h in data.get('payload', {}).get('headers', [])}
labels = data.get('labelIds', [])
unread = '● ' if 'UNREAD' in labels else '  '
print(f\"{unread}{data['id'][:12]}  {headers.get('Date','')[:16]}  {headers.get('From','')[:30]}  {headers.get('Subject','')[:50]}\")
"
  done
}

cmd_read() {
  local message_id="${1:?Usage: gmail.sh read <message_id>}"
  gmail_get "/messages/$message_id" | parse_message
}

cmd_send() {
  local to="${1:?Usage: gmail.sh send <to> <subject> <body>}"
  local subject="${2:?Missing subject}"
  local body="${3:?Missing body}"

  local raw
  raw=$(encode_email "$to" "$subject" "$body")

  gmail_post "/messages/send" "{\"raw\": \"$raw\"}"
  echo "Message sent to $to"
}

cmd_reply() {
  local message_id="${1:?Usage: gmail.sh reply <message_id> <body>}"
  local body="${2:?Missing reply body}"

  local original
  original=$(gmail_get "/messages/$message_id")

  local from subject msg_id_header thread_id
  from=$(echo "$original" | python3 -c "import json,sys; d=json.load(sys.stdin); print(next((h['value'] for h in d['payload']['headers'] if h['name']=='From'),''))")
  subject=$(echo "$original" | python3 -c "import json,sys; d=json.load(sys.stdin); s=next((h['value'] for h in d['payload']['headers'] if h['name']=='Subject'),''); print(s if s.startswith('Re:') else f'Re: {s}')")
  msg_id_header=$(echo "$original" | python3 -c "import json,sys; d=json.load(sys.stdin); print(next((h['value'] for h in d['payload']['headers'] if h['name']=='Message-ID'),''))")
  thread_id=$(echo "$original" | python3 -c "import json,sys; d=json.load(sys.stdin); print(d.get('threadId',''))")

  local raw
  raw=$(encode_email "$from" "$subject" "$body" "$msg_id_header" "$msg_id_header")

  gmail_post "/messages/send" "{\"raw\": \"$raw\", \"threadId\": \"$thread_id\"}"
  echo "Reply sent to $from"
}

cmd_search() {
  local query="${1:?Usage: gmail.sh search <query> [--max N]}"
  shift
  cmd_list --query "$query" "$@"
}

cmd_labels() {
  gmail_get "/labels" | python3 -c "
import json, sys
data = json.load(sys.stdin)
for label in sorted(data.get('labels', []), key=lambda x: x['name']):
    ltype = label.get('type', '')
    print(f\"  {label['id']:<24} {label['name']:<30} ({ltype})\")
"
}

cmd_label() {
  local message_id="${1:?Usage: gmail.sh label <message_id> <+add/-remove>}"
  local label_op="${2:?Usage: gmail.sh label <message_id> <+LABEL or -LABEL>}"

  local op="${label_op:0:1}"
  local label="${label_op:1}"

  case "$op" in
    +) gmail_post "/messages/$message_id/modify" "{\"addLabelIds\": [\"$label\"]}" ;;
    -) gmail_post "/messages/$message_id/modify" "{\"removeLabelIds\": [\"$label\"]}" ;;
    *) err "Use +LABEL to add or -LABEL to remove" ;;
  esac

  echo "Label '$label' ${op/+/added}${op/-/removed} on $message_id"
}

cmd_star()    { gmail_post "/messages/$1/modify" '{"addLabelIds":["STARRED"]}' >/dev/null; echo "Starred $1"; }
cmd_unstar()  { gmail_post "/messages/$1/modify" '{"removeLabelIds":["STARRED"]}' >/dev/null; echo "Unstarred $1"; }
cmd_archive() { gmail_post "/messages/$1/modify" '{"removeLabelIds":["INBOX"]}' >/dev/null; echo "Archived $1"; }
cmd_trash()   { gmail_post "/messages/$1/trash" '{}' >/dev/null; echo "Trashed $1"; }

cmd_thread() {
  local thread_id="${1:?Usage: gmail.sh thread <thread_id>}"
  gmail_get "/threads/$thread_id" | python3 -c "
import json, sys, base64
data = json.load(sys.stdin)
messages = data.get('messages', [])
print(f'Thread: {data[\"id\"]} ({len(messages)} messages)')
print('=' * 60)
for msg in messages:
    headers = {h['name']: h['value'] for h in msg.get('payload', {}).get('headers', [])}
    print(f\"From:    {headers.get('From', 'N/A')}\")
    print(f\"Date:    {headers.get('Date', 'N/A')}\")
    print(f\"Subject: {headers.get('Subject', 'N/A')}\")
    print('---')
    def get_body(payload):
        if 'body' in payload and payload['body'].get('data'):
            return base64.urlsafe_b64decode(payload['body']['data']).decode('utf-8', errors='replace')
        if 'parts' in payload:
            for part in payload['parts']:
                if part.get('mimeType') == 'text/plain' and part.get('body', {}).get('data'):
                    return base64.urlsafe_b64decode(part['body']['data']).decode('utf-8', errors='replace')
        return ''
    body = get_body(msg.get('payload', {}))
    print(body[:2000] if body else '(no body)')
    print('-' * 60)
"
}

cmd_profile() {
  gmail_get "/profile" | python3 -c "
import json, sys
data = json.load(sys.stdin)
print(f\"Email:    {data.get('emailAddress', 'N/A')}\")
print(f\"Messages: {data.get('messagesTotal', 'N/A')}\")
print(f\"Threads:  {data.get('threadsTotal', 'N/A')}\")
print(f\"History:  {data.get('historyId', 'N/A')}\")
"
}

cmd_ai_summary() {
  local query="is:unread" max_results="10"

  while [[ $# -gt 0 ]]; do
    case "$1" in
      --query) query="$2"; shift 2 ;;
      --max)   max_results="$2"; shift 2 ;;
      *)       shift ;;
    esac
  done

  echo "Fetching emails..."

  local endpoint="/messages?maxResults=$max_results&q=$(python3 -c "import urllib.parse; print(urllib.parse.quote('$query'))")"
  local msg_list
  msg_list=$(gmail_get "$endpoint")

  local email_content=""
  local count=0

  echo "$msg_list" | python3 -c "
import json, sys
data = json.load(sys.stdin)
for m in data.get('messages', []):
    print(m['id'])
" | while read -r mid; do
    count=$((count + 1))
    local msg_data
    msg_data=$(gmail_get "/messages/$mid")

    local snippet
    snippet=$(echo "$msg_data" | python3 -c "
import json, sys, base64
data = json.load(sys.stdin)
headers = {h['name']: h['value'] for h in data.get('payload', {}).get('headers', [])}
def get_body(payload):
    if 'body' in payload and payload['body'].get('data'):
        return base64.urlsafe_b64decode(payload['body']['data']).decode('utf-8', errors='replace')
    if 'parts' in payload:
        for part in payload['parts']:
            if part.get('mimeType') == 'text/plain' and part.get('body', {}).get('data'):
                return base64.urlsafe_b64decode(part['body']['data']).decode('utf-8', errors='replace')
    return data.get('snippet', '')
body = get_body(data.get('payload', {}))[:1000]
print(f\"Email {$count}:\")
print(f\"From: {headers.get('From', 'N/A')}\")
print(f\"Subject: {headers.get('Subject', 'N/A')}\")
print(f\"Date: {headers.get('Date', 'N/A')}\")
print(f\"Body: {body}\")
print('---')
")
    email_content="$email_content
$snippet"
  done

  [ -z "$email_content" ] && { echo "No emails found for query: $query"; return; }

  echo "Generating AI summary..."
  evolink_ai "You are an email assistant. Summarize the following emails concisely. For each email, provide: 1) A one-line summary 2) Priority level (URGENT/NORMAL/LOW) 3) Action needed (if any). End with an overall inbox summary." "$email_content"
}

cmd_ai_reply() {
  local message_id="${1:?Usage: gmail.sh ai-reply <message_id> <prompt>}"
  local prompt="${2:?Missing prompt for AI reply}"

  echo "Reading original email..."
  local original
  original=$(gmail_get "/messages/$message_id")

  local email_text
  email_text=$(echo "$original" | python3 -c "
import json, sys, base64
data = json.load(sys.stdin)
headers = {h['name']: h['value'] for h in data.get('payload', {}).get('headers', [])}
def get_body(payload):
    if 'body' in payload and payload['body'].get('data'):
        return base64.urlsafe_b64decode(payload['body']['data']).decode('utf-8', errors='replace')
    if 'parts' in payload:
        for part in payload['parts']:
            if part.get('mimeType') == 'text/plain' and part.get('body', {}).get('data'):
                return base64.urlsafe_b64decode(part['body']['data']).decode('utf-8', errors='replace')
    return data.get('snippet', '')
body = get_body(data.get('payload', {}))[:3000]
print(f\"From: {headers.get('From', 'N/A')}\")
print(f\"Subject: {headers.get('Subject', 'N/A')}\")
print(f\"Date: {headers.get('Date', 'N/A')}\")
print(f\"Body: {body}\")
")

  echo "Generating AI reply draft..."
  evolink_ai "You are a professional email assistant. Draft a reply to the following email. User instruction: $prompt. Write only the reply body, no subject line, no greetings metadata. Be professional and concise." "$email_text"
}

cmd_ai_prioritize() {
  local max_results="20"

  while [[ $# -gt 0 ]]; do
    case "$1" in
      --max) max_results="$2"; shift 2 ;;
      *)     shift ;;
    esac
  done

  echo "Fetching recent emails..."

  local msg_list
  msg_list=$(gmail_get "/messages?maxResults=$max_results")

  local email_content=""
  local count=0

  echo "$msg_list" | python3 -c "
import json, sys
data = json.load(sys.stdin)
for m in data.get('messages', []):
    print(m['id'])
" | while read -r mid; do
    count=$((count + 1))
    local msg_data
    msg_data=$(gmail_get "/messages/$mid?format=metadata&metadataHeaders=From&metadataHeaders=Subject&metadataHeaders=Date")

    echo "$msg_data" | python3 -c "
import json, sys
data = json.load(sys.stdin)
headers = {h['name']: h['value'] for h in data.get('payload', {}).get('headers', [])}
labels = data.get('labelIds', [])
print(f\"$count. From: {headers.get('From','N/A')} | Subject: {headers.get('Subject','N/A')} | Date: {headers.get('Date','N/A')} | Labels: {','.join(labels)}\")
"
  done | { email_content=$(cat); }

  [ -z "$email_content" ] && { echo "No emails found."; return; }

  echo "Analyzing priority..."
  evolink_ai "You are an email triage assistant. Rank the following emails by importance and urgency. Group them into: URGENT (needs immediate action), IMPORTANT (needs action today), NORMAL (can wait), LOW (informational/newsletter). For each email, explain why in one sentence." "$email_content"
}

# --- Main ---
COMMAND="${1:-help}"
shift || true

case "$COMMAND" in
  list)           cmd_list "$@" ;;
  read)           cmd_read "$@" ;;
  send)           cmd_send "$@" ;;
  reply)          cmd_reply "$@" ;;
  search)         cmd_search "$@" ;;
  labels)         cmd_labels ;;
  label)          cmd_label "$@" ;;
  star)           cmd_star "${1:?Missing message_id}" ;;
  unstar)         cmd_unstar "${1:?Missing message_id}" ;;
  archive)        cmd_archive "${1:?Missing message_id}" ;;
  trash)          cmd_trash "${1:?Missing message_id}" ;;
  thread)         cmd_thread "$@" ;;
  profile)        cmd_profile ;;
  ai-summary)     cmd_ai_summary "$@" ;;
  ai-reply)       cmd_ai_reply "$@" ;;
  ai-prioritize)  cmd_ai_prioritize "$@" ;;
  help|*)
    echo "Gmail Assistant — Read, send, search, and manage Gmail with AI"
    echo ""
    echo "Usage: bash gmail.sh <command> [options]"
    echo ""
    echo "Core Commands:"
    echo "  list [--query Q] [--max N]       List messages"
    echo "  read <message_id>                Read a message"
    echo "  send <to> <subject> <body>       Send an email"
    echo "  reply <message_id> <body>        Reply to a message"
    echo "  search <query> [--max N]         Search messages"
    echo "  labels                           List all labels"
    echo "  label <id> <+ADD/-REMOVE>        Modify labels"
    echo "  star <message_id>                Star a message"
    echo "  unstar <message_id>              Unstar a message"
    echo "  archive <message_id>             Archive a message"
    echo "  trash <message_id>               Trash a message"
    echo "  thread <thread_id>               View a thread"
    echo "  profile                          View account info"
    echo ""
    echo "AI Commands (requires EVOLINK_API_KEY):"
    echo "  ai-summary [--query Q] [--max N] Summarize emails"
    echo "  ai-reply <id> <prompt>           Draft a reply with AI"
    echo "  ai-prioritize [--max N]          Rank emails by importance"
    ;;
esac
