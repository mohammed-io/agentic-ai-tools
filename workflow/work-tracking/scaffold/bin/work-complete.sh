#!/bin/bash

# Script to complete work files and move them to completed folder

WORK_DIR="agent-work"
COMPLETED_DIR="$WORK_DIR/completed"

# Ensure completed directory exists
mkdir -p "$COMPLETED_DIR"

name_or_timestamp="$1"

if [ -z "$name_or_timestamp" ]; then
  echo "Usage: work-complete <name_or_timestamp>"
  echo "Examples:"
  echo "  work-complete improve_pdf_generation"
  echo "  work-complete 20251230162552"
  echo "  work-complete 20251230162552_improve_pdf_generation"
  exit 1
fi

# Find the work file
# Try different matching strategies in order:

# 1. Exact filename match (with or without .md extension)
if [ -f "$WORK_DIR/$name_or_timestamp" ]; then
  file="$WORK_DIR/$name_or_timestamp"
elif [ -f "$WORK_DIR/$name_or_timestamp.md" ]; then
  file="$WORK_DIR/$name_or_timestamp.md"
# 2. Match by name suffix (*_name.md)
else
  file=$(find "$WORK_DIR" -maxdepth 1 -name "*_${name_or_timestamp}.md" -type f 2>/dev/null | head -1)
fi

# 3. Match by timestamp prefix (timestamp_*.md)
if [ -z "$file" ]; then
  file=$(find "$WORK_DIR" -maxdepth 1 -name "${name_or_timestamp}_*.md" -type f 2>/dev/null | head -1)
fi

if [ -z "$file" ]; then
  echo "Error: Work file not found for '$name_or_timestamp'"
  echo "Available work files:"
  ls -1 "$WORK_DIR"/*.md 2>/dev/null | grep -v "^$" || echo "  (none)"
  exit 1
fi

# Generate completion timestamp
completion_timestamp=$(TZ=UTC date +"%Y%m%d%H%M%S")

# Update status in the file
# This works for both BSD and GNU sed
if [[ "$OSTYPE" == "darwin"* ]]; then
  sed -i '' "s/## Status: in_progress/## Status: completed (${completion_timestamp})/" "$file"
else
  sed -i "s/## Status: in_progress/## Status: completed (${completion_timestamp})/" "$file"
fi

# Move to completed directory
filename=$(basename "$file")
mv "$file" "$COMPLETED_DIR/$filename"

echo "Completed and moved: $COMPLETED_DIR/$filename"
