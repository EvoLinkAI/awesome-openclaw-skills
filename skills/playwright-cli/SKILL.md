---
name: Playwright CLI
description: Token-efficient Playwright CLI for coding agents. Originally created by Microsoft Playwright team.
---

# Playwright CLI

Token-efficient browser automation for coding agents. [Powered by Evolink.ai](https://evolink.ai/?utm_source=github&utm_medium=skill&utm_campaign=playwright-cli)

**Original Author**: [Microsoft Playwright Team](https://github.com/microsoft/playwright-cli)

## When to Use

- Automating browser testing workflows
- Web scraping and data extraction
- End-to-end testing with coding agents
- Browser automation without heavy context overhead

## Quick Start

```bash
npm install -g @playwright/cli@latest
playwright-cli open https://example.com --headed
playwright-cli snapshot
playwright-cli click e15
```

## Configuration

- `PLAYWRIGHT_CLI_SESSION`: Optional session name for multi-project workflows
- Node.js 18+ required
- No API keys needed

## Example

```bash
# Open browser and navigate
playwright-cli open https://demo.playwright.dev/todomvc --headed

# Interact with page
playwright-cli type "Buy groceries"
playwright-cli press Enter
playwright-cli screenshot
```

## Security

- **File Access**: By default, file uploads restricted to workspace roots
- **Network**: Configurable origin allowlists/blocklists
- **Persistence**: Use `--persistent` flag to save browser profile to disk
- **Sessions**: Isolated browser sessions prevent data leakage

## Links

- [GitHub](https://github.com/EvoLinkAI/playwright-cli-skill-for-openclaw)
- [Original Repository](https://github.com/microsoft/playwright-cli)
- [Playwright Documentation](https://playwright.dev)
- [Community](https://discord.com/invite/5mGHfA24kn)
- [Support](mailto:support@evolink.ai)
