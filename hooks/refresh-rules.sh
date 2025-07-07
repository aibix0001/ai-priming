#!/bin/bash

# Hook: Refresh assistant's understanding of rules based on command memory
# Triggered: On notifications (with 15-minute cooldown)

# Check if command memory file exists
memory_file=".claude-commands.memory"
if [[ ! -f "$memory_file" ]]; then
    # No memory file, nothing to refresh
    exit 0
fi

# Time-based cooldown check (15 minutes = 900 seconds)
last_refresh=$(cat .claude-last-refresh 2>/dev/null || echo "0")
current_time=$(date +%s)
time_diff=$((current_time - last_refresh))

# Only refresh if 15+ minutes have passed
if [ $time_diff -lt 900 ]; then
    # Too recent, skip refresh
    exit 0
fi

# Update last refresh timestamp
echo "$current_time" > .claude-last-refresh

# Get current timestamp for logging
timestamp=$(date '+%Y-%m-%d %H:%M:%S')

# Create logs directory if it doesn't exist
mkdir -p .claude/logs

# Read the last few commands from memory
recent_commands=$(tail -5 "$memory_file" 2>/dev/null)

if [[ -n "$recent_commands" ]]; then
    # Log refresh attempt
    echo "[$timestamp] Rule refresh triggered" >> .claude/logs/refresh.log
    echo "Recent commands from memory:" >> .claude/logs/refresh.log
    echo "$recent_commands" >> .claude/logs/refresh.log
    echo "" >> .claude/logs/refresh.log
    
    # Extract unique command names from memory
    commands=$(grep -o '@\.claude/commands/[a-zA-Z]*\.md' "$memory_file" 2>/dev/null | sed 's/@\.claude\/commands\///g' | sed 's/\.md//g' | sort -u | tr '\n' ' ')
    
    if [[ -n "$commands" ]]; then
        echo "Commands used in this project: $commands" >> .claude/logs/refresh.log
        
        # Create a refresh instruction for Claude
        refresh_instruction="REFRESH REMINDER: This project has used the following commands: $commands. "
        refresh_instruction+="Please re-read the corresponding command files if working with related tasks."
        
        # Output instruction for Claude to see
        echo "$refresh_instruction"
        
        # Log the instruction
        echo "[$timestamp] Refresh instruction: $refresh_instruction" >> .claude/logs/refresh.log
    fi
fi

# Return success
exit 0