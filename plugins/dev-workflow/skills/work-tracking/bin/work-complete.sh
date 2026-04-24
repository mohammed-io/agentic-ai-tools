#!/bin/bash
set -euo pipefail

# work-complete.sh — Complete and archive a work tracking file.
#
# Usage:
#   work-complete.sh <project_dir> <task_name>
#   work-complete.sh <task_name>              (uses $PWD as project dir)
#
# Examples:
#   work-complete.sh ~/my-project improve_pdf_generation
#   work-complete.sh improve_pdf_generation    (run from within the project)

# Parse arguments
if [ $# -eq 2 ]; then
  project_dir="$1"
  name="$2"
elif [ $# -eq 1 ]; then
  project_dir="$PWD"
  name="$1"
else
  echo "Usage: work-complete.sh <project_dir> <task_name>"
  echo "       work-complete.sh <task_name>"
  echo "Examples:"
  echo "  work-complete.sh improve_pdf_generation"
  echo "  work-complete.sh 20251230162552_improve_pdf_generation"
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

if [ ! -d "$WORK_DIR" ]; then
  echo "Error: No agent-work directory found in '$project_dir'."
  exit 1
fi

# --- Input validation ---

# Task name: only lowercase letters, digits, and underscores
if ! echo "$name" | grep -qE '^[a-z0-9_]+$'; then
  echo "Error: Invalid task name '$name'"
  echo "Task names must contain only lowercase letters (a-z), digits (0-9), and underscores (_)."
  exit 1
fi

case "$name" in
  ""|_*|*_)
    echo "Error: Invalid task name '$name'"
    echo "Task names must not start or end with an underscore."
    exit 1
    ;;
esac

# --- Find the work file ---

file=""

# 1. Exact filename match (with or without .md extension)
if [ -f "$WORK_DIR/$name" ]; then
  file="$WORK_DIR/$name"
elif [ -f "$WORK_DIR/$name.md" ]; then
  file="$WORK_DIR/$name.md"
# 2. Match by name suffix (*_name.md)
else
  file=$(find "$WORK_DIR" -maxdepth 1 -name "*_${name}.md" -type f 2>/dev/null | head -1)
fi

if [ -z "$file" ]; then
  echo "Error: Work file not found for '$name'"
  echo "Available work files:"
  ls -1 "$WORK_DIR"/*.md 2>/dev/null | grep -v "^$" || echo "  (none)"
  exit 1
fi

# Verify the resolved path stays within WORK_DIR
real_work_dir=$(cd "$WORK_DIR" && pwd)
real_file=$(cd "$(dirname "$file")" && pwd)/$(basename "$file")
case "$real_file" in
  "$real_work_dir"/*) ;;
  *)
    echo "Error: Resolved file path is outside the work directory."
    exit 1
    ;;
esac

# --- Complete the work file ---

mkdir -p "$COMPLETED_DIR"

completion_timestamp=$(TZ=UTC date +"%Y%m%d%H%M%S")

if [[ "$OSTYPE" == "darwin"* ]]; then
  sed -i '' "s/## Status: in_progress/## Status: completed (${completion_timestamp})/" "$file"
else
  sed -i "s/## Status: in_progress/## Status: completed (${completion_timestamp})/" "$file"
fi

filename=$(basename "$file")
mv "$file" "$COMPLETED_DIR/$filename"

echo "Completed and moved: $COMPLETED_DIR/$filename"
