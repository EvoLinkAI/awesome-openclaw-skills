#!/usr/bin/env bash
set -euo pipefail

# Google Sheets Assistant — Read, write, and analyze Google Sheets with AI
# Usage: bash sheets.sh <command> [options]
#
# Core Commands:
#   read <ID> [range]                  — Read values from a spreadsheet
#   write <ID> <range> <values_json>   — Write values to a range
#   append <ID> <range> <values_json>  — Append rows to a range
#   info <ID>                          — Get spreadsheet metadata
#   create <title>                     — Create a new spreadsheet
#   clear <ID> <range>                 — Clear a range
#   format <ID> <requests_json>        — Apply formatting via batchUpdate
#   connection list|create|delete      — Manage Google OAuth connections
#
# AI Commands (requires EVOLINK_API_KEY):
#   ai-analyze <ID> [range]            — AI-powered data analysis
#   ai-formula <description>           — Generate formula from description
#   ai-summary <ID> [range]            — Summarize spreadsheet content

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
MATON_GATEWAY="https://gateway.maton.ai/google-sheets"
MATON_CTRL="https://ctrl.maton.ai"
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

check_maton_key() {
  : "${MATON_API_KEY:?Set MATON_API_KEY. Get one at https://maton.ai/settings}"
}

check_evolink_key() {
  : "${EVOLINK_API_KEY:?Set EVOLINK_API_KEY for AI features. Get one at https://evolink.ai/signup}"
}

urlencode_range() {
  python3 -c "import urllib.parse,sys; print(urllib.parse.quote(sys.argv[1], safe=''))" "$1" | tr -d '\r'
}

# Authenticated GET to Maton gateway
maton_get() {
  local path="$1"
  local response
  response=$(curl -s -w "\n%{http_code}" "$MATON_GATEWAY$path" \
    -H "Authorization: Bearer $MATON_API_KEY")

  local body http_code
  http_code=$(echo "$response" | tail -1)
  body=$(echo "$response" | sed '$d')

  if [[ "$http_code" -ge 400 ]]; then
    case "$http_code" in
      400) err "No Google connection found. Run: bash sheets.sh connection create" ;;
      401) err "Invalid MATON_API_KEY. Check your key at https://maton.ai/settings" ;;
      429) err "Rate limited (10 req/sec). Wait a moment and try again." ;;
      *)   err "API error ($http_code): $body" ;;
    esac
  fi
  echo "$body"
}

# Authenticated POST/PUT to Maton gateway
maton_post() {
  local method="$1"
  local path="$2"
  local body_file="${3:-}"

  local curl_args=(-s -w "\n%{http_code}" -X "$method"
    "$MATON_GATEWAY$path"
    -H "Authorization: Bearer $MATON_API_KEY"
    -H "Content-Type: application/json")

  if [ -n "$body_file" ]; then
    curl_args+=(-d "@$body_file")
  fi

  local response
  response=$(curl "${curl_args[@]}")

  local result http_code
  http_code=$(echo "$response" | tail -1)
  result=$(echo "$response" | sed '$d')

  if [[ "$http_code" -ge 400 ]]; then
    case "$http_code" in
      400) err "No Google connection found. Run: bash sheets.sh connection create" ;;
      401) err "Invalid MATON_API_KEY. Check your key at https://maton.ai/settings" ;;
      429) err "Rate limited (10 req/sec). Wait a moment and try again." ;;
      *)   err "API error ($http_code): $result" ;;
    esac
  fi
  echo "$result"
}

# Requests to ctrl.maton.ai
maton_ctrl() {
  local method="$1"
  local path="$2"
  local body_file="${3:-}"

  local curl_args=(-s -w "\n%{http_code}" -X "$method"
    "${MATON_CTRL}${path}"
    -H "Authorization: Bearer $MATON_API_KEY"
    -H "Content-Type: application/json")

  if [ -n "$body_file" ]; then
    curl_args+=(-d "@$body_file")
  fi

  local response
  response=$(curl "${curl_args[@]}")

  local result http_code
  http_code=$(echo "$response" | tail -1)
  result=$(echo "$response" | sed '$d')

  if [[ "$http_code" -ge 400 ]]; then
    case "$http_code" in
      401) err "Invalid MATON_API_KEY. Check your key at https://maton.ai/settings" ;;
      *)   err "API error ($http_code): $result" ;;
    esac
  fi
  echo "$result"
}

