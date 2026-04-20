#!/usr/bin/env bash
set -euo pipefail

# Slack OAuth Authentication Manager
# Usage:
#   bash slack-auth.sh setup          — Configure Slack app credentials
#   bash slack-auth.sh login          — Run OAuth flow and get tokens
#   bash slack-auth.sh status         — Check authentication status
#   bash slack-auth.sh revoke         — Revoke token and remove stored credentials

CONFIG_DIR="${SLACK_SKILL_DIR:-$HOME/.slack-skill}"
CREDENTIALS_FILE="$CONFIG_DIR/credentials.json"
TOKEN_FILE="$CONFIG_DIR/token.json"

# Bot token scopes needed for all features
SCOPES="channels:read,channels:write,channels:history,channels:manage,chat:write,files:read,files:write,groups:read,groups:write,groups:history,im:read,im:write,im:history,mpim:read,mpim:write,mpim:history,search:read,users:read,users:read.email,reactions:read,reactions:write"

# --- Helpers ---
err() { echo "Error: $*" >&2; exit 1; }
info() { echo "→ $*"; }

# Convert Git Bash paths (/c/Users/...) to Windows paths (C:/Users/...) for Python
to_native_path() {
  if [[ "$1" =~ ^/([a-zA-Z])/ ]]; then
    echo "${BASH_REMATCH[1]}:/${1:3}"
  else
    echo "$1"
  fi
}

CREDENTIALS_FILE_NATIVE=$(to_native_path "$CREDENTIALS_FILE")
TOKEN_FILE_NATIVE=$(to_native_path "$TOKEN_FILE")

ensure_config_dir() {
  mkdir -p "$CONFIG_DIR"
  chmod 700 "$CONFIG_DIR"
}

check_credentials() {
  [ -f "$CREDENTIALS_FILE" ] || err "credentials.json not found at $CREDENTIALS_FILE
Create a Slack app and save credentials:
  1. Go to https://api.slack.com/apps
  2. Create New App > From scratch
  3. Go to OAuth & Permissions
  4. Add Bot Token Scopes (see docs)
  5. Install to Workspace
  6. Save client_id, client_secret, and bot_token to $CREDENTIALS_FILE"
}

read_credential_field() {
  python3 -c "
import json
with open('$CREDENTIALS_FILE_NATIVE') as f:
    data = json.load(f)
print(data.get('$1', ''))
" | tr -d '\r'
}

# --- Commands ---
cmd_setup() {
  ensure_config_dir
  info "Slack Skill config directory: $CONFIG_DIR"

  if [ -f "$CREDENTIALS_FILE" ]; then
    info "credentials.json already exists at $CREDENTIALS_FILE"
    local bot_token
    bot_token=$(read_credential_field "bot_token")
    if [ -n "$bot_token" ]; then
      info "Bot token: ${bot_token:0:15}..."
      info "Run 'slack-auth.sh status' to verify."
    else
      info "No bot_token found. Run 'slack-auth.sh login' for OAuth flow."
    fi
  else
    info "Setting up Slack credentials..."
    info ""
    info "Option A: Direct Bot Token (Recommended for personal use)"
    info "  1. Go to https://api.slack.com/apps"
    info "  2. Create New App > From scratch"
    info "  3. Go to 'OAuth & Permissions'"
    info "  4. Add Bot Token Scopes:"
    info "     channels:read, channels:write, channels:history, channels:manage"
    info "     chat:write, files:read, files:write"
    info "     groups:read, groups:write, groups:history"
    info "     im:read, im:write, im:history"
    info "     mpim:read, mpim:write, mpim:history"
    info "     search:read, users:read, users:read.email"
    info "     reactions:read, reactions:write"
    info "  5. Install App to Workspace"
    info "  6. Copy the 'Bot User OAuth Token' (starts with xoxb-)"
    info "  7. Create $CREDENTIALS_FILE with:"
    info '     {"bot_token": "xoxb-your-token", "client_id": "...", "client_secret": "..."}'
    info ""
    info "Option B: OAuth Flow (For distributable apps)"
    info "  1. Complete steps 1-4 above"
    info "  2. Add Redirect URL: http://localhost:8085"
    info "  3. Save client_id and client_secret to credentials.json:"
    info '     {"client_id": "...", "client_secret": "..."}'
    info "  4. Run 'slack-auth.sh login'"
  fi
}

