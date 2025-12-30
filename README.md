# Agentic AI Tools

Claude Code plugins and skills for AI-assisted development workflow automation.

## Overview

Focused plugins with progressive disclosure—skills load knowledge only when activated, keeping context minimal.

## Quick Start

### Step 1: Add the Marketplace

```bash
/plugin marketplace add mohammed-io/agentic-ai-tools
```

### Step 2: Install Plugins

```bash
/plugin install dev-workflow
```

## Available Plugins

### Dev Workflow

Development workflow skills including work tracking and task management.

**Skills included:**
- **Work Tracking** - Enforces mandatory work tracking before code changes with progressive todo updates and crash recovery

## Repository Structure

```
agentic-ai-tools/
├── .claude-plugin/
│   └── marketplace.json          # Plugin manifest
├── plugins/
│   └── dev-workflow/
│       └── skills/
│           └── work-tracking/
│               ├── README.md
│               ├── SKILL.md
│               └── scaffold/
└── README.md
```

## License

MIT