# AI via EvoLink API (ported from YouTube skill)
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

# Fetch sheet data as string for AI commands
fetch_sheet_data() {
  local spreadsheet_id="$1"
  local range="${2:-Sheet1}"
  local encoded_range
  encoded_range=$(urlencode_range "$range")
  maton_get "/v4/spreadsheets/$spreadsheet_id/values/$encoded_range"
}

# --- Core Commands ---

cmd_read() {
  local spreadsheet_id="${1:?Usage: sheets.sh read <SPREADSHEET_ID> [range]}"
  local range="${2:-Sheet1}"
  check_deps
  check_maton_key

  echo "Reading $range..." >&2
  local encoded_range
  encoded_range=$(urlencode_range "$range")

  local result
  result=$(maton_get "/v4/spreadsheets/$spreadsheet_id/values/$encoded_range") || exit 1

  echo "$result" | python3 -c "
import json, sys

data = json.load(sys.stdin)
values = data.get('values', [])
if not values:
    print('(empty range)')
    sys.exit(0)

# Calculate column widths
widths = []
for row in values:
    for i, cell in enumerate(row):
        val = str(cell)
        if i >= len(widths):
            widths.append(len(val))
        else:
            widths[i] = max(widths[i], len(val))

# Print aligned table
for row_idx, row in enumerate(values):
    cells = []
    for i in range(len(widths)):
        val = str(row[i]) if i < len(row) else ''
        cells.append(val.ljust(widths[i]))
    print('  '.join(cells))
    if row_idx == 0 and len(values) > 1:
        print('  '.join('-' * w for w in widths))
" | tr -d '\r'
}

