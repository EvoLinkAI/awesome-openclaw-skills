#!/usr/bin/env bash
set -euo pipefail

# Humanize Text — Remove AI writing patterns via Evolink API
# Usage: bash humanize.sh <file-or-text> [tone-hint]
#   tone-hint: blog, academic, email, casual (default: auto-detect)

INPUT="${1:?Usage: humanize.sh <file-or-text> [tone-hint]}"
TONE="${2:-auto}"

API_KEY="${EVOLINK_API_KEY:?Set EVOLINK_API_KEY first. Get one at https://evolink.ai/signup}"
MODEL="${EVOLINK_MODEL:-claude-opus-4-6}"
API_URL="https://api.evolink.ai/v1/messages"

# --- Security: Path validation for local files ---
validate_file() {
    local filepath="$1"
    
    # 1. Resolve absolute path (realpath -e: file MUST exist, resolves all symlinks)
    local resolved
    resolved=$(realpath -e "$filepath" 2>/dev/null)
    if [ -z "$resolved" ]; then
        echo "Error: File not found or path contains broken symlinks: $filepath" >&2
        exit 1
    fi

    # 2. Reject symlinks pointing outside safe dir
    if [ -L "$filepath" ]; then
        echo "Error: Symlinks are not allowed for security. Use the actual file path." >&2
        exit 1
    fi

    # 3. Scope check with trailing slash to prevent prefix bypass
    #    e.g., /home/user/.openclaw/workspace_evil would NOT match /home/user/.openclaw/workspace/
    SAFE_DIR="${HUMANIZE_SAFE_DIR:-$HOME/.openclaw/workspace}"
    # Normalize: ensure SAFE_DIR ends with /
    SAFE_DIR="${SAFE_DIR%/}/"
    if [[ "$resolved" != "$SAFE_DIR"* ]]; then
        echo "Error: Access restricted to $SAFE_DIR" >&2
        exit 1
    fi

    # 4. Filename blacklist
    local basename
    basename=$(basename "$resolved")
    case "$basename" in
        .env*|*.key|id_rsa*|authorized_keys|.bash_history|config.json|.ssh|*.pem|*.p12|*.pfx|shadow|passwd)
            echo "Error: Access to sensitive files is blocked." >&2
            exit 1
            ;;
    esac

    # 5. File size check (5MB limit)
    local size
    size=$(stat -c%s "$resolved")
    if [ "$size" -gt 5242880 ]; then
        echo "Error: File exceeds 5MB limit." >&2
        exit 1
    fi

    # 6. MIME type validation
    if command -v file &>/dev/null; then
        local mime
        mime=$(file --mime-type -b "$resolved")
        if [[ ! "$mime" =~ ^(text/|application/json|inode/x-empty) ]]; then
            echo "Error: Unsupported file type ($mime). Only text files accepted." >&2
            exit 1
        fi
    fi

    echo "$resolved"
}

# --- Extract input content ---
get_content() {
    if [ "$INPUT" = "-" ]; then
        # Read from stdin
        cat
    elif [[ "$INPUT" == /* || "$INPUT" == ./* || "$INPUT" == ../* ]]; then
        # Looks like a file path — validate and read
        if [ ! -f "$INPUT" ]; then
            echo "Error: File not found: $INPUT" >&2
            exit 1
        fi
        local safe_path
        safe_path=$(validate_file "$INPUT")
        cat "$safe_path"
    elif [ -f "$INPUT" ]; then
        # Existing file with relative name
        local safe_path
        safe_path=$(validate_file "$INPUT")
        cat "$safe_path"
    else
        # Treat as raw text
        echo "$INPUT"
    fi
}

CONTENT=$(get_content)

if [ -z "$CONTENT" ]; then
    echo "Error: No content provided." >&2
    exit 1
fi

# Truncate if extremely long (keep first ~50K chars for API)
CONTENT=$(echo "$CONTENT" | head -c 50000)

# --- Build prompt ---
SYSTEM_PROMPT="You are a writing editor specialized in removing AI-generated text patterns. Make text sound natural and human.

CRITICAL RULES:
- NEVER fabricate information. Do not invent people, names, numbers, anecdotes, or details that are not in the original text.
- Preserve the original meaning exactly. The rewrite must say the same thing, just without AI patterns.
- If the original is vague, make it concise — but do not add fake specifics to 'make it more human'.

PATTERN RULES:
1. Scan for all 24 common AI writing patterns (significance inflation, promotional language, AI vocabulary like 'delve/tapestry/landscape/crucial/robust/seamless', filler phrases, chatbot artifacts, etc.)
2. Rewrite flagged sections with natural alternatives
3. Vary sentence length and structure
4. Use simple verbs ('is', 'has') instead of pretentious alternatives ('serves as', 'boasts')
5. Remove filler: 'Furthermore' → cut. 'In order to' → 'to'. 'It is worth noting' → just say it.
6. Replace vague attributions with specifics from the original, or remove them
7. No generic conclusions ('The future looks bright')
8. Auto-detect language (English, Chinese, Japanese, Korean, Russian, Hindi, German, French, Italian) and preserve it
9. Match tone to context: ${TONE}

Chinese-specific patterns to fix:
- 过度使用'此外'、'值得一提的是'、'综上所述'
- 假大空收尾：'未来可期'、'让我们拭目以待'
- 模糊归因：'业内人士表示'、'有专家指出'

Apply equivalent pattern detection for Japanese, Korean, Russian, Hindi, German, French, and Italian.
Each language has its own AI-typical filler phrases, empty emphasis words, and formulaic conclusions — detect and rewrite them.

OUTPUT FORMAT:
1. **Rewritten text** (the clean version — same meaning, no fabrication)
2. **Changes**: Brief list of what was fixed"

USER_MSG="Humanize this text:\n\n${CONTENT}"

# --- JSON escape ---
json_escape() {
    printf '%s' "$1" | python3 -c 'import json,sys; print(json.dumps(sys.stdin.read()))'
}

ESCAPED_SYSTEM=$(json_escape "$SYSTEM_PROMPT")
ESCAPED_USER=$(json_escape "$USER_MSG")

# --- Call Evolink API ---
RESPONSE=$(curl -s "$API_URL" \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer $API_KEY" \
    -d "{
        \"model\": \"$MODEL\",
        \"max_tokens\": 4096,
        \"system\": $ESCAPED_SYSTEM,
        \"messages\": [{\"role\": \"user\", \"content\": $ESCAPED_USER}]
    }")

# --- Extract and display result ---
echo "$RESPONSE" | python3 -c "
import json, sys
try:
    data = json.load(sys.stdin)
    if 'content' in data:
        for block in data['content']:
            if block.get('type') == 'text':
                print(block['text'])
    elif 'error' in data:
        print(f\"Error: {data['error'].get('message', 'Unknown error')}\", file=sys.stderr)
        sys.exit(1)
except Exception as e:
    print(f'Error parsing response: {e}', file=sys.stderr)
    sys.exit(1)
"
