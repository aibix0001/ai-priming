#!/bin/bash

# Hook: Log bash commands for tracking automation
# Triggered: Before Bash tool execution

# Create logs directory if it doesn't exist
mkdir -p .claude/logs

# Get current timestamp
timestamp=$(date '+%Y-%m-%d %H:%M:%S')

# Read JSON data from stdin
json_input=$(cat)

# Debug: Log the raw input to understand what we're receiving
echo "[$timestamp] DEBUG: Raw input received:" >> .claude/logs/debug.log
echo "$json_input" >> .claude/logs/debug.log
echo "---" >> .claude/logs/debug.log

# Extract command details using jq (fallback to basic parsing if jq not available)
if command -v jq >/dev/null 2>&1; then
    command_description=$(echo "$json_input" | jq -r '.tool_input.description // "No description"')
    command_text=$(echo "$json_input" | jq -r '.tool_input.command // "No command"')
    tool_name=$(echo "$json_input" | jq -r '.tool_name // "Unknown"')
else
    # Basic fallback parsing without jq
    command_description=$(echo "$json_input" | grep -o '"description":"[^"]*"' | cut -d'"' -f4)
    command_text=$(echo "$json_input" | grep -o '"command":"[^"]*"' | cut -d'"' -f4)
    tool_name=$(echo "$json_input" | grep -o '"tool_name":"[^"]*"' | cut -d'"' -f4)
    
    # Set defaults if extraction failed
    command_description="${command_description:-No description}"
    command_text="${command_text:-No command}"
    tool_name="${tool_name:-Unknown}"
fi

# Log to file
echo "[$timestamp] $tool_name: $command_description" >> .claude/logs/commands.log
echo "  Command: $command_text" >> .claude/logs/commands.log
echo "" >> .claude/logs/commands.log

# Return success to allow command execution
exit 0