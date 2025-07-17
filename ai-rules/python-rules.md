# Rule: python-rules

## Description
Python-specific guidelines and workflows for Claude Code using uv for modern Python tooling, emphasizing code quality, reusability, and UV-first development practices.

## Prerequisites
- uv installed (https://docs.astral.sh/uv/getting-started/installation/)
- Python interpreter available (uv will manage versions)
- Target environment accessible

## Extends
- Base: /CLAUDE.md

## Steps

### 1. Environment Setup
- Use uv exclusively for Python operations
- No virtual environments (venv, virtualenv, conda)
- No package installation with pip
- Rely on uv's ephemeral environments

### 2. Project Structure
- Initialize projects with `uv init`
- Use pyproject.toml for dependency specification
- Avoid traditional requirements.txt files
- Configure development dependencies in [tool.uv] sections

### 3. Code Quality
- No hardcoding of values in scripts
- Parameterize all functions
- Check for existing similar functions before creating new ones
- Create shared modules when functionality needed in 2+ places

### 4. Testing Implementation
- Detect test frameworks (pytest/unittest)
- Run tests with uvx after changes
- Create unit tests for new functions
- Ensure all tests pass before completion

### 5. Code Style
- Use uv-managed formatters (black, ruff)
- Follow PEP 8 guidelines
- Match existing project conventions
- Organize imports properly

## Configuration

### Files Created
- `pyproject.toml` - Project configuration and dependencies
- `src/` - Source code directory
- `tests/` - Test files
- `main.py` - Entry point script
- `.env` - Environment variables (if needed)

### Files Modified
- `.claude-commands.memory` - Add python-rules.md to initialization list

## Post-Setup
1. Initialize project: `uv init my-project`
2. Add dependencies: `uv add requests pandas python-dotenv`
3. Add dev dependencies: `uv add --dev pytest black ruff mypy`
4. Run tests: `uvx pytest`
5. Format code: `uvx black . && uvx ruff check --fix .`

## Environment Management

### UV-First Rules
- **No virtual environments**: **MUST NOT** use python venv, virtualenv, or conda
- **No package installation**: **MUST NOT** install packages with pip or any package manager
- **UV only**: **MUST** use `uv` and `uvx` for all Python operations
- **Ephemeral environments**: **MUST** rely on uv's ephemeral environments for clean execution
- **Current packages**: uv automatically provides latest package versions without local artifacts

### UV Commands
```bash
# Run Python scripts with dependencies
uvx --from package script_name

# Run Python code with specific packages
uv run --with requests --with pandas script.py

# Run one-off commands
uvx ruff check .
uvx black .
uvx pytest

# Execute Python with inline dependencies
uv run --with 'requests>=2.25.0' python script.py
```

### Project Structure with UV
```bash
# Initialize project with uv
uv init my-project
cd my-project

# Add dependencies to pyproject.toml
uv add requests pandas

# Run the project
uv run python main.py

# Run with additional dependencies
uv run --with matplotlib python analysis.py
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

Refer to CLAUDE.md "Testing Framework and Strategy" section for general testing principles.

### Python-Specific Testing with UV
- **Framework detection**: Check for pytest/unittest in pyproject.toml
- **Test execution**: Use `uvx pytest` for running tests without installation
- **Coverage**: Use `uvx pytest --cov` for coverage reports

### Test Commands with UV
```bash
# Run tests with uvx (no installation needed)
uvx pytest                    # Run all tests
uvx pytest tests/            # Run tests in directory
uvx pytest -v               # Verbose output
uvx pytest --cov=module     # Coverage report

# Run unittest tests
uv run python -m unittest discover
uv run python -m unittest tests.test_module

# Run tests with additional dependencies
uv run --with pytest-cov --with pytest-mock pytest
```

## Package Management with UV

### Dependency Management
- **pyproject.toml**: Use pyproject.toml for dependency specification
- **No requirements.txt**: Avoid traditional requirements.txt files
- **Version constraints**: Specify appropriate version constraints in pyproject.toml
- **Development dependencies**: Use [tool.uv] sections for dev dependencies

### UV Project Configuration
```toml
# pyproject.toml
[project]
name = "my-project"
version = "0.1.0"
description = "Project description"
dependencies = [
    "requests>=2.25.0",
    "pandas>=1.3.0",
]

[tool.uv]
dev-dependencies = [
    "pytest>=7.0.0",
    "black>=22.0.0",
    "ruff>=0.1.0",
]

[build-system]
requires = ["hatchling"]
build-backend = "hatchling.build"
```

### Running Code with Dependencies
```bash
# Add dependency and run
uv add requests
uv run python script.py

# One-time dependency usage
uv run --with requests python script.py

# Run with multiple dependencies
uv run --with requests --with pandas --with matplotlib data_analysis.py
```

## Code Style and Formatting

### Follow Project Conventions
- Match existing code style exactly
- Use the same naming conventions as surrounding code
- Follow PEP 8 guidelines unless project uses different style
- Use uv-managed formatters (black, ruff) for consistency

### Formatting with UV
```bash
# Format code with black
uvx black .

# Lint with ruff
uvx ruff check .
uvx ruff check --fix .

# Type checking with mypy
uvx mypy .

# All-in-one formatting and linting
uvx black . && uvx ruff check --fix . && uvx mypy .
```

### Import Organization
- Follow PEP 8 import order: standard library, third-party, local
- Use absolute imports when possible
- Group imports logically
- Remove unused imports with ruff

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

Refer to CLAUDE.md "Secrets and Credentials Management" section for general principles.

### Python-Specific Implementation
- **Use python-dotenv**: Include in dependencies and use `load_dotenv()`
- **UV execution**: `uv run --with python-dotenv python script.py`
- **Access pattern**: Use `os.getenv()` for environment variables

```python
from dotenv import load_dotenv
import os

load_dotenv()
API_TOKEN = os.getenv('API_TOKEN')
```

## Development Workflow

### Project Initialization
```bash
# Create new project
uv init my-project
cd my-project

# Add dependencies
uv add requests pandas python-dotenv

# Add development dependencies
uv add --dev pytest black ruff mypy

# Run the project
uv run python main.py
```

### Common Development Tasks
```bash
# Format and lint
uvx black . && uvx ruff check --fix .

# Type checking
uvx mypy .

# Run tests
uvx pytest

# Run with additional tools
uvx --from rich python -c "from rich.console import Console; Console().print('Hello!', style='bold red')"

# Execute specific tools
uvx bandit -r .  # Security linting
uvx safety check  # Vulnerability scanning
```

## Testing Framework with UV

### Test Configuration
```toml
# pyproject.toml
[tool.pytest.ini_options]
testpaths = ["tests"]
python_files = ["test_*.py"]
python_classes = ["Test*"]
python_functions = ["test_*"]
addopts = ["-v", "--tb=short"]

[tool.coverage.run]
source = ["src"]
omit = ["tests/*"]
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

### Coverage and Mocking with UV
```bash
# Run tests with coverage
uvx pytest --cov=src --cov-report=html

# Run tests with specific dependencies
uv run --with pytest-mock --with pytest-cov pytest

# Performance testing
uvx pytest-benchmark
```

## Production Considerations

### Deployment with UV
- **Docker integration**: Use uv in Docker for reproducible builds
- **Lock files**: Commit uv.lock for reproducible deployments
- **Build process**: Use `uv build` for distribution packages
- **Security**: Regular security audits with `uvx safety check`

### Example Dockerfile
```dockerfile
FROM python:3.12-slim
RUN pip install uv
COPY . /app
WORKDIR /app
RUN uv sync --frozen
CMD ["uv", "run", "python", "main.py"]
```

## Memory Integration

After using this rule, Claude must:

- **1.** Check if `.claude-commands.memory` file exists - if not, create it with initial content:
```
## read these files upon initialization

```

- **2.** Check if `- /ai-rules/python-rules.md` is listed under section `## read these files upon initialization` in `.claude-commands.memory`
- **3.** If not listed: add `- /ai-rules/python-rules.md` to list under section `## read these files upon initialization` in `.claude-commands.memory`