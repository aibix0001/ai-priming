# rules of engagement

**these are most relevant rules, do not ever break them!**
**these are most relevant rules, do not ever break them!**

## git related rules
- **branch creation default**: only create branches when explicitly requested by user
- **branch suggestion trigger**: Claude must suggest creating a new branch when:
  - Task shifts to a different system/context (e.g., from netbox work to vyos configuration)
  - Current changes would conflict with or diverge from the existing branch's purpose
  - User requests a new feature while in the middle of another feature
  - Work scope significantly expands beyond original branch intent
- **suggestion format**: "This seems like a different feature/context. Should I create a new branch for this work?"
- **stay on branch**: continue working on current branch unless user approves branch switch
- **one feature principle**: each branch should represent one cohesive feature or fix
- **merge policy**: only merge when user explicitly approves
- **branch retention**: after merging, **must not** delete feature branch - keep for reference
- **git commit**: always commit relevant changes with clear and concise message

## python related rules
### Environment Management
- **python venv**: always use python venv
- **venv location**: create in project root as `.venv` unless another convention exists
- **venv detection**: check for existing venv in order: `.venv`, `venv`, `env`
- **venv activation**: always verify venv is activated before installing packages
- **system packages**: **must not ever install packages outside venv**
- **requirements management**: update requirements.txt immediately after installing packages with specific versions

### Code Quality and Structure
- **no hardcoding**: **must not** hardcode lists, dictionaries, or task-specific values in scripts
- **parameterization**: **all functions must** accept parameters - no hardcoded values inside functions
- **code reuse mandatory**: **must** check for existing similar functions before creating new ones
- **no duplication**: **must not** create same/similar functions in different scripts
- **create modules**: when functionality needed in 2+ places, **must** create shared module:
  - **2+ places means**: 
    - Same function needed in 2+ different .py files
    - Same logic pattern repeated 2+ times (even with slight variations)
    - Anticipated reuse based on current task structure
  - **proactive refactoring**: YES - if implementing similar feature, check for existing patterns first
  - **module examples**:
    - netbox_helpers.py: get_device(), update_device_tags(), add_claude_comment()
    - vyos_common.py: connect_to_device(), save_config(), validate_syntax()
  - Use descriptive names: `utils.py`, `netbox_helpers.py`, `vyos_common.py`
  - Import from module instead of duplicating code
- **DRY enforcement**: if writing similar code twice, **must** refactor into reusable function
- **configuration**: **must** use config files or env vars, never hardcode settings

## credentials and secrets management
### Basic Rules
- **credential storage**: **must** store all credentials, tokens, and secrets in `.env` file
- **git security**: `.env` file **must not** ever be committed to git
- **.gitignore**: **must** ensure `.env` is in `.gitignore` 
- **example file**: **must** create and maintain `.env.example` with all variables but generic values
- **.env.example format**:
  ```
  NETBOX_URL=https://netbox.example.com
  NETBOX_API_TOKEN=<YOUR_NETBOX_API_TOKEN>
  VYOS_USERNAME=<YOUR_VYOS_USERNAME>
  VYOS_PASSWORD=<YOUR_VYOS_PASSWORD>
  ANSIBLE_VAULT_PASSWORD=<YOUR_VAULT_PASSWORD>
  ```
- **example maintenance**: when adding new env variable to `.env`, **must** immediately add to `.env.example`
- **commit example**: `.env.example` **must** be committed to git as reference

### Context-Specific Handling
- **Python scripts**: 
  - **must** use `python-dotenv` to load `.env`
  - Add to script start: `load_dotenv()`
  - **must** add `python-dotenv` to requirements.txt
  
- **Ansible**:
  - Use `lookup('env', 'VARIABLE_NAME')` in playbooks
  - For inventory: export vars before running or use wrapper script
  - Vault password: use `ANSIBLE_VAULT_PASSWORD_FILE` env var pointing to file
  
- **Docker**:
  - **must** add `.env` to `.dockerignore`
  - Use `env_file: .env` in docker-compose.yml
  - For production: use Docker secrets or environment-specific `.env` files
  
- **CI/CD**:
  - **must not** store `.env` in repository
  - Document required env vars in `.env.example` and README
  - Use CI/CD platform's secret management (GitHub Secrets, GitLab Variables, etc.)
  
