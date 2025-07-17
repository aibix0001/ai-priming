# Rule: git-advanced-rules

## Description
Advanced Git workflow guidelines for Claude Code, covering worktree management, subagent coordination, and complex parallel work scenarios.

## Prerequisites
- Git installed (version 2.20 or higher recommended)
- Familiarity with basic Git workflows
- Understanding of Git worktrees
- Multiple parallel tasks or complex project structure

## Extends
- Base: /CLAUDE.md
- Rule: /ai-rules/git-rules.md

## Steps

### 1. Worktree Setup
- Use `git worktree add <path> -b <branch>` for parallel work
- Create separate directory for each worktree
- Assign dedicated branch to each worktree
- List all worktrees with `git worktree list`

### 2. Working Context Validation
- Always validate working context before git operations
- Use validation sequence to confirm location and branch
- Stop and request guidance if validation fails
- Never proceed without successful validation

### 3. Parallel Work Management
- Use separate worktrees for parallel tasks
- Coordinate merges to avoid conflicts
- Report status independently for each task
- Isolate failures to prevent cascade effects

### 4. Directory Management
- Always use absolute paths in commands
- Verify working directory with `pwd`
- Confirm repository context with `git rev-parse --show-toplevel`
- Check branch context with `git branch --show-current`

### 5. Advanced Git Features
- Use `git stash` for temporary work management
- Implement Git hooks for automation
- Set up useful Git aliases
- Maintain appropriate Git configuration

## Configuration

### Files Created
- `.git/worktrees/*` - Worktree metadata
- `.git/hooks/*` - Optional Git hooks for automation

### Files Modified
- `.git/config` - Worktree and advanced configuration
- `.claude-commands.memory` - Add git-advanced-rules.md to initialization list

## Post-Setup
1. Verify worktree setup: `git worktree list`
2. Test validation sequences in each worktree
3. Confirm isolation between worktrees
4. Validate parallel work capabilities

## Worktree Management

### Worktree Creation
```bash
# Create worktree with new branch
git worktree add /absolute/path/to/worktree -b feature/branch-name

# Create worktree from existing branch
git worktree add /absolute/path/to/worktree existing-branch

# List all worktrees
git worktree list
```

### Worktree Best Practices
- One worktree per major feature or parallel task
- Use descriptive paths that match branch names
- Keep worktrees organized in dedicated directory
- Clean up unused worktrees with `git worktree remove`

## Validation Templates

### Working Context Validation
**MANDATORY before ANY git operation:**

```bash
# Required validation sequence
echo "Current directory: $(pwd)"
echo "Current branch: $(git branch --show-current)"
echo "Repository root: $(git rev-parse --show-toplevel)"
git status --short
```

### Pre-Operation Safety Check
**Run before any git operation that modifies files:**

```bash
echo "=== PRE-OPERATION SAFETY CHECK ==="
echo "Current directory: $(pwd)"
echo "Current branch: $(git branch --show-current)"
echo "Repository status:"
git status --short

# Verify not on main branch (unless authorized)
if [ "$(git branch --show-current)" = "main" ]; then
    echo "⚠️  WARNING: Operating on main branch - requires explicit authorization"
fi

# Check for uncommitted changes
if [ -n "$(git status --porcelain)" ]; then
    echo "⚠️  WARNING: Uncommitted changes detected"
    git status --short
fi
```

## Subagent Coordination

### Isolation Requirements
- Each subagent must work in isolated worktree
- Validate location before ANY file operations
- Report working context transparently
- Prevent errors from affecting other worktrees

### Working Directory Protocol
1. Receive explicit path assignment
2. Execute `cd <assigned-path>` as first action
3. Validate location with required commands
4. Report validation results
5. ONLY proceed if validation confirms correct location

### Forbidden Operations
Subagents must NEVER:
- Operate on main branch unless explicitly authorized
- Modify files outside assigned worktree
- Skip validation steps
- Assume working directory context

## Parallel Work Safeguards

### Main Branch Protection
- Main branch modifications require explicit user approval
- Use feature branches for all development work
- Merge only after review and approval

### Conflict Prevention
- Use separate branches for parallel work
- Coordinate merge timing
- Communicate changes between parallel workers
- Test integration before final merge

### Status Reporting
- Each parallel worker reports independently
- Include branch and worktree in status updates
- Flag potential conflicts early
- Maintain clear audit trail

## Advanced Git Configuration

### Useful Aliases
```bash
# Add to .git/config or ~/.gitconfig
[alias]
    st = status --short
    co = checkout
    br = branch
    ci = commit
    unstage = reset HEAD --
    last = log -1 HEAD
    visual = !gitk
```

### Git Hooks
- Pre-commit: Code quality checks
- Commit-msg: Enforce message format
- Pre-push: Run tests before pushing
- Post-checkout: Environment setup

### Performance Optimization
- Use `git gc` for repository maintenance
- Configure `git config core.preloadindex true`
- Enable `git config core.fscache true` on Windows
- Adjust `git config core.packedGitLimit` for large repos

## Memory Integration

After using this rule, Claude must:

- **1.** Check if `.claude-commands.memory` file exists - if not, create it with initial content:
```
## read these files upon initialization

```

- **2.** Check if `- /ai-rules/git-advanced-rules.md` is listed under section `## read these files upon initialization` in `.claude-commands.memory`
- **3.** If not listed: add `- /ai-rules/git-advanced-rules.md` to list under section `## read these files upon initialization` in `.claude-commands.memory`