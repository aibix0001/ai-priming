#!/bin/bash

# Hook: Monitor changes to important files
# Triggered: Before Edit/Write/MultiEdit operations

# Create logs directory if it doesn't exist
mkdir -p .claude/logs

# Get current timestamp
timestamp=$(date '+%Y-%m-%d %H:%M:%S')

# Get file path from environment
file_path="${CLAUDE_TOOL_FILE_PATH:-Unknown file}"

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
    echo "[$timestamp] IMPORTANT FILE MODIFIED: $file_path" >> .claude/logs/file-changes.log
    
    # If it's a command file, check if we should update command memory
    if [[ "$file_path" =~ commands/ ]]; then
        command_name=$(basename "$file_path" .md)
        echo "[$timestamp] Command file modified: $command_name" >> .claude/logs/file-changes.log
    fi
fi

# Return success to allow file operation
exit 0