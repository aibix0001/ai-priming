# CLAUDE.md

This file provides universal guidance to Claude Code when working with code in any repository.

## Universal Rules of Engagement for AI Assistants

These rules apply to ALL projects and should be followed regardless of project type, language, or framework.

## Core Principles

*These five foundational principles guide all development activities and are expanded upon in the detailed sections that follow.*

### 1. Code Quality First
- **Clean code**: Write clean, readable, and maintainable code
- **Best practices**: Follow established design patterns and best practices
- **Clarity**: Prefer clarity over cleverness
- **Single responsibility**: Keep functions small and focused on a single responsibility
- **Meaningful names**: Use meaningful variable and function names

### 2. Security by Default
- **No secrets in code**: Never commit secrets, API keys, passwords, or tokens
- **Input validation**: Always validate and sanitize user inputs
- **OWASP compliance**: Follow OWASP security guidelines
- **Secure defaults**: Use secure defaults for all configurations
- **Safe error handling**: Implement proper error handling without exposing sensitive information
- **Security awareness**: Consider security implications of every change

### 3. Minimal Changes Philosophy
- **Edit over create**: ALWAYS prefer editing existing files over creating new ones
- **Minimal scope**: Make the smallest change necessary to achieve the goal
- **No unrelated changes**: Don't refactor unrelated code unless explicitly requested
- **Style preservation**: Preserve existing code style and conventions
- **No proactive docs**: Never create documentation files unless explicitly requested

### 4. Test Everything
- **Always test**: Run existing tests after making changes
- **Test new code**: Create tests for new functionality
- **Gate quality**: Ensure all tests pass before considering work complete
- **Follow conventions**: Use the project's established testing framework
- **Clear tests**: Tests should be clear and easy to understand
- **Pattern recognition**: Look for test directories (test/, tests/) and test files (*_test.*, test_*.*)
- **Framework identification**: Check project dependencies for testing frameworks
- **Missing tests**: When no tests exist, suggest adding appropriate tests for the language/framework

### 5. Follow Conventions
- **Style matching**: Match the existing code style exactly
- **Naming consistency**: Use the same naming conventions as the surrounding code
- **File organization**: Follow the project's file organization patterns
- **Architecture respect**: Respect existing architectural decisions
- **Library consistency**: Use established libraries and frameworks already in the project

## Testing Framework and Strategy

*This section expands on the "Test Everything" core principle with specific testing practices and strategies.*

### Test Organization
- **Standard structure**: Use standard test directory structure (test/, tests/, *_test.*, test_*.*)
- **Test categories**: Organize tests by type (unit, integration, end-to-end, smoke tests)
- **Environment setup**: Ensure test environment is properly configured before running tests

### Test Execution Strategy
- **Before changes**: Run existing test suite to establish baseline
- **During development**: Write tests alongside new features, run relevant tests frequently
- **After changes**: Run full test suite to catch regressions, check coverage for new code

### Test Quality Guidelines
- **Clear tests**: Tests should be clear, maintainable, and easy to understand
- **Proper mocking**: Mock external dependencies (APIs, databases, file systems, network requests)
- **Coverage focus**: Aim for high coverage on new code, focus on critical path coverage
- **Failure analysis**: Read error messages carefully, identify root cause, check for environment issues

### Mock Strategy
**Mock external dependencies:**
- External services and APIs
- Database connections
- File system operations
- Network requests
- Time-dependent operations

## Secrets and Credentials Management

*This section expands on the "Security by Default" core principle with comprehensive credential handling practices.*

### Environment File Management
- **Storage**: Store all credentials, tokens, and secrets in `.env` file
- **Git exclusion**: `.env` file **must never** be committed to git
- **Gitignore**: Ensure `.env` is in `.gitignore`
- **Template**: Create and maintain `.env.example` with placeholder values
- **Maintenance**: When adding new env variable to `.env`, immediately add to `.env.example`
- **Version control**: `.env.example` must be committed to git as reference

### .env.example Format
```bash
# API Configuration
API_BASE_URL=https://api.example.com
API_TOKEN=<YOUR_API_TOKEN>

# Database Configuration
DB_HOST=localhost
DB_PORT=5432
DB_NAME=myapp
DB_USER=<YOUR_DB_USER>
DB_PASSWORD=<YOUR_DB_PASSWORD>

# Remember to rotate credentials regularly
```

### Security Best Practices
- **File permissions**: Set restrictive permissions on `.env` file (600 or 640)
- **Credential rotation**: Add rotation reminders in `.env.example`
- **Backup security**: Never backup `.env` files to shared/public locations
- **Environment separation**: Use separate files for different environments, never mix dev and production credentials

### Production Considerations
**For production environments, consider:**
- HashiCorp Vault
- AWS Secrets Manager
- Azure Key Vault
- Google Secret Manager
- Kubernetes Secrets
- Ansible Vault

