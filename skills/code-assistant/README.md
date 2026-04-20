# Code Assistant Skill for OpenClaw

> **Powered by [Evolink.ai](https://evolink.ai/signup?utm_source=github&utm_medium=readme&utm_campaign=code-assistant-skill-for-openclaw?utm_source=github&utm_medium=skill&utm_campaign=code-assistant)** — Generate, review, debug, and refactor code in any language with zero placeholders.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![OpenClaw](https://img.shields.io/badge/OpenClaw-Skill-blue)](https://clawhub.ai)

## TL;DR

A comprehensive code assistant that generates **working code** (not templates), reviews for security/performance issues, debugs errors with context, and refactors legacy codebases. Supports 6+ languages with automatic syntax verification.

## What It Does

- **Generate**: Create production-ready code from natural language prompts
- **Review**: Analyze code for security vulnerabilities, performance bottlenecks, and style issues
- **Debug**: Locate and fix bugs with contextual understanding
- **Refactor**: Modernize legacy code while preserving functionality

## Key Features

| Feature | Description |
|---------|-------------|
| 🚫 Zero Placeholders | Every line of generated code is executable — no `TODO` or `pass` statements |
| ✅ Physical Verification | Automatic syntax checking after generation (`python -m py_compile`, `node --check`, etc.) |
| 🌍 Multi-Language | Python, JavaScript/TypeScript, Go, Rust, Java, C/C++ |
| 🔍 Context-Aware | Reads existing project files to understand architecture before making changes |
| 🧪 Test Generation | Optionally generates unit tests for critical logic |
| 📦 CLI Tool | `evocode` command for pipeline integration |

## Setup

1. Get an API key at [evolink.ai/signup](https://evolink.ai/signup?utm_source=github&utm_medium=readme&utm_campaign=code-assistant-skill-for-openclaw?utm_source=github&utm_medium=skill&utm_campaign=code-assistant)
2. Set the environment variable:

```bash
export EVOLINK_API_KEY="your-key-here"
```

## Usage

### Via OpenClaw Chat

```
Generate a REST API with JWT authentication in Python

Review this file for security issues: src/auth.py

Debug the TypeError in line 42 of app.js

Refactor legacy.js to modern ES6+ syntax
```

### Via CLI

```bash
# Generate code
evocode generate "REST API with auth" --lang python --output api.py

# Review code
evocode review src/app.py --focus security

# Debug
evocode debug "TypeError in line 42" --file app.py

# Refactor
evocode refactor legacy.js --target "modern ES6+"
```

## How It Works

1. **Context First**: Reads your project structure and existing files
2. **Generate/Modify**: Creates or edits code based on your request
3. **Verify**: Runs syntax checks and optional tests
4. **Report**: Shows output and explains changes

## Configuration

| Variable | Default | Description |
|----------|---------|-------------|
| `EVOLINK_API_KEY` | (required) | Your Evolink API key |
| `EVOLINK_MODEL` | `[REDACTED]` | Model for code generation. Switch to any model supported by the [Evolink API](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=code-assistant) |

Optional: Create `.evocoderc.json` in your project root for custom settings:

```json
{
  "defaultLanguage": "python",
  "autoTest": true,
  "verifyOnGenerate": true
}
```

## Supported Languages

- **Python** (3.8+)
- **JavaScript/TypeScript** (Node.js 16+)
- **Go** (1.18+)
- **Rust** (1.70+)
- **Java** (11+)
- **C/C++** (GCC 9+)

## Examples

### Example 1: Generate a CLI Tool

**Prompt**: "Create a Python CLI tool that converts JSON to YAML"

**Output**: Fully functional script with argparse, error handling, and file I/O

### Example 2: Security Review

**Prompt**: "Review auth.py for SQL injection vulnerabilities"

**Output**: Detailed report with line numbers, severity levels, and fix suggestions

### Example 3: Debug with Context

**Prompt**: "Fix the 'list index out of range' error in data_processor.py"

**Output**: Root cause analysis + surgical fix with explanation

## Why This Skill?

- **No Guesswork**: Reads your actual codebase instead of making assumptions
- **Production-Ready**: Generated code includes error handling and edge cases
- **Language-Agnostic**: Works across your entire tech stack
- **Transparent**: Shows verification results and test output

## Security & Limits

- **File Access**: Reads files from workspace directory (`/root/.openclaw/workspace`) to understand project context
- **Data Transmission**: **Workspace files and code are sent to `api.evolink.ai` for processing.** Do not use with repositories containing secrets or confidential information unless you consent to external transmission.
- **Code Execution**: Automatically runs syntax checks and optionally executes tests. **User code will be executed** during verification.
- **File Size Limits**: 
  - Text/Code: 5MB
  - Binary files: Not supported for security reasons
- **Network Access**: Sends generated code and analysis to `api.evolink.ai` for processing. Requires `EVOLINK_API_KEY`.

## Links

- [Source Code](https://github.com/EvoLinkAI/code-assistant-skill-for-openclaw) — GitHub
- [API Reference](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=github&utm_medium=skill&utm_campaign=code-assistant)
- [Community](https://discord.com/invite/5mGHfA24kn)
- [Support](mailto:support@evolink.ai)
- [Get API Key](https://evolink.ai/signup?utm_source=github&utm_medium=readme&utm_campaign=code-assistant-skill-for-openclaw?utm_source=github&utm_medium=skill&utm_campaign=code-assistant) — Free signup

## License

MIT

Powered by [Evolink.ai](https://evolink.ai?utm_source=github&utm_medium=skill&utm_campaign=code-assistant)
