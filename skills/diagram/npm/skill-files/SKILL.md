---
name: Diagram Generator
description: AI-powered diagram creation, editing, and format conversion. Generate flowcharts, sequence diagrams, ER diagrams, architecture diagrams and more in Mermaid, draw.io, PlantUML, and Graphviz formats. Powered by evolink.ai
version: 1.0.0
homepage: https://github.com/EvoLinkAI/diagram-skill-for-openclaw
metadata: {"openclaw":{"homepage":"https://github.com/EvoLinkAI/diagram-skill-for-openclaw","requires":{"bins":["python3","curl"],"env":["EVOLINK_API_KEY"]},"primaryEnv":"EVOLINK_API_KEY"}}
---

# Diagram Generator

AI-powered diagram creation, editing, and format conversion from your terminal. Generate flowcharts, sequence diagrams, ER diagrams, architecture diagrams and more in Mermaid, draw.io, PlantUML, and Graphviz formats.

Powered by [Evolink.ai](https://evolink.ai?utm_source=clawhub&utm_medium=skill&utm_campaign=diagram)

## When to Use

- User wants to generate a diagram from a natural language description
- User asks to modify or update an existing diagram file
- User needs to convert a diagram between formats (e.g., Mermaid to draw.io)
- User wants to understand what an existing diagram represents
- User asks to preview or render a diagram locally
- User needs a quick reference for diagram types and format syntax

## Quick Start

### 1. Set your EvoLink API key

    export EVOLINK_API_KEY="your-key-here"

Get a free key: [evolink.ai/signup](https://evolink.ai/signup?utm_source=clawhub&utm_medium=skill&utm_campaign=diagram)

### 2. Generate a diagram

    bash scripts/diagram.sh generate flowchart "user login flow with OAuth and MFA"

### 3. Preview it

    bash scripts/diagram.sh preview login_diagram.mmd

## Capabilities

### Local Commands (no API key needed)

| Command | Description |
|---------|-------------|
| `templates` | List all diagram types, formats, and usage examples |
| `preview <file>` | Open diagram in browser (Mermaid HTML, draw.io link, PlantUML URL, Graphviz SVG) |

### AI Commands (require EVOLINK_API_KEY)

| Command | Description |
|---------|-------------|
| `generate <type> [--format <fmt>] "<desc>"` | AI generate diagram from natural language description |
| `edit <file> "<instruction>"` | AI modify existing diagram file based on instruction |
| `convert <file> --to <format>` | AI convert diagram between formats |
| `explain <file>` | AI explain diagram structure in plain language |

### Diagram Types

| Type | Description |
|------|-------------|
| `flowchart` | Process flows, decision trees, workflows |
| `sequence` | API calls, service interactions, message flows |
| `class` | OOP class hierarchies, interfaces, relationships |
| `er` | Database entity-relationship diagrams |
| `state` | State machines, lifecycle transitions |
| `mindmap` | Idea maps, topic hierarchies, brainstorming |
| `architecture` | System architecture, microservices, cloud infra |
| `network` | Network topology, server layout, connectivity |
| `gantt` | Project timelines, task scheduling |
| `pie` | Data distribution, proportions |
| `git` | Git branch/merge visualization |
| `c4` | C4 model (context, container, component, code) |

### Output Formats

| Format | Extension | Best For |
|--------|-----------|----------|
| `mermaid` | `.mmd` | Documentation, README files (native GitHub/GitLab rendering) |
| `drawio` | `.drawio` | Architecture diagrams (drag-and-drop editing in diagrams.net) |
| `plantuml` | `.puml` | UML diagrams (rich UML support, sequence diagrams) |
| `graphviz` | `.dot` | Graph/network layouts (automatic layout algorithms) |

## Examples

### Generate a flowchart

    bash scripts/diagram.sh generate flowchart "CI/CD pipeline with build, test, and deploy stages"

### Generate an ER diagram in draw.io format

    bash scripts/diagram.sh generate er --format drawio "e-commerce database with users, orders, products"

### Edit an existing diagram

    bash scripts/diagram.sh edit flow.mmd "add error handling branch after validation step"

### Convert Mermaid to draw.io

    bash scripts/diagram.sh convert flow.mmd --to drawio

### Explain a diagram

    bash scripts/diagram.sh explain architecture.puml

### Preview a Mermaid diagram

    bash scripts/diagram.sh preview flow.mmd

## Configuration

| Variable | Default | Required | Description |
|---|---|---|---|
| `EVOLINK_API_KEY` | — | Yes (AI commands) | Your EvoLink API key. [Get one free](https://evolink.ai/signup?utm_source=clawhub&utm_medium=skill&utm_campaign=diagram) |
| `EVOLINK_MODEL` | `claude-opus-4-6` | No | Model for AI generation |

Required binaries: `python3`, `curl`

Optional: `dot` (Graphviz) for local SVG rendering in `preview` command

## Security

**Data Transmission**

AI commands send diagram content to `api.evolink.ai` for processing by Claude. By setting `EVOLINK_API_KEY` and using these commands, you consent to this transmission. Data is not stored after the response is returned. The `templates` and `preview` commands run entirely locally and never transmit data.

**Preview Command**

- Mermaid preview generates a local HTML file using the Mermaid.js CDN — no diagram data is sent externally.
- PlantUML preview sends diagram code to `plantuml.com` for rendering. A warning is displayed before opening.
- draw.io preview opens the diagrams.net web app — you load the file manually.
- Graphviz preview renders locally via the `dot` binary if installed.

**Network Access**

- `api.evolink.ai` — AI generation (AI commands only)
- `cdn.jsdelivr.net` — Mermaid.js library (preview command, Mermaid format only)
- `plantuml.com` — PlantUML rendering (preview command, PlantUML format only)

**Persistence & Privilege**

Temporary files for API payloads are cleaned up automatically. No credentials or persistent data are stored.

## Links

- [GitHub](https://github.com/EvoLinkAI/diagram-skill-for-openclaw)
- [EvoLink API](https://docs.evolink.ai/en/api-manual/language-series/claude/claude-messages-api?utm_source=clawhub&utm_medium=skill&utm_campaign=diagram)
- [Community](https://discord.com/invite/5mGHfA24kn)
- [Support](mailto:support@evolink.ai)