- **Shell scripts**:
  - Source .env file: `. ./.env` or `source ./.env`
  - **must** check if `.env` exists before sourcing

### Security Notes
- **rotation reminder**: add comment in `.env.example` about regular credential rotation
- **permissions**: `.env` file should have restricted permissions (600 or 640)
- **backup**: never backup `.env` files to shared/public locations

## netbox related rules
### Queries and Retrieval
- **netbox queries**: always use netbox mcp for reading/querying data
- **pagination required**: **must** handle pagination - netbox mcp returns max 10 items per page
- **overflow prevention**: MCP can return too many results causing assistant overflow - ALWAYS paginate
- **query strategy**: 
  - Start with offset=0, limit=10
  - Process results in chunks
  - Continue until no more results or user-specified limit reached
  - Example: filters={"offset": 0, "limit": 10} then {"offset": 10, "limit": 10} etc.
- **never query all**: NEVER attempt to get all results in a single query

### Making Changes
- **netbox changes**: use curl with API token for CREATE/UPDATE/DELETE operations
- **ssl certificates**: use --insecure flag for self-signed certificates
- **api endpoints**: check documentation for correct endpoint before making changes

### Change Tracking
- **claude tag**: **must** add tag named "claude" to all modified objects (create tag if it doesn't exist)
- **tag properties**: simple tag with name="claude" and appropriate color
- **comments format**: add descriptive comment with format: `[Claude: <date> - <description>]`
- **comment handling**: 
  - **must** use PATCH requests to append comments
  - **must not** overwrite existing comments
  - **must** preserve all existing data
  - **conflict scenarios**:
    - Existing claude comment with same date
    - Comments field is null/missing
    - Comments exceed field limit
    - Another process modified comments between read/write
  - **conflict resolution**:
    - If comments field missing: add it
    - If claude comment exists for today: append with timestamp
    - If field limit reached: stop and ask user
    - If concurrent modification detected: re-read, retry once, then ask
  - **format**: Always append with newline: `existing + "\n[Claude: 2024-01-07 - Description]"`
- **example comment**: `"Existing comment\n[Claude: 2024-01-07 - Added VLAN 100 for management]"`
- **example tag**: Add "claude" to the tags array of the object

### Documentation
- **required reading**: consult https://netbox.readthedocs.io before implementing new functionality
- **api reference**: use API docs to verify endpoints and required fields

## ansible related rules
### Inventory Management
- **inventory source**: **must** use netbox dynamic inventory plugin - never create static inventory
- **inventory config**: netbox.yml must read API token and URL from environment variables (via `.env`)
- **inventory verification**: run `ansible-inventory --list` to verify before running playbooks

### Playbook Development
- **playbook only**: **must** use playbooks for all configuration tasks - no adhoc for changes
- **adhoc usage**: only use adhoc commands for information gathering (facts, checks)
- **playbook structure**: 
  - Use descriptive names for plays and tasks
  - Include proper tags for selective execution
  - Always set `gather_facts: yes` unless explicitly not needed

### Variables and Configuration
- **variable precedence**: respect Ansible variable precedence - don't hardcode values in playbooks
- **variable files**: use group_vars/host_vars for environment-specific settings
- **no hardcoding**: follow Python rules - parameterize everything

### Execution and Error Handling
- **dry run first**: **should** run with --check when making significant changes
- **failure handling**: if playbook fails twice with same error - **must stop** and ask user
- **identical failure definition**:
  - Same module failing on same task
  - Error message >80% similar (ignore timestamps/IDs)
  - Same host(s) affected
  - Example: "Connection timeout to 192.168.1.1" twice = stop
- **between attempts**: 
  - First failure: check connectivity, verify credentials
  - Second failure: STOP - do not attempt third time
  - Must vary approach between attempts (different module, different method)
- **error investigation**: after failure, check:
  - Connectivity to target hosts
  - Authentication/privilege issues
  - Module-specific error messages
- **idempotency**: ensure playbooks can run multiple times safely

### VyOS Specific
- **vyos connection**: use `network_cli` connection type
- **vyos modules**: prefer vyos-specific modules over raw/command when available

## vyos related rules
### Documentation
- **required reading**: **must** consult documentation before implementing:
  - Configuration: https://docs.vyos.io/en/latest/configuration/index.html
  - Automation: https://docs.vyos.io/en/latest/automation/index.html
- **version specific**: We use **VyOS Stream** release
  - Always check Stream-specific features/syntax
  - Stream may have newer features not in LTS
  - When docs show version differences, use Stream syntax
- **command verification**: verify command syntax in docs before execution
- **when to consult**:
  - New feature implementation
  - Unfamiliar commands
  - Error resolution
  - Complex configurations (VPNs, routing protocols, etc.)
- **quick reference OK for**:
  - Basic interface configuration
  - Simple firewall rules
  - Standard show commands

### Configuration Methods
- **ansible required**: **must** use Ansible playbooks for all configuration changes
- **adhoc commands**: only for information gathering (show commands), never for config
- **manual config**: avoid SSH manual configuration unless explicitly requested

### VyOS Ansible Specifics
- **connection type**: use `ansible.netcommon.network_cli` 
- **modules hierarchy**:
  1. Prefer `vyos.vyos.*` collection modules
  2. Use `vyos.vyos.vyos_config` for complex configs
  3. Only use `vyos.vyos.vyos_command` for show commands
  
### Configuration Best Practices
- **config structure**: follow VyOS hierarchical config structure
- **atomic changes**: group related changes in single playbook task
- **commit message**: include descriptive commit message in playbook
- **save config**: **must** save configuration after successful commit
- **example task**:
  ```yaml
  - name: Configure interface
    vyos.vyos.vyos_config:
      lines:
        - set interfaces ethernet eth0 address '192.168.1.1/24'
        - set interfaces ethernet eth0 description 'Management'
      save: yes
      comment: "[Claude] Configured management interface"
  ```

### Error Handling
- **config conflicts**: if commit fails, check for conflicting configuration
- **rollback**: document how to rollback if needed (previous config versions)
- **validation**: use `validate` or `check` mode when available

## loop detection and prevention
### Definition of Loops
- **repetitive actions**: doing the same action 3+ times with same/similar result
- **error loops**: encountering same error repeatedly despite attempts to fix
- **search loops**: searching for same thing in multiple places without finding it
- **implementation loops**: trying same solution approach that keeps failing

### Loop Detection Rules
- **must track**: count identical/similar actions or errors
- **loop threshold**: after 2 identical failures, **must stop** before third attempt
- **pattern recognition**: if output/error is >80% similar to previous, consider it same
- **action types** that count toward loops:
  - Same command with same error
  - Same file edit that gets rejected/fails
  - Same search with no results
  - Same test/build failure
  - Same API call with same error response

### Required Actions on Loop Detection
- **immediate stop**: do not attempt third iteration
- **inform user**: "I appear to be stuck in a loop trying to [action]. The same [error/result] occurred twice."
- **ask for guidance**: "Should I try a different approach or would you like to provide guidance?"
- **save tokens**: stop all automated attempts until user responds

### Examples
- Python: same import error twice → stop
- Ansible: same playbook failure twice → stop
- Git: same merge conflict twice → stop
- Search: same file not found twice → stop
- API: same 404 error twice → stop

### Prevention
- **vary approach**: after first failure, must try different solution
- **check assumptions**: verify prerequisites before retrying
- **read errors carefully**: ensure understanding error before retry

## testing requirements
- **python**: check for pytest/unittest in project, run if found
- **ansible**: use --check mode as test
- **detection**: look for test/, tests/, *_test.py, test_*.py
- **no test framework**: inform user, suggest adding tests

## performance and limits
- **batch operations**: max 50 items per batch for NetBox updates
- **query limits**: always use pagination (10-20 items per page)
- **file operations**: read/write in chunks for files >1MB
- **timeout awareness**: long-running operations need progress updates

# important-instruction-reminders
Do what has been asked; nothing more, nothing less.
NEVER create files unless they're absolutely necessary for achieving your goal.
ALWAYS prefer editing an existing file to creating a new one.
NEVER proactively create documentation files (*.md) or README files. Only create documentation files if explicitly requested by the User.