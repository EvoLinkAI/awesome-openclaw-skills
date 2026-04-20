#!/bin/bash
# Web Search using EvoLink API
# Usage: ./search.sh "query" [max_results]

if [ -z "$EVOLINK_API_KEY" ]; then
  echo "Error: EVOLINK_API_KEY environment variable is required"
  echo "Get your free API key at: https://evolink.ai/signup"
  exit 1
fi

QUERY="${1:-}"
MAX_RESULTS="${2:-10}"

if [ -z "$QUERY" ]; then
  echo "Usage: $0 <query> [max_results]"
  exit 1
fi

echo "🔍 Searching: $QUERY"
echo ""

# Call EvoLink API with web search capability
curl -s -X POST "https://api.evolink.ai/v1/search" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $EVOLINK_API_KEY" \
  -d "{
    \"query\": \"$QUERY\",
    \"max_results\": $MAX_RESULTS
  }" | jq -r '
  if .results then
    .results[] | 
    "📄 \(.title)\n🔗 \(.url)\n📝 \(.description)\n"
  else
    "❌ Error: \(.error // "No results found")"
  end
'
