#!/usr/bin/env bash
set -euo pipefail

# SEO Assistant — AI-powered SEO analysis and optimization
# Usage: bash seo.sh <command> [options]
#
# Commands:
#   audit <file|dir>                       — Local HTML SEO audit
#   check <url>                            — Fetch + AI analyze a live URL
#   rewrite <file>                         — AI rewrite title/meta/description
#   keywords <topic>                       — AI keyword research
#   schema <file> --type <type>            — AI generate schema markup
#   sitemap <dir> --base <url>             — Generate XML sitemap

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

# --- Local HTML audit (no API needed) ---

local_audit() {
  local target="$1"

  python3 -c "
import sys, os, re
from html.parser import HTMLParser

class SEOParser(HTMLParser):
    def __init__(self):
        super().__init__()
        self.title = ''
        self.meta_desc = ''
        self.h1s = []
        self.h2s = []
        self.imgs_no_alt = 0
        self.imgs_total = 0
        self.has_lang = False
        self.has_viewport = False
        self.has_charset = False
        self.has_canonical = False
        self.og_tags = []
        self.twitter_tags = []
        self.links_count = 0
        self._tag = None

    def handle_starttag(self, tag, attrs):
        d = dict(attrs)
        if tag == 'html' and 'lang' in d:
            self.has_lang = True
        if tag == 'title':
            self._tag = 'title'
        if tag in ('h1','h2'):
            self._tag = tag
        if tag == 'meta':
            name = d.get('name','').lower()
            prop = d.get('property','').lower()
            content = d.get('content','')
            if name == 'description': self.meta_desc = content
            if name == 'viewport': self.has_viewport = True
            if d.get('charset'): self.has_charset = True
            if prop.startswith('og:'): self.og_tags.append(prop)
            if name.startswith('twitter:'): self.twitter_tags.append(name)
        if tag == 'link' and d.get('rel','') == 'canonical':
            self.has_canonical = True
        if tag == 'img':
            self.imgs_total += 1
            if not d.get('alt','').strip(): self.imgs_no_alt += 1
        if tag == 'a': self.links_count += 1

    def handle_data(self, data):
        if self._tag == 'title': self.title += data
        elif self._tag == 'h1': self.h1s.append(data.strip())
        elif self._tag == 'h2': self.h2s.append(data.strip())

    def handle_endtag(self, tag):
        if tag in ('title','h1','h2'): self._tag = None

def audit_file(path):
    with open(path, 'r', encoding='utf-8', errors='replace') as f:
        html = f.read()
    p = SEOParser()
    p.feed(html)

    issues = []
    warnings = []
    good = []

    # Title
    if not p.title.strip():
        issues.append('Missing <title> tag')
    elif len(p.title.strip()) < 30:
        warnings.append(f'Title too short ({len(p.title.strip())} chars, aim for 50-60)')
    elif len(p.title.strip()) > 60:
        warnings.append(f'Title too long ({len(p.title.strip())} chars, aim for 50-60)')
    else:
        good.append(f'Title OK ({len(p.title.strip())} chars): {p.title.strip()[:60]}')

    # Meta description
    if not p.meta_desc:
        issues.append('Missing meta description')
    elif len(p.meta_desc) < 120:
        warnings.append(f'Meta description short ({len(p.meta_desc)} chars, aim for 150-160)')
    elif len(p.meta_desc) > 160:
        warnings.append(f'Meta description long ({len(p.meta_desc)} chars, aim for 150-160)')
    else:
        good.append(f'Meta description OK ({len(p.meta_desc)} chars)')

    # H1
    if not p.h1s:
        issues.append('Missing H1 heading')
    elif len(p.h1s) > 1:
        warnings.append(f'Multiple H1 tags ({len(p.h1s)}), use only one')
    else:
        good.append(f'H1 OK: {p.h1s[0][:50]}')

    # Images
    if p.imgs_no_alt > 0:
        issues.append(f'{p.imgs_no_alt}/{p.imgs_total} images missing alt text')
    elif p.imgs_total > 0:
        good.append(f'All {p.imgs_total} images have alt text')

    # Technical
    if not p.has_lang: issues.append('Missing lang attribute on <html>')
    else: good.append('HTML lang attribute present')
    if not p.has_viewport: warnings.append('Missing viewport meta tag')
    else: good.append('Viewport meta tag present')
    if not p.has_charset: warnings.append('Missing charset meta tag')
    if not p.has_canonical: warnings.append('Missing canonical URL')
    if not p.og_tags: warnings.append('Missing Open Graph tags')
    else: good.append(f'Open Graph tags: {len(p.og_tags)}')
    if not p.twitter_tags: warnings.append('Missing Twitter Card tags')

    # Content
    text = re.sub(r'<[^>]+>', '', html)
    word_count = len(text.split())
    if word_count < 300:
        warnings.append(f'Low content ({word_count} words, aim for 300+)')
    else:
        good.append(f'Content length OK ({word_count} words)')

    return issues, warnings, good

def scan(target):
    files = []
    if os.path.isfile(target):
        files = [target]
    elif os.path.isdir(target):
        for root, dirs, fnames in os.walk(target):
            dirs[:] = [d for d in dirs if not d.startswith('.') and d not in ('node_modules','vendor')]
            for f in fnames:
                if f.endswith(('.html','.htm')):
                    files.append(os.path.join(root, f))
    if not files:
        print(f'No HTML files found in {target}')
        sys.exit(1)
    return files

target = sys.argv[1]
files = scan(target)
total_issues = 0
total_warnings = 0

for f in files:
    issues, warnings, good = audit_file(f)
    total_issues += len(issues)
    total_warnings += len(warnings)
    print(f'=== {f} ===')
    for i in issues: print(f'  [ISSUE] {i}')
    for w in warnings: print(f'  [WARN]  {w}')
    for g in good: print(f'  [OK]    {g}')
    print()

score = max(0, 100 - total_issues * 10 - total_warnings * 3)
print(f'SEO Score: {score}/100  ({total_issues} issues, {total_warnings} warnings, {len(files)} files)')
" "$target"
}

