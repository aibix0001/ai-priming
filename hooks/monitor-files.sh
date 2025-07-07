#!/bin/bash

# Hook: Monitor changes to important files
# Triggered: Before Edit/Write/MultiEdit operations

# Create logs directory if it doesn't exist
mkdir -p .claude/logs

# Get current timestamp
timestamp=$(date '+%Y-%m-%d %H:%M:%S')

# Read JSON input from stdin and extract file path
input_json=$(cat)
file_path=$(echo "$input_json" | python3 -c "import json, sys; data=json.load(sys.stdin); print(data.get('tool_input', {}).get('file_path', 'Unknown file'))" 2>/dev/null || echo "Unknown file")

# Check if this is an important file
important_files=(
	"CLAUDE.md"
	"CLAUDE.local.md"
	"commands/"
	".claude/settings.json"
	"setup.sh"
	"README.md"
)

is_important=false
for pattern in "${important_files[@]}"; do
	if [[ "$file_path" =~ $pattern ]]; then
		is_important=true
		break
	fi
done

if [[ "$is_important" == "true" ]]; then
	# Log important file modification
	echo "[$timestamp] IMPORTANT FILE MODIFIED: $file_path" >>.claude/logs/file-changes.log

	# If it's a command file, check if we should update command memory
	if [[ "$file_path" =~ commands/ ]]; then
		command_name=$(basename "$file_path" .md)
		echo "[$timestamp] Command file modified: $command_name" >>.claude/logs/file-changes.log
	fi
fi

# Return success to allow file operation
exit 0
