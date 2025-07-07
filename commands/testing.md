# Testing Framework Command

This command provides testing rules and workflows for Claude Code across different languages and frameworks.

## General Testing Principles

### Testing Philosophy
- Run existing tests after making changes
- Create tests for new functionality
- Ensure all tests pass before considering work complete
- Use the project's established testing framework
- Write tests that are clear and maintainable

### Test Detection Strategy
- **Detection patterns**: look for test/, tests/, *_test.py, test_*.py, *.test.js, *.spec.js
- **Framework identification**: check for testing frameworks in project dependencies
- **No test framework**: inform user, suggest adding tests appropriate for the language/framework

## Language-Specific Testing

### Python Testing
- **Frameworks**: pytest, unittest, nose2, tox
- **Detection**: look for pytest.ini, tox.ini, setup.cfg, pyproject.toml
- **Execution**: run tests after changes, create unit tests for new functions

#### Python Test Commands
```bash
# pytest
pytest                    # Run all tests
pytest tests/            # Run tests in directory
pytest -v               # Verbose output
pytest -x               # Stop on first failure
pytest --cov=module     # Coverage report

# unittest
python -m unittest discover
python -m unittest tests.test_module
python -m unittest tests.test_module.TestClass.test_method
```

#### Python Test Structure
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

### JavaScript/Node.js Testing
- **Frameworks**: Jest, Mocha, Jasmine, Vitest
- **Detection**: look for package.json test scripts, jest.config.js, mocha.opts
- **Execution**: `npm test`, `yarn test`, `npm run test:unit`

#### JavaScript Test Commands
```bash
# npm/yarn
npm test
npm run test:unit
npm run test:integration
yarn test
yarn test:watch

# Direct framework usage
jest
mocha
```

### Ansible Testing
- **Test method**: use `--check` mode as primary test
- **Syntax check**: `ansible-playbook --syntax-check playbook.yml`
- **Dry run**: `ansible-playbook --check playbook.yml`
- **Molecule**: for complex role testing

#### Ansible Test Commands
```bash
# Syntax validation
ansible-playbook --syntax-check playbook.yml

# Dry run
ansible-playbook --check playbook.yml

# Lint check
ansible-lint playbook.yml

# Molecule testing
molecule test
```

### Configuration Testing
- **VyOS**: use `commit-confirm` and validate commands
- **Network devices**: verify connectivity and configuration state
- **Infrastructure**: test service availability and configuration

## Test Organization

### Test Structure Patterns
```
project/
├── src/
│   └── module.py
├── tests/
│   ├── __init__.py
│   ├── test_module.py
│   ├── unit/
│   │   └── test_unit.py
│   └── integration/
│       └── test_integration.py
└── requirements-test.txt
```

### Test Categories
- **Unit tests**: test individual functions/methods
- **Integration tests**: test component interactions
- **End-to-end tests**: test complete workflows
- **Smoke tests**: basic functionality verification

## Test Execution Strategy

### Before Changes
- Run existing test suite to establish baseline
- Identify which tests might be affected by changes
- Ensure test environment is properly configured

### During Development
- Write tests alongside new features
- Run relevant tests frequently during development
- Use test-driven development when appropriate

### After Changes
- Run full test suite
- Check test coverage for new code
- Verify no regressions introduced
- Update tests if behavior intentionally changed

## Test Configuration

### Python Test Configuration
```ini
# pytest.ini
[tool:pytest]
testpaths = tests
python_files = test_*.py
python_classes = Test*
python_functions = test_*
addopts = -v --tb=short
```

### JavaScript Test Configuration
```json
// package.json
{
  "scripts": {
    "test": "jest",
    "test:watch": "jest --watch",
    "test:coverage": "jest --coverage"
  },
  "jest": {
    "testEnvironment": "node",
    "collectCoverage": true,
    "coverageDirectory": "coverage"
  }
}
```

## Error Handling in Tests

### Test Failure Analysis
- Read error messages carefully
- Identify root cause (code bug vs test issue)
- Check for environment-specific issues
- Verify test data and expectations

### Common Test Issues
- Flaky tests (timing, network dependencies)
- Environment differences
- Missing test dependencies
- Incorrect test data or mocks

## Continuous Integration

### CI/CD Integration
- Ensure tests run in CI pipeline
- Configure test reporting
- Set up coverage reporting
- Implement test quality gates

### Test Performance
- Monitor test execution time
- Optimize slow tests
- Use parallel execution when possible
- Consider test sharding for large suites

## Test Coverage

### Coverage Goals
- Aim for high coverage on new code
- Focus on critical path coverage
- Don't sacrifice test quality for coverage percentage
- Use coverage reports to identify gaps

### Coverage Tools
```bash
# Python
pytest --cov=mymodule --cov-report=html

# JavaScript
npm test -- --coverage
jest --coverage
```

## Mock and Stub Strategy

### When to Mock
- External services and APIs
- Database connections
- File system operations
- Network requests
- Time-dependent operations

### Mock Examples
```python
# Python with unittest.mock
from unittest.mock import patch, Mock

@patch('requests.get')
def test_api_call(mock_get):
    mock_get.return_value.json.return_value = {'status': 'success'}
    result = my_api_function()
    assert result == {'status': 'success'}
```

## Integration with Other Commands

This command works with:
- `/python` - for Python-specific testing frameworks
- `/ansible` - for playbook testing and validation
- `/secrets` - for test environment configuration
- `/netbox` - for integration testing with NetBox
- `/vyos` - for network device testing
- Generic CLAUDE.md rules for version control and change management

## Project-Specific Testing

### Test Discovery
- Check existing test configuration
- Identify test patterns and conventions
- Understand project-specific test requirements
- Adapt to existing test infrastructure

### Test Maintenance
- Keep tests up to date with code changes
- Refactor tests when needed
- Remove obsolete tests
- Document test requirements and setup

## Performance Testing

### Load Testing
- Test system under expected load
- Identify performance bottlenecks
- Validate resource usage
- Test scalability limits

### Benchmarking
- Establish performance baselines
- Monitor performance changes over time
- Compare different implementation approaches
- Validate performance requirements