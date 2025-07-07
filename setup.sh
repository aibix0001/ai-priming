#!/bin/bash

# Setup script to create symlinks for Claude configuration
# This script creates symlinks from the repository's CLAUDE.md and commands folder
# to the user's ~/.claude/ directory

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print colored output
print_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Get the absolute path of the repository
REPO_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

print_info "Repository detected at: $REPO_PATH"

# Validate we're in the correct repository
if [[ ! -f "$REPO_PATH/CLAUDE.md" ]]; then
    print_error "CLAUDE.md not found in $REPO_PATH"
    print_error "This script must be run from the ai-priming repository root"
    exit 1
fi

if [[ ! -d "$REPO_PATH/commands" ]]; then
    print_error "commands directory not found in $REPO_PATH"
    print_error "This script must be run from the ai-priming repository root"
    exit 1
fi

if [[ ! -d "$REPO_PATH/hooks" ]]; then
    print_error "hooks directory not found in $REPO_PATH"
    print_error "This script must be run from the ai-priming repository root"
    exit 1
fi

if [[ ! -f "$REPO_PATH/settings.json" ]]; then
    print_error "settings.json not found in $REPO_PATH"
    print_error "This script must be run from the ai-priming repository root"
    exit 1
fi

print_info "Repository validation passed"

# Create ~/.claude directory if it doesn't exist
CLAUDE_DIR="$HOME/.claude"
if [[ ! -d "$CLAUDE_DIR" ]]; then
    mkdir -p "$CLAUDE_DIR"
    print_info "Created directory: $CLAUDE_DIR"
else
    print_info "Directory already exists: $CLAUDE_DIR"
fi

# Create symlink for CLAUDE.md
CLAUDE_MD_LINK="$CLAUDE_DIR/CLAUDE.md"
if [[ ! -L "$CLAUDE_MD_LINK" ]]; then
    if [[ -e "$CLAUDE_MD_LINK" ]]; then
        print_warning "File exists but is not a symlink: $CLAUDE_MD_LINK"
        print_warning "Please remove it manually if you want to create the symlink"
    else
        ln -s "$REPO_PATH/CLAUDE.md" "$CLAUDE_MD_LINK"
        print_info "Created symlink: $CLAUDE_MD_LINK -> $REPO_PATH/CLAUDE.md"
    fi
else
    print_info "Symlink already exists: $CLAUDE_MD_LINK"
fi

# Create symlink for commands directory
COMMANDS_LINK="$CLAUDE_DIR/commands"
if [[ ! -L "$COMMANDS_LINK" ]]; then
    if [[ -e "$COMMANDS_LINK" ]]; then
        print_warning "Directory/file exists but is not a symlink: $COMMANDS_LINK"
        print_warning "Please remove it manually if you want to create the symlink"
    else
        ln -s "$REPO_PATH/commands" "$COMMANDS_LINK"
        print_info "Created symlink: $COMMANDS_LINK -> $REPO_PATH/commands"
    fi
else
    print_info "Symlink already exists: $COMMANDS_LINK"
fi

# Create symlink for settings.json
SETTINGS_LINK="$CLAUDE_DIR/settings.json"
if [[ ! -L "$SETTINGS_LINK" ]]; then
    if [[ -e "$SETTINGS_LINK" ]]; then
        print_warning "File exists but is not a symlink: $SETTINGS_LINK"
        print_warning "Please remove it manually if you want to create the symlink"
    else
        ln -s "$REPO_PATH/settings.json" "$SETTINGS_LINK"
        print_info "Created symlink: $SETTINGS_LINK -> $REPO_PATH/settings.json"
    fi
else
    print_info "Symlink already exists: $SETTINGS_LINK"
fi

# Create symlink for hooks directory
HOOKS_LINK="$CLAUDE_DIR/hooks"
if [[ ! -L "$HOOKS_LINK" ]]; then
    if [[ -e "$HOOKS_LINK" ]]; then
        print_warning "Directory/file exists but is not a symlink: $HOOKS_LINK"
        print_warning "Please remove it manually if you want to create the symlink"
    else
        ln -s "$REPO_PATH/hooks" "$HOOKS_LINK"
        print_info "Created symlink: $HOOKS_LINK -> $REPO_PATH/hooks"
    fi
else
    print_info "Symlink already exists: $HOOKS_LINK"
fi

print_info "Setup complete!"
print_info "Claude will now use the configuration from this repository"
print_info "Repository: $REPO_PATH"
print_info "Claude config: $CLAUDE_DIR"