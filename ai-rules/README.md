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
- `ansible-rules.md` - Ansible automation workflows and playbook management
- `netbox-rules.md` - NetBox network documentation and device management
- `vyos-rules.md` - VyOS network device configuration and management

### Development & Testing
- `python-rules.md` - Python development workflows and best practices
- `typescript-rules.md` - TypeScript development workflows and best practices

### Version Control
- `git-rules.md` - Core Git workflow guidelines and best practices
- `git-advanced-rules.md` - Advanced Git features (worktrees, subagent coordination)
- `gitlab-rules.md` - GitLab platform integration via glab CLI

*Note: Testing framework guidelines and secrets management best practices are now incorporated into the main CLAUDE.md file under "Testing Framework and Strategy" and "Secrets and Credentials Management" sections respectively.*

## Creating New Rules

When creating a new rule:

1. Follow the naming convention: `technology-rules.md` or `workflow-rules.md`
2. Make rules idempotent (safe to apply multiple times)
3. Include error handling and rollback instructions
4. Test the rule in different scenarios
5. Document all assumptions and side effects

## Rule Inheritance

Rules can reference other rules or the base CLAUDE.md:

```markdown
## Extends
- Base: /CLAUDE.md
- Rule: /ai-rules/python-rules.md
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

## Path Reference Convention

All rule references should use absolute paths from the project root:
- ✅ Correct: `/ai-rules/python-rules.md`
- ❌ Incorrect: `@ai-rules/python-rules.md` or `python-rules.md`

This ensures consistency across all rules and prevents path resolution issues.

## When to Use Rule Inheritance

Use the `## Extends` section when:
- Your rule builds upon another rule's functionality
- You need prerequisites from another rule
- You want to avoid duplicating common patterns

Example scenarios:
- `gitlab-rules.md` extends `git-rules.md` (GitLab requires Git)
- `git-advanced-rules.md` extends `git-rules.md` (advanced features need basics)
- All rules extend `/CLAUDE.md` (universal principles apply)

## How Rules Interact with CLAUDE.md

CLAUDE.md provides universal principles that all rules follow:
- **Core Principles**: Code quality, security, minimal changes, testing, conventions
- **Common Sections**: Testing strategy, secrets management, error handling

Rules should:
- Reference CLAUDE.md sections instead of duplicating content
- Add only technology-specific implementations
- Follow the same structure and naming conventions

## Common Rule Combinations

Frequently used together:
- **Web Development**: `typescript-rules.md` + `git-rules.md`
- **Infrastructure**: `ansible-rules.md` + `vyos-rules.md` + `netbox-rules.md`
- **Python Projects**: `python-rules.md` + `git-rules.md`
- **GitLab Workflow**: `git-rules.md` + `gitlab-rules.md`

## Troubleshooting Rule Conflicts

If rules seem to conflict:
1. Check the `## Extends` hierarchy
2. More specific rules override general ones
3. User instructions override all rules
4. When in doubt, ask for clarification

Common issues:
- **Path conflicts**: Ensure consistent path references
- **Duplicate instructions**: Check if content should reference CLAUDE.md
- **Missing dependencies**: Verify all extended rules exist