---
name: work-tracking
description: Creates and maintains work tracking files before code changes. Tracks progress with progressive todo updates and archives completed work. Use this skill for features, bug fixes, refactoring, and improvements.
allowed-tools: [Read, Write, Edit, Bash, Glob]

## When This Skill Activates

Use obra-superpowers planning skill whenever possible.

This skill is used for:
- Any new feature implementation
- Any bug fix
- Any refactoring
- Any improvement or optimization
- Any code change that will be committed

This skill activates when the user requests:
- "Implement X"
- "Fix Y"
- "Add Z feature"
- "Refactor A"
- "Improve B"
- Any task involving code changes

---

## Script Location

The scripts live in this skill's `bin/` directory. The agent knows this skill's filesystem location (it loaded SKILL.md from there). Use `bin/` relative to that known path.

Resolve it once at the start of any session using this skill:

```bash
# Resolve the skill's bin directory from the known skill path
# Replace SKILL_DIR with the actual path where this skill is installed
SKILL_DIR="<path-to-this-skill>"
SKILL_BIN="$SKILL_DIR/bin"
```

Then use `$SKILL_BIN` to call the scripts:

```bash
$SKILL_BIN/work-create.sh <task_name>
$SKILL_BIN/work-complete.sh <task_name>
```

The scripts accept an optional project directory as the first argument. When omitted, they use `$PWD`:

```bash
$SKILL_BIN/work-create.sh <project_dir> <task_name>
$SKILL_BIN/work-complete.sh <project_dir> <task_name>
```

---

## Step 1: Check for Active Work

**Do this before creating new work.**

```bash
ls agent-work/*.md 2>/dev/null
```

If there's an active work file:
- Show it to the user
- Ask: "There's an active work file: [filename]. Would you like to:
  1. Continue with this work
  2. Complete it first
  3. Create new work file"
- Wait for user response before proceeding

If no active work file, proceed to Step 2.

---

## Step 2: Create Work File

**Run this script before writing any code.**

```bash
$SKILL_BIN/work-create.sh <task_name>
```

The script will create `agent-work/` and `agent-work/completed/` in the project directory if they don't exist.

### Task Naming Rules
Use descriptive, snake_case names containing only letters, numbers, and underscores (minimum 3 characters):
- ✅ `improve_pdf_generation`
- ✅ `add_watermark_support`
- ✅ `fix_date_parsing_bug`
- ❌ `new_feature` (too vague)
- ❌ `fix` (too short)
- ❌ `fix auth; rm -rf /` (shell metacharacters)

### Input Safety
The `task_name` must contain **only** lowercase letters (`a-z`), digits (`0-9`), and underscores (`_`). The script rejects any name containing spaces, slashes, shell metacharacters, or other special characters.

---

## Step 3: Populate Work File

**Immediately after creation, populate the work file with:**

1. **Context** - What problem is being solved, why it's needed
2. **Value Proposition** - What the feature achieves, business value
3. **Alternatives Considered** - Other approaches considered with trade-offs
4. **Todos** - Specific, actionable tasks with `[ ]` checkboxes
5. **Acceptance Criteria** - How to verify the work is complete
6. **Notes** - Any additional information

See `EXAMPLES.md` for complete, real-world examples.

---

## Step 4: Implement Work (Update Todos Progressively)

**Update the work file after each todo, not after all todos.**

### Recommended approach:
```
1. Complete Todo 1
2. Update work file: [ ] Task 1 → [x] Task 1
3. Complete Todo 2
4. Update work file: [ ] Task 2 → [x] Task 2
```

### Why this matters:
- If the process is interrupted, progress isn't lost
- Maintains accurate progress tracking
- Allows resumption from any point
- User can see real-time progress

### How to Update:
Use the Edit tool to change `[ ]` to `[x]` for completed todos.

---

## Step 5: Complete Work

**When ALL todos are checked as [x], complete the work:**

```bash
$SKILL_BIN/work-complete.sh <task_name>
```

### What the script does:
- Validates the task name
- Updates status to `completed ({completion_timestamp})`
- Moves file to `agent-work/completed/` directory

---

## Work File Locations

- **Active work**: `agent-work/{timestamp}_{task_name}.md`
- **Completed work**: `agent-work/completed/{timestamp}_{task_name}.md`

---

## Workflow Checklist

**Before writing any code:**
- [ ] Checked for active work files
- [ ] Created work file using `work-create.sh`
- [ ] Populated Context, Value Proposition, Alternatives, Todos, Acceptance Criteria

While implementing:
- [ ] Update work file after each todo completion
- [ ] Use Edit tool to change `[ ]` to `[x]`

After completing all todos:
- [ ] Verify ALL todos are marked `[x]`
- [ ] Run `work-complete.sh` to move file to completed/

---

## Summary

**Recommended sequence:**
1. Check for active work: `ls agent-work/*.md`
2. Create work file: `$SKILL_BIN/work-create.sh <task_name>`
3. Populate work file with context, todos, etc.
4. Implement each todo + update work file after each
5. Complete work: `$SKILL_BIN/work-complete.sh <task_name>`

For complete examples of work files, see `EXAMPLES.md`.