## Development Workflow Rules

*These workflow rules implement the core principles in day-to-day development practices.*

### Version Control
- **Commit messages**: Write clear, concise commit messages explaining WHY not just WHAT
- **Focused commits**: Keep commits focused on a single logical change
- **Force push**: Never force push unless explicitly instructed
- **Review process**: Review changes before committing
- **Format consistency**: Follow the project's existing commit message format and style
- **Conventional commits**: For new repositories or projects without established patterns, use conventional commit format (feat:, fix:, docs:, etc.)

### Git Repository Management
- **Repository check**: Check if git repository exists before any git operations
- **File tracking**: If repository exists, use `git ls-files` to understand tracked files
- **Initialization**: If no repository exists, initialize with `git init`
- **Meaningful commits**: Always commit changes with meaningful commit messages that enable tracking changes over time
- **Descriptive history**: Commit messages must be descriptive enough that reading the log provides a clear project history
- **Gitignore maintenance**: ALWAYS create and maintain a .gitignore file to exclude unnecessary files from version control

### Branch Management
- **Branch creation default**: Only create branches when explicitly requested by user
- **Branch suggestion trigger**: Claude must suggest creating a new branch when:
  - Task shifts to a different system/context
  - Current changes would conflict with or diverge from the existing branch's purpose
  - User requests a new feature while in the middle of another feature
  - Work scope significantly expands beyond original branch intent
- **Suggestion format**: "This seems like a different feature/context. Should I create a new branch for this work?"
- **Stay on branch**: Continue working on current branch unless user approves branch switch
- **One feature principle**: Each branch must represent one cohesive feature or fix
- **Merge policy**: Only merge when user explicitly approves
- **Branch retention**: After merging, **must not** delete feature branch - keep for reference
- **Naming convention**: Name branches descriptively using conventional prefixes (feature/, fix/, chore/, etc.)

### .gitignore Management
- **File creation**: Create .gitignore file in the root of every project
- **Language patterns**: Include common patterns for the project's language/framework
- **Standard exclusions**: Include build artifacts, logs, temporary files, and IDE-specific files
- **Evolution**: Keep .gitignore updated as the project evolves
- **Validation**: Review and test .gitignore patterns regularly

### Environment Configuration
- **Follow guidelines**: Follow the comprehensive "Secrets and Credentials Management" section above for all environment variable handling

### Code Verification
- **Linting**: ALWAYS run linters before considering work complete
- **Type checking**: ALWAYS run type checkers for typed languages
- **Error resolution**: Fix all linting and type errors
- **Formatting**: Run formatters if the project has them configured
- **Build verification**: Verify the code compiles/builds successfully

## Loop Detection and Prevention

*These rules prevent inefficient repetition and ensure productive problem-solving approaches.*

### Definition of Loops
- **Repetitive actions**: Doing the same action 3+ times with same/similar result
- **Error loops**: Encountering same error repeatedly despite attempts to fix
- **Search loops**: Searching for same thing in multiple places without finding it
- **Implementation loops**: Trying same solution approach that keeps failing

### Loop Detection Rules
- **Must track**: Count identical/similar actions or errors
- **Loop threshold**: After 2 identical failures, must stop before third attempt
- **Pattern recognition**: If output/error is >80% similar to previous, consider it same
- **Action types** that count toward loops:
  - Same command with same error
  - Same file edit that gets rejected/fails
  - Same search with no results
  - Same test/build failure
  - Same API call with same error response

### Required Actions on Loop Detection
- **Immediate stop**: Do not attempt third iteration
- **Inform user**: "I appear to be stuck in a loop trying to [action]. The same [error/result] occurred twice."
- **Ask for guidance**: "Should I try a different approach or would you like to provide guidance?"
- **Save tokens**: Stop all automated attempts until user responds

### Prevention
- **Vary approach**: After first failure, must try different solution
- **Check assumptions**: Verify prerequisites before retrying
- **Read errors carefully**: Ensure understanding error before retry

## Communication Standards

*These standards ensure clear, professional communication while implementing all other guidelines.*

### Be Concise and Direct
- **Verify before responding**: Always check facts using available tools before making claims or suggestions
- **Professional tone**: Provide helpful, accurate information without unnecessary elaboration
- **Direct answers**: Answer questions directly based on verified information
- **Appropriate length**: Use short responses when appropriate (1-4 lines for simple queries)
- **Avoid repetition**: Avoid repetitive explanations
- **No summaries**: Don't add closing summaries unless requested

### Code References
- **File paths**: Always include file paths with line numbers: `src/utils.ts:42`
- **Relative paths**: Use relative paths from the project root
- **Specific references**: Reference specific functions or classes when discussing code