# --- Commands ---

cmd_audit() {
  local target="${1:?Usage: seo.sh audit <html-file-or-directory>}"
  echo "Running local SEO audit..." >&2
  local_audit "$target"
}

cmd_check() {
  local url="${1:?Usage: seo.sh check <url>}"
  check_deps

  echo "Fetching $url ..." >&2
  local html
  html=$(curl -sL -A "Mozilla/5.0 (compatible; SEOBot/1.0)" --max-time 15 "$url" | head -c 15000)

  [ -z "$html" ] && err "Failed to fetch URL or empty response."

  echo "Analyzing..." >&2
  evolink_ai "You are a senior SEO consultant. Analyze this HTML page and provide a comprehensive SEO audit:

1. **SEO Score** — Rate 0-100 with brief justification.
2. **Critical Issues** — Must-fix problems (missing title, meta, H1, alt text, lang, etc).
3. **Warnings** — Should-fix items (title length, description length, OG tags, schema, canonical).
4. **Content Analysis** — Keyword density, readability, content length assessment.
5. **Technical SEO** — Mobile-friendliness, structured data, canonical, robots directives.
6. **Recommendations** — Top 5 prioritized actions to improve rankings.

Be specific — reference actual content from the page. Show exact HTML fixes where applicable." "URL: $url

HTML SOURCE:
$html"
}

cmd_rewrite() {
  local file="${1:?Usage: seo.sh rewrite <html-file>}"
  check_deps

  echo "Reading HTML..." >&2
  local content
  content=$(read_file "$file")
  local truncated
  truncated=$(echo "$content" | head -c 12000)

  echo "Generating optimized SEO tags..." >&2
  evolink_ai "You are a senior SEO copywriter. Analyze this HTML page and rewrite its SEO elements for maximum search visibility:

1. **Title Tag** — Optimized title (50-60 chars). Show before/after.
2. **Meta Description** — Compelling description (150-160 chars) with CTA. Show before/after.
3. **H1 Tag** — Optimized H1 if needed. Show before/after.
4. **Open Graph Tags** — Complete og:title, og:description, og:type, og:image tags.
5. **Twitter Card Tags** — Complete twitter:card, twitter:title, twitter:description tags.
6. **Suggested Keywords** — 5-10 target keywords based on page content.

For each rewrite, show the exact HTML to copy-paste. Explain why each change improves SEO." "HTML SOURCE:
$truncated"
}

cmd_keywords() {
  local topic="$*"
  [ -z "$topic" ] && err "Usage: seo.sh keywords <topic>"
  check_deps

  echo "Researching keywords..." >&2
  evolink_ai "You are a senior SEO strategist. Perform keyword research for the given topic:

1. **Primary Keywords** (5-8) — High-volume, directly relevant terms.
2. **Long-tail Keywords** (10-15) — Lower competition, specific phrases.
3. **LSI Keywords** (8-10) — Semantically related terms for content depth.
4. **Question Keywords** (5-8) — Questions people ask (for FAQ/featured snippets).
5. **Content Strategy** — Suggest 3-5 article titles targeting these keywords.
6. **Keyword Grouping** — Group keywords by search intent (informational, transactional, navigational).

For each keyword, estimate:
- Search intent (informational / transactional / navigational)
- Competition level (low / medium / high)
- Priority (must-target / should-target / nice-to-have)" "TOPIC: $topic"
}

cmd_schema() {
  local file=""
  local schema_type="Article"

  while [[ $# -gt 0 ]]; do
    case "$1" in
      --type) schema_type="${2:?Missing schema type}"; shift 2 ;;
      -*) err "Unknown option: $1" ;;
      *) file="$1"; shift ;;
    esac
  done

  [ -z "$file" ] && err "Usage: seo.sh schema <html-file> --type <Article|Product|FAQ|HowTo|LocalBusiness|Event>"
  check_deps

  echo "Reading HTML..." >&2
  local content
  content=$(read_file "$file")
  local truncated
  truncated=$(echo "$content" | head -c 12000)

  echo "Generating schema markup..." >&2
  evolink_ai "You are a structured data expert. Generate JSON-LD schema markup for this HTML page.

