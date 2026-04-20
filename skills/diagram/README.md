# Diagram Generator — OpenClaw Skill

AI-powered diagram creation, editing, and format conversion. Generate flowcharts, sequence diagrams, ER diagrams, architecture diagrams and more in Mermaid, draw.io, PlantUML, and Graphviz — all from your terminal.

Powered by [EvoLink.ai](https://evolink.ai)

## Install

### Via ClawHub (Recommended)

```
npx clawhub install ai-diagram-generator
```

### Via npm

```
npx evolinkai-diagram-generator
```

## Quick Start

```bash
# Set your API key
export EVOLINK_API_KEY="your-key-here"

# Generate a flowchart from description
bash scripts/diagram.sh generate flowchart "user login flow with OAuth"

# Generate an ER diagram in draw.io format
bash scripts/diagram.sh generate er --format drawio "e-commerce database schema"

# Edit an existing diagram
bash scripts/diagram.sh edit flow.mmd "add error handling after validation"

# Convert Mermaid to draw.io
bash scripts/diagram.sh convert flow.mmd --to drawio

# Explain a diagram
bash scripts/diagram.sh explain architecture.puml

# Preview in browser
bash scripts/diagram.sh preview flow.mmd
```

Get a free API key at [evolink.ai/signup](https://evolink.ai/signup)

## What This Skill Does

### Local Commands (no API key needed)

| Command | Description |
|---------|-------------|
| `templates` | List all diagram types, formats, and usage examples |
| `preview <file>` | Open diagram in browser for visual preview |

### AI Commands (require EVOLINK_API_KEY)

| Command | Description |
|---------|-------------|
| `generate <type> [--format <fmt>] "<desc>"` | AI generate diagram from natural language |
| `edit <file> "<instruction>"` | AI modify existing diagram file |
| `convert <file> --to <format>` | AI convert between diagram formats |
| `explain <file>` | AI explain diagram in plain language |

### Diagram Types

| Type | Description |
|------|-------------|
| `flowchart` | Process flows, decision trees, workflows |
| `sequence` | API calls, service interactions, message flows |
| `class` | OOP class hierarchies, interfaces |
| `er` | Database entity-relationship diagrams |
| `state` | State machines, lifecycle transitions |
| `mindmap` | Idea maps, topic hierarchies |
| `architecture` | System architecture, microservices, cloud infra |
| `network` | Network topology, server layout |
| `gantt` | Project timelines, task scheduling |
| `pie` | Data distribution, proportions |
| `git` | Git branch/merge visualization |
| `c4` | C4 model (context, container, component, code) |

### Output Formats

| Format | Extension | Best For |
|--------|-----------|----------|
| `mermaid` | `.mmd` | Documentation, README (native GitHub rendering) |
| `drawio` | `.drawio` | Architecture diagrams (diagrams.net editing) |
| `plantuml` | `.puml` | UML diagrams (rich UML support) |
| `graphviz` | `.dot` | Graph/network layouts (auto layout) |

## Structure

```
diagram-skill-for-openclaw/
├── SKILL.md                    # Skill definition for ClawHub
├── _meta.json                  # Metadata
├── scripts/
│   └── diagram.sh              # Core script — all commands
└── npm/
    ├── package.json            # npm package config
    ├── bin/install.js          # npm installer
    └── skill-files/            # Files copied on install
```

## Configuration

| Variable | Default | Required | Description |
|---|---|---|---|
| `EVOLINK_API_KEY` | — | Yes (AI commands) | EvoLink API key. [Get one free](https://evolink.ai/signup) |
| `EVOLINK_MODEL` | `claude-opus-4-6` | No | AI model for generation |

Required: `python3`, `curl`

Optional: `dot` (Graphviz) for local SVG rendering

## Security & Data

- AI commands send diagram content to `api.evolink.ai` for processing. Data is not stored after response.
- `templates` and `preview` commands run entirely locally — no data transmitted.
- Mermaid preview uses CDN for Mermaid.js library (no diagram data sent).
- PlantUML preview sends code to `plantuml.com` for rendering (warning displayed).
- Temporary files are cleaned up automatically. No credentials stored.

## Links

- [ClawHub](https://clawhub.ai/evolinkai/ai-diagram-generator)
- [EvoLink API Docs](https://docs.evolink.ai)
- [Discord](https://discord.com/invite/5mGHfA24kn)

## License

MIT
