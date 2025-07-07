# Python Development Command

This command provides Python-specific rules and workflows for Claude Code.

## Environment Management

### Virtual Environment Rules
- **Python venv**: always use python virtual environments
- **Venv location**: create in project root as `.venv` unless another convention exists
- **Venv detection**: check for existing venv in order: `.venv`, `venv`, `env`
- **Venv activation**: always verify venv is activated before installing packages
- **System packages**: **must not ever install packages outside venv**
- **Requirements management**: update requirements.txt immediately after installing packages with specific versions

### Virtual Environment Commands
```bash
# Create virtual environment
python -m venv .venv

# Activate virtual environment
source .venv/bin/activate  # Linux/Mac
.venv\Scripts\activate     # Windows

# Verify activation
which python  # Should show .venv path
```

## Code Quality and Structure

### No Hardcoding Rules
- **No hardcoding**: **must not** hardcode lists, dictionaries, or task-specific values in scripts
- **Parameterization**: **all functions must** accept parameters - no hardcoded values inside functions
- **Configuration**: **must** use config files or env vars, never hardcode settings

### Code Reuse Mandatory
- **Code reuse mandatory**: **must** check for existing similar functions before creating new ones
- **No duplication**: **must not** create same/similar functions in different scripts
- **Create modules**: when functionality needed in 2+ places, **must** create shared module

### Module Creation Rules
- **2+ places means**:
  - Same function needed in 2+ different .py files
  - Same logic pattern repeated 2+ times (even with slight variations)
  - Anticipated reuse based on current task structure
- **Proactive refactoring**: YES - if implementing similar feature, check for existing patterns first
- **Module examples**:
  - `utils.py`: general utility functions
  - `config.py`: configuration management
  - `database.py`: database operations
  - `api_client.py`: API interaction functions
- Use descriptive names for modules
- Import from module instead of duplicating code

### DRY Enforcement
- **DRY enforcement**: if writing similar code twice, **must** refactor into reusable function
- Check existing codebase for similar patterns before implementing new functionality
- Consolidate duplicate code into shared utilities

## Testing Requirements

### Test Detection
- **Detection**: look for test/, tests/, *_test.py, test_*.py directories and files
- **Python frameworks**: check for pytest/unittest in project, run if found
- **No test framework**: inform user, suggest adding tests

### Test Execution
- Run existing tests after making changes
- Create unit tests for new functions
- Ensure all tests pass before considering work complete
- Use the project's established testing framework

### Test Commands
```bash
# Common test commands
pytest                    # Run all tests
pytest tests/            # Run tests in directory
pytest -v               # Verbose output
python -m unittest      # Run unittest tests
```

## Package Management

### Requirements Management
- Always update requirements.txt after installing packages
- Pin specific versions in requirements.txt
- Use `pip freeze > requirements.txt` to capture exact versions
- Separate development dependencies if using requirements-dev.txt

### Installation Best Practices
```bash
# Install packages
pip install package_name

# Install from requirements
pip install -r requirements.txt

# Update requirements after installation
pip freeze > requirements.txt
```

## Code Style and Formatting

### Follow Project Conventions
- Match existing code style exactly
- Use the same naming conventions as surrounding code
- Follow PEP 8 guidelines unless project uses different style
- Use existing formatters (black, autopep8) if configured

### Import Organization
- Follow PEP 8 import order: standard library, third-party, local
- Use absolute imports when possible
- Group imports logically
- Remove unused imports

## Error Handling

### Exception Handling
- Use specific exception types rather than bare except clauses
- Provide meaningful error messages
- Don't suppress exceptions silently
- Log errors appropriately

### Example Error Handling
```python
try:
    result = risky_operation()
except SpecificError as e:
    logger.error(f"Operation failed: {e}")
    raise
except Exception as e:
    logger.error(f"Unexpected error: {e}")
    raise
```

## Integration with Other Commands

This command works well with:
- `/secrets` - for environment variable management
- `/testing` - for comprehensive testing strategies
- Generic CLAUDE.md rules always apply as foundation