# Claude Commands

This directory contains specialized workflow commands for Claude Code to help with infrastructure management, development workflows, and operational tasks.

## How Commands Work

Commands are markdown files that provide structured instructions and best practices for Claude to follow when working with specific technologies or workflows. These commands contain:

1. Technology-specific guidelines and conventions
2. Security best practices and requirements
3. Workflow templates and common patterns
4. Configuration standards and examples

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

### Infrastructure & Automation
- `ansible.md` - Ansible automation workflows and playbook management
- `netbox.md` - NetBox network documentation and device management
- `vyos.md` - VyOS network device configuration and management

### Development & Testing
- `python.md` - Python development workflows and best practices
- `testing.md` - Testing framework setup and configuration guidelines

### Security & Operations
- `secrets.md` - Secrets management and security best practices

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