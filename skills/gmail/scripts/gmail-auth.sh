#!/usr/bin/env bash
set -euo pipefail

# Gmail OAuth Authentication Manager
# Usage:
#   bash gmail-auth.sh setup          — Configure credentials.json path
#   bash gmail-auth.sh login          — Run OAuth flow and get tokens
#   bash gmail-auth.sh refresh        — Refresh expired access token
#   bash gmail-auth.sh revoke         — Revoke tokens and remove stored credentials
#   bash gmail-auth.sh status         — Check authentication status

CONFIG_DIR="${GMAIL_SKILL_DIR:-$HOME/.gmail-skill}"
CREDENTIALS_FILE="$CONFIG_DIR/credentials.json"
TOKEN_FILE="$CONFIG_DIR/token.json"

SCOPES="https://www.googleapis.com/auth/gmail.modify https://www.googleapis.com/auth/gmail.compose https://www.googleapis.com/auth/gmail.readonly"

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
Download it from Google Cloud Console:
  1. Go to https://console.cloud.google.com/apis/credentials
  2. Create OAuth client ID (Desktop app)
  3. Download JSON and place at $CREDENTIALS_FILE"
}

read_credential_field() {
  python3 -c "
import json, sys
with open('$CREDENTIALS_FILE_NATIVE') as f:
    data = json.load(f)
key = list(data.keys())[0]
print(data[key]['$1'])
"
}

# --- Commands ---
cmd_setup() {
  ensure_config_dir
  info "Gmail Skill config directory: $CONFIG_DIR"

  if [ -f "$CREDENTIALS_FILE" ]; then
    info "credentials.json already exists at $CREDENTIALS_FILE"
    CLIENT_ID=$(read_credential_field "client_id")
    info "Client ID: ${CLIENT_ID:0:20}..."
    info "Run 'gmail-auth.sh login' to authorize."
  else
    info "Place your Google OAuth credentials.json at:"
    info "  $CREDENTIALS_FILE"
    info ""
    info "How to get credentials.json:"
    info "  1. Go to https://console.cloud.google.com/"
    info "  2. Create or select a project"
    info "  3. Enable Gmail API: APIs & Services > Library > Gmail API"
    info "  4. Create OAuth credentials: APIs & Services > Credentials"
    info "     > Create Credentials > OAuth client ID > Desktop app"
    info "  5. Download the JSON file"
    info "  6. Copy it to $CREDENTIALS_FILE"
  fi
}

cmd_login() {
  check_credentials

  CLIENT_ID=$(read_credential_field "client_id")
  CLIENT_SECRET=$(read_credential_field "client_secret")

  # Start a temporary local HTTP server to receive the OAuth callback
  REDIRECT_PORT=8085
  REDIRECT_URI="http://localhost:$REDIRECT_PORT"

  ENCODED_SCOPES=$(python3 -c "import urllib.parse; print(urllib.parse.quote('$SCOPES'))")

  AUTH_URL="https://accounts.google.com/o/oauth2/v2/auth?client_id=${CLIENT_ID}&redirect_uri=$(python3 -c "import urllib.parse; print(urllib.parse.quote('$REDIRECT_URI'))")&response_type=code&scope=${ENCODED_SCOPES}&access_type=offline&prompt=consent"

  info "Open this URL in your browser to authorize:"
  echo ""
  echo "$AUTH_URL"
  echo ""
  info "Waiting for authorization callback on port $REDIRECT_PORT..."

  # Use Python to run a one-shot HTTP server that captures the auth code
  AUTH_CODE=$(python3 -c "
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
            self.wfile.write(b'<html><body><h2>Authorization successful!</h2><p>You can close this window now.</p></body></html>')
            print(code)
        elif error:
            self.send_response(400)
            self.send_header('Content-Type', 'text/html')
            self.end_headers()
            self.wfile.write(f'<html><body><h2>Authorization failed: {error}</h2></body></html>'.encode())
            print('ERROR:' + error, file=sys.stderr)
        sys.stdout.flush()

    def log_message(self, format, *args):
        pass  # Suppress HTTP logs

server = http.server.HTTPServer(('localhost', $REDIRECT_PORT), Handler)
server.handle_request()
server.server_close()
")

  [ -z "$AUTH_CODE" ] && err "No authorization code received"

  info "Exchanging code for tokens..."

  RESPONSE=$(curl -s -X POST "https://oauth2.googleapis.com/token" \
    -H "Content-Type: application/x-www-form-urlencoded" \
    -d "code=$AUTH_CODE" \
    -d "client_id=$CLIENT_ID" \
    -d "client_secret=$CLIENT_SECRET" \
    -d "redirect_uri=$REDIRECT_URI" \
    -d "grant_type=authorization_code")

  ERROR=$(echo "$RESPONSE" | python3 -c "import json,sys; d=json.load(sys.stdin); print(d.get('error',''))" 2>/dev/null || echo "parse_error")

  if [ -n "$ERROR" ] && [ "$ERROR" != "" ]; then
    err "Token exchange failed: $RESPONSE"
  fi

  echo "$RESPONSE" | python3 -c "
import json, sys, time
data = json.load(sys.stdin)
data['created_at'] = int(time.time())
with open('$TOKEN_FILE_NATIVE', 'w') as f:
    json.dump(data, f, indent=2)
"

  chmod 600 "$TOKEN_FILE"
  info "Authentication successful! Tokens saved to $TOKEN_FILE"
}

cmd_refresh() {
  [ -f "$TOKEN_FILE" ] || err "No token file found. Run 'gmail-auth.sh login' first."
  check_credentials

  CLIENT_ID=$(read_credential_field "client_id")
  CLIENT_SECRET=$(read_credential_field "client_secret")

  REFRESH_TOKEN=$(python3 -c "
import json
with open('$TOKEN_FILE_NATIVE') as f:
    print(json.load(f)['refresh_token'])
")

  [ -z "$REFRESH_TOKEN" ] && err "No refresh token found. Run 'gmail-auth.sh login' again."

  RESPONSE=$(curl -s -X POST "https://oauth2.googleapis.com/token" \
    -H "Content-Type: application/x-www-form-urlencoded" \
    -d "refresh_token=$REFRESH_TOKEN" \
    -d "client_id=$CLIENT_ID" \
    -d "client_secret=$CLIENT_SECRET" \
    -d "grant_type=refresh_token")

  ERROR=$(echo "$RESPONSE" | python3 -c "import json,sys; d=json.load(sys.stdin); print(d.get('error',''))" 2>/dev/null || echo "")

  if [ -n "$ERROR" ] && [ "$ERROR" != "" ]; then
    err "Token refresh failed: $RESPONSE"
  fi

  python3 -c "
import json, time
with open('$TOKEN_FILE_NATIVE') as f:
    token_data = json.load(f)
import sys
new_data = json.loads(sys.stdin.read())
token_data['access_token'] = new_data['access_token']
token_data['expires_in'] = new_data.get('expires_in', 3600)
token_data['created_at'] = int(time.time())
with open('$TOKEN_FILE_NATIVE', 'w') as f:
    json.dump(token_data, f, indent=2)
" <<< "$RESPONSE"

  info "Token refreshed successfully."
}

cmd_revoke() {
  if [ -f "$TOKEN_FILE" ]; then
    ACCESS_TOKEN=$(python3 -c "
import json
with open('$TOKEN_FILE_NATIVE') as f:
    print(json.load(f).get('access_token', ''))
")

    if [ -n "$ACCESS_TOKEN" ]; then
      curl -s "https://oauth2.googleapis.com/revoke?token=$ACCESS_TOKEN" >/dev/null 2>&1 || true
      info "Token revoked from Google."
    fi

    rm -f "$TOKEN_FILE"
    info "Local token file removed."
  else
    info "No token file found. Nothing to revoke."
  fi
}

cmd_status() {
  info "Config directory: $CONFIG_DIR"

  if [ -f "$CREDENTIALS_FILE" ]; then
    CLIENT_ID=$(read_credential_field "client_id")
    info "Credentials: OK (${CLIENT_ID:0:20}...)"
  else
    info "Credentials: NOT FOUND"
  fi

  if [ -f "$TOKEN_FILE" ]; then
    CREATED=$(python3 -c "
import json, time
with open('$TOKEN_FILE_NATIVE') as f:
    d = json.load(f)
created = d.get('created_at', 0)
expires = d.get('expires_in', 3600)
remaining = (created + expires) - int(time.time())
if remaining > 0:
    print(f'VALID ({remaining}s remaining)')
else:
    print('EXPIRED (run gmail-auth.sh refresh)')
")
    info "Token: $CREATED"
  else
    info "Token: NOT FOUND (run gmail-auth.sh login)"
  fi
}

# --- Main ---
COMMAND="${1:-help}"

case "$COMMAND" in
  setup)   cmd_setup ;;
  login)   cmd_login ;;
  refresh) cmd_refresh ;;
  revoke)  cmd_revoke ;;
  status)  cmd_status ;;
  help|*)
    echo "Gmail OAuth Authentication Manager"
    echo ""
    echo "Usage: bash gmail-auth.sh <command>"
    echo ""
    echo "Commands:"
    echo "  setup    — Configure credentials.json path"
    echo "  login    — Run OAuth flow and get tokens"
    echo "  refresh  — Refresh expired access token"
    echo "  revoke   — Revoke tokens and clean up"
    echo "  status   — Check authentication status"
    ;;
esac
