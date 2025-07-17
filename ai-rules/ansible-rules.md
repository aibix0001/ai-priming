# Rule: ansible-rules

## Description
Comprehensive Ansible automation workflows and best practices for Claude Code, covering inventory management, playbook development, variable management, and network device configuration.

## Prerequisites
- Ansible installed and configured
- Dynamic inventory configured (preferably NetBox)
- Environment variables configured (see `/secrets` command)
- Target hosts accessible

## Extends
- Base: /CLAUDE.md

## Steps

### 1. Inventory Setup
- Configure NetBox dynamic inventory plugin
- Set up netbox.yml with environment variables
- Verify inventory loads correctly with `ansible-inventory --list`

### 2. Playbook Development
- Create playbooks following proper structure
- Use descriptive names and appropriate tags
- Set `gather_facts: yes` unless explicitly not needed
- Implement proper error handling and idempotency

### 3. Variable Management
- Use group_vars/host_vars for environment-specific settings
- Parameterize all configurations
- Use environment variable lookups for sensitive data
- Follow variable precedence rules

### 4. Execution and Testing
- Run syntax checks before execution
- Use dry run (`--check`) for significant changes
- Test on subset of hosts first using `--limit`
- Implement proper failure handling protocols

### 5. Integration
- Integrate with NetBox for dynamic inventory
- Use Ansible Vault for sensitive data
- Update NetBox after successful configuration changes
- Commit changes to version control

## Configuration

### Files Created
- `netbox.yml` - NetBox dynamic inventory configuration
- `group_vars/all.yml` - Global variables
- `group_vars/[role].yml` - Role-specific variables
- `host_vars/[host].yml` - Host-specific variables
- `playbooks/[name].yml` - Playbook files
- `.vault_pass` - Vault password file (if using)

### Files Modified
- `.env` - Environment variables for API tokens and URLs
- `.claude-commands.memory` - Add ansible-rules.md to initialization list

## Post-Setup
1. Verify inventory loads correctly: `ansible-inventory --list`
2. Test connectivity: `ansible all -m ping`
3. Run syntax check: `ansible-playbook --syntax-check playbook.yml`
4. Execute dry run: `ansible-playbook --check playbook.yml`

## Inventory Management

### Dynamic Inventory Rules
- **Inventory source**: **must** use NetBox dynamic inventory plugin - never create static inventory
- **Inventory config**: netbox.yml must read API token and URL from environment variables (via `.env`)
- **Inventory verification**: run `ansible-inventory --list` to verify before running playbooks

### NetBox Inventory Configuration
```yaml
# netbox.yml
plugin: netbox.netbox.nb_inventory
api_endpoint: "{{ lookup('env', 'NETBOX_URL') }}"
token: "{{ lookup('env', 'NETBOX_API_TOKEN') }}"
validate_certs: false
config_context: false
group_by:
  - device_roles
  - sites
  - device_types
compose:
  ansible_host: primary_ip4.address | ipaddr('address')
```

### Inventory Verification Commands
```bash
# Verify inventory loads correctly
ansible-inventory --list

# Check specific group
ansible-inventory --list --limit switches

# Test connectivity
ansible all -m ping
```

## Playbook Development

### Playbook Structure Rules
- **Playbook only**: **must** use playbooks for all configuration tasks - no adhoc for changes
- **Adhoc usage**: only use adhoc commands for information gathering (facts, checks)
- **Playbook structure**:
  - Use descriptive names for plays and tasks
  - Include proper tags for selective execution
  - Always set `gather_facts: yes` unless explicitly not needed

### Example Playbook Structure
```yaml
---
- name: Configure network devices
  hosts: switches
  gather_facts: yes
  become: yes
  
  vars:
    config_timestamp: "{{ ansible_date_time.iso8601 }}"
  
  tasks:
    - name: Gather device facts
      setup:
      tags: [facts, always]
    
    - name: Configure interfaces
      # task implementation
      tags: [interfaces, config]
    
    - name: Save configuration
      # save task
      tags: [save, always]
```

## Variables and Configuration

### Variable Management
- **Variable precedence**: respect Ansible variable precedence - don't hardcode values in playbooks
- **Variable files**: use group_vars/host_vars for environment-specific settings
- **No hardcoding**: follow Python rules - parameterize everything
- **Environment variables**: use `lookup('env', 'VARIABLE_NAME')` for sensitive data

### Variable Hierarchy
```
group_vars/
  all.yml              # Global variables
  switches.yml         # Device role specific
  site_datacenter.yml  # Site specific
host_vars/
  switch01.yml         # Host specific
```

### Environment Variable Usage
```yaml
# In playbook
vars:
  api_token: "{{ lookup('env', 'NETBOX_API_TOKEN') }}"
  base_url: "{{ lookup('env', 'NETBOX_URL') }}"
```

## Execution and Error Handling

### Dry Run and Testing
- **Dry run first**: **should** run with `--check` when making significant changes
- **Validate syntax**: use `ansible-playbook --syntax-check` before execution
- **Limit scope**: use `--limit` to test on subset of hosts first

### Failure Handling Rules
- **Failure handling**: if playbook fails twice with same error - **must stop** and ask user
- **Identical failure definition**:
  - Same module failing on same task
  - Error message >80% similar (ignore timestamps/IDs)
  - Same host(s) affected
  - Example: "Connection timeout to 192.168.1.1" twice = stop

### Between Attempts Protocol
- **First failure**: check connectivity, verify credentials
- **Second failure**: STOP - do not attempt third time
- **Must vary approach** between attempts (different module, different method)

