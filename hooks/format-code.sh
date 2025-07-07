#!/bin/bash

# Hook: Auto-format code after file operations
# Triggered: After Edit/Write/MultiEdit operations

# Read JSON input from stdin and extract file path
input_json=$(cat)
file_path=$(echo "$input_json" | python3 -c "import json, sys; data=json.load(sys.stdin); print(data.get('tool_input', {}).get('file_path', ''))" 2>/dev/null || echo "")

# Only format if file exists
if [[ ! -f "$file_path" ]]; then
	exit 0
fi

# Get file extension
extension="${file_path##*.}"

case "$extension" in
"py")
	# Format Python files if black is available
	if command -v black >/dev/null 2>&1; then
		black "$file_path" 2>/dev/null
	fi
	;;
"js" | "ts" | "json")
	# Format JavaScript/TypeScript/JSON if prettier is available
	if command -v prettier >/dev/null 2>&1; then
		prettier --write "$file_path" 2>/dev/null
	fi
	;;
"sh")
	# Format shell scripts if shfmt is available
	if command -v shfmt >/dev/null 2>&1; then
		shfmt -w "$file_path" 2>/dev/null
	fi
	;;
esac

# Return success regardless of formatting result
exit 0
