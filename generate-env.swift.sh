#!/bin/bash

set -e

ENV_FILE=".env"
OUTPUT_FILE="./Modules/Sources/Networking/Generated/Environment.swift"

mkdir -p "$(dirname "$OUTPUT_FILE")"

if [ ! -f "$ENV_FILE" ]; then
  echo "❌ .env file not found!"
  exit 1
fi

# Start Swift file
echo "// Auto-generated file. Do not edit." > "$OUTPUT_FILE"
echo "" >> "$OUTPUT_FILE"
echo "import Foundation" >> "$OUTPUT_FILE"
echo "" >> "$OUTPUT_FILE"
echo "public enum Environment {" >> "$OUTPUT_FILE"

# Function to convert SNAKE_CASE to camelCase (Bash 3.2 compatible)
to_camel_case() {
  local input="$1"
  local result=""
  local upper_next=false

  IFS='_' read -ra parts <<< "$input"

  for i in "${!parts[@]}"; do
    part="${parts[$i]}"
    part_lower=$(echo "$part" | tr 'A-Z' 'a-z')

    if [ $i -eq 0 ]; then
      result="$part_lower"
    else
      first_char=$(echo "${part_lower:0:1}" | tr 'a-z' 'A-Z')
      rest_chars="${part_lower:1}"
      result+="${first_char}${rest_chars}"
    fi
  done

  echo "$result"
}

# Read the .env file line-by-line (handle last line even if no newline)
while IFS='=' read -r raw_key raw_value || [ -n "$raw_key" ]; do
  raw_key=$(echo "$raw_key" | xargs)
  raw_value=$(echo "$raw_value" | xargs)

  [[ -z "$raw_key" || "$raw_key" =~ ^# ]] && continue

  key=$(to_camel_case "$raw_key")
  escaped_value=$(echo "$raw_value" | sed 's/"/\\"/g')

  echo "    public static let $key = \"$escaped_value\"" >> "$OUTPUT_FILE"
done < "$ENV_FILE"

echo "}" >> "$OUTPUT_FILE"

echo "✅ Environment.swift generated at $OUTPUT_FILE"