#!/bin/bash

# Hook: Log bash commands for tracking automation
# Triggered: Before Bash tool execution

# Create logs directory if it doesn't exist
mkdir -p .claude/logs

# Get current timestamp
timestamp=$(date '+%Y-%m-%d %H:%M:%S')

# Get the bash command from environment (Claude provides tool parameters)
# Note: Actual command extraction may need adjustment based on Claude's hook implementation
command_description="${CLAUDE_TOOL_DESCRIPTION:-Unknown command}"
command_text="${CLAUDE_TOOL_COMMAND:-Not provided}"

# Log to file
echo "[$timestamp] Bash: $command_description" >> .claude/logs/commands.log
echo "  Command: $command_text" >> .claude/logs/commands.log
echo "" >> .claude/logs/commands.log

# Return success to allow command execution
exit 0