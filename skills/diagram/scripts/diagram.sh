#!/usr/bin/env bash
set -euo pipefail

# Diagram Generator — AI-powered diagram creation, editing, and conversion
# Usage: bash diagram.sh <command> [options]
#
# Commands:
#   templates                                — List diagram types and format examples
#   generate <type> [--format <fmt>] "<desc>" — AI generate diagram from description
#   edit <file> "<instruction>"              — AI modify existing diagram file
#   convert <file> --to <format>             — AI convert between diagram formats
#   explain <file>                           — AI explain diagram structure in plain language
#   preview <file>                           — Open diagram in browser for visual preview

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

detect_format() {
  local file="$1"
  local ext="${file##*.}"
  case "$ext" in
    mmd|mermaid) echo "mermaid" ;;
    drawio|xml)  echo "drawio" ;;
    puml|plantuml) echo "plantuml" ;;
    dot|gv)      echo "graphviz" ;;
    json)
      if python3 -c "import json,sys; d=json.load(open(sys.argv[1])); sys.exit(0 if 'type' in d and 'elements' in d else 1)" "$file" 2>/dev/null; then
        echo "excalidraw"
      else
        echo "json"
      fi
      ;;
    *) echo "unknown" ;;
  esac
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
    'max_tokens': 8192,
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

  local result
  result=$(python3 -c "
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
" "$response")

  echo "$result"
}

# --- Commands ---

cmd_templates() {
  cat <<'EOF'
=== Diagram Types & Formats ===

Supported diagram types:
  flowchart        — Process flows, decision trees, workflows
  sequence         — API calls, service interactions, message flows
  class            — OOP class hierarchies, interfaces, relationships
  er               — Database entity-relationship diagrams
  state            — State machines, lifecycle transitions
  mindmap          — Idea maps, topic hierarchies, brainstorming
  architecture     — System architecture, microservices, cloud infra
  network          — Network topology, server layout, connectivity
  gantt            — Project timelines, task scheduling
  pie              — Data distribution, proportions
  git              — Git branch/merge visualization
  c4               — C4 model (context, container, component, code)

Supported output formats:
  mermaid    (.mmd)     — Text-based, renders in GitHub/GitLab/Notion
  drawio     (.drawio)  — XML-based, opens in draw.io / diagrams.net
  plantuml   (.puml)    — Text-based, renders via PlantUML server
  graphviz   (.dot)     — DOT language, renders via Graphviz

Format recommendations:
  Documentation / README  → mermaid (native GitHub rendering)
  Architecture diagrams   → drawio (drag-and-drop editing)
  UML / sequence diagrams → plantuml (rich UML support)
  Graph / network layout  → graphviz (automatic layout algorithms)

Examples:
  bash diagram.sh generate flowchart "user login flow with OAuth"
  bash diagram.sh generate er --format drawio "e-commerce database schema"
  bash diagram.sh generate architecture --format mermaid "microservices with API gateway"
EOF
}

cmd_generate() {
  check_deps
  [ $# -ge 1 ] || err "Usage: bash diagram.sh generate <type> [--format <fmt>] \"<description>\""

  local dtype="$1"; shift
  local format="mermaid"
  local description=""

  while [ $# -gt 0 ]; do
    case "$1" in
      --format) format="${2:?Missing format value}"; shift 2 ;;
      *) description="$1"; shift ;;
    esac
  done

  [ -n "$description" ] || err "Missing description. Usage: bash diagram.sh generate <type> [--format <fmt>] \"<description>\""

  local ext
  case "$format" in
    mermaid)  ext="mmd" ;;
    drawio)   ext="drawio" ;;
    plantuml) ext="puml" ;;
    graphviz) ext="dot" ;;
    *) err "Unknown format: $format. Supported: mermaid, drawio, plantuml, graphviz" ;;
  esac

  local prompt="You are a diagram generation expert. Generate a $dtype diagram in $format format based on the user's description.

