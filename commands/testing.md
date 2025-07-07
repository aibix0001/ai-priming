# Testing Framework Guidelines

Universal testing rules and principles for Claude Code across all languages and tools.

## Core Testing Principles

### Testing Philosophy
- **Always test**: Run existing tests after making changes
- **Test new code**: Create tests for new functionality
- **Gate quality**: Ensure all tests pass before considering work complete
- **Follow conventions**: Use the project's established testing framework
- **Write maintainable tests**: Tests should be clear and easy to understand

### Test Detection Strategy
- **Pattern recognition**: Look for test directories (test/, tests/) and test files (*_test.*, test_*.*)
- **Framework identification**: Check project dependencies for testing frameworks
- **Missing tests**: When no tests exist, suggest adding appropriate tests for the language/framework

## Test Organization

### Standard Test Structure
```
project/
├── src/
│   └── modules/
├── tests/
│   ├── unit/
│   ├── integration/
│   └── fixtures/
└── test-requirements.txt
```

### Test Categories
- **Unit tests**: Test individual functions/methods in isolation
- **Integration tests**: Test component interactions
- **End-to-end tests**: Test complete workflows
- **Smoke tests**: Basic functionality verification

## Test Execution Strategy

### Before Making Changes
- Run existing test suite to establish baseline
- Identify which tests might be affected by changes
- Ensure test environment is properly configured

### During Development
- Write tests alongside new features
- Run relevant tests frequently during development
- Use test-driven development when appropriate

### After Making Changes
- Run full test suite to catch regressions
- Check test coverage for new code
- Verify no unintended side effects
- Update tests if behavior intentionally changed

## Test Quality Guidelines

### Test Failure Analysis
- Read error messages carefully
- Identify root cause (code bug vs test issue)
- Check for environment-specific issues
- Verify test data and expectations

### Common Test Issues
- **Flaky tests**: Timing issues, external dependencies
- **Environment differences**: Local vs CI environment
- **Missing dependencies**: Test-specific packages not installed
- **Incorrect expectations**: Test data or mocks don't match reality

## Test Coverage

### Coverage Goals
- Aim for high coverage on new code
- Focus on critical path coverage
- Don't sacrifice test quality for coverage percentage
- Use coverage reports to identify gaps

### Mock Strategy
Mock external dependencies:
- External services and APIs
- Database connections
- File system operations
- Network requests
- Time-dependent operations

## Integration with Other Commands

Language and tool-specific testing:
- See `python.md` for pytest, unittest, and coverage tools
- See `ansible.md` for playbook testing and validation
- See `netbox.md` for API integration testing
- See `vyos.md` for network device testing
- Follow `secrets.md` for test environment configuration

## Command Memory Tracking

**Important**: When this command is invoked, add the following to the project's command memory:
```bash
echo "$(date '+%Y-%m-%d %H:%M:%S'): /testing" >> .claude-commands.memory
```

This helps track which commands have been used in the project for automatic rule refreshing.