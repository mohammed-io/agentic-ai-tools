# Work Tracking Plugin

Enforces mandatory work tracking before any code changes. Ensures 100% compliance with work file creation, progressive todo updates, and proper completion.

## What It Does

Claude automatically uses this skill for ALL coding tasks:

- **No code without a work file** - Creates tracking document before any implementation
- **Progressive updates** - Updates work file after EACH todo, not batched
- **Crash recovery** - Progress is never lost if AI crashes mid-task
- **Audit trail** - Complete history of all work in `agent-work/completed/`

## Usage

```
"Implement a new feature for XYZ"
"Fix the date parsing bug"
"Refactor the HTML templates"
"Add watermark support"
```

Claude will:
1. Check for existing active work
2. Create a work file with context, value proposition, and todos
3. Update the file after each todo completion
4. Complete and archive the work when done

## Quick Start with AI

**Copy and paste this prompt into Claude Code or Cursor:**

```text
Help me install the work-tracking skill from: https://github.com/mohammed-io/agentic-ai-tools/tree/main/plugins/dev-workflow/skills/work-tracking

1. Create .claude/skills/work-tracking/ directory
2. Copy SKILL.md and scaffold/ folder
3. Add the Work Tracking System section to AGENTS.md or CLAUDE.md
4. Set up the agent-work directory structure
```

Or install manually below:

## Installation

1. Copy to your project's `.claude/skills/` directory:

```bash
mkdir -p .claude/skills/work-tracking
cp SKILL.md .claude/skills/work-tracking/
cp -r scaffold .claude/skills/work-tracking/
```

2. **IMPORTANT:** Add this to your `AGENTS.md` or `CLAUDE.md` file:

```markdown
## Work Tracking System

**⚠️ CRITICAL: WORK TRACKING IS NON-NEGOTIABLE ⚠️**

**⚠️ BEFORE STARTING ANY WORK, YOU MUST:**
1. Run: `ls agent-work/*.md` to check for active work files
2. If no active work exists, invoke: `Skill(work-tracking)`
3. Follow the skill's procedures to create a work file
4. Only proceed with coding AFTER work file is created

**NO EXCEPTIONS - this applies to ALL code changes: features, bug fixes, refactoring, etc.**
```

## How It Works

### Work File Template

Each work file includes:
- **Context** - What problem is being solved
- **Value Proposition** - Acceptance criteria and goals
- **Alternatives Considered** - Why this approach was chosen
- **Todos** - Checkbox list of tasks
- **Notes** - Additional information

### Progressive Updates

The key insight: update after **each** todo, not all at once. This means if the AI crashes, you can resume exactly where you left off.

### Completion

When all todos are checked, the work file is automatically moved to `agent-work/completed/` with a completion timestamp.

## Structure

```
agent-work/
├── bin/
│   ├── work-create.sh    # Creates new work files
│   └── work-complete.sh  # Completes and archives
├── completed/            # Archive of finished work
└── {timestamp}_{task}.md # Active work files
```

## For AI Agents

See `SKILL.md` for complete implementation details including:
- Step-by-step procedures
- Enforcement checklist
- Common mistakes to avoid
- Example workflow

## Authors

Mohammed A. I
