#!/usr/bin/env bash
set -euo pipefail

# Email Assistant — AI-powered email writing, review, and compliance checking
# Usage: bash email.sh <command> [options]
#
# Commands:
#   templates                              — List available email template types
#   dns                                    — SPF/DKIM/DMARC configuration guide
#   generate <type> [--tone <tone>]        — AI generate email template
#   review <file>                          — AI review for spam triggers & best practices
#   subject <file>                         — AI generate subject line variants
#   compliance <file>                      — AI check CAN-SPAM/GDPR/CASL compliance
#   translate <file> --lang <language>     — AI translate email content

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
  response=$(curl -sS "$EVOLINK_API" \
    -H "Content-Type: application/json" \
    -H "x-api-key: $api_key" \
    -H "anthropic-version: 2023-06-01" \
    -d @"$tmp_payload" 2>&1)

  python3 -c "
import json, sys
try:
    data = json.loads(sys.argv[1])
    if 'content' in data and len(data['content']) > 0:
        print(data['content'][0].get('text', ''))
    elif 'error' in data:
        print('API Error: ' + data['error'].get('message', str(data['error'])), file=sys.stderr)
        sys.exit(1)
    else:
        print('Unexpected response format', file=sys.stderr)
        sys.exit(1)
except json.JSONDecodeError:
    print('Failed to parse API response', file=sys.stderr)
    sys.exit(1)
" "$response"
}

# --- Local Commands ---

cmd_templates() {
  cat <<'EOF'
Email Template Types
====================

Transactional:
  welcome             New user onboarding / welcome email
  password-reset      Password reset with secure link
  verification        Email address verification / double opt-in
  order-confirmation  E-commerce order receipt
  shipping            Shipping notification with tracking
  invoice             Payment invoice / billing receipt
  security-alert      Account security notification (login, 2FA, etc.)

Marketing:
  newsletter          Newsletter / content digest
  promotion           Promotional offer / sale announcement
  reengagement        Win-back inactive users

Usage:
  bash email.sh generate <type> [--tone <tone>]

Tones: professional, casual, friendly, urgent, minimal
EOF
}

cmd_dns() {
  cat <<'EOF'
SPF / DKIM / DMARC Configuration Guide
=======================================

1. SPF (Sender Policy Framework)
---------------------------------
Add a TXT record to your domain DNS:

  Name:  @
  Type:  TXT
  Value: v=spf1 include:_spf.google.com include:amazonses.com ~all

Replace the include: entries with your email provider's SPF domain.
Use ~all (softfail) during testing, -all (hardfail) in production.

2. DKIM (DomainKeys Identified Mail)
-------------------------------------
Your email provider generates a public/private key pair.
Add the public key as a TXT record:

  Name:  selector._domainkey
  Type:  TXT
  Value: v=DKIM1; k=rsa; p=MIGfMA0GCSqGSIb3DQEBAQUAA4...

The selector and key are provided by your email service.

3. DMARC (Domain-based Message Authentication)
-----------------------------------------------
Add a TXT record:

  Name:  _dmarc
  Type:  TXT
  Value: v=DMARC1; p=none; rua=mailto:dmarc@yourdomain.com; pct=100

Policy options:
  p=none       Monitor only (start here)
  p=quarantine Send failures to spam
  p=reject     Block failures entirely

Recommended rollout:
  Week 1-2: p=none (collect reports)
  Week 3-4: p=quarantine; pct=10 (quarantine 10%)
  Month 2+: p=reject (full enforcement)

4. Verification
----------------
Test your setup:
  - https://mxtoolbox.com/spf.aspx
  - https://mail-tester.com
  - Send a test email to mail-tester.com's address

5. BIMI (Brand Indicators for Message Identification)
------------------------------------------------------
Optional: display your logo in supported email clients.
Requires DMARC p=quarantine or p=reject.

  Name:  default._bimi
  Type:  TXT
  Value: v=BIMI1; l=https://yourdomain.com/logo.svg
EOF
}

# --- AI Commands ---

