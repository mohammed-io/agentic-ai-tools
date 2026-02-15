---
name: work-tracking
description: Enforces mandatory work tracking before any file changes. Ensures 100% compliance with work file creation, progressive todo updates, and proper completion. Use this skill for ALL tasks, bug fixes, features, and improvements.
allowed-tools: [Read, Write, Edit, Bash, Glob]

## When This Skill Activates

This skill MUST be used for:
- Any new feature implementation
- Any bug fix
- Any refactoring
- Any improvement or optimization
- Any code change that will be committed

This skill activates AUTOMATICALLY when the user requests:
- "Implement X"
- "Fix Y"
- "Add Z feature"
- "Refactor A"
- "Improve B"
- Any task involving code changes

---

## Step 1: Initialize Work Directory (If Needed)

**Before checking for active work, ensure agent-work directory exists:**

```bash
if [ ! -d "agent-work" ]; then
  echo "Initializing work directory..."
  cp -r .claude/skills/work-tracking/scaffold agent-work
  echo "Work directory initialized from scaffold"
fi
```

**What this does:**
- Checks if `agent-work/` directory exists
- If not, copies the scaffold structure from `.claude/skills/work-tracking/scaffold/`
- Creates the necessary `bin/` and `completed/` subdirectories
- Sets up the work tracking system ready for use

---

## Step 2: Check for Active Work

**ALWAYS do this first before creating new work.**

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

If no active work file, proceed to Step 3.

---

## Step 3: Create Work File (MANDATORY)

**You MUST run this script BEFORE writing ANY code.**

```bash
./agent-work/bin/work-create.sh <task_name>
```

### Task Naming Rules
Use descriptive, snake_case names:
- ✅ `improve_pdf_generation`
- ✅ `add_watermark_support`
- ✅ `fix_date_parsing_bug`
- ✅ `implement_resume_validator`
- ❌ `new_feature`
- ❌ `stuff`
- ❌ `update`

### What the script does:
- Generates UTC timestamp automatically
- Creates `agent-work/{timestamp}_{task_name}.md`
- Populates it with the template

**Example output:**
```
Created work file: agent-work/20251230164521_improve_pdf_generation.md
```

---

## Step 4: Populate Work File

**Immediately after creation, populate the work file with:**

1. **Context** - What problem is being solved, why it's needed
2. **Value Proposition** - What the feature achieves, business value
3. **Alternatives Considered** - Other approaches considered with trade-offs
4. **Todos** - Specific, actionable tasks with `[ ]` checkboxes
5. **Acceptance Criteria** - How to verify the work is complete
6. **Notes** - Any additional information

See `EXAMPLES.md` for complete, real-world examples of properly filled work files.

---

## Step 5: Implement Work (Update Todos Progressively)

**⚠️ CRITICAL: Update the work file after EACH todo, not after all todos.**

### Wrong Approach (DO NOT DO THIS):
```
1. Complete all 5 todos
2. Update work file once with all 5 checked
```

### Correct Approach (DO THIS):
```
1. Complete Todo 1
2. Update work file: [ ] Task 1 → [x] Task 1
3. Complete Todo 2
4. Update work file: [ ] Task 2 → [x] Task 2
5. And so on...
```

### Why This Matters:
- If AI crashes, progress isn't lost
- Maintains accurate progress tracking
- Allows resumption from any point
- User can see real-time progress

### How to Update:
Use the Edit tool to change `[ ]` to `[x]` for completed todos:

```
Edit: agent-work/{timestamp}_{task_name}.md
Old: - [ ] Update PDF generator to verify text layer
New: - [x] Update PDF generator to verify text layer
```

---

## Step 6: Complete Work

**When ALL todos are checked as [x], complete the work:**

```bash
./agent-work/bin/work-complete.sh <name>
```

### Examples:
```bash
./agent-work/bin/work-complete.sh improve_pdf_generation
./agent-work/bin/work-complete.sh 20251230164521_improve_pdf_generation
```

### What the script does:
- Updates status to `completed ({completion_timestamp})`
- Moves file to `agent-work/completed/` directory

**Example output:**
```
Completed and moved: agent-work/completed/20251230164521_improve_pdf_generation.md
```

---

## Work File Locations

- **Active work**: `agent-work/{timestamp}_{task_name}.md`
- **Completed work**: `agent-work/completed/{timestamp}_{task_name}.md`

---

## Enforcement Checklist

**First time in project:**
- [ ] Initialized agent-work directory from scaffold

**Before writing ANY code, verify:**
- [ ] Checked for active work files
- [ ] Created work file using `work-create.sh`
- [ ] Populated Context, Value Proposition, Alternatives, Todos, Acceptance Criteria
- [ ] Work file exists in `agent-work/` directory

While implementing:
- [ ] Update work file after EACH todo completion
- [ ] Use Edit tool to change `[ ]` to `[x]`
- [ ] Never batch todo updates

After completing all todos:
- [ ] Verify ALL todos are marked `[x]`
- [ ] Run `work-complete.sh` to move file to completed/

---

## Common Mistakes to Avoid

❌ **Starting to code before creating work file**
✅ Always create work file first

❌ **Updating all todos at once after completing all work**
✅ Update each todo immediately after completion

❌ **Not checking for active work files**
✅ Always check first: `ls agent-work/*.md`

❌ **Using vague task names like "update" or "fix"**
✅ Use descriptive names like "fix_date_parsing_bug"

❌ **Forgetting to complete work file when done**
✅ Run `work-complete.sh` to move to completed/

---

## Summary

**MANDATORY SEQUENCE:**
1. **First time only**: Initialize agent-work directory from scaffold (Step 1)
2. Check for active work: `ls agent-work/*.md` (Step 2)
3. Create work file: `./agent-work/bin/work-create.sh <task_name>` (Step 3)
4. Populate work file with context, todos, etc. (Step 4)
5. Implement EACH todo + update work file immediately after EACH (Step 5)
6. Complete work: `./agent-work/bin/work-complete.sh <name>` (Step 6)

**NO CODE WITHOUT A WORK FILE. NO EXCEPTIONS.**

For complete examples of work files, see `EXAMPLES.md`.
