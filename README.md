# AI Priming

A comprehensive framework for establishing consistent AI assistant behavior across all software development projects through universal rules and reusable commands.

## Purpose

This repository serves as the single source of truth for AI assistant configuration, ensuring consistent, secure, and efficient development practices across all project types. It provides a hierarchical rule system where universal principles are extended by language-specific and project-specific requirements.

## Implemented Features

### ✅ Core Framework
- **Universal CLAUDE.md**: Comprehensive rules of engagement including:
  - Core principles (code quality, security, minimal changes, testing, conventions)
  - Development workflow rules with Git repository and branch management
  - Communication standards for concise, direct responses
  - Safety guidelines and ethical boundaries
  - Performance optimization strategies
  - Error handling and recovery strategies
  - Continuous improvement guidelines

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
  - Secrets management and security practices
  - Testing framework setup and configuration
  - VyOS network device configuration
- Command template documentation and best practices
- Support for reusable workflows
- Command inheritance system

### ✅ Setup Automation
- `setup.sh` script for automatic symlink creation
- Support for both global (~/.claude/) and per-project configurations
- Idempotent setup process (safe to run multiple times)

## Repository Structure

```
ai-priming/
├── CLAUDE.md                 # Universal rules for all projects
├── commands/                 # Reusable command templates
│   ├── README.md            # Command documentation and template
│   ├── ansible.md           # Ansible automation workflows
│   ├── netbox.md            # NetBox management commands
│   ├── python.md            # Python development workflows
│   ├── secrets.md           # Secrets management practices
│   ├── testing.md           # Testing framework setup
│   └── vyos.md              # VyOS configuration management
├── setup.sh                 # Setup script for symlink creation
├── settings.local.json      # Local Claude settings
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
git clone https://github.com/your-username/ai-priming.git
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