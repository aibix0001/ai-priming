# Git Rules Blueprint Specification

## Overview
This document provides a comprehensive specification for creating a generic `git-rules.md` file that follows the established ai-rules structure from README.md.

## Purpose
The git-rules.md file will provide Claude Code with comprehensive Git workflow guidance, including branching strategies, commit practices, merge/rebase decisions, and collaboration patterns, while remaining platform-agnostic.

## Structure (Following README.md Template)

### Rule Header
```markdown
# Rule: git-rules

## Description
Comprehensive Git workflow guidelines and best practices for Claude Code, covering repository management, branching strategies, commit practices, and collaboration workflows.

## Prerequisites
- Git installed (version 2.20 or higher recommended)
- Basic understanding of version control concepts
- Repository initialized or ready to be initialized
- User identity configured (git config user.name and user.email)
```

### Core Sections to Include

#### 1. Repository Management
**Steps:**
- Repository initialization (`git init`)
- Remote repository setup and configuration
- Cloning existing repositories
- Remote management (origin, upstream)
- Repository health checks and maintenance

#### 2. Branching Strategy
**Steps:**
- Main branch protection and standards
- Feature branch creation and naming conventions
- Branch lifecycle management
- Branch switching and navigation
- Branch cleanup and deletion

#### 3. Commit Management
**Steps:**
- Atomic commit principles
- Commit message formatting standards
- Conventional commit patterns
- When to commit (frequency and timing)
- Commit amending and fixup strategies

#### 4. Merge and Rebase Operations
**Steps:**
- Merge vs rebase decision framework
- Fast-forward vs no-fast-forward merges
- Interactive rebase workflows
- Conflict resolution strategies
- History linearization techniques

#### 5. Collaboration Workflows
**Steps:**
- Feature branch workflow
- Gitflow workflow considerations
- Code review preparation
- Pull request preparation
- Synchronization with team branches

#### 6. Advanced Git Features
**Steps:**
- Git worktree usage patterns
- Stashing and temporary work management
- Git hooks integration
- Submodule management
- Git aliases and configuration

### Configuration Section
```markdown
## Configuration
### Files Created
- `.gitignore` - Repository-specific ignore patterns
- `.git/config` - Local repository configuration
- `.git/hooks/*` - Optional Git hooks for automation

### Files Modified
- `README.md` - May be updated with Git workflow documentation
- Project files - As part of normal development workflow
- `.claude-commands.memory` - Add git-rules.md to initialization list
```

### Post-Setup Section
```markdown
## Post-Setup
After applying Git rules:
1. Verify Git configuration: `git config --list`
2. Check repository status: `git status`
3. Validate remote connections: `git remote -v`
4. Test branch operations: `git branch -a`
5. Confirm commit signing (if configured): `git log --show-signature`
```

## Detailed Content Areas

### Repository Initialization Standards
- Directory structure requirements
- Initial commit practices
- README.md and documentation setup
- License file considerations
- .gitignore creation and maintenance

### Branch Naming Conventions
- Feature branches: `feature/description` or `feat/description`
- Bug fixes: `fix/description` or `bugfix/description`
- Hotfixes: `hotfix/description`
- Release branches: `release/version`
- Maintenance branches: `maint/description`

### Commit Message Standards
- Subject line format (50 character limit)
- Body formatting (72 character wrap)
- Footer conventions (references, co-authors)
- Conventional commit types (feat, fix, docs, style, refactor, test, chore)
- Breaking change indicators

### Merge Strategy Guidelines
- When to use merge vs rebase
- Squash merge considerations
- Merge commit message standards
- Branch protection requirements
- Conflict resolution workflows

### Collaboration Patterns
- Fork-based workflows
- Shared repository workflows
- Code review integration
- Continuous integration considerations
- Release management practices

### Security and Credential Management
- SSH key setup and management
- GPG signing configuration
- Credential helper configuration
- Secret scanning prevention
- .gitignore security patterns

### Worktree Management
- When to use worktrees vs branches
- Worktree creation and management
- Cleanup procedures
- Integration with development workflows
- Performance considerations

### Git Configuration Best Practices
- Global vs local configuration
- Essential configuration options
- Alias recommendations
- Editor and merge tool setup
- Performance optimization settings

## Integration Requirements

### Memory Integration
The git-rules.md file must include a memory integration section:
```markdown
## Memory Integration

After using this rule, Claude must:

- **1.** Check if `.claude-commands.memory` file exists - if not, create it with initial content:
```
## read these files upon initialization

```

- **2.** Check if `- @ai-rules/git.md` is listed under section `## read these files upon initialization` in `.claude-commands.memory`
- **3.** If not listed: add `- @ai-rules/git.md` to list under section `## read these files upon initialization` in `.claude-commands.memory`
```

### Integration with CLAUDE.md
The git-rules.md must transfer generic Git-related content already in CLAUDE.md to the new @ai-rules/git.md:
- Branch management rules (lines 135-155 in CLAUDE.md)
- Version control standards (lines 145-155 in CLAUDE.md)
- Commit message guidelines (lines 145-155 in CLAUDE.md)
- **CLAUDE.md maintenance** after extracting **generic** git-related content from CLAUDE.md transfer platform-specific git-rules to a tmp/platform-git.txt and remove all git-related content from CLAUDE.md 

## Blueprint Characteristics

### Platform Agnostic
- No references to GitLab, GitHub, or other Git platforms
- Generic Git commands only
- Avoid platform-specific terminology (MR vs PR)
- Focus on Git CLI operations

### Consistency with README.md Structure
- Follows exact template structure from README.md
- Maintains section ordering and naming
- Includes all required sections (Description, Prerequisites, Steps, Configuration, Post-Setup)
- Uses consistent markdown formatting

### Comprehensive Coverage
- Covers all major Git operations
- Includes both basic and advanced workflows
- Addresses common Git challenges
- Provides clear decision frameworks

### Security Focus
- Credential management best practices
- Secret prevention strategies
- Secure configuration recommendations
- Access control considerations

## Implementation Notes

### Scope Limitations
- Must NOT include platform-specific commands (glab, gh, etc.)
- Must NOT reference specific Git hosting services
- Must focus on Git CLI and workflows only

### Quality Standards
- Each step must be atomic and verifiable
- Include validation checks where appropriate
- Provide clear error handling guidance
- Maintain idempotent operations

### Testing Considerations
- Rules should be safe to apply multiple times
- Include rollback procedures for major changes
- Provide verification steps for each operation
- Document edge cases and limitations