Rules:
- Output ONLY the raw diagram code, no markdown fences, no explanations
- For mermaid: start directly with the diagram type keyword (graph, sequenceDiagram, classDiagram, etc.)
- For drawio: output valid XML starting with <?xml or <mxfile>
- For plantuml: start with @startuml and end with @enduml
- For graphviz: start with digraph or graph
- Use clear, descriptive labels for all nodes and edges
- Follow best practices for the chosen diagram type
- Make the diagram complete and production-ready"

  echo "Generating $dtype diagram in $format format..."
  local result
  result=$(evolink_ai "$prompt" "Diagram type: $dtype
Format: $format
Description: $description")

  local outfile="${dtype}_diagram.${ext}"
  printf '%s\n' "$result" > "$outfile"
  echo "Saved to: $outfile"
  echo ""
  echo "$result"
}

cmd_edit() {
  check_deps
  [ $# -ge 2 ] || err "Usage: bash diagram.sh edit <file> \"<instruction>\""

  local file="$1"; shift
  local instruction="$*"
  local content
  content=$(read_file "$file")
  local format
  format=$(detect_format "$file")

  [ "$format" != "unknown" ] || err "Cannot detect diagram format for: $file"

  local prompt="You are a diagram editing expert. Modify the following $format diagram according to the user's instruction.

Rules:
- Output ONLY the modified diagram code, no markdown fences, no explanations
- Preserve the existing structure and style where possible
- Only change what the instruction asks for
- Keep the output in the same format as the input"

  echo "Editing $file ($format format)..."
  local result
  result=$(evolink_ai "$prompt" "Format: $format
Instruction: $instruction

Current diagram:
$content")

  printf '%s\n' "$result" > "$file"
  echo "Updated: $file"
  echo ""
  echo "$result"
}

cmd_convert() {
  check_deps
  [ $# -ge 3 ] || err "Usage: bash diagram.sh convert <file> --to <format>"

  local file="$1"; shift
  local target_format=""

  while [ $# -gt 0 ]; do
    case "$1" in
      --to) target_format="${2:?Missing target format}"; shift 2 ;;
      *) err "Unknown option: $1" ;;
    esac
  done

  [ -n "$target_format" ] || err "Missing --to <format>"

  local content
  content=$(read_file "$file")
  local source_format
  source_format=$(detect_format "$file")

  [ "$source_format" != "unknown" ] || err "Cannot detect source format for: $file"

  local ext
  case "$target_format" in
    mermaid)  ext="mmd" ;;
    drawio)   ext="drawio" ;;
    plantuml) ext="puml" ;;
    graphviz) ext="dot" ;;
    *) err "Unknown target format: $target_format. Supported: mermaid, drawio, plantuml, graphviz" ;;
  esac

  local prompt="You are a diagram format conversion expert. Convert the following diagram from $source_format to $target_format format.

Rules:
- Output ONLY the converted diagram code, no markdown fences, no explanations
- Preserve all nodes, edges, labels, and relationships from the original
- Use idiomatic syntax for the target format
- Maintain visual structure and layout hints where possible"

  echo "Converting $file from $source_format to $target_format..."
  local result
  result=$(evolink_ai "$prompt" "Source format: $source_format
Target format: $target_format

Source diagram:
$content")

  local basename="${file%.*}"
  local outfile="${basename}.${ext}"
  printf '%s\n' "$result" > "$outfile"
  echo "Saved to: $outfile"
  echo ""
  echo "$result"
}

