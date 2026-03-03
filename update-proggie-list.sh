#!/bin/bash
# Update proggie-list-sorted.txt with current files

REPO_ROOT="$(cd "$(dirname "$0")" && pwd)"
OUTPUT_FILE="$REPO_ROOT/proggie-list-sorted.txt"

echo "Scanning for proggies..."

# Find all .zip and .rar files in programs directory, sort them
find "$REPO_ROOT/programs" -type f \( -name "*.zip" -o -name "*.rar" \) | \
    sed "s|$REPO_ROOT/||" | \
    sort > "$OUTPUT_FILE"

COUNT=$(wc -l < "$OUTPUT_FILE" | tr -d ' ')
echo "✓ Updated $OUTPUT_FILE with $COUNT files"