cmd_generate() {
  local type="${1:-}"
  [ -n "$type" ] || err "Usage: bash email.sh generate <type> [--tone <tone>]"
  shift

  local tone="professional"
  while [[ $# -gt 0 ]]; do
    case "$1" in
      --tone) tone="${2:-professional}"; shift 2 ;;
      *) shift ;;
    esac
  done

  check_deps
  echo "Generating $type email template (tone: $tone)..." >&2

  local prompt="You are an expert email copywriter and developer. Generate a complete, production-ready email template.

Template type: $type
Tone: $tone

Requirements:
1. Output a complete HTML email with inline CSS (email-client compatible)
2. Use a clean, responsive single-column layout that works in all major email clients
3. Include proper email structure: preheader text, header, body, footer
4. Footer must include: unsubscribe link placeholder, physical address placeholder, company name placeholder
5. Use table-based layout for maximum email client compatibility
6. Include <!-- CUSTOMIZE: ... --> comments where the user should edit content
7. Use placeholder text that clearly shows what to replace: [Company Name], [User Name], etc.
8. Keep the design modern but safe (no CSS grid, no flexbox, no media queries in body)

For the specific template type '$type', include the appropriate content sections and CTAs.

Output ONLY the HTML code, no explanations before or after."

  evolink_ai "$prompt" "Generate a $type email template with $tone tone."
}

cmd_review() {
  local file="${1:-}"
  [ -n "$file" ] || err "Usage: bash email.sh review <file>"

  check_deps
  local content
  content=$(read_file "$file")

  # Truncate to 12000 chars
  content="${content:0:12000}"

  echo "Reviewing email content..." >&2

  local prompt="You are an email deliverability expert. Review this email content and provide a detailed analysis.

Analyze the following aspects:

1. **Spam Score** (0-10): Rate the likelihood of triggering spam filters
   - Check for spam trigger words (FREE, URGENT, ACT NOW, etc.)
   - Check image-to-text ratio concerns
   - Check for excessive capitalization or punctuation

2. **Issues Found**: List each issue with a tag:
   - [SPAM] — Likely spam trigger
   - [WARN] — Best practice violation
   - [OK] — Passing check
   Check for: spam words, unsubscribe link, physical address, plain-text alternative, subject line issues, sender name, preheader text, broken HTML

3. **Readability**: Estimate reading grade level (Flesch-Kincaid or similar)

4. **Deliverability Estimate**: Low / Medium / High based on overall analysis

5. **Recommendations**: Top 3 actionable improvements

Format the output clearly with sections and bullet points. Be specific — quote the problematic text when flagging issues."

  evolink_ai "$prompt" "$content"
}

cmd_subject() {
  local file="${1:-}"
  [ -n "$file" ] || err "Usage: bash email.sh subject <file>"

  check_deps
  local content
  content=$(read_file "$file")
  content="${content:0:12000}"

  echo "Generating subject line variants..." >&2

  local prompt="You are an email marketing expert specializing in subject line optimization.

Based on the email content below, generate exactly 5 subject line variants optimized for open rates.

For each variant, provide:
1. The subject line (max 60 characters)
2. A matching preheader text (max 100 characters)
3. The strategy used (curiosity, urgency, personalization, benefit-driven, question)
4. Estimated open rate impact (relative: higher/baseline/lower)

Then provide:
- **A/B Test Recommendation**: Which 2 variants to test against each other and why
- **Best for Mobile**: Which variant works best on mobile (shorter display)
- **Avoid**: Any subject line patterns to avoid for this type of email

Format clearly with numbered variants."

  evolink_ai "$prompt" "$content"
}

