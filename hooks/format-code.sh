#!/bin/bash

# Hook: Auto-format code after file operations
# Triggered: After Edit/Write/MultiEdit operations

# Get file path from environment
file_path="${CLAUDE_TOOL_FILE_PATH:-}"

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
    "js"|"ts"|"json")
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