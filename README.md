# AI Priming

A comprehensive framework for establishing consistent AI assistant behavior across all software development projects through universal rules and reusable commands.

## Purpose

This repository serves as the single source of truth for AI assistant configuration, ensuring consistent, secure, and efficient development practices across all project types. It provides a hierarchical rule system where universal principles are extended by language-specific and project-specific requirements.

## Implemented Features

### ✅ Core Framework
- **Universal CLAUDE.md**: Comprehensive rules of engagement including:
  - Core principles (code quality, security, minimal changes, testing, conventions)
  - Integrated testing framework and strategy guidelines
  - Comprehensive secrets and credentials management
  - Development workflow rules with Git repository and branch management
  - Communication standards for concise, direct responses
  - Safety guidelines and ethical boundaries
  - Performance optimization strategies
  - Error handling and recovery strategies
  - Continuous improvement guidelines
  - Professional formatting with consistent structure and cross-references

### ✅ Version Control Rules
- Automatic Git repository detection and initialization
- Meaningful commit messages for tracking project history
- Feature branch workflow with protection for main branch
- Branch persistence after merging for reference
- Proper use of `git ls-files` for repository awareness

### ✅ Language-Specific Requirements
- **Python**: Mandatory virtual environment usage (.venv)
  - Automatic creation and activation
  - Package isolation (no global installations)
  - Requirements.txt maintenance
- **TypeScript**: Strict type safety and modern tooling
  - Always use tsconfig.json with strict settings
  - ESLint and Prettier integration
  - Proper build and test scripts in package.json
  - Type-first development approach

### ✅ Command Infrastructure
- `ai-rules/` directory with specialized workflows:
  - Ansible automation and playbook management
  - NetBox network documentation and management
  - Python development best practices
  - TypeScript development workflows
  - VyOS network device configuration
- Universal testing and secrets management integrated into main CLAUDE.md
- Command template documentation and best practices
- Support for reusable workflows
- Command inheritance system

### ✅ Setup Automation
- `setup.sh` script for automatic symlink creation
- Support for both global (~/.claude/) and per-project configurations
- Idempotent setup process (safe to run multiple times)

### ✅ Claude Hooks Integration
- Comprehensive hooks system for automation and safety
- Command logging and git operation validation
- File modification monitoring for important files
- Automatic code formatting when supported tools are available
- Rule refresh system with command memory tracking
- Periodic assistant context refresh based on used commands

## Repository Structure

```
ai-priming/
├── CLAUDE.md                 # Universal rules for all projects
├── settings.json            # Hooks configuration
├── hooks/                   # Hook scripts
│   ├── log-bash.sh          # Command logging
│   ├── validate-git.sh      # Git operation validation
│   ├── monitor-files.sh     # File change monitoring
│   ├── format-code.sh       # Auto-formatting
│   └── refresh-rules.sh     # Rule refresh system
├── ai-rules/                 # Modular rule templates
│   ├── README.md            # Rule documentation and template
│   ├── ansible.md           # Ansible automation workflows
│   ├── netbox.md            # NetBox management commands
│   ├── python.md            # Python development workflows
│   ├── typescript.md        # TypeScript development workflows
│   └── vyos.md              # VyOS configuration management
├── ai-docs/                  # On-demand documentation for assistant
│   ├── ansible-docs.md      # Ansible reference documentation
│   ├── mcp.md               # MCP protocol documentation
│   ├── netbox-docs.md       # NetBox API and usage docs
│   ├── python-docs.md       # Python best practices and references
│   ├── typescript-docs.md   # TypeScript and Node.js references
│   └── vyos-docs.md         # VyOS configuration references
├── ai-plans/                 # Collaborative development plans
├── setup.sh                 # Setup script for symlink creation
├── .gitignore               # Excludes local settings and credentials
└── README.md                # This file
```

## Rule Hierarchy

1. **Universal Rules** (root CLAUDE.md) - Always apply
2. **Language-Specific Rules** - Apply when using specific languages
3. **Project-Specific Rules** - Extend universal rules for individual projects
4. **Rule Templates** - Modular workflows in `ai-rules/`
5. **User Instructions** - Session-specific overrides

## Getting Started

### Setting Up a New Project

To use this AI priming framework in your project:

```bash
git clone https://github.com/aibix0001/ai-priming.git <your project folder>/.claude
```

This will create a `.claude` directory inside your project folder containing all the AI assistant configuration and rules. **This becomes the `.claude` folder for your new project**.

After cloning, you can:

1. Navigate to your project folder: `cd <your project folder>`
2. Start Claude Code: `claude`
3. Claude will automatically discover and use the configuration from the `.claude` directory
4. Extend with project-specific rules by creating `CLAUDE.local.md` in your project root
5. Add command-specific workflows as needed

The `.claude` directory provides the foundation for consistent AI assistant behavior across your entire project development lifecycle.

## Claude Hooks System

This repository includes a comprehensive hooks system that provides:

### Automated Logging
- **Command tracking**: All bash commands are logged with timestamps
- **File monitoring**: Changes to important files (CLAUDE.md, ai-rules/, etc.) are tracked
- **Git validation**: Ensures commit messages follow conventional format standards

### Safety Features
- **Git operation validation**: Prevents dangerous operations like force pushes
- **File change alerts**: Monitors modifications to critical configuration files
- **Error prevention**: Validates command patterns before execution

### Code Quality
- **Auto-formatting**: Automatically formats code using available tools (black, prettier, shfmt)
- **Syntax validation**: Checks file syntax where applicable
- **Consistent standards**: Enforces project coding conventions

#### Supported Formatters
To enable automatic code formatting, install the following tools:
- **Python**: `pip install black` - Formats .py files
- **JavaScript/TypeScript/JSON**: `npm install -g prettier` - Formats .js, .ts, .json files
- **Shell Scripts**: Install `shfmt` - Formats .sh files

The formatting hook will silently skip files if the corresponding formatter is not available.

### Rule Refresh System
- **Rule memory**: Tracks which rules have been used in the project
- **Dual refresh strategy**: Session start refresh (immediate) + periodic refresh (15-minute cooldown)
- **Context awareness**: Ensures assistant stays current with project-specific rules
- **Token optimization**: Time-based cooldown prevents context pollution from frequent refreshes

### Hook Configuration
The hooks are configured in `settings.json` and execute at specific lifecycle events:
- **PreToolUse**: Before tool execution (validation, logging)
- **PostToolUse**: After tool completion (formatting, cleanup)
- **Notification**: During notifications (rule refresh with 15-minute cooldown)

All hooks are designed to be non-blocking and provide helpful feedback without interrupting workflow.

## Planned Features

- [ ] Rule templates for common project types (Node.js, React, Next.js, Rust, etc.)
- [ ] Example projects demonstrating rule extensions
- [ ] Additional language-specific requirements
- [ ] Security audit rule templates
- [ ] Performance optimization workflows

## Contributing

New rules and workflow improvements should follow the established patterns and be thoroughly tested across different scenarios.

## License

MIT License