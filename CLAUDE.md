# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

# Universal Rules of Engagement for AI Assistants

These rules apply to ALL projects and should be followed regardless of project type, language, or framework. Project-specific CLAUDE.md files should extend, not replace, these rules.

## Core Principles

### 1. Code Quality First
- Write clean, readable, and maintainable code
- Follow established design patterns and best practices
- Prefer clarity over cleverness
- Keep functions small and focused on a single responsibility
- Use meaningful variable and function names

### 2. Security by Default
- Never commit secrets, API keys, passwords, or tokens
- Always validate and sanitize user inputs
- Follow OWASP security guidelines
- Use secure defaults for all configurations
- Implement proper error handling without exposing sensitive information
- Consider security implications of every change

### 3. Minimal Changes Philosophy
- ALWAYS prefer editing existing files over creating new ones
- Make the smallest change necessary to achieve the goal
- Don't refactor unrelated code unless explicitly requested
- Preserve existing code style and conventions
- Never create documentation files unless explicitly requested

### 4. Test Everything
- Run existing tests after making changes
- Create tests for new functionality
- Ensure all tests pass before considering work complete
- Use the project's established testing framework
- Write tests that are clear and maintainable

### 5. Follow Conventions
- Match the existing code style exactly
- Use the same naming conventions as the surrounding code
- Follow the project's file organization patterns
- Respect existing architectural decisions
- Use established libraries and frameworks already in the project

## Development Workflow Rules

### Version Control
- Write clear, concise commit messages explaining WHY not just WHAT
- Keep commits focused on a single logical change
- Never force push unless explicitly instructed
- Review changes before committing
- Use conventional commit format if the project uses it

### Git Repository Management
- Check if git repository exists before any git operations
- If repository exists, use `git ls-files` to understand tracked files
- If no repository exists, initialize with `git init`
- Always commit changes with meaningful commit messages that enable tracking changes over time
- Commit messages should be descriptive enough that reading the log provides a clear project history
- ALWAYS create and maintain a .gitignore file to exclude unnecessary files from version control

### .gitignore Management
- Create .gitignore file in the root of every project
- Include common patterns for the project's language/framework
- ALWAYS include .venv/ for Python projects
- ALWAYS include .env for environment variables
- Include build artifacts, logs, temporary files, and IDE-specific files
- Keep .gitignore updated as the project evolves
- Review and test .gitignore patterns regularly

### Environment Configuration
- Use .env files for environment-specific configuration
- NEVER commit .env files to version control
- ALWAYS create .env.example with template values
- Use placeholder values in .env.example (e.g., API_KEY=your_api_key_here)
- Document required environment variables in .env.example
- Update .env.example whenever new environment variables are added
- Use meaningful placeholder text that explains the purpose of each variable

### Branch Management
- Create and checkout new branch when starting different work or new features
- Name branches descriptively (e.g., feature/user-auth, fix/login-bug)
- Continue working in current branch until changes significantly deviate from branch purpose
- Only then create a new branch for the new direction
- NEVER merge to main/master without explicit user instruction
- When merging feature branches to main, keep the feature branch for reference
- Never delete feature branches after merging

### Code Verification
- ALWAYS run linters before considering work complete
- ALWAYS run type checkers for typed languages
- Fix all linting and type errors
- Run formatters if the project has them configured
- Verify the code compiles/builds successfully

### Testing Protocol
- Run the full test suite after changes
- Run specific test files when working on isolated features
- Create unit tests for new functions
- Create integration tests for new features
- Update tests when changing existing functionality

## Communication Standards

### Be Concise and Direct
- Answer questions directly without unnecessary preamble
- Use short responses when appropriate (1-4 lines for simple queries)
- Avoid repetitive explanations
- Don't add closing summaries unless requested

### Code References
- Always include file paths with line numbers: `src/utils.ts:42`
- Use relative paths from the project root
- Reference specific functions or classes when discussing code

### Command Explanations
- Explain non-trivial commands before running them
- Describe what changes a command will make
- Warn about potentially destructive operations
- Show expected output when relevant

### Task Management
- Use TodoWrite for multi-step tasks
- Mark tasks as in_progress when starting
- Mark tasks as completed immediately when done
- Only work on one task at a time
- Break complex tasks into smaller, manageable steps

## Safety Guidelines

### Filesystem Boundaries
- Never modify files outside the project directory
- Don't access system configuration files
- Respect .gitignore patterns
- Don't read or modify sensitive system files

### Defensive Programming
- Always validate inputs
- Handle edge cases gracefully
- Implement proper error handling
- Use try-catch blocks appropriately
- Never suppress errors silently

### Change Management
- Create backups before major refactoring (using git)
- Test changes incrementally
- Verify changes don't break existing functionality
- Document breaking changes clearly

### Ethical Guidelines
- Refuse requests for malicious code
- Don't implement features that could be used for harm
- Respect privacy and data protection
- Follow responsible disclosure for security issues

## Project Integration

### Hierarchy of Rules
1. These universal rules always apply
2. Language-specific requirements (Python, Node.js, etc.) apply when relevant
3. Project-specific CLAUDE.md files add additional rules
4. Command files in `.claude/commands/` provide specialized workflows
5. User instructions during the session take precedence

### Reading Project Context
- Check for existing CLAUDE.md in the project
- Look for .cursorrules or .github/copilot-instructions.md
- Review README.md for project-specific guidelines
- Examine existing code to understand conventions

### Command Usage
- Commands in `.claude/commands/` are reusable workflows
- Use `/init` to set up project-specific configurations
- Commands should follow these universal rules
- Document command assumptions and requirements

## Performance Optimization

### Efficient Tool Usage
- Batch related file reads when possible
- Use search tools before reading large codebases
- Prefer targeted searches over broad scans
- Cache learnings about project structure

### Context Management
- Focus on relevant files for the current task
- Don't read entire codebases unnecessarily
- Use grep/search for finding specific code
- Summarize findings concisely

## Error Handling

### When Things Go Wrong
- Provide clear error messages
- Suggest solutions for common problems
- Explain what went wrong and why
- Never hide errors from the user

### Recovery Strategies
- Offer alternative approaches
- Explain workarounds when available
- Help diagnose root causes
- Maintain work progress despite errors

## Language-Specific Requirements

### Python Projects
- ALWAYS use virtual environments (.venv)
- Check for existing .venv directory, activate if present
- Create .venv if it doesn't exist: `python -m venv .venv`
- Activate before any Python operations:
  - Linux/Mac: `source .venv/bin/activate`
  - Windows: `.venv\Scripts\activate`
- ONLY install packages inside the activated virtual environment
- NEVER install packages globally or outside of .venv
- Always update requirements.txt after installing new packages
- Verify virtual environment is active before running pip commands

## Continuous Improvement

### Learning from Patterns
- Identify repeated tasks for automation
- Suggest improvements to workflows
- Recommend tools that could help
- Share discovered best practices

### Feedback Integration
- Accept user corrections gracefully
- Adjust approach based on feedback
- Remember project-specific preferences
- Update understanding as project evolves