cmd_write() {
  local spreadsheet_id="${1:?Usage: sheets.sh write <SPREADSHEET_ID> <range> <values_json>}"
  local range="${2:?Missing range}"
  local values_json="${3:?Missing values JSON, e.g. '[[\"A1\",\"B1\"],[\"A2\",\"B2\"]]'}"
  check_deps
  check_maton_key

  local encoded_range
  encoded_range=$(urlencode_range "$range")

  local tmpfile
  tmpfile=$(mktemp)
  trap "rm -f '$tmpfile'" RETURN

  local native_tmp
  native_tmp=$(to_native_path "$tmpfile")

  python3 -c "
import json
values = json.loads('''$values_json''')
data = {'values': values}
with open('$native_tmp', 'w') as f:
    json.dump(data, f)
"

  echo "Writing to $range..." >&2
  local result
  result=$(maton_post "PUT" "/v4/spreadsheets/$spreadsheet_id/values/$encoded_range?valueInputOption=USER_ENTERED" "$tmpfile") || exit 1

  echo "$result" | python3 -c "
import json, sys
data = json.load(sys.stdin)
print(f\"Updated: {data.get('updatedRange', 'N/A')}\")
print(f\"Cells:   {data.get('updatedCells', 0)}\")
print(f\"Rows:    {data.get('updatedRows', 0)}\")
print(f\"Cols:    {data.get('updatedColumns', 0)}\")
" | tr -d '\r'
}

cmd_append() {
  local spreadsheet_id="${1:?Usage: sheets.sh append <SPREADSHEET_ID> <range> <values_json>}"
  local range="${2:?Missing range}"
  local values_json="${3:?Missing values JSON}"
  check_deps
  check_maton_key

  local encoded_range
  encoded_range=$(urlencode_range "$range")

  local tmpfile
  tmpfile=$(mktemp)
  trap "rm -f '$tmpfile'" RETURN

  local native_tmp
  native_tmp=$(to_native_path "$tmpfile")

  python3 -c "
import json
values = json.loads('''$values_json''')
data = {'values': values}
with open('$native_tmp', 'w') as f:
    json.dump(data, f)
"

  echo "Appending to $range..." >&2
  local result
  result=$(maton_post "POST" "/v4/spreadsheets/$spreadsheet_id/values/$encoded_range:append?valueInputOption=USER_ENTERED" "$tmpfile") || exit 1

  echo "$result" | python3 -c "
import json, sys
data = json.load(sys.stdin)
updates = data.get('updates', {})
print(f\"Appended to: {updates.get('updatedRange', 'N/A')}\")
print(f\"Rows added:  {updates.get('updatedRows', 0)}\")
" | tr -d '\r'
}

cmd_info() {
  local spreadsheet_id="${1:?Usage: sheets.sh info <SPREADSHEET_ID>}"
  check_deps
  check_maton_key

  echo "Fetching spreadsheet info..." >&2
  local result
  result=$(maton_get "/v4/spreadsheets/$spreadsheet_id") || exit 1

  echo "$result" | python3 -c "
import json, sys

data = json.load(sys.stdin)
props = data.get('properties', {})
sheets = data.get('sheets', [])

print(f\"Title:      {props.get('title', 'N/A')}\")
print(f\"Locale:     {props.get('locale', 'N/A')}\")
print(f\"Timezone:   {props.get('timeZone', 'N/A')}\")
print(f\"Sheets:     {len(sheets)}\")
print(f\"URL:        https://docs.google.com/spreadsheets/d/{data.get('spreadsheetId', '')}\")
print()
for i, s in enumerate(sheets):
    sp = s.get('properties', {})
    gp = sp.get('gridProperties', {})
    print(f\"  Sheet {i+1}: {sp.get('title', 'N/A')}\")
    print(f\"    ID:      {sp.get('sheetId', 'N/A')}\")
    print(f\"    Rows:    {gp.get('rowCount', 'N/A')}\")
    print(f\"    Cols:    {gp.get('columnCount', 'N/A')}\")
    frozen_rows = gp.get('frozenRowCount', 0)
    frozen_cols = gp.get('frozenColumnCount', 0)
    if frozen_rows or frozen_cols:
        print(f\"    Frozen:  {frozen_rows} rows, {frozen_cols} cols\")
    print()
" | tr -d '\r'
}

cmd_create() {
  local title="${1:?Usage: sheets.sh create <title>}"
  check_deps
  check_maton_key

  local tmpfile
  tmpfile=$(mktemp)
  trap "rm -f '$tmpfile'" RETURN

  local native_tmp
  native_tmp=$(to_native_path "$tmpfile")

  python3 -c "
import json
data = {
    'properties': {'title': '''$title'''},
    'sheets': [{'properties': {'title': 'Sheet1'}}]
}
with open('$native_tmp', 'w') as f:
    json.dump(data, f)
"

  echo "Creating spreadsheet..." >&2
  local result
  result=$(maton_post "POST" "/v4/spreadsheets" "$tmpfile") || exit 1

  echo "$result" | python3 -c "
import json, sys
data = json.load(sys.stdin)
sid = data.get('spreadsheetId', '')
print(f\"Created: {data.get('properties', {}).get('title', 'N/A')}\")
print(f\"ID:      {sid}\")
print(f\"URL:     https://docs.google.com/spreadsheets/d/{sid}\")
" | tr -d '\r'
}

cmd_clear() {
  local spreadsheet_id="${1:?Usage: sheets.sh clear <SPREADSHEET_ID> <range>}"
  local range="${2:?Missing range}"
  check_deps
  check_maton_key

  local encoded_range
  encoded_range=$(urlencode_range "$range")

  echo "Clearing $range..." >&2
  local result
  result=$(maton_post "POST" "/v4/spreadsheets/$spreadsheet_id/values/$encoded_range:clear" "") || exit 1

  echo "$result" | python3 -c "
import json, sys
data = json.load(sys.stdin)
print(f\"Cleared: {data.get('clearedRange', 'N/A')}\")
" | tr -d '\r'
}

cmd_format() {
  local spreadsheet_id="${1:?Usage: sheets.sh format <SPREADSHEET_ID> <requests_json>}"
  local requests_json="${2:?Missing requests JSON. See Google Sheets batchUpdate docs.}"
  check_deps
  check_maton_key

  local tmpfile
  tmpfile=$(mktemp)
  trap "rm -f '$tmpfile'" RETURN

  local native_tmp
  native_tmp=$(to_native_path "$tmpfile")

  python3 -c "
import json
requests = json.loads('''$requests_json''')
data = {'requests': requests if isinstance(requests, list) else [requests]}
with open('$native_tmp', 'w') as f:
    json.dump(data, f)
"

  echo "Applying format..." >&2
  local result
  result=$(maton_post "POST" "/v4/spreadsheets/$spreadsheet_id:batchUpdate" "$tmpfile") || exit 1

  echo "$result" | python3 -c "
import json, sys
data = json.load(sys.stdin)
replies = data.get('replies', [])
print(f\"Applied {len(replies)} formatting operation(s).\")
" | tr -d '\r'
}

cmd_connection() {
  local action="${1:?Usage: sheets.sh connection list|create|delete [connection_id]}"
  shift || true
  check_deps
  check_maton_key

  case "$action" in
    list)
      echo "Listing Google connections..." >&2
      local result
      result=$(maton_ctrl "GET" "/connections?app=google-sheets&status=ACTIVE") || exit 1

      echo "$result" | python3 -c "
import json, sys
data = json.load(sys.stdin)
connections = data if isinstance(data, list) else data.get('connections', [])
if not connections:
    print('No active Google connections.')
    print('Run: bash sheets.sh connection create')
    sys.exit(0)
print(f'Found {len(connections)} connection(s):')
print()
for c in connections:
    print(f\"  ID:      {c.get('connection_id', 'N/A')}\")
    print(f\"  Status:  {c.get('status', 'N/A')}\")
    print(f\"  Created: {c.get('creation_time', 'N/A')}\")
    print()
" | tr -d '\r'
      ;;

    create)
      local tmpfile
      tmpfile=$(mktemp)
      trap "rm -f '$tmpfile'" RETURN

      local native_tmp
      native_tmp=$(to_native_path "$tmpfile")

      python3 -c "
import json
with open('$native_tmp', 'w') as f:
    json.dump({'app': 'google-sheets'}, f)
"

      echo "Creating Google connection..." >&2
      local result
      result=$(maton_ctrl "POST" "/connections" "$tmpfile") || exit 1

      echo "$result" | python3 -c "
import json, sys
data = json.load(sys.stdin)
conn = data.get('connection', data)
url = conn.get('url', '')
print(f\"Connection ID: {conn.get('connection_id', 'N/A')}\")
print(f\"Status:        {conn.get('status', 'N/A')}\")
print()
if url:
    print('Open this URL in your browser to authorize Google access:')
    print(f'  {url}')
    print()
    print('After authorization, your connection will be active.')
" | tr -d '\r'
      ;;

    delete)
      local conn_id="${1:?Usage: sheets.sh connection delete <connection_id>}"
      echo "Deleting connection $conn_id..." >&2
      maton_ctrl "DELETE" "/connections/$conn_id" || exit 1
      echo "Connection $conn_id deleted."
      ;;

    *)
      err "Unknown connection action: $action. Use list, create, or delete."
      ;;
  esac
}

# --- AI Commands ---

cmd_ai_analyze() {
  local spreadsheet_id="${1:?Usage: sheets.sh ai-analyze <SPREADSHEET_ID> [range]}"
  local range="${2:-Sheet1}"
  check_deps
  check_maton_key
  check_evolink_key

  echo "Fetching data from $range..." >&2
  local data
  data=$(fetch_sheet_data "$spreadsheet_id" "$range") || exit 1

  local truncated
  truncated=$(echo "$data" | head -c 12000)

  if [ ${#data} -gt 12000 ]; then
    echo "Note: Data truncated to 12000 chars for AI analysis." >&2
  fi

  echo "Analyzing with AI..." >&2
  evolink_ai "You are a data analyst. Analyze the following Google Sheets data and provide:

1. Data Overview (what the data represents, rows/columns)
2. Key Patterns (trends, correlations, outliers)
3. Statistical Summary (averages, ranges, distributions where applicable)
4. Data Quality Issues (missing values, inconsistencies, duplicates)
5. Actionable Insights (recommendations based on the data)

Be specific with numbers and cell references. Format with clear sections." "SPREADSHEET DATA (JSON):
$truncated"
}

cmd_ai_formula() {
  local description="${1:?Usage: sheets.sh ai-formula <description>}"
  check_deps
  check_evolink_key

  echo "Generating formula..." >&2
  evolink_ai "You are a Google Sheets formula expert. The user wants a formula that does:

$description

Provide:
1. The exact Google Sheets formula
2. Brief explanation of how it works
3. Example with sample data
4. Alternative approaches (if any)

Use standard Google Sheets functions (not Excel-only). Be precise and ready to paste." ""
}

cmd_ai_summary() {
  local spreadsheet_id="${1:?Usage: sheets.sh ai-summary <SPREADSHEET_ID> [range]}"
  local range="${2:-Sheet1}"
  check_deps
  check_maton_key
  check_evolink_key

  echo "Fetching spreadsheet info..." >&2
  local metadata
  metadata=$(maton_get "/v4/spreadsheets/$spreadsheet_id") || exit 1

  local meta_compact
  meta_compact=$(echo "$metadata" | python3 -c "
import json, sys
data = json.load(sys.stdin)
props = data.get('properties', {})
sheets = data.get('sheets', [])
print(f\"Title: {props.get('title', 'N/A')}\")
print(f\"Sheets: {len(sheets)}\")
for s in sheets:
    sp = s.get('properties', {})
    gp = sp.get('gridProperties', {})
    print(f\"  - {sp.get('title', 'N/A')}: {gp.get('rowCount', 0)} rows x {gp.get('columnCount', 0)} cols\")
" | tr -d '\r')

  echo "Fetching data from $range..." >&2
  local data
  data=$(fetch_sheet_data "$spreadsheet_id" "$range") || exit 1

  local truncated
  truncated=$(echo "$data" | head -c 12000)

  if [ ${#data} -gt 12000 ]; then
    echo "Note: Data truncated to 12000 chars for AI summary." >&2
  fi

  echo "Generating AI summary..." >&2
  evolink_ai "You are a data analyst. Summarize the following Google Sheets data concisely. Include:

1. What the data is about (purpose, topic)
2. Key figures and metrics
3. Notable trends or patterns
4. Recommended next steps or actions

Be concise and insightful." "SPREADSHEET METADATA:
$meta_compact

SPREADSHEET DATA (JSON):
$truncated"
}

# --- Main ---
COMMAND="${1:-help}"
shift || true

case "$COMMAND" in
  read)           cmd_read "$@" ;;
  write)          cmd_write "$@" ;;
  append)         cmd_append "$@" ;;
  info)           cmd_info "$@" ;;
  create)         cmd_create "$@" ;;
  clear)          cmd_clear "$@" ;;
  format)         cmd_format "$@" ;;
  connection)     cmd_connection "$@" ;;
  ai-analyze)     cmd_ai_analyze "$@" ;;
  ai-formula)     cmd_ai_formula "$@" ;;
  ai-summary)     cmd_ai_summary "$@" ;;
  help|*)
    echo "Google Sheets Assistant — Read, write, and analyze spreadsheets with AI"
    echo ""
    echo "Usage: bash sheets.sh <command> [options]"
    echo ""
    echo "Setup:"
    echo "  connection list                         List Google OAuth connections"
    echo "  connection create                       Create new Google connection"
    echo "  connection delete <connection_id>       Delete a connection"
    echo ""
    echo "Core Commands (requires MATON_API_KEY):"
    echo "  read <ID> [range]                       Read values from spreadsheet"
    echo "  write <ID> <range> <values_json>        Write values to range"
    echo "  append <ID> <range> <values_json>       Append rows to range"
    echo "  info <ID>                               Get spreadsheet metadata"
    echo "  create <title>                          Create new spreadsheet"
    echo "  clear <ID> <range>                      Clear a range"
    echo "  format <ID> <requests_json>             Apply batchUpdate formatting"
    echo ""
    echo "AI Commands (requires EVOLINK_API_KEY):"
    echo "  ai-analyze <ID> [range]                 Analyze data patterns & insights"
    echo "  ai-formula <description>                Generate formula from description"
    echo "  ai-summary <ID> [range]                 Summarize spreadsheet content"
    echo ""
    echo "Get Maton API key:   https://maton.ai/settings"
    echo "Get EvoLink API key: https://evolink.ai/signup"
    ;;
esac
