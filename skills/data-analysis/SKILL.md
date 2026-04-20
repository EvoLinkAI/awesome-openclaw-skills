🌐 English | [日本語](README.ja.md) | [한국어](README.ko.md) | [Français](README.fr.md) | [Deutsch](README.de.md) | [Русский](README.ru.md) | [हिन्दी](README.hi.md) | [Türkçe](README.tr.md) 

---
name: data-analysis
description: AI-powered data analysis using EvoLink API. Decision-first methodology with statistical rigor. Powered by evolink.ai
---

# Data Analysis Assistant

AI-powered data analysis with decision-first methodology and statistical rigor.

Powered by [Evolink.ai](https://evolink.ai?utm_source=clawhub&utm_medium=skill&utm_campaign=data-analysis)

## When to Use

Use this skill when the user needs to:
- Analyze data from CSV, Excel, JSON files
- Find patterns, trends, or anomalies
- Understand metrics and KPIs
- Test hypotheses or A/B tests
- Perform cohort or funnel analysis
- Debug data quality issues
- Generate insights for decision-making

**Core Principle**: Analysis without a decision is just arithmetic. Always clarify what would change if the analysis shows X vs Y.

## Usage

```bash
{baseDir}/scripts/analyze.sh <file_path> "<analysis_question>"
```

## Configuration

| Variable | Default | Required | Description |
|---|---|---|---|
| `EVOLINK_API_KEY` | - | Yes | Your EvoLink API key |
| `EVOLINK_MODEL` | `claude-opus-4-6` | No | Model for analysis. Switch to any model supported by the [Evolink API](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=clawhub&utm_medium=skill&utm_campaign=data-analysis) |
| `DATA_ANALYSIS_SAFE_DIR` | `$HOME/.openclaw/workspace` | No | Allowed directory for local file access |

👉 [Get free API key](https://evolink.ai/signup?utm_source=clawhub&utm_medium=skill&utm_campaign=data-analysis)

## Example

```bash
bash scripts/analyze.sh sales_data.csv "What are the top 3 revenue drivers this quarter?"
```

Output:
```
📊 Analyzing: sales_data.csv
❓ Question: What are the top 3 revenue drivers this quarter?

🔍 Analysis Results:

1. **Product Category A** - $2.4M (40% of total)
   - 15% growth vs last quarter
   - Driven by enterprise segment

2. **Geographic Expansion** - $1.8M (30% of total)
   - New markets in APAC region
   - 3x growth vs last quarter

3. **Upsell to Existing Customers** - $1.2M (20% of total)
   - 25% conversion rate on upgrade offers
   - Average deal size: $50K

📈 Confidence: High (n=1,247 transactions)
⚠️  Caveats: Q4 includes holiday seasonality
💡 Recommendation: Double down on APAC expansion and enterprise upsells
```

## Methodology

### 1. Decision First
- Identify the decision owner and question
- Clarify what would change based on results
- Set deadline before computing

### 2. Statistical Rigor
- Check sample size sufficiency
- Ensure fair comparison groups
- Account for multiple comparisons
- Quantify uncertainty (confidence intervals)
- Verify effect size is meaningful

### 3. Output Standards
- Lead with insight, not methodology
- Quantify uncertainty (ranges, not point estimates)
- State limitations clearly
- Recommend next steps

## Security

**⚠️ Data Transmission Warning**

This skill reads the **entire content** of your data file and sends it to `api.evolink.ai` for analysis. **Do not use this skill on files containing:**
- API keys, tokens, or credentials
- Personally Identifiable Information (PII)
- Confidential business data
- Any sensitive information you don't want transmitted to an external service

The script implements security checks (directory constraints, symlink rejection, filename blacklist, size/MIME validation), but **cannot guarantee** that arbitrary data files are free of secrets.

**Credentials & Network**

Requires `EVOLINK_API_KEY` to call EvoLink API. Your data file content and analysis question are sent to `api.evolink.ai` for processing. EvoLink processes the data and returns analysis results. No data is stored after processing.

**File Access**

This skill reads the specified data file (CSV, Excel, JSON) from your local filesystem. Files must be within `DATA_ANALYSIS_SAFE_DIR` (default: `$HOME/.openclaw/workspace`). 

Security validations:
- Path resolution via `realpath -e` (requires file to exist, resolves symlinks)
- Symlink inputs are explicitly rejected
- Directory constraint with trailing-slash comparison
- Filename blacklist: `.env*`, `*.key`, `*.pem`, `*.p12`, `*.pfx`, `id_rsa*`, `authorized_keys`, `config.json`, `.bash_history`, `.ssh`, `shadow`, `passwd`
- File size limit: 50MB maximum
- MIME validation: Only `text/csv`, `text/plain`, `application/json`, `application/vnd.ms-excel`, `application/vnd.openxmlformats-officedocument.spreadsheetml.sheet` accepted

**Network Access**

- **EvoLink API** (`api.evolink.ai`) - Sends data and receives analysis

All network calls use curl and can be audited in the script source.

**Persistence & Privilege**

This skill does not modify other skills or system settings. Does not request elevated or persistent permissions.

## Links

- [GitHub](https://github.com/EvoLinkAI/data-analysis-skill-for-openclaw)
- [API Reference](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=clawhub&utm_medium=skill&utm_campaign=data-analysis)
- [Community](https://discord.com/invite/5mGHfA24kn)
- [Support](mailto:support@evolink.ai)