### Error Investigation Checklist
After failure, check:
- Connectivity to target hosts
- Authentication/privilege issues
- Module-specific error messages
- Variable substitution correctness
- Inventory group membership

### Example Error Handling
```yaml
- name: Configure interface
  vyos.vyos.vyos_config:
    lines:
      - set interfaces ethernet eth0 description 'Management'
  register: config_result
  failed_when: false
  
- name: Check configuration result
  fail:
    msg: "Configuration failed: {{ config_result.msg }}"
  when: config_result.failed and 'timeout' not in config_result.msg
```

## Network Device Specifics

### VyOS Connection
- **VyOS connection**: use `network_cli` connection type
- **VyOS modules**: prefer vyos-specific modules over raw/command when available
- See `/vyos` command for detailed VyOS-specific rules

### Connection Configuration
```yaml
# In inventory or group_vars
ansible_connection: network_cli
ansible_network_os: vyos
ansible_user: "{{ lookup('env', 'VYOS_USERNAME') }}"
ansible_password: "{{ lookup('env', 'VYOS_PASSWORD') }}"
```

## Idempotency and Best Practices

### Idempotency Rules
- **Idempotency**: ensure playbooks can run multiple times safely
- Use appropriate modules that support idempotency
- Check current state before making changes
- Use `changed_when` conditions appropriately

### Task Organization
- Group related tasks logically
- Use blocks for error handling
- Implement proper rollback mechanisms
- Document complex logic with comments

### Example Idempotent Task
```yaml
- name: Ensure VLAN exists
  vyos.vyos.vyos_config:
    lines:
      - set interfaces bridge br0 member interface eth1 vlan 100
    backup: yes
    comment: "Ansible managed - {{ ansible_date_time.iso8601 }}"
  register: vlan_config
  
- name: Commit configuration
  vyos.vyos.vyos_config:
    save: yes
  when: vlan_config.changed
```

## Integration with Other Systems

### NetBox Integration
- Use NetBox dynamic inventory
- Update NetBox after successful configuration changes
- Sync configuration state back to NetBox
- Use NetBox as source of truth for device data

### Vault Integration
- Use Ansible Vault for sensitive data
- Store vault password in environment variable
- Encrypt sensitive variable files
- Use `ansible-vault` commands for management

### Example Vault Usage
```bash
# Encrypt sensitive vars
ansible-vault encrypt group_vars/all/vault.yml

# Run playbook with vault
ansible-playbook -i inventory playbook.yml --ask-vault-pass

# Or use environment variable
export ANSIBLE_VAULT_PASSWORD_FILE=.vault_pass
ansible-playbook -i inventory playbook.yml
```

## Common Workflows

### Device Configuration Workflow
1. Verify inventory and connectivity
2. Run playbook with `--check` flag
3. Execute playbook with appropriate limits
4. Verify changes on target devices
5. Update NetBox with configuration changes
6. Commit changes to version control

### Troubleshooting Workflow
1. Check inventory and group membership
2. Test connectivity with adhoc ping
3. Verify credentials and permissions
4. Check variable substitution
5. Run with increased verbosity (`-vvv`)
6. Check logs on target devices

## Performance Considerations

### Parallel Execution
- Use `forks` setting to control parallelism
- Consider `serial` keyword for rolling updates
- Monitor system resources during execution

### Large Scale Operations
- Use `batch` or `throttle` for large inventories
- Implement progress reporting for long-running tasks
- Consider using `async` for long-running operations

## Secrets Management

Refer to CLAUDE.md "Secrets and Credentials Management" section for general principles.

### Ansible-Specific Implementation
- **Environment lookups**: Use `lookup('env', 'VARIABLE_NAME')` in playbooks
- **Ansible Vault**: For encrypting sensitive files
- **Vault password**: Store in `ANSIBLE_VAULT_PASSWORD_FILE` environment variable

```yaml
# Example usage in playbook
vars:
  api_token: "{{ lookup('env', 'API_TOKEN') }}"
  
# Vault commands
ansible-vault encrypt group_vars/all/vault.yml
ansible-playbook playbook.yml --ask-vault-pass
```

## Testing and Validation

### Ansible-Specific Testing
- **Syntax check**: Use `ansible-playbook --syntax-check playbook.yml`
- **Dry run**: Use `ansible-playbook --check playbook.yml` as primary test method
- **Lint check**: Use `ansible-lint playbook.yml` for best practices
- **Molecule**: Use for complex role testing scenarios

### Test Commands
```bash
# Syntax validation
ansible-playbook --syntax-check playbook.yml

# Dry run (preferred test method)
ansible-playbook --check playbook.yml

# Lint check
ansible-lint playbook.yml

# Molecule testing
molecule test
```

### Testing Strategy
- **Before deployment**: Always run syntax check and dry run
- **Limited testing**: Use `--limit` to test on subset of hosts first
- **Validation**: Test connectivity with `ansible all -m ping`
- **Post-deployment**: Verify changes on target devices

## Memory Integration

After using this rule, Claude must:

- **1.** Check if `.claude-commands.memory` file exists - if not, create it with initial content:
```
## read these files upon initialization

```

- **2.** Check if `- /ai-rules/ansible-rules.md` is listed under section `## read these files upon initialization` in `.claude-commands.memory`
- **3.** If not listed: add `- /ai-rules/ansible-rules.md` to list under section `## read these files upon initialization` in `.claude-commands.memory`