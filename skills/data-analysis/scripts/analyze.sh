#!/usr/bin/env bash
set -euo pipefail

# Data Analysis Script using EvoLink API
# Usage: analyze.sh <file_path> "<analysis_question>"

FILE_PATH="${1:-}"
QUESTION="${2:-}"
SAFE_DIR="${DATA_ANALYSIS_SAFE_DIR:-$HOME/.openclaw/workspace}"
MODEL="${EVOLINK_MODEL:-[REDACTED]}"
API_KEY="${EVOLINK_API_KEY:-}"

# Validate inputs
if [[ -z "$FILE_PATH" ]] || [[ -z "$QUESTION" ]]; then
    echo "Usage: $0 <file_path> \"<analysis_question>\""
    echo ""
    echo "Example:"
    echo "  $0 sales_data.csv \"What are the top 3 revenue drivers?\""
    exit 1
fi

if [[ -z "$API_KEY" ]]; then
    echo "Error: EVOLINK_API_KEY environment variable is required"
    echo "Get your free API key: https://evolink.ai/signup"
    exit 1
fi

# Security: Path validation
RESOLVED=$(realpath -e "$FILE_PATH" 2>/dev/null || echo "")
if [[ -z "$RESOLVED" ]]; then
    echo "Error: File not found: $FILE_PATH"
    exit 1
fi

# Security: Reject symlinks
if [[ -L "$FILE_PATH" ]]; then
    echo "Error: Symlinks are not allowed for security reasons"
    exit 1
fi

# Security: Directory constraint with trailing slash
SAFE_DIR="${SAFE_DIR%/}/"
if [[ "$RESOLVED" != "$SAFE_DIR"* ]]; then
    echo "Error: File must be within $SAFE_DIR"
    exit 1
fi

# Security: Filename blacklist (improved anchoring)
BASENAME=$(basename "$RESOLVED")
if [[ "$BASENAME" =~ ^\.env.*$ ]] || \
   [[ "$BASENAME" =~ \.key$ ]] || \
   [[ "$BASENAME" =~ \.pem$ ]] || \
   [[ "$BASENAME" =~ \.p12$ ]] || \
   [[ "$BASENAME" =~ \.pfx$ ]] || \
   [[ "$BASENAME" =~ ^id_rsa ]] || \
   [[ "$BASENAME" == "authorized_keys" ]] || \
   [[ "$BASENAME" == ".bash_history" ]] || \
   [[ "$BASENAME" == "config.json" ]] || \
   [[ "$BASENAME" == ".ssh" ]] || \
   [[ "$BASENAME" == "shadow" ]] || \
   [[ "$BASENAME" == "passwd" ]]; then
    echo "Error: This file type is not allowed for security reasons"
    exit 1
fi

# Security: File size limit (50MB for data files)
FILE_SIZE=$(stat -f%z "$RESOLVED" 2>/dev/null || stat -c%s "$RESOLVED" 2>/dev/null)
MAX_SIZE=$((50 * 1024 * 1024))
if [[ "$FILE_SIZE" -gt "$MAX_SIZE" ]]; then
    echo "Error: File size exceeds 50MB limit"
    exit 1
fi

# Security: MIME type validation (with fallback)
if command -v file >/dev/null 2>&1; then
    MIME_TYPE=$(file --mime-type -b "$RESOLVED")
    case "$MIME_TYPE" in
        text/csv|text/plain|application/json|application/vnd.ms-excel|application/vnd.openxmlformats-officedocument.spreadsheetml.sheet)
            # Allowed types
            ;;
        *)
            echo "Error: Unsupported file type: $MIME_TYPE"
            echo "Supported: CSV, JSON, Excel (.xlsx, .xls)"
            exit 1
            ;;
    esac
else
    # Fallback: Check file extension
    EXT="${BASENAME##*.}"
    EXT_LOWER=$(echo "$EXT" | tr '[:upper:]' '[:lower:]')
    case "$EXT_LOWER" in
        csv|json|xlsx|xls)
            # Allowed extensions
            ;;
        *)
            echo "Error: Unsupported file extension: .$EXT"
            echo "Supported: .csv, .json, .xlsx, .xls"
            exit 1
            ;;
    esac
fi

echo "📊 Analyzing: $FILE_PATH"
echo "❓ Question: $QUESTION"
echo ""

# Read file content
FILE_CONTENT=$(cat "$RESOLVED")

# Prepare prompt
SYSTEM_PROMPT="You are a data analyst. Analyze the provided data and answer the user's question.

Core Principles:
1. Decision-first: Focus on actionable insights
2. Statistical rigor: Check sample size, confidence, effect size
3. Clear output: Lead with insight, quantify uncertainty, state limitations

Output Format:
- Key findings (numbered list)
- Statistical confidence level
- Caveats and limitations
- Recommended next steps"

USER_PROMPT="Data file: $FILE_PATH

Data content:
\`\`\`
$FILE_CONTENT
\`\`\`

Question: $QUESTION

Please analyze this data and provide insights following the decision-first methodology."

# Escape JSON
escape_json() {
    python3 -c 'import json, sys; print(json.dumps(sys.stdin.read()))'
}

SYSTEM_JSON=$(echo "$SYSTEM_PROMPT" | escape_json)
USER_JSON=$(echo "$USER_PROMPT" | escape_json)

# Call EvoLink API
RESPONSE=$(curl -s -X POST "https://api.evolink.ai/v1/messages" \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer $API_KEY" \
    -d "{
        \"model\": \"$MODEL\",
        \"max_tokens\": 4096,
        \"system\": $SYSTEM_JSON,
        \"messages\": [
            {
                \"role\": \"user\",
                \"content\": $USER_JSON
            }
        ]
    }")

# Check for API errors
if echo "$RESPONSE" | jq -e '.error' > /dev/null 2>&1; then
    echo "❌ API Error:"
    echo "$RESPONSE" | jq -r '.error.message // .error'
    exit 1
fi

# Extract and display result
echo "🔍 Analysis Results:"
echo ""
echo "$RESPONSE" | jq -r '.content[0].text // "No response from API"'