cmd_explain() {
  check_deps
  [ $# -ge 1 ] || err "Usage: bash diagram.sh explain <file>"

  local file="$1"
  local content
  content=$(read_file "$file")
  local format
  format=$(detect_format "$file")

  [ "$format" != "unknown" ] || err "Cannot detect diagram format for: $file"

  local prompt="You are a diagram analysis expert. Explain the following $format diagram in clear, plain language.

Rules:
- Describe what the diagram represents at a high level
- List the main components/entities and their relationships
- Note any important flows, dependencies, or patterns
- Keep the explanation concise but complete
- Use bullet points for clarity"

  echo "=== Diagram Explanation ==="
  echo "File: $file"
  echo "Format: $format"
  echo ""
  evolink_ai "$prompt" "Format: $format

Diagram:
$content"
}

cmd_preview() {
  [ $# -ge 1 ] || err "Usage: bash diagram.sh preview <file>"

  local file="$1"
  [ -f "$file" ] || err "File not found: $file"

  local format
  format=$(detect_format "$file")
  local content
  content=$(read_file "$file")

  case "$format" in
    mermaid)
      local html_file="${file%.mmd}.html"
      cat > "$html_file" <<HTMLEOF
<!DOCTYPE html>
<html><head><meta charset="utf-8"><title>Mermaid Preview</title>
<script src="https://cdn.jsdelivr.net/npm/mermaid/dist/mermaid.min.js"></script>
<style>body{font-family:sans-serif;display:flex;justify-content:center;padding:2rem;background:#f5f5f5}
.mermaid{background:#fff;padding:2rem;border-radius:8px;box-shadow:0 2px 8px rgba(0,0,0,.1)}</style>
</head><body>
<div class="mermaid">
$(cat "$file")
</div>
<script>mermaid.initialize({startOnLoad:true,theme:'default'});</script>
</body></html>
HTMLEOF
      echo "Preview saved to: $html_file"
      if command -v start &>/dev/null; then
        start "$html_file"
      elif command -v xdg-open &>/dev/null; then
        xdg-open "$html_file"
      elif command -v open &>/dev/null; then
        open "$html_file"
      else
        echo "Open $html_file in your browser to view the diagram."
      fi
      ;;
    drawio)
      echo "Open in draw.io: https://app.diagrams.net/"
      echo "Or open the file directly: $file"
      if command -v start &>/dev/null; then
        start "https://app.diagrams.net/"
      fi
      ;;
    plantuml)
      local encoded
      encoded=$(python3 -c "
import sys, zlib, base64
data = open(sys.argv[1], 'r').read().encode('utf-8')
compressed = zlib.compress(data)
b64 = base64.urlsafe_b64encode(compressed).decode()
print(b64)
" "$file")
      local url="https://www.plantuml.com/plantuml/uml/~1${encoded}"
      echo "PlantUML preview URL generated."
      echo "Note: This sends diagram code to plantuml.com for rendering."
      if command -v start &>/dev/null; then
        start "$url"
      elif command -v xdg-open &>/dev/null; then
        xdg-open "$url"
      elif command -v open &>/dev/null; then
        open "$url"
      else
        echo "Open this URL in your browser: $url"
      fi
      ;;
    graphviz)
      if command -v dot &>/dev/null; then
        local svg_file="${file%.*}.svg"
        dot -Tsvg "$file" -o "$svg_file"
        echo "Rendered to: $svg_file"
        if command -v start &>/dev/null; then
          start "$svg_file"
        elif command -v xdg-open &>/dev/null; then
          xdg-open "$svg_file"
        elif command -v open &>/dev/null; then
          open "$svg_file"
        fi
      else
        echo "Graphviz (dot) not installed. Install it or paste the content at:"
        echo "  https://dreampuf.github.io/GraphvizOnline/"
      fi
      ;;
    *)
      err "Cannot preview format: $format. Supported: mermaid, drawio, plantuml, graphviz"
      ;;
  esac
}

# --- Main ---
COMMAND="${1:-help}"
shift || true

case "$COMMAND" in
  templates)  cmd_templates ;;
  generate)   cmd_generate "$@" ;;
  edit)       cmd_edit "$@" ;;
  convert)    cmd_convert "$@" ;;
  explain)    cmd_explain "$@" ;;
  preview)    cmd_preview "$@" ;;
  help|*)
    echo "Diagram Generator — AI-powered diagram creation, editing, and conversion"
    echo ""
    echo "Usage: bash diagram.sh <command> [options]"
    echo ""
    echo "Local Commands (no API key needed):"
    echo "  templates                                List diagram types and format examples"
    echo "  preview <file>                           Open diagram in browser for visual preview"
    echo ""
    echo "AI Commands (requires EVOLINK_API_KEY):"
    echo "  generate <type> [--format <fmt>] \"desc\"  AI generate diagram from description"
    echo "  edit <file> \"instruction\"                AI modify existing diagram file"
    echo "  convert <file> --to <format>             AI convert between diagram formats"
    echo "  explain <file>                           AI explain diagram in plain language"
    echo ""
    echo "Diagram types: flowchart, sequence, class, er, state, mindmap,"
    echo "  architecture, network, gantt, pie, git, c4"
    echo ""
    echo "Output formats: mermaid (.mmd), drawio (.drawio), plantuml (.puml), graphviz (.dot)"
    echo ""
    echo "Get a free EvoLink API key: https://evolink.ai/signup"
    ;;
esac
