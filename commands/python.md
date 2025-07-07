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

## Secrets Management

### Environment Variables
- **Use python-dotenv**: Load environment variables from `.env` file
- **Add to requirements**: Include `python-dotenv` in requirements.txt
- **Load at startup**: Call `load_dotenv()` at the beginning of scripts

```python
from dotenv import load_dotenv
import os

load_dotenv()

API_TOKEN = os.getenv('API_TOKEN')
DB_PASSWORD = os.getenv('DB_PASSWORD')
```

### Configuration Class Pattern
```python
class Config:
    def __init__(self):
        load_dotenv()
        self.api_token = os.getenv('API_TOKEN')
        self.db_password = os.getenv('DB_PASSWORD')
        self.debug = os.getenv('DEBUG', 'False').lower() == 'true'
```

### Required Environment Variables
```python
import os
from dotenv import load_dotenv

load_dotenv()

# Check required environment variables
REQUIRED_VARS = ['API_TOKEN', 'DB_PASSWORD', 'SECRET_KEY']

for var in REQUIRED_VARS:
    if not os.getenv(var):
        raise ValueError(f"Required environment variable {var} is not set")
```

## Testing Framework

### Test Detection and Execution
- **Frameworks**: pytest (preferred), unittest, nose2, tox
- **Detection**: Look for pytest.ini, tox.ini, setup.cfg, pyproject.toml
- **Commands**: Run tests after changes, create unit tests for new functions

### Test Commands
```bash
# pytest (preferred)
pytest                    # Run all tests
pytest tests/            # Run tests in directory
pytest -v               # Verbose output
pytest -x               # Stop on first failure
pytest --cov=module     # Coverage report

# unittest
python -m unittest discover
python -m unittest tests.test_module
```

### Test Structure
```python
# test_example.py
import pytest
from mymodule import my_function

def test_my_function():
    result = my_function("input")
    assert result == "expected_output"
    
def test_my_function_edge_case():
    with pytest.raises(ValueError):
        my_function(None)
```

### Test Configuration
```ini
# pytest.ini
[tool:pytest]
testpaths = tests
python_files = test_*.py
python_classes = Test*
python_functions = test_*
addopts = -v --tb=short
```

### Coverage and Mocking
```python
# Coverage
pytest --cov=mymodule --cov-report=html

# Mocking with unittest.mock
from unittest.mock import patch, Mock

@patch('requests.get')
def test_api_call(mock_get):
    mock_get.return_value.json.return_value = {'status': 'success'}
    result = my_api_function()
    assert result == {'status': 'success'}
```

## Integration with Other Commands

**Required Reading**: Before applying Python-specific rules, the assistant must read:
- `secrets.md` - for universal .env file management principles
- `testing.md` - for universal testing philosophy and organization
- Generic CLAUDE.md rules always apply as foundation

This command extends and implements the universal principles defined in those files.

## Command Memory Tracking

**Important**: When this command is invoked, add the following to the project's command memory:
```bash
echo "$(date '+%Y-%m-%d %H:%M:%S'): .claude/commands/python.md" >> .claude-commands.memory
```

This helps track which commands have been used in the project for automatic rule refreshing.