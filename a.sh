#!/usr/bin/env bash
set -euo pipefail

echo "[INFO] Starting echo count script"

tmpfile=$(mktemp)

find . \( \
  -path "./*/scripts/*.sh" -o \
  -path "./ci-cd/riker/*/build.sh" -o \
  -path "./ci-cd/makeself/*.sh" -o \
  -path "./ci-cd/makeself/tests/*.sh" -o \
  -path "./web-index.new/scripts/c/*.sh" \
\) -type f 2>/dev/null > "$tmpfile"

file_count=$(wc -l < "$tmpfile" | tr -d '[:space:]')
echo "[INFO] Found $file_count matching files"

total=0

while IFS= read -r file; do
  if [ -f "$file" ]; then
  # if file in ./infrastructure/* continue
  if [[ "$file" == ./infrastructure/* ]]; then
    echo "[DEBUG] Skipping infrastructure file: $file"
    continue
  fi
    count=$( (grep -ow 'echo' "$file" || true) | wc -l )
    # turn count into integer
    count=$(echo "$count" | tr -d '[:space:]')
    if [[ $count != 0 ]]; then
      echo "$count"
    fi    
    total=$(( total + count ))
  else
    echo "[WARN] Skipping missing file: $file"
  fi
done < "$tmpfile"

rm -f "$tmpfile"

echo "Total 'echo' occurrences: $total"
