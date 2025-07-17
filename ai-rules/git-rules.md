# Rule: git-rules

## Description
Core Git workflow guidelines and best practices for Claude Code, covering repository management, branching strategies, commit practices, and collaboration workflows.

## Prerequisites
- Git installed (version 2.20 or higher recommended)
- Basic understanding of version control concepts
- Repository initialized or ready to be initialized
- User identity configured (git config user.name and user.email)

## Extends
- Base: /CLAUDE.md

## Steps

### 1. Repository Setup
- Check if git repository exists before any git operations
- Initialize with `git init` if no repository exists
- Configure origin and upstream remotes appropriately
- Create `.gitignore` file with language-appropriate patterns

### 2. Branching Strategy
- Treat main/master branch as protected and stable
- Only create branches when explicitly requested by user
- Use descriptive branch names with conventional prefixes (feature/, fix/, etc.)
- Each branch must represent one cohesive feature or fix

### 3. Commit Management
- Make atomic commits representing single logical changes
- Write meaningful commit messages following project conventions
- Use conventional commit format for new projects (feat:, fix:, docs:, etc.)
- Review changes before committing

### 4. Collaboration Workflow
- Use feature branch workflow for team collaboration
- Prepare clear pull request descriptions
- Sync regularly with main branch
- Link work to issues when applicable

### 5. Basic Git Operations
- Always `git pull` when starting a new session
- Use `git status` to understand current state
- Resolve merge conflicts carefully
- Never delete feature branches after merging

## Configuration

### Files Created
- `.gitignore` - Repository-specific ignore patterns
- `.git/config` - Local repository configuration (created by git init)

### Files Modified
- `.claude-commands.memory` - Add git-rules.md to initialization list
- Project files - As part of normal development workflow

## Post-Setup
1. Verify Git configuration: `git config --list`
2. Check repository status: `git status`
3. Validate remote connections: `git remote -v`
4. Test branch operations: `git branch -a`

## Branching Best Practices

### Branch Creation Guidelines
- **Branch suggestion trigger**: Suggest creating a new branch when:
  - Task shifts to a different system/context
  - Current changes would conflict with existing branch purpose
  - User requests a new feature while working on another
  - Work scope significantly expands beyond original intent
- **Suggestion format**: "This seems like a different feature/context. Should I create a new branch for this work?"
- **Naming convention**:
  - Feature branches: `feature/description` or `feat/description`
  - Bug fixes: `fix/description` or `bugfix/description`
  - Hotfixes: `hotfix/description`
  - Release branches: `release/version`

### Branch Management
- Stay on current branch unless user approves switch
- Include issue numbers in branch names when applicable (e.g., `feature/123-implement-login`)
- Follow project-specific work authorization requirements

## Commit Best Practices

### Commit Message Format
- Keep subject line under 50 characters
- Wrap body text at 72 characters
- Follow existing project conventions
- For new projects, use conventional commits:
  - `feat:` - New features
  - `fix:` - Bug fixes
  - `docs:` - Documentation changes
  - `style:` - Code style changes
  - `refactor:` - Code refactoring
  - `test:` - Adding or modifying tests
  - `chore:` - Maintenance tasks

### Commit Guidelines
- Review changes before committing
- Clearly indicate breaking changes
- Make commits that tell a story when reading the log

## Merge and Collaboration

### Merge Strategy
- Use merge for feature integration to main branch
- Use rebase for cleaning up feature branch history
- Prefer fast-forward merges when possible
- Only merge when user explicitly approves
- Never delete feature branches - keep for reference

### Conflict Resolution
- Resolve conflicts carefully, understanding both sides
- Test after conflict resolution
- Document resolution rationale in commit message

## .gitignore Management

### Standard Patterns
Include patterns for:
- Build artifacts and dependencies
- IDE and editor files
- Operating system files
- Log files and temporary files
- Environment files (.env)

### Maintenance
- Keep .gitignore updated as project evolves
- Review and test patterns regularly
- Use language-specific templates as starting point

## Security Considerations

### Credential Management
- Never commit secrets, tokens, or credentials
- Ensure .env files are in .gitignore
- Use SSH keys for authentication
- Configure credential helpers appropriately

### Access Control
- Follow principle of least privilege
- Set up commit signing for verified commits
- Review repository access permissions regularly

## Memory Integration

After using this rule, Claude must:

- **1.** Check if `.claude-commands.memory` file exists - if not, create it with initial content:
```
## read these files upon initialization

```

- **2.** Check if `- /ai-rules/git-rules.md` is listed under section `## read these files upon initialization` in `.claude-commands.memory`
- **3.** If not listed: add `- /ai-rules/git-rules.md` to list under section `## read these files upon initialization` in `.claude-commands.memory`