# Claude Rules

This directory contains modular rule templates for Claude Code to help with infrastructure management, development workflows, and operational tasks. These rules can be called from command line or via init-commands.

## How Rules Work

Rules are markdown files that provide structured instructions and best practices for Claude to follow when working with specific technologies or workflows. These modular rules contain:

1. Technology-specific guidelines and conventions
2. Security best practices and requirements
3. Workflow templates and common patterns
4. Configuration standards and examples

## Command Structure

Each rule file should follow this structure:

```markdown
# Rule: [rule-name]

## Description
Brief description of what this rule provides

## Prerequisites
- List of requirements before applying this rule
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

## Available Rules

### Infrastructure & Automation
- `ansible.md` - Ansible automation workflows and playbook management
- `netbox.md` - NetBox network documentation and device management
- `vyos.md` - VyOS network device configuration and management

### Development & Testing
- `python.md` - Python development workflows and best practices

*Note: Testing framework guidelines and secrets management best practices are now incorporated into the main CLAUDE.md file under "Testing Framework and Strategy" and "Secrets and Credentials Management" sections respectively.*

## Creating New Rules

When creating a new rule:

1. Follow the naming convention: `technology.md` or `workflow.md`
2. Make rules idempotent (safe to apply multiple times)
3. Include error handling and rollback instructions
4. Test the rule in different scenarios
5. Document all assumptions and side effects

## Rule Inheritance

Rules can reference other rules or the base CLAUDE.md:

```markdown
## Extends
- Base: /CLAUDE.md
- Rule: /add-linting.md
```

This allows rules to build upon existing configurations without duplication.

## Best Practices

1. **Keep rules focused** - One rule should cover one technology/workflow well
2. **Make them composable** - Rules should work together
3. **Validate inputs** - Check prerequisites before making changes
4. **Provide feedback** - Show progress and explain what's happening
5. **Handle errors gracefully** - Anticipate common failure modes

## Testing Rules

Before adding a new rule:

1. Test in an empty directory
2. Test in a partially configured project
3. Test applying the rule multiple times
4. Document edge cases and limitations