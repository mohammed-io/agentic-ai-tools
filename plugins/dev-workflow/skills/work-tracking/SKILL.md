---
name: work-tracking
description: Enforces mandatory work tracking before any code changes. Ensures 100% compliance with work file creation, progressive todo updates, and proper completion. Use this skill for ALL coding tasks, bug fixes, features, and improvements.
allowed-tools: [Read, Write, Edit, Bash, Glob]
---

# Work Tracking Skill

## ⚠️ CRITICAL NON-NEGOTIABLE RULES ⚠️

**This skill MUST be activated BEFORE any code is written. No exceptions.**

1. **NO CODE WITHOUT A WORK FILE** - Creating a work file is MANDATORY before writing any code
2. **UPDATE TODOS PROGRESSIVELY** - Update the work file after EACH todo completion, not after all
3. **USE THE SCRIPTS** - Always use `work-create.sh` and `work-complete.sh` scripts
4. **CHECK FOR ACTIVE WORK** - Before creating new work, check if there's already an active work file

**Failure to follow these rules will result in rejected work.**

---

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

## Step 0: Verify Configuration (MANDATORY - First Time Only)

**Before checking for active work, ensure the project is configured for work tracking:**

1. **Check if AGENTS.md or CLAUDE.md exists:**
   ```bash
   ls AGENTS.md CLAUDE.md 2>/dev/null
   ```

2. **Check if work tracking instructions are already present:**
   ```bash
   grep -l "WORK TRACKING" AGENTS.md CLAUDE.md 2>/dev/null
   ```

3. **If NOT found, ask the user:**
   ```
   ⚠️ Work tracking is not configured in this project.

   The work tracking system requires instructions in AGENTS.md or CLAUDE.md.

   If cannot infer it, ask the user which file would you like to use?
   1. AGENTS.md
   2. CLAUDE.md
   3. Skip (work tracking may not function correctly)

   Respond with 1, 2, or 3.
   ```

4. **If user chooses 1 or 2, add these instructions:**

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

5. **Confirm with user:**
   ```
   ✓ Added work tracking system instructions to AGENTS.md (or CLAUDE.md)
   ```

**Why this matters:**
- Without these instructions, Claude won't know to use work tracking
- The instructions act as a persistent reminder across sessions
- AGENTS.md/CLAUDE.md are automatically loaded by Claude Code

---

## Step 2: Initialize Work Directory (If Needed)

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

## Step 3: Check for Active Work

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

If no active work file, proceed to Step 4.

---

## Step 4: Create Work File (MANDATORY)

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

## Step 5: Populate Work File

**Immediately after creation, populate the work file with:**

1. **Context** - What problem is being solved, why it's needed
2. **Value Proposition** - What the feature achieves, acceptance criteria
3. **Alternatives Considered** - Other approaches considered and why this approach was chosen
4. **Todos** - Specific, actionable tasks with `[ ]` checkboxes
5. **Notes** - Any additional information

### Example Work File:
```markdown
# Improve PDF Generation

## Status: in_progress

## Context
Current PDF generation doesn't preserve text selectable layers, making it hard for ATS systems to parse. Users report that their resumes aren't being parsed correctly.

## Value Proposition
- PDFs must have selectable text layers
- Font embedding must be verified
- Metadata must be properly set
- ATS systems should be able to extract all text

## Alternatives considered
- LaTeX generation: Too complex, requires LaTeX installation
- Puppeteer: Similar to Playwright but less stable
- Playwright (chosen): Best text layer support, reliable, well-maintained

## Todos
- [ ] Update PDF generator to verify text layer
- [ ] Add font embedding checks
- [ ] Implement metadata setting
- [ ] Test with ATS parsers
- [ ] Update documentation

## Notes
```

---

## Step 6: Implement Work (Update Todos Progressively)

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

## Step 7: Complete Work

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
- [ ] Verified AGENTS.md or CLAUDE.md exists
- [ ] Added work tracking system instructions to AGENTS.md or CLAUDE.md
- [ ] Initialized agent-work directory from scaffold

**Before writing ANY code, verify:**
- [ ] Checked for active work files
- [ ] Created work file using `work-create.sh`
- [ ] Populated Context, Value Proposition, Alternatives, Todos
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

## Example Workflow

### User Request: "Add watermark support to PDFs"

#### Step 1: Check for active work
```bash
ls agent-work/*.md
# (no files found)
```

#### Step 2: Create work file
```bash
./agent-work/bin/work-create.sh add_pdf_watermark_support
# Created work file: agent-work/20251230170000_add_pdf_watermark_support.md
```

#### Step 3: Populate work file
Edit the file with context, value proposition, alternatives, todos:
```markdown
## Todos
- [ ] Add watermark option to PDF generator
- [ ] Implement watermark positioning
- [ ] Add opacity control
- [ ] Test with sample PDFs
- [ ] Update documentation
```

#### Step 4: Implement first todo
Write code for watermark option...

**Immediately after:** Update work file
```
Edit: agent-work/20251230170000_add_pdf_watermark_support.md
Old: - [ ] Add watermark option to PDF generator
New: - [x] Add watermark option to PDF generator
```

#### Step 5: Implement second todo
Write code for positioning...

**Immediately after:** Update work file
```
Edit: agent-work/20251230170000_add_pdf_watermark_support.md
Old: - [ ] Implement watermark positioning
New: - [x] Implement watermark positioning
```

#### Step 6: Continue until all todos are [x]

#### Step 7: Complete work
```bash
./agent-work/bin/work-complete.sh add_pdf_watermark_support
# Completed and moved: agent-work/completed/20251230170000_add_pdf_watermark_support.md
```

---

## Summary

**MANDATORY SEQUENCE:**
1. **First time only**: Verify AGENTS.md/CLAUDE.md has work tracking instructions (Step 0)
2. **First time only**: Initialize agent-work directory from scaffold (Step 1)
3. Check for active work: `ls agent-work/*.md` (Step 2)
4. Create work file: `./agent-work/bin/work-create.sh <task_name>` (Step 3)
5. Populate work file with context, todos, etc. (Step 4)
6. Implement EACH todo + update work file immediately after EACH (Step 5)
7. Complete work: `./agent-work/bin/work-complete.sh <name>` (Step 6)

**NO CODE WITHOUT A WORK FILE. NO EXCEPTIONS.**