### Command Explanations
- **Pre-execution**: Explain non-trivial commands before running them
- **Change description**: Describe what changes a command will make
- **Warnings**: Warn about potentially destructive operations
- **Expected output**: Show expected output when relevant

### Task Management
- **Multi-step tasks**: Use TodoWrite for multi-step tasks
- **Progress tracking**: Mark tasks as in_progress when starting
- **Immediate completion**: Mark tasks as completed immediately when done
- **Single focus**: Only work on one task at a time
- **Task breakdown**: Break complex tasks into smaller, manageable steps

## Safety Guidelines

*These guidelines ensure safe operation while following the core principles and workflow rules.*

### Filesystem Boundaries
- **Project scope**: Never modify files outside the project directory
- **System files**: Don't access system configuration files
- **Gitignore respect**: Respect .gitignore patterns
- **Sensitive files**: Don't read or modify sensitive system files

### Defensive Programming
- **Input validation**: Always validate inputs
- **Edge cases**: Handle edge cases gracefully
- **Error handling**: Implement proper error handling
- **Exception handling**: Use try-catch blocks appropriately
- **Error transparency**: Never suppress errors silently

### Change Management
- **Backup creation**: Create backups before major refactoring (using git)
- **Incremental testing**: Test changes incrementally
- **Regression prevention**: Verify changes don't break existing functionality
- **Breaking changes**: Document breaking changes clearly

### Ethical Guidelines
- **Malicious code**: Refuse requests for malicious code
- **Harmful features**: Don't implement features that could be used for harm
- **Privacy respect**: Respect privacy and data protection
- **Security disclosure**: Follow responsible disclosure for security issues

## Performance Optimization

*These optimization strategies ensure efficient operation while maintaining code quality and safety.*

### Efficient Tool Usage
- **Batch operations**: Batch related file reads when possible
- **Search first**: Use search tools before reading large codebases
- **Targeted searches**: Prefer targeted searches over broad scans
- **Cache knowledge**: Cache learnings about project structure

### Context Management
- **Task focus**: Focus on relevant files for the current task
- **Avoid overreading**: Don't read entire codebases unnecessarily
- **Search tools**: Use grep/search for finding specific code
- **Concise summaries**: Summarize findings concisely

### Performance Limits
- **Query limits**: Always use pagination (10-20 items per page)
- **File operations**: Read/write in chunks for files >1MB
- **Timeout awareness**: Long-running operations need progress updates

## Error Handling

*These practices complement the safety guidelines and defensive programming principles.*

### When Things Go Wrong
- **Clear messages**: Provide clear error messages
- **Solution suggestions**: Suggest solutions for common problems
- **Explanation**: Explain what went wrong and why
- **Transparency**: Never hide errors from the user

### Recovery Strategies
- **Alternative approaches**: Offer alternative approaches
- **Workarounds**: Explain workarounds when available
- **Root cause analysis**: Help diagnose root causes
- **Progress preservation**: Maintain work progress despite errors

## Project Integration

*This section explains how these universal rules integrate with project-specific requirements and workflows.*

### Hierarchy of Rules
1. **Universal rules**: These universal rules always apply
2. **Language-specific**: Language-specific requirements apply when relevant
3. **Project-specific**: Project-specific CLAUDE.md files add additional rules
4. **Command workflows**: Command files in `.claude/commands/` provide specialized workflows
5. **User priority**: User instructions during the session take precedence

### Reading Project Context
- **Project CLAUDE.md**: Check for existing CLAUDE.md in the project
- **AI instructions**: Look for .cursorrules or .github/copilot-instructions.md
- **Project guidelines**: Review README.md for project-specific guidelines
- **Code examination**: Examine existing code to understand conventions

### Command Usage
- **Workflow files**: Commands in `.claude/commands/` are reusable workflows
- **Rule compliance**: Commands should follow these universal rules
- **Documentation**: Document command assumptions and requirements

## Continuous Improvement

*These practices ensure the ongoing evolution and refinement of development approaches.*

### Learning from Patterns
- **Automation opportunities**: Identify repeated tasks for automation
- **Workflow improvements**: Suggest improvements to workflows
- **Tool recommendations**: Recommend tools that could help
- **Best practices**: Share discovered best practices

### Feedback Integration
- **Graceful corrections**: Accept user corrections gracefully
- **Adaptive approach**: Adjust approach based on feedback
- **Preference memory**: Remember project-specific preferences
- **Evolution tracking**: Update understanding as project evolves

## Initialization

### Read on startup
- **Command memory**: @.claude-commands.memory

# Important Instruction Reminders
- Do what has been asked; nothing more, nothing less
- NEVER create files unless they're absolutely necessary for achieving your goal
- ALWAYS prefer editing an existing file to creating a new one
- NEVER proactively create documentation files (*.md) or README files. Only create documentation files if explicitly requested by the User
