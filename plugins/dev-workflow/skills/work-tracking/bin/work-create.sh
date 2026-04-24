#!/bin/bash
set -euo pipefail

# work-create.sh — Create a work tracking file in a project's agent-work/ directory.
#
# Usage:
#   work-create.sh <project_dir> <task_name>
#   work-create.sh <task_name>              (uses $PWD as project dir)
#
# Examples:
#   work-create.sh ~/my-project improve_pdf_generation
#   work-create.sh improve_pdf_generation    (run from within the project)

# Parse arguments
if [ $# -eq 2 ]; then
  project_dir="$1"
  name="$2"
elif [ $# -eq 1 ]; then
  project_dir="$PWD"
  name="$1"
else
  echo "Usage: work-create.sh <project_dir> <task_name>"
  echo "       work-create.sh <task_name>"
  echo "Example: work-create.sh improve_pdf_generation"
  exit 1
fi

# Resolve and validate project directory
if [ ! -d "$project_dir" ]; then
  echo "Error: Directory '$project_dir' does not exist."
  exit 1
fi
project_dir=$(cd "$project_dir" && pwd)

WORK_DIR="$project_dir/agent-work"
COMPLETED_DIR="$WORK_DIR/completed"

# --- Input validation ---

# Task name: only lowercase letters, digits, and underscores
if ! echo "$name" | grep -qE '^[a-z0-9_]+$'; then
  echo "Error: Invalid task name '$name'"
  echo "Task names must contain only lowercase letters (a-z), digits (0-9), and underscores (_)."
  exit 1
fi

# Reject edge-case names
case "$name" in
  ""|_*|*_)
    echo "Error: Invalid task name '$name'"
    echo "Task names must not start or end with an underscore."
    exit 1
    ;;
esac

# Minimum length
if [ ${#name} -lt 3 ]; then
  echo "Error: Task name too short (minimum 3 characters)."
  exit 1
fi

# --- Create work file ---

mkdir -p "$WORK_DIR" "$COMPLETED_DIR"

timestamp=$(TZ=UTC date +"%Y%m%d%H%M%S")
filename="${timestamp}_${name}.md"
filepath="$WORK_DIR/$filename"

# Quoted heredoc prevents any shell expansion
cat > "$filepath" <<'EOF'
# PLACEHOLDER_TITLE

## Status: in_progress

## Context
Context of this feature

## Value Proposition
What it tries to solve

## Alternatives considered (with trade-offs)
Other options

## Todos
- [ ] Task 1
  - [ ] Subtask 1
- [ ] Task 2
...

## Acceptance Criteria
- Criterion 1
- Criterion 2

## Notes
EOF

# Replace the placeholder title with the actual task name
# sed works on the validated name (safe: only [a-z0-9_])
if [[ "$OSTYPE" == "darwin"* ]]; then
  sed -i '' "s/# PLACEHOLDER_TITLE/# ${name}/" "$filepath"
else
  sed -i "s/# PLACEHOLDER_TITLE/# ${name}/" "$filepath"
fi

echo "Created work file: $filepath"
