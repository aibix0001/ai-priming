#!/bin/bash

# Hook: Validate git operations follow our standards
# Triggered: Before Bash tool execution (git commands)

# Only process if this is a git command
command_text="${CLAUDE_TOOL_COMMAND:-}"
if [[ ! "$command_text" =~ ^git ]]; then
    exit 0
fi

# Extract git operation
if [[ "$command_text" =~ git\ commit ]]; then
    # Check if commit message follows our format
    if [[ "$command_text" =~ \-m.*\"\$ ]]; then
        # Get commit message
        commit_msg=$(echo "$command_text" | sed -n 's/.*-m.*"\(.*\)".*/\1/p')
        
        # Check for required patterns
        if [[ ! "$commit_msg" =~ ^(feat|fix|docs|refactor|test|chore): ]]; then
            echo "ERROR: Commit message must start with conventional commit type (feat:, fix:, docs:, etc.)"
            echo "Current message: $commit_msg"
            exit 1
        fi
        
        # Check for Claude Code signature
        if [[ ! "$command_text" =~ "Generated with \[Claude Code\]" ]]; then
            echo "WARNING: Commit missing Claude Code signature"
            # Don't block, just warn
        fi
    fi
fi

# Check for dangerous git operations
if [[ "$command_text" =~ git\ push.*--force ]]; then
    echo "ERROR: Force push detected. Use with extreme caution."
    echo "Command: $command_text"
    exit 1
fi

if [[ "$command_text" =~ git\ reset.*--hard ]]; then
    echo "WARNING: Hard reset detected. This will lose uncommitted changes."
    echo "Command: $command_text"
    # Don't block, just warn
fi

# Return success to allow command execution
exit 0