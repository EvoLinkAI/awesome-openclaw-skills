#!/bin/bash
# Audio Transcription transcriber
# usage: ./transcribe.sh <file> [--diarize] [--lang <code>]

set -euo pipefail

FILE=$1
shift
DIARIZATION=false
LANG="en"

while [[ "$#" -gt 0 ]]; do
  case $1 in
    --diarize) DIARIZATION=true ;;
    --lang) LANG="$2"; shift ;;
    *) echo "Unknown parameter: $1"; exit 1 ;;
  esac
  shift
done

if [ ! -f "$FILE" ]; then
  echo "Error: File $FILE not found."
  exit 1
fi

if [ -z "$EVOLINK_API_KEY" ]; then
  echo "Error: EVOLINK_API_KEY not set."
  exit 1
fi

python3 -c "
import base64, json, sys, requests
with open('$FILE', 'rb') as f:
    audio_base64 = base64.b64encode(f.read()).decode('utf-8')
headers = {'Authorization': 'Bearer $EVOLINK_API_KEY', 'Content-Type': 'application/json'}
payload = {
    'model': '${EVOLINK_MODEL:-gemini-3.1-pro-preview-customtools}',
    'messages': [{
        'role': 'user',
        'content': [
            {'type': 'text', 'text': '请转录这段音频 (Diarization: $DIARIZATION, Lang: $LANG)'},
            {'type': 'input_audio', 'input_audio': {'data': audio_base64, 'format': 'mp3'}}
        ]
    }]
}
response = requests.post('https://api.evolink.ai/v1/chat/completions', json=payload, headers=headers)
print(response.json()['choices'][0]['message']['content'])
"
