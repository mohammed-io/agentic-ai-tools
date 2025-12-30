# Agentic AI Tools

Collection of [Claude Code](https://claude.com/claude-code) skills and workflow automation tools.

## Overview

Focused plugins and skills for AI-assisted development with progressive disclosure—skills load knowledge only when activated.

## Quick Start

```bash
# Clone
git clone git@github.com:mohammed-io/agentic-ai-tools.git
cd agentic-ai-tools

# Install a skill (example: work-tracking)
mkdir -p .claude/skills/work-tracking
cp plugins/dev-workflow/skills/work-tracking/SKILL.md .claude/skills/work-tracking/
```

Add to your `AGENTS.md` or `CLAUDE.md`:

```markdown
## Work Tracking System

**⚠️ BEFORE STARTING ANY WORK:**
1. Run: `ls agent-work/*.md` to check for active work
2. If none, invoke: `Skill(work-tracking)`
3. Only proceed with coding AFTER work file is created
```

## Available Skills

### Work Tracking

Enforces mandatory work tracking before code changes. Creates tracking documents, updates progressively after each todo, and archives completed work.

**Location:** `plugins/dev-workflow/skills/work-tracking/`

- No code without a work file
- Progressive updates (not batched)
- Crash recovery
- Complete audit trail

## Structure

```
plugins/
└── dev-workflow/
    └── skills/
        └── work-tracking/
            ├── README.md
            ├── SKILL.md
            └── scaffold/
```

## Contributing

1. Create directory: `plugins/{category}/skills/{skill-name}/`
2. Add `SKILL.md` with skill definition
3. Add `README.md` with documentation
4. Include any scaffold files

## License

MIT

## Author

Mohammed A. I
