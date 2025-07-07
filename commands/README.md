# Claude Commands

This directory contains reusable command templates for Claude Code to help set up and manage different types of projects.

## How Commands Work

Commands are markdown files that provide structured instructions for Claude to execute specific workflows. When a user runs a command (e.g., `/init nodejs`), Claude will:

1. Look for the corresponding command file (e.g., `init-nodejs.md`)
2. Parse the instructions and requirements
3. Execute the workflow step by step
4. Apply project-specific configurations

## Command Structure

Each command file should follow this structure:

```markdown
# Command: [command-name]

## Description
Brief description of what this command does

## Prerequisites
- List of requirements before running this command
- E.g., "Empty directory" or "Node.js installed"

## Steps
1. Step-by-step instructions
2. Each step should be atomic and verifiable
3. Include validation checks

## Configuration
### Files Created
- List of files that will be created

### Files Modified  
- List of files that will be modified

## Post-Setup
Instructions or commands to run after setup
```

## Available Commands

### Project Initialization
- `init-nodejs.md` - Initialize a Node.js project
- `init-python.md` - Initialize a Python project
- `init-rust.md` - Initialize a Rust project
- `init-react.md` - Initialize a React application
- `init-nextjs.md` - Initialize a Next.js application

### Development Workflows
- `add-testing.md` - Add testing framework to existing project
- `add-linting.md` - Set up linting and formatting
- `add-ci.md` - Configure continuous integration

### Utility Commands
- `analyze-deps.md` - Analyze and update dependencies
- `security-audit.md` - Run security audits
- `performance-check.md` - Analyze performance bottlenecks

## Creating New Commands

When creating a new command:

1. Follow the naming convention: `action-target.md`
2. Make commands idempotent (safe to run multiple times)
3. Include error handling and rollback instructions
4. Test the command in different scenarios
5. Document all assumptions and side effects

## Command Inheritance

Commands can reference other commands or the base CLAUDE.md:

```markdown
## Extends
- Base: /CLAUDE.md
- Command: /add-linting.md
```

This allows commands to build upon existing configurations without duplication.

## Best Practices

1. **Keep commands focused** - One command should do one thing well
2. **Make them composable** - Commands should work together
3. **Validate inputs** - Check prerequisites before making changes
4. **Provide feedback** - Show progress and explain what's happening
5. **Handle errors gracefully** - Anticipate common failure modes

## Testing Commands

Before adding a new command:

1. Test in an empty directory
2. Test in a partially configured project
3. Test running the command multiple times
4. Document edge cases and limitations