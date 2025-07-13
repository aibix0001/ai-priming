# Claude Code Hooks

This directory contains hook scripts that integrate with Claude Code to provide automated logging, safety features, code quality enforcement, and context management.

## Hook Overview

Hooks are shell scripts that execute at specific Claude Code lifecycle events to enhance the development workflow with automated safety checks, logging, and code quality enforcement.

## Available Hooks

### format-code.sh
**Trigger**: After Edit/Write/MultiEdit operations  
**Purpose**: Automatically formats code files using appropriate tools

**Supported Formatters**:
- **Python**: `black` for .py files
- **JavaScript/TypeScript/JSON**: `prettier` for .js, .ts, .json files  
- **Shell Scripts**: `shfmt` for .sh files

**Behavior**: Silently skips formatting if the corresponding formatter is not installed.

### log-bash.sh
**Trigger**: Before Bash tool execution  
**Purpose**: Tracks all bash commands for automation monitoring

**Features**:
- Creates timestamped logs in `.claude/logs/commands.log`
- Records command descriptions and full command text
- Uses `jq` for JSON parsing when available, falls back to basic parsing
- Helps track automation patterns and debugging

### monitor-files.sh
**Trigger**: Before Edit/Write/MultiEdit operations  
**Purpose**: Monitors changes to critical configuration files

**Monitored Files**:
- `CLAUDE.md` and `CLAUDE.local.md`
- `commands/` directory (legacy, now `ai-rules/`)
- `.claude/settings.json`
- `setup.sh`
- `README.md`

**Features**:
- Logs important file modifications to `.claude/logs/file-changes.log`
- Special handling for command/rule file changes
- Non-blocking monitoring

### refresh-rules.sh
**Trigger**: On notifications (with 15-minute cooldown)  
**Purpose**: Refreshes Claude's understanding of project-specific rules

**Features**:
- **Cooldown system**: 15-minute minimum between refreshes to prevent context pollution
- **Command memory tracking**: Reads from `.claude-commands.memory` file
- **Smart refresh**: Only refreshes when relevant commands have been used
- **Logging**: Tracks refresh attempts and instructions in `.claude/logs/refresh.log`

**Refresh Logic**:
1. Checks if `.claude-commands.memory` exists
2. Verifies 15+ minutes have passed since last refresh
3. Extracts recently used commands from memory
4. Generates contextual refresh instructions for Claude
5. Updates cooldown timestamp

### validate-git.sh
**Trigger**: Before Bash tool execution (git commands only)  
**Purpose**: Validates git operations follow project standards

**Validations**:
- **Commit message format**: Enforces conventional commit format (feat:, fix:, docs:, etc.)
- **Claude Code signature**: Warns if commit missing Claude Code signature
- **Dangerous operations**: Blocks force pushes, warns on hard resets
- **Safety checks**: Prevents destructive git operations

**Error Handling**:
- Blocks execution for critical violations (force push, invalid commit format)
- Issues warnings for questionable operations (missing signature, hard reset)

## Hook Configuration

Hooks are configured in `settings.json` with the following lifecycle events:

```json
{
  "hooks": {
    "preToolUse": ["log-bash.sh", "validate-git.sh", "monitor-files.sh"],
    "postToolUse": ["format-code.sh"],
    "notification": ["refresh-rules.sh"]
  }
}
```

### Lifecycle Events

- **preToolUse**: Executes before tool operations (validation, logging)
- **postToolUse**: Executes after tool completion (formatting, cleanup)
- **notification**: Executes during notification events (context refresh)

## Log Files

All hooks create logs in `.claude/logs/`:

- `commands.log`: Complete bash command history with timestamps
- `file-changes.log`: Critical file modification tracking
- `refresh.log`: Rule refresh attempts and instructions

## Installation and Setup

Hooks are automatically active when:
1. `settings.json` is properly configured
2. Hook scripts have executable permissions
3. `.claude/logs/` directory exists (created automatically)

## Customization

### Adding New Hooks

1. Create a new shell script in the `hooks/` directory
2. Make it executable: `chmod +x hooks/your-hook.sh`
3. Add it to the appropriate lifecycle event in `settings.json`
4. Follow the existing pattern for input/output handling

### Hook Requirements

- Must read JSON input from stdin when applicable
- Should create `.claude/logs/` directory if needed
- Must return exit code 0 for success, non-zero to block operation
- Should handle missing dependencies gracefully
- Must be non-interactive (no user prompts)

## Best Practices

1. **Non-blocking design**: Hooks should enhance workflow, not interrupt it
2. **Graceful degradation**: Handle missing tools/dependencies without errors
3. **Comprehensive logging**: Log both successes and failures for debugging
4. **Performance awareness**: Keep hooks lightweight for responsive operation
5. **Security conscious**: Validate inputs and avoid executing arbitrary code

## Troubleshooting

### Common Issues

- **Permission errors**: Ensure hook scripts are executable
- **Missing dependencies**: Install formatters (black, prettier, shfmt) for full functionality
- **Log directory issues**: Hooks automatically create `.claude/logs/` if missing
- **Cooldown confusion**: refresh-rules.sh intentionally limits refreshes to every 15 minutes

### Debugging

Check log files in `.claude/logs/` for detailed hook execution information and any error messages.