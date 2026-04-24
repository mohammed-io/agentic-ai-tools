# Work Tracking Plugin

Creates and maintains work tracking files before code changes. Tracks progress with progressive todo updates and archives completed work.

## What It Does

Claude uses this skill for coding tasks:

- **Work file before code** - Creates tracking document before any implementation
- **Progressive updates** - Updates work file after each todo, not batched
- **Crash recovery** - Progress is preserved if the process is interrupted mid-task
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

## Installation

Copy the skill to your Claude skills directory:

```bash
# Install to your preferred skills directory, e.g.:
SKILL_DIR=~/.claude/skills/work-tracking
# or: SKILL_DIR=~/.pi/agent/skills/work-tracking
# or: SKILL_DIR=~/.agents/skills/work-tracking
mkdir -p "$SKILL_DIR"
cp SKILL.md "$SKILL_DIR/"
cp -r bin "$SKILL_DIR/"
cp EXAMPLES.md "$SKILL_DIR/"
```

Then add the following to your `AGENTS.md` or `CLAUDE.md`:

```markdown
## Work Tracking System

Before starting any work, invoke the work-tracking skill and follow its procedures to create a work file. Only proceed with coding after the work file is created. This applies to features, bug fixes, refactoring, and all other code changes.
```

## How It Works

### Scripts

The skill includes two scripts in `bin/`:

| Script | Purpose |
|---|---|
| `bin/work-create.sh` | Creates `agent-work/` in the project and generates a work file |
| `bin/work-complete.sh` | Marks a work file complete and moves it to `agent-work/completed/` |

Both scripts accept an optional `<project_dir>` as the first argument. When omitted, they use `$PWD`.

```bash
# From within a project (uses $PWD)
$SKILL_DIR/bin/work-create.sh improve_pdf_generation
$SKILL_DIR/bin/work-complete.sh improve_pdf_generation

# Targeting a specific project
$SKILL_DIR/bin/work-create.sh ~/my-project improve_pdf_generation
```

### Work File Template

Each work file includes:
- **Context** - What problem is being solved
- **Value Proposition** - Acceptance criteria and goals
- **Alternatives Considered** - Why this approach was chosen
- **Todos** - Checkbox list of tasks
- **Notes** - Additional information

### Progressive Updates

The key insight: update after **each** todo, not all at once. This means if the process is interrupted, you can resume exactly where you left off.

### Completion

When all todos are checked, the work file is moved to `agent-work/completed/` with a completion timestamp.

### Security

Task names are validated to contain only `[a-z0-9_]` (minimum 3 characters). Shell metacharacters, path traversal sequences, and command substitution patterns are rejected.

## Structure

```
work-tracking/
├── README.md          # This file
├── SKILL.md           # Claude skill definition
├── EXAMPLES.md        # Real-world work file examples
└── bin/
    ├── work-create.sh    # Creates new work files
    └── work-complete.sh  # Completes and archives
```

After running `work-create.sh`, the project gets:

```
<project>/
├── agent-work/
│   ├── completed/            # Archive of finished work
│   └── {timestamp}_{task}.md # Active work files
└── ...
```

## For AI Agents

See `SKILL.md` for complete implementation details including step-by-step procedures, the workflow checklist, and task naming rules.

## Authors

Mohammed A. I