cmd_compliance() {
  local file="${1:-}"
  [ -n "$file" ] || err "Usage: bash email.sh compliance <file>"

  check_deps
  local content
  content=$(read_file "$file")
  content="${content:0:12000}"

  echo "Checking compliance..." >&2

  local prompt="You are a legal compliance expert specializing in email marketing regulations. Audit this email against all major email compliance frameworks.

Check against these regulations:

**CAN-SPAM (United States)**
- [ ] Accurate From/Reply-To header
- [ ] Non-deceptive subject line
- [ ] Identified as advertisement (if applicable)
- [ ] Physical postal address included
- [ ] Opt-out/unsubscribe mechanism present
- [ ] Opt-out honored within 10 business days

**GDPR (European Union)**
- [ ] Lawful basis for processing (consent or legitimate interest)
- [ ] Clear identification of sender
- [ ] Easy unsubscribe mechanism
- [ ] Privacy policy link
- [ ] Data processing transparency
- [ ] Right to erasure mentioned or accessible

**CASL (Canada)**
- [ ] Express or implied consent obtained
- [ ] Sender identification (name, address, contact)
- [ ] Unsubscribe mechanism (must work for 60 days)
- [ ] No misleading subject lines or sender info

For each regulation:
1. Mark each requirement as PASS / FAIL / NEEDS REVIEW
2. Quote the relevant part of the email (or note its absence)
3. Provide specific fix instructions for any FAIL items

End with an overall compliance rating: Compliant / Partially Compliant / Non-Compliant for each regulation."

  evolink_ai "$prompt" "$content"
}

cmd_translate() {
  local file="${1:-}"
  [ -n "$file" ] || err "Usage: bash email.sh translate <file> --lang <language>"
  shift

  local lang=""
  while [[ $# -gt 0 ]]; do
    case "$1" in
      --lang) lang="${2:-}"; shift 2 ;;
      *) shift ;;
    esac
  done

  [ -n "$lang" ] || err "Usage: bash email.sh translate <file> --lang <language>"

  check_deps
  local content
  content=$(read_file "$file")
  content="${content:0:12000}"

  echo "Translating to $lang..." >&2

  local prompt="You are a professional email translator and localization expert.

Translate the email content below into $lang.

Requirements:
1. Translate ALL text content (subject line, preheader, body, footer, CTA buttons)
2. Keep HTML structure and tags intact — only translate the text between tags
3. Adapt cultural references and idioms naturally (localization, not just translation)
4. Keep placeholder tokens unchanged: [Company Name], [User Name], {{variables}}, etc.
5. Maintain the same tone and formality level as the original
6. If the email contains legal text (unsubscribe, privacy), translate it but add a comment: <!-- LEGAL: Have this reviewed by local counsel -->
7. Preserve all links, images, and HTML attributes unchanged

Output the complete translated email. If the input is HTML, output HTML. If plain text, output plain text."

  evolink_ai "$prompt" "$content"
}

# --- Main ---
COMMAND="${1:-help}"
shift || true

case "$COMMAND" in
  templates)   cmd_templates ;;
  dns)         cmd_dns ;;
  generate)    cmd_generate "$@" ;;
  review)      cmd_review "$@" ;;
  subject)     cmd_subject "$@" ;;
  compliance)  cmd_compliance "$@" ;;
  translate)   cmd_translate "$@" ;;
  help|*)
    echo "Email Assistant — AI-powered email writing, review, and compliance"
    echo ""
    echo "Usage: bash email.sh <command> [options]"
    echo ""
    echo "Local Commands (no API key needed):"
    echo "  templates                              List available email template types"
    echo "  dns                                    SPF/DKIM/DMARC configuration guide"
    echo ""
    echo "AI Commands (requires EVOLINK_API_KEY):"
    echo "  generate <type> [--tone <tone>]        AI generate email template"
    echo "  review <file>                          AI review for spam triggers & best practices"
    echo "  subject <file>                         AI generate subject line variants"
    echo "  compliance <file>                      AI check CAN-SPAM/GDPR/CASL compliance"
    echo "  translate <file> --lang <language>     AI translate email content"
    echo ""
    echo "Template types: welcome, password-reset, verification, order-confirmation,"
    echo "  shipping, invoice, newsletter, promotion, reengagement, security-alert"
    echo ""
    echo "Tones: professional, casual, friendly, urgent, minimal"
    echo ""
    echo "Get a free EvoLink API key: https://evolink.ai/signup"
    ;;
esac
