# Rule: git-rules

## Description
Comprehensive Git workflow guidelines and best practices for Claude Code, covering repository management, branching strategies, commit practices, and collaboration workflows.

## Prerequisites
- Git installed (version 2.20 or higher recommended)
- Basic understanding of version control concepts
- Repository initialized or ready to be initialized
- User identity configured (git config user.name and user.email)

## Steps

### 1. Repository Management
- **Repository check**: Check if git repository exists before any git operations
- **Session initialization**: When starting a new session, always `git pull` to stay current and avoid conflicts down the line
- **File tracking**: If repository exists, use `git ls-files` to understand tracked files
- **Initialization**: If no repository exists, initialize with `git init`
- **Remote setup**: Configure origin and upstream remotes appropriately
- **Repository health**: Perform regular maintenance with `git gc` and `git fsck`

### 2. Branching Strategy
- **Main branch protection**: Treat main/master branch as protected and stable
- **Branch creation default**: Only create branches when explicitly requested by user
- **Branch suggestion trigger**: Claude must suggest creating a new branch when:
  - Task shifts to a different system/context
  - Current changes would conflict with or diverge from the existing branch's purpose
  - User requests a new feature while in the middle of another feature
  - Work scope significantly expands beyond original branch intent
- **Suggestion format**: "This seems like a different feature/context. Should I create a new branch for this work?"
- **Stay on branch**: Continue working on current branch unless user approves branch switch
- **One feature principle**: Each branch must represent one cohesive feature or fix
- **Naming convention**: Name branches descriptively using conventional prefixes:
  - Feature branches: `feature/description` or `feat/description`
  - Bug fixes: `fix/description` or `bugfix/description`
  - Hotfixes: `hotfix/description`
  - Release branches: `release/version`
  - Maintenance branches: `maint/description`

### 3. Commit Management
- **Atomic commits**: Each commit should represent a single logical change
- **Meaningful commits**: Always commit changes with meaningful commit messages that enable tracking changes over time
- **Descriptive history**: Commit messages must be descriptive enough that reading the log provides a clear project history
- **Format consistency**: Follow the project's existing commit message format and style
- **Conventional commits**: For new repositories or projects without established patterns, use conventional commit format:
  - `feat:` - New features
  - `fix:` - Bug fixes
  - `docs:` - Documentation changes
  - `style:` - Code style changes (formatting, missing semi-colons, etc.)
  - `refactor:` - Code refactoring
  - `test:` - Adding or modifying tests
  - `chore:` - Maintenance tasks
- **Subject line**: Keep subject line under 50 characters
- **Body formatting**: Wrap body text at 72 characters
- **Breaking changes**: Clearly indicate breaking changes in commit messages
- **Review process**: Review changes before committing

### 4. Merge and Rebase Operations
- **Merge vs rebase decision**: 
  - Use merge for feature integration to main branch
  - Use rebase for cleaning up feature branch history
  - Use rebase for staying current with main branch
- **Fast-forward preference**: Use fast-forward merges when possible to maintain linear history
- **Conflict resolution**: 
  - Resolve conflicts carefully, understanding both sides
  - Test after conflict resolution
  - Document resolution rationale in commit message
- **Interactive rebase**: Use for cleaning up commit history before merging
- **Merge policy**: Only merge when user explicitly approves
- **Branch retention**: After merging, **must not** delete feature branch - keep for reference

### 5. Collaboration Workflows
- **Feature branch workflow**: Default workflow for team collaboration
- **Code review preparation**: Ensure commits are clean and well-documented
- **Synchronization**: Regularly sync with team branches and main branch
- **Pull request preparation**: Prepare clear descriptions and context
- **Shared repository**: Follow agreed-upon team workflows and conventions

### 6. Advanced Git Features
- **Stashing**: Use `git stash` for temporary work management
- **Worktree usage**: Use worktrees for parallel work on different branches
- **Git hooks**: Implement hooks for automation and quality checks
- **Aliases**: Set up useful Git aliases for common operations
- **Configuration**: Maintain appropriate local and global Git configuration

## Configuration

### Files Created
- `.gitignore` - Repository-specific ignore patterns
- `.git/config` - Local repository configuration
- `.git/hooks/*` - Optional Git hooks for automation

### Files Modified
- `README.md` - May be updated with Git workflow documentation
- Project files - As part of normal development workflow
- `.claude-commands.memory` - Add git-rules.md to initialization list

### .gitignore Management
- **File creation**: Create .gitignore file in the root of every project
- **Language patterns**: Include common patterns for the project's language/framework
- **Standard exclusions**: Include build artifacts, logs, temporary files, and IDE-specific files
- **Evolution**: Keep .gitignore updated as the project evolves
- **Validation**: Review and test .gitignore patterns regularly

### Security and Credential Management
- **SSH key setup**: Configure SSH keys for secure authentication
- **GPG signing**: Set up commit signing for verified commits
- **Credential helpers**: Configure appropriate credential helpers
- **Secret prevention**: Never commit secrets, tokens, or credentials
- **Access control**: Follow principle of least privilege

## Post-Setup
After applying Git rules:
1. Verify Git configuration: `git config --list`
2. Check repository status: `git status`
3. Validate remote connections: `git remote -v`
4. Test branch operations: `git branch -a`
5. Confirm commit signing (if configured): `git log --show-signature`

## Memory Integration

After using this rule, Claude must:

- **1.** Check if `.claude-commands.memory` file exists - if not, create it with initial content:
```
## read these files upon initialization

```

- **2.** Check if `- @ai-rules/git.md` is listed under section `## read these files upon initialization` in `.claude-commands.memory`
- **3.** If not listed: add `- @ai-rules/git.md` to list under section `## read these files upon initialization` in `.claude-commands.memory`