Schema type requested: $schema_type

Rules:
- Output valid JSON-LD wrapped in <script type=\"application/ld+json\"> tags.
- Extract real data from the page content (titles, descriptions, dates, authors, etc).
- Follow schema.org specifications exactly.
- Include all recommended properties for the $schema_type type.
- If the page content doesn't match the requested type well, suggest a better type.
- Show where to insert the script tag in the HTML.

Common types and their key properties:
- Article: headline, author, datePublished, image, publisher
- Product: name, description, price, availability, review
- FAQ: mainEntity with Question/Answer pairs
- HowTo: name, step, totalTime, tool, supply
- LocalBusiness: name, address, telephone, openingHours
- Event: name, startDate, location, performer" "HTML SOURCE:
$truncated"
}

cmd_sitemap() {
  local dir=""
  local base_url=""

  while [[ $# -gt 0 ]]; do
    case "$1" in
      --base) base_url="${2:?Missing base URL}"; shift 2 ;;
      -*) err "Unknown option: $1" ;;
      *) dir="$1"; shift ;;
    esac
  done

  [ -z "$dir" ] && err "Usage: seo.sh sitemap <directory> --base <https://example.com>"
  [ -z "$base_url" ] && err "Missing --base. Provide your site URL (e.g., --base https://example.com)"

  echo "Generating sitemap..." >&2

  python3 -c "
import os, sys
from datetime import datetime
from xml.dom.minidom import getDOMImplementation

directory = sys.argv[1]
base_url = sys.argv[2].rstrip('/')

impl = getDOMImplementation()
doc = impl.createDocument('http://www.sitemaps.org/schemas/sitemap/0.9', 'urlset', None)
root = doc.documentElement
root.setAttribute('xmlns', 'http://www.sitemaps.org/schemas/sitemap/0.9')

count = 0
for dirpath, dirs, files in os.walk(directory):
    dirs[:] = [d for d in dirs if not d.startswith('.') and d not in ('node_modules','vendor','__pycache__')]
    for f in sorted(files):
        if not f.endswith(('.html','.htm')): continue
        fpath = os.path.join(dirpath, f)
        rel = os.path.relpath(fpath, directory).replace(os.sep, '/')
        if f.lower() in ('index.html','index.htm'):
            parent = os.path.dirname(rel)
            url_path = '' if parent == '.' else parent
        else:
            url_path = rel.rsplit('.', 1)[0]
        full_url = f'{base_url}/{url_path}'.rstrip('/')
        if not full_url.endswith(base_url.split('/')[-1]):
            full_url = full_url if url_path else base_url + '/'

        mtime = datetime.fromtimestamp(os.path.getmtime(fpath)).strftime('%Y-%m-%d')

        url_el = doc.createElement('url')
        loc = doc.createElement('loc')
        loc.appendChild(doc.createTextNode(full_url))
        url_el.appendChild(loc)
        lm = doc.createElement('lastmod')
        lm.appendChild(doc.createTextNode(mtime))
        url_el.appendChild(lm)
        root.appendChild(url_el)
        count += 1

if count == 0:
    print('No HTML files found in', directory, file=sys.stderr)
    sys.exit(1)

xml_str = doc.toprettyxml(indent='  ', encoding='UTF-8').decode('utf-8')
outfile = os.path.join(directory, 'sitemap.xml')
with open(outfile, 'w', encoding='utf-8') as out:
    out.write(xml_str)

print(f'Sitemap generated: {outfile}')
print(f'URLs included: {count}')
print()
print('Next steps:')
print(f'1. Upload {outfile} to your website root')
print(f'2. Add to robots.txt: Sitemap: {base_url}/sitemap.xml')
print(f'3. Submit to Google Search Console and Bing Webmaster Tools')
" "$dir" "$base_url"
}

# --- Main ---
COMMAND="${1:-help}"
shift || true

case "$COMMAND" in
  audit)      cmd_audit "$@" ;;
  check)      cmd_check "$@" ;;
  rewrite)    cmd_rewrite "$@" ;;
  keywords)   cmd_keywords "$@" ;;
  schema)     cmd_schema "$@" ;;
  sitemap)    cmd_sitemap "$@" ;;
  help|*)
    echo "SEO Assistant — AI-powered SEO analysis and optimization"
    echo ""
    echo "Usage: bash seo.sh <command> [options]"
    echo ""
    echo "Local Commands (no API key needed):"
    echo "  audit <file|dir>                       Local HTML SEO audit with scoring"
    echo "  sitemap <dir> --base <url>             Generate XML sitemap"
    echo ""
    echo "AI Commands (requires EVOLINK_API_KEY):"
    echo "  check <url>                            Fetch + AI deep SEO analysis"
    echo "  rewrite <file>                         AI rewrite title/meta/description/OG"
    echo "  keywords <topic>                       AI keyword research + content strategy"
    echo "  schema <file> --type <type>            AI generate JSON-LD schema markup"
    echo ""
    echo "Schema types: Article, Product, FAQ, HowTo, LocalBusiness, Event"
    echo ""
    echo "Get a free EvoLink API key: https://evolink.ai/signup"
    ;;
esac