cmd_login() {
  check_credentials

  # Check if we already have a bot token
  local existing_token
  existing_token=$(read_credential_field "bot_token")
  if [ -n "$existing_token" ]; then
    info "Bot token already present in credentials.json."
    info "Testing connection..."
    local test_result
    test_result=$(curl -s -H "Authorization: Bearer $existing_token" "https://slack.com/api/auth.test")
    local ok
    ok=$(echo "$test_result" | python3 -c "import json,sys; print(json.load(sys.stdin).get('ok',''))" | tr -d '\r')
    if [ "$ok" = "True" ]; then
      # Save to token.json for consistency
      python3 -c "
import json, time
data = {'bot_token': '$existing_token', 'created_at': int(time.time())}
with open('$TOKEN_FILE_NATIVE', 'w') as f:
    json.dump(data, f, indent=2)
"
      chmod 600 "$TOKEN_FILE"
      local team user
      team=$(echo "$test_result" | python3 -c "import json,sys; print(json.load(sys.stdin).get('team',''))" | tr -d '\r')
      user=$(echo "$test_result" | python3 -c "import json,sys; print(json.load(sys.stdin).get('user',''))" | tr -d '\r')
      info "Connected! Workspace: $team, Bot: $user"
      return
    else
      info "Stored bot token is invalid. Starting OAuth flow..."
    fi
  fi

  # OAuth flow
  local client_id client_secret
  client_id=$(read_credential_field "client_id")
  client_secret=$(read_credential_field "client_secret")

  [ -z "$client_id" ] && err "client_id not found in credentials.json"
  [ -z "$client_secret" ] && err "client_secret not found in credentials.json"

  REDIRECT_PORT=8085
  REDIRECT_URI="http://localhost:$REDIRECT_PORT"

  local auth_url="https://slack.com/oauth/v2/authorize?client_id=${client_id}&scope=${SCOPES}&redirect_uri=$(python3 -c "import urllib.parse; print(urllib.parse.quote('$REDIRECT_URI'))" | tr -d '\r')"

  info "Open this URL in your browser to authorize:"
  echo ""
  echo "$auth_url"
  echo ""
  info "Waiting for authorization callback on port $REDIRECT_PORT..."

  # One-shot HTTP server to capture OAuth callback
  local auth_code
  auth_code=$(python3 -c "
import http.server, urllib.parse, sys

class Handler(http.server.BaseHTTPRequestHandler):
    def do_GET(self):
        query = urllib.parse.urlparse(self.path).query
        params = urllib.parse.parse_qs(query)
        code = params.get('code', [None])[0]
        error = params.get('error', [None])[0]

        if code:
            self.send_response(200)
            self.send_header('Content-Type', 'text/html')
            self.end_headers()
            self.wfile.write(b'<html><body><h2>Slack authorization successful!</h2><p>You can close this window now.</p></body></html>')
            print(code)
        elif error:
            self.send_response(400)
            self.send_header('Content-Type', 'text/html')
            self.end_headers()
            self.wfile.write(f'<html><body><h2>Authorization failed: {error}</h2></body></html>'.encode())
            print('ERROR:' + error, file=sys.stderr)
        sys.stdout.flush()

    def log_message(self, format, *args):
        pass

server = http.server.HTTPServer(('localhost', $REDIRECT_PORT), Handler)
server.handle_request()
server.server_close()
" | tr -d '\r')

  [ -z "$auth_code" ] && err "No authorization code received"

  info "Exchanging code for token..."

  local response
  response=$(curl -s -X POST "https://slack.com/api/oauth.v2.access" \
    -d "code=$auth_code" \
    -d "client_id=$client_id" \
    -d "client_secret=$client_secret" \
    -d "redirect_uri=$REDIRECT_URI")

  local ok
  ok=$(echo "$response" | python3 -c "import json,sys; print(json.load(sys.stdin).get('ok', False))" | tr -d '\r')

  if [ "$ok" != "True" ]; then
    err "Token exchange failed: $response"
  fi

  python3 -c "
import json, time
response = json.loads('''$response''')
token_data = {
    'bot_token': response.get('access_token', ''),
    'team_id': response.get('team', {}).get('id', ''),
    'team_name': response.get('team', {}).get('name', ''),
    'bot_user_id': response.get('bot_user_id', ''),
    'scope': response.get('scope', ''),
    'created_at': int(time.time())
}
with open('$TOKEN_FILE_NATIVE', 'w') as f:
    json.dump(token_data, f, indent=2)
"

  chmod 600 "$TOKEN_FILE"
  info "Authentication successful! Token saved to $TOKEN_FILE"
}

cmd_status() {
  info "Config directory: $CONFIG_DIR"

  if [ -f "$CREDENTIALS_FILE" ]; then
    local bot_token
    bot_token=$(read_credential_field "bot_token")
    if [ -n "$bot_token" ]; then
      info "Credentials: OK (bot_token present)"
    else
      local client_id
      client_id=$(read_credential_field "client_id")
      info "Credentials: OK (client_id: ${client_id:0:15}...)"
    fi
  else
    info "Credentials: NOT FOUND"
    return
  fi

  # Test the actual token
  local token=""
  if [ -f "$TOKEN_FILE" ]; then
    token=$(python3 -c "import json; f=open('$TOKEN_FILE_NATIVE'); print(json.load(f).get('bot_token',''))" | tr -d '\r')
  fi
  [ -z "$token" ] && token=$(read_credential_field "bot_token")

  if [ -n "$token" ]; then
    local result
    result=$(curl -s -H "Authorization: Bearer $token" "https://slack.com/api/auth.test")
    local ok
    ok=$(echo "$result" | python3 -c "import json,sys; print(json.load(sys.stdin).get('ok',''))" | tr -d '\r')
    if [ "$ok" = "True" ]; then
      local team user
      team=$(echo "$result" | python3 -c "import json,sys; print(json.load(sys.stdin).get('team',''))" | tr -d '\r')
      user=$(echo "$result" | python3 -c "import json,sys; print(json.load(sys.stdin).get('user',''))" | tr -d '\r')
      info "Token: VALID (Workspace: $team, Bot: $user)"
    else
      local error_msg
      error_msg=$(echo "$result" | python3 -c "import json,sys; print(json.load(sys.stdin).get('error','unknown'))" | tr -d '\r')
      info "Token: INVALID ($error_msg)"
    fi
  else
    info "Token: NOT FOUND (run slack-auth.sh login)"
  fi
}

cmd_revoke() {
  local token=""
  if [ -f "$TOKEN_FILE" ]; then
    token=$(python3 -c "import json; f=open('$TOKEN_FILE_NATIVE'); print(json.load(f).get('bot_token',''))" | tr -d '\r')
  fi
  [ -z "$token" ] && token=$(read_credential_field "bot_token" 2>/dev/null || echo "")

  if [ -n "$token" ]; then
    curl -s -X POST "https://slack.com/api/auth.revoke" \
      -H "Authorization: Bearer $token" >/dev/null 2>&1 || true
    info "Token revoked from Slack."
  fi

  if [ -f "$TOKEN_FILE" ]; then
    rm -f "$TOKEN_FILE"
    info "Local token file removed."
  else
    info "No token file found. Nothing to revoke."
  fi
}

# --- Main ---
COMMAND="${1:-help}"

case "$COMMAND" in
  setup)   cmd_setup ;;
  login)   cmd_login ;;
  status)  cmd_status ;;
  revoke)  cmd_revoke ;;
  help|*)
    echo "Slack OAuth Authentication Manager"
    echo ""
    echo "Usage: bash slack-auth.sh <command>"
    echo ""
    echo "Commands:"
    echo "  setup    — Configure Slack app credentials"
    echo "  login    — Authenticate with bot token or OAuth flow"
    echo "  status   — Check authentication status"
    echo "  revoke   — Revoke token and clean up"
    ;;
esac
