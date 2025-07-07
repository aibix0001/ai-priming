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

### ✅ Command Infrastructure
- `commands/` directory with specialized workflows:
  - Ansible automation and playbook management
  - NetBox network documentation and management
  - Python development best practices
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
├── commands/                 # Reusable command templates
│   ├── README.md            # Command documentation and template
│   ├── ansible.md           # Ansible automation workflows
│   ├── netbox.md            # NetBox management commands
│   ├── python.md            # Python development workflows
│   └── vyos.md              # VyOS configuration management
├── setup.sh                 # Setup script for symlink creation
├── .gitignore               # Excludes local settings and credentials
└── README.md                # This file
```

## Rule Hierarchy

1. **Universal Rules** (root CLAUDE.md) - Always apply
2. **Language-Specific Rules** - Apply when using specific languages
3. **Project-Specific Rules** - Extend universal rules for individual projects
4. **Command Rules** - Specific workflows in `.claude/commands/`
5. **User Instructions** - Session-specific overrides

## Getting Started

### Option 1: Global Setup (Recommended)

Use the setup script to create symlinks in your home directory:

```bash
git clone https://github.com/aibix0001/ai-priming.git
cd ai-priming
./setup.sh
```

This creates symlinks in `~/.claude/` that Claude will automatically discover for all projects.

### Option 2: Per-Project Setup

For project-specific configuration:

1. Clone or copy this repository to your project as `.claude/`
2. Claude will automatically find and use the configuration
3. Extend with project-specific rules as needed

### Option 3: Manual Copy

Copy the universal `CLAUDE.md` to your project root and extend with project-specific rules as needed.

## Claude Hooks System

This repository includes a comprehensive hooks system that provides:

### Automated Logging
- **Command tracking**: All bash commands are logged with timestamps
- **File monitoring**: Changes to important files (CLAUDE.md, commands/, etc.) are tracked
- **Git validation**: Ensures commit messages follow conventional format standards

### Safety Features
- **Git operation validation**: Prevents dangerous operations like force pushes
- **File change alerts**: Monitors modifications to critical configuration files
- **Error prevention**: Validates command patterns before execution

### Code Quality
- **Auto-formatting**: Automatically formats code using available tools (black, prettier, shfmt)
- **Syntax validation**: Checks file syntax where applicable
- **Consistent standards**: Enforces project coding conventions

### Rule Refresh System
- **Command memory**: Tracks which commands have been used in the project
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

- [ ] Command templates for common project types (Node.js, React, Next.js, Rust, etc.)
- [ ] Example projects demonstrating rule extensions
- [ ] Additional language-specific requirements
- [ ] Security audit commands
- [ ] Performance optimization workflows

## Contributing

New commands and rule improvements should follow the established patterns and be thoroughly tested across different scenarios.

## License

MIT