# Claude Hooks System Improvements

## Current Status
The basic hooks system has been implemented with:
- `.claude/settings.json` - Hook configuration
- `.claude/hooks/` - Five hook scripts (logging, validation, monitoring, formatting, refresh)
- Command memory tracking in all command files
- Documentation in README.md

## Identified Issues

### 1. Stop Hook Timing Problem
- **Issue**: Stop hook triggers just before session ends
- **Problem**: Refreshing rules right before exit wastes tokens
- **Solution**: Remove Stop hook from configuration

### 2. Notification Hook Frequency
- **Issue**: Notifications may fire frequently during work
- **Problem**: Could spam context with repeated refresh messages
- **Solution**: Implement time-based cooldown (15 minutes)

### 3. Session Start Context
- **Issue**: New sessions don't get immediate rule refresh
- **Problem**: Assistant starts without project command context
- **Solution**: Add refresh instruction to CLAUDE.md

## Proposed Improvements

### 1. Time-Based Refresh Cooldown

**Implementation**: Modify `refresh-rules.sh`:
```bash
# Check last refresh timestamp
last_refresh=$(cat .claude-last-refresh 2>/dev/null || echo "0")
current_time=$(date +%s)
time_diff=$((current_time - last_refresh))

# Only refresh if 15+ minutes have passed (900 seconds)
if [ $time_diff -ge 900 ]; then
    # Perform refresh logic
    echo "$current_time" > .claude-last-refresh
else
    # Skip refresh, too recent
    exit 0
fi
```

**Benefits**:
- Prevents context pollution from frequent refreshes
- Maintains reasonable rule currency during long sessions
- Works regardless of notification frequency

### 2. Session Start Refresh

**Implementation**: Add to CLAUDE.md:
```markdown
## Session Initialization

**Rule Refresh Check**: At the start of each session, check for command memory:
- If `.claude-commands.memory` exists, read it and refresh understanding of those command files
- This ensures the assistant starts with current project context
- Example: If memory shows `/python /ansible`, re-read python.md and ansible.md
```

**Benefits**:
- Fresh sessions get immediate project context
- Uses natural Claude Code file discovery
- No dependency on hook timing uncertainty

### 3. Hook Configuration Cleanup

**Current Configuration**:
```json
{
  "hooks": {
    "Notification": [
      {
        "matcher": ".*",
        "hooks": [{"type": "command", "command": ".claude/hooks/refresh-rules.sh"}]
      }
    ],
    "Stop": [
      {
        "matcher": ".*", 
        "hooks": [{"type": "command", "command": ".claude/hooks/refresh-rules.sh"}]
      }
    ]
  }
}
```

**Improved Configuration**:
```json
{
  "hooks": {
    "Notification": [
      {
        "matcher": ".*",
        "hooks": [{"type": "command", "command": ".claude/hooks/refresh-rules.sh"}]
      }
    ]
  }
}
```

**Changes**:
- Remove Stop hook (wasteful timing)
- Keep Notification hook with time-based cooldown

### 4. Documentation Updates

**Add to README.md**:
- Explain dual refresh strategy (session start + periodic)
- Document 15-minute cooldown mechanism
- Update repository structure to show `.claude-last-refresh` (gitignored)

## Implementation Priority

1. **High**: Modify refresh-rules.sh with time-based cooldown
2. **High**: Add session start refresh to CLAUDE.md
3. **Medium**: Update settings.json to remove Stop hook
4. **Low**: Update documentation

## Expected Outcomes

- **Optimal timing**: Refresh at session start and periodically during work
- **No waste**: No refresh at session end
- **No spam**: Time-based cooldown prevents context pollution
- **Reliable context**: Assistant always has current project command awareness

## Files to Modify

- `.claude/hooks/refresh-rules.sh` - Add time-based logic
- `CLAUDE.md` - Add session start refresh instruction
- `.claude/settings.json` - Remove Stop hook
- `README.md` - Update documentation
- `.gitignore` - Already updated to exclude `.claude-last-refresh`

## Testing Plan

1. Test session start refresh via CLAUDE.md instruction
2. Verify time-based cooldown prevents frequent refreshes
3. Confirm proper project context loading
4. Validate hook timing and effectiveness