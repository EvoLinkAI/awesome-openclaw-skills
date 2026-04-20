#!/usr/bin/env bash
set -euo pipefail

# Debug Assistant — AI-powered debugging for error logs, stack traces, and code
# Usage: bash debug.sh <command> [options]
#
# Commands:
#   languages                          — List supported languages
#   cheatsheet [language]              — Quick debugging commands
#   analyze <file>                     — AI analyze error log file
#   explain <error_message>            — AI explain an error message
#   trace <file>                       — AI parse and explain stack trace
#   suggest <file> --error <message>   — AI suggest fixes for code with error

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

# --- Cheatsheets ---

cheatsheet_js() {
  cat <<'EOF'
JavaScript / TypeScript Debugging:

  # Node.js debugger
  node --inspect-brk app.js
  # Then open chrome://inspect

  # Console debugging
  console.log(JSON.stringify(obj, null, 2))
  console.trace('Call stack here')
  console.time('perf'); /* code */ console.timeEnd('perf')

  # Memory leaks
  node --expose-gc --max-old-space-size=4096 app.js

  # Common errors:
  Cannot read property of undefined  → Add optional chaining (?.) or validate data
  Module not found                   → npm install, check tsconfig paths
  Hydration mismatch (React)         → Ensure consistent SSR/CSR, use useEffect
EOF
}

cheatsheet_python() {
  cat <<'EOF'
Python Debugging:

  # Built-in debugger
  python -m pdb script.py

  # Breakpoint in code (Python 3.7+)
  breakpoint()

  # Memory tracing
  python -X tracemalloc script.py

  # Profiling
  python -m cProfile -s cumulative script.py

  # Common errors:
  IndexError: list index out of range  → Check list length before access
  KeyError                             → Use dict.get(key, default)
  ImportError / ModuleNotFoundError    → pip install, check sys.path
  TypeError: NoneType                  → Function returning None unexpectedly
EOF
}

cheatsheet_go() {
  cat <<'EOF'
Go Debugging:

  # Delve debugger
  dlv debug main.go
  (dlv) break main.main
  (dlv) continue
  (dlv) print myVar
  (dlv) goroutines

  # Race condition detection
  go run -race main.go
  go test -race ./...

  # Profiling
  go test -cpuprofile cpu.prof -memprofile mem.prof -bench .
  go tool pprof cpu.prof

  # Common errors:
  nil pointer dereference       → Check nil before accessing struct fields
  deadlock                      → Review goroutine/channel usage, use -race
  cannot use X as type Y        → Check interface implementation
EOF
}

cheatsheet_rust() {
  cat <<'EOF'
Rust Debugging:

  # GDB / LLDB
  rust-gdb target/debug/myapp
  rust-lldb target/debug/myapp

  # Verbose compiler output
  RUST_BACKTRACE=1 cargo run
  RUST_BACKTRACE=full cargo run

  # Logging
  RUST_LOG=debug cargo run   # requires env_logger

  # Common errors:
  borrow checker errors         → Review ownership, use clone() or Rc/Arc
  cannot move out of borrowed   → Use references or .clone()
  thread 'main' panicked        → Check unwrap() calls, use match/if let
EOF
}

cheatsheet_java() {
  cat <<'EOF'
Java Debugging:

  # Remote debugging
  java -agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=5005 -jar app.jar

  # Heap dump
  jmap -dump:format=b,file=heap.hprof <pid>

  # Thread dump
  jstack <pid>

  # GC logging
  java -Xlog:gc*:file=gc.log -jar app.jar

  # Common errors:
  NullPointerException          → Null check or use Optional
  ClassNotFoundException        → Check classpath, dependency versions
  OutOfMemoryError              → Increase -Xmx, check for leaks
  ConcurrentModificationException → Use Iterator.remove() or CopyOnWriteArrayList
EOF
}

cheatsheet_network() {
  cat <<'EOF'
Network Debugging:

  # HTTP debugging
  curl -v https://api.example.com/endpoint
  curl -w "time_total: %{time_total}s\n" -o /dev/null -s https://example.com

  # DNS
  dig example.com
  nslookup example.com

  # Ports
  lsof -i :3000
  netstat -tlnp

  # TCP connections
  ss -tunapl

  # Common errors:
  ECONNREFUSED        → Service not running on expected port
  CORS error          → Backend missing CORS headers
  ETIMEDOUT           → Firewall, DNS, or service unreachable
  SSL certificate     → Check cert expiry, chain, hostname match
EOF
}

cheatsheet_css() {
  cat <<'EOF'
CSS / Layout Debugging:

  /* Outline all elements */
  * { outline: 1px solid red !important; }

  /* Debug specific element */
  .debug { background: rgba(255,0,0,0.1) !important; }

  /* Show overflow */
  * { overflow: visible !important; }

  Common issues:
  Element not visible       → Check display, visibility, opacity, z-index
  Unexpected overflow       → Find element wider than viewport with outline trick
  Flexbox not working       → Check parent display:flex, child flex properties
  Grid misalignment         → Use Firefox Grid Inspector
EOF
}

cheatsheet_git() {
  cat <<'EOF'
Git Bisect (binary search for bugs):

  git bisect start
  git bisect bad                # Current commit is broken
  git bisect good abc1234       # Known good commit
  # Git checks out middle commit — test it, then:
  git bisect good   # or   git bisect bad
  # Repeat until root cause commit is found
  git bisect reset

  # Automated bisect with test script
  git bisect start HEAD abc1234
  git bisect run npm test
EOF
}

# --- Commands ---

cmd_languages() {
  echo "Supported Languages & Tools:"
  echo ""
  echo "  javascript    JS/TS — Node.js debugger, console, memory"
  echo "  python        pdb, breakpoint, tracemalloc, cProfile"
  echo "  go            Delve, race detection, pprof"
  echo "  rust          GDB/LLDB, RUST_BACKTRACE, env_logger"
  echo "  java          Remote debug, jmap, jstack, GC logging"
  echo "  network       curl, dig, lsof, netstat, ss"
  echo "  css           Outline tricks, layout debugging"
  echo "  git           git bisect for binary search debugging"
}

cmd_cheatsheet() {
  local lang="${1:-all}"
  case "$lang" in
    javascript|js|typescript|ts) cheatsheet_js ;;
    python|py)                   cheatsheet_python ;;
    go|golang)                   cheatsheet_go ;;
    rust|rs)                     cheatsheet_rust ;;
    java|jvm)                    cheatsheet_java ;;
    network|net)                 cheatsheet_network ;;
    css|layout)                  cheatsheet_css ;;
    git|bisect)                  cheatsheet_git ;;
    all)
      cheatsheet_js; echo ""; echo "---"; echo ""
      cheatsheet_python; echo ""; echo "---"; echo ""
      cheatsheet_go; echo ""; echo "---"; echo ""
      cheatsheet_rust; echo ""; echo "---"; echo ""
      cheatsheet_java; echo ""; echo "---"; echo ""
      cheatsheet_network; echo ""; echo "---"; echo ""
      cheatsheet_css; echo ""; echo "---"; echo ""
      cheatsheet_git ;;
    *) err "Unknown language: $lang. Run 'debug.sh languages' for the list." ;;
  esac
}

cmd_analyze() {
  local file="${1:?Usage: debug.sh analyze <error-log-file>}"
  check_deps

  echo "Reading log file..." >&2
  local content
  content=$(read_file "$file")
  local truncated
  truncated=$(echo "$content" | head -c 12000)

  echo "Analyzing errors..." >&2
  evolink_ai "You are a senior debugging engineer. Analyze this error log and provide:

1. **Error Summary** — What went wrong, in one sentence.
2. **Root Cause** — The most likely underlying cause.
3. **Error Chain** — If multiple errors exist, show the causal chain (which error triggered which).
4. **Affected Components** — Which parts of the system are involved.
5. **Fix Steps** — Numbered, actionable steps to resolve the issue.
6. **Prevention** — How to prevent this from happening again.

Be specific. Reference exact error messages, line numbers, and file paths from the log. Do not give generic advice." "ERROR LOG:
$truncated"
}

cmd_explain() {
  local message="$*"
  [ -z "$message" ] && err "Usage: debug.sh explain <error_message>"
  check_deps

  echo "Analyzing error..." >&2
  evolink_ai "You are a senior debugging engineer. Explain this error message:

1. **What it means** — Plain English explanation.
2. **Common causes** — Top 3 most likely causes, ranked by probability.
3. **Quick fix** — The fastest way to resolve it.
4. **Proper fix** — The correct long-term solution.
5. **Related errors** — Other errors that often appear alongside this one.

Be concise and practical. No filler." "ERROR MESSAGE:
$message"
}

cmd_trace() {
  local file="${1:?Usage: debug.sh trace <stacktrace-file>}"
  check_deps

  echo "Reading stack trace..." >&2
  local content
  content=$(read_file "$file")
  local truncated
  truncated=$(echo "$content" | head -c 12000)

  echo "Parsing stack trace..." >&2
  evolink_ai "You are a senior debugging engineer. Parse and explain this stack trace:

1. **Exception/Error** — The top-level error type and message.
2. **Origin** — The exact file, line, and function where the error originated.
3. **Call Chain** — Simplified call chain from entry point to error (skip framework internals, focus on user code).
4. **Root Cause** — What most likely went wrong at the origin point.
5. **Fix** — Specific code change to resolve this.

Format the call chain as a clean, readable list. Highlight user code vs framework/library code." "STACK TRACE:
$truncated"
}

cmd_suggest() {
  local file=""
  local error_msg=""

  while [[ $# -gt 0 ]]; do
    case "$1" in
      --error) shift; error_msg="$*"; break ;;
      -*) err "Unknown option: $1" ;;
      *) file="$1"; shift ;;
    esac
  done

  [ -z "$file" ] && err "Usage: debug.sh suggest <code-file> --error <error_message>"
  [ -z "$error_msg" ] && err "Missing --error. Provide the error message."
  check_deps

  echo "Reading code..." >&2
  local content
  content=$(read_file "$file")
  local truncated
  truncated=$(echo "$content" | head -c 12000)

  echo "Generating fix suggestions..." >&2
  evolink_ai "You are a senior debugging engineer. The user has this code file that produces the error shown below.

1. **Bug Location** — Identify the exact line(s) causing the error.
2. **Why It Fails** — Explain the root cause.
3. **Fix** — Show the corrected code (minimal diff, only change what's needed).
4. **Verification** — How to verify the fix works.

Show the fix as a before/after code diff. Do not rewrite the entire file — only show the relevant section." "ERROR: $error_msg

CODE FILE ($file):
$truncated"
}

# --- Main ---
COMMAND="${1:-help}"
shift || true

case "$COMMAND" in
  languages)    cmd_languages ;;
  cheatsheet)   cmd_cheatsheet "$@" ;;
  analyze)      cmd_analyze "$@" ;;
  explain)      cmd_explain "$@" ;;
  trace)        cmd_trace "$@" ;;
  suggest)      cmd_suggest "$@" ;;
  help|*)
    echo "Debug Assistant — AI-powered debugging from your terminal"
    echo ""
    echo "Usage: bash debug.sh <command> [options]"
    echo ""
    echo "Info Commands (no API key needed):"
    echo "  languages                          List supported languages"
    echo "  cheatsheet [language]              Debugging commands cheatsheet"
    echo ""
    echo "AI Commands (requires EVOLINK_API_KEY):"
    echo "  analyze <file>                     Analyze error log file"
    echo "  explain <error_message>            Explain an error message"
    echo "  trace <file>                       Parse and explain stack trace"
    echo "  suggest <file> --error <message>   Suggest fixes for code"
    echo ""
    echo "Languages: javascript, python, go, rust, java, network, css, git"
    echo ""
    echo "Get a free EvoLink API key: https://evolink.ai/signup"
    ;;
esac
