# Rule: vyos-rules

## Description
VyOS-specific rules and workflows for Claude Code, covering network device configuration, Ansible automation, and VyOS Stream best practices.

## Prerequisites
- VyOS devices accessible via SSH
- Ansible with VyOS collection installed
- Credentials configured (see `/secrets` command)
- Network connectivity to target devices

## Extends
- Base: /CLAUDE.md

## Steps

### 1. Documentation Review
- Consult VyOS documentation before implementing new features
- Check VyOS Stream-specific features and syntax
- Verify command syntax in documentation before execution

### 2. Ansible Setup
- Use Ansible playbooks for all configuration changes
- Configure network_cli connection type
- Set ansible_network_os to vyos
- Use environment variables for credentials

### 3. Configuration Management
- Follow VyOS hierarchical configuration structure
- Group related changes in single playbook tasks
- Include descriptive commit messages
- Save configuration after successful commits

### 4. Error Handling
- Create backups before major changes
- Use commit-confirm for critical changes
- Implement rollback procedures
- Validate configuration before applying

### 5. Verification
- Use show commands for information gathering
- Verify configuration after changes
- Test connectivity post-configuration
- Monitor logs for errors

## Configuration

### Files Created
- `vyos-playbooks/` - Ansible playbooks directory
- `group_vars/vyos.yml` - VyOS-specific variables
- `host_vars/[device].yml` - Device-specific variables
- `templates/` - Configuration templates
- `backup/` - Configuration backups

### Files Modified
- `.env` - Add VYOS_USERNAME and VYOS_PASSWORD
- `inventory/hosts.yml` - VyOS device inventory
- `.claude-commands.memory` - Add vyos-rules.md to initialization list

## Post-Setup
1. Test connectivity: `ansible vyos_hosts -m ping`
2. Gather device facts: `ansible vyos_hosts -m vyos.vyos.vyos_facts`
3. Validate playbook syntax: `ansible-playbook --syntax-check vyos-config.yml`
4. Run dry-run: `ansible-playbook --check vyos-config.yml`

## Documentation Requirements

### Required Reading
- **Required reading**: **must** consult documentation before implementing:
  - Configuration: https://docs.vyos.io/en/latest/configuration/index.html
  - Automation: https://docs.vyos.io/en/latest/automation/index.html
- **Version specific**: We use **VyOS Stream** release
  - Always check Stream-specific features/syntax
  - Stream may have newer features not in LTS
  - When docs show version differences, use Stream syntax

### When to Consult Documentation
- **Must consult**:
  - New feature implementation
  - Unfamiliar commands
  - Error resolution
  - Complex configurations (VPNs, routing protocols, etc.)
- **Quick reference OK for**:
  - Basic interface configuration
  - Simple firewall rules
  - Standard show commands

### Command Verification
- **Command verification**: verify command syntax in docs before execution
- Test commands in lab environment when possible
- Use `commit-confirm` for critical changes

## Configuration Methods

### Ansible-Only Rule
- **Ansible required**: **must** use Ansible playbooks for all configuration changes
- **Adhoc commands**: only for information gathering (show commands), never for config
- **Manual config**: avoid SSH manual configuration unless explicitly requested

### VyOS Ansible Specifics
- **Connection type**: use `ansible.netcommon.network_cli`
- **Network OS**: set `ansible_network_os: vyos`
- **Modules hierarchy**:
  1. Prefer `vyos.vyos.*` collection modules
  2. Use `vyos.vyos.vyos_config` for complex configs
  3. Only use `vyos.vyos.vyos_command` for show commands

### Connection Configuration
```yaml
# In inventory or group_vars
ansible_connection: network_cli
ansible_network_os: vyos
ansible_user: "{{ lookup('env', 'VYOS_USERNAME') }}"
ansible_password: "{{ lookup('env', 'VYOS_PASSWORD') }}"
```

## Configuration Best Practices

### Hierarchical Configuration
- **Config structure**: follow VyOS hierarchical config structure
- **Atomic changes**: group related changes in single playbook task
- **Validation**: use `validate` or `check` mode when available

### Configuration Management
- **Commit message**: include descriptive commit message in playbook
- **Save config**: **must** save configuration after successful commit
- **Backup**: create backup before major changes

### Example Configuration Task
```yaml
- name: Configure interface
  vyos.vyos.vyos_config:
    lines:
      - set interfaces ethernet eth0 address '192.168.1.1/24'
      - set interfaces ethernet eth0 description 'Management'
    backup: yes
    save: yes
    comment: "[Claude] Configured management interface"
  register: config_result
  
- name: Verify configuration
  vyos.vyos.vyos_command:
    commands:
      - show interfaces ethernet eth0
  register: interface_status
```

## Error Handling and Recovery

### Configuration Conflicts
- **Config conflicts**: if commit fails, check for conflicting configuration
- **Rollback**: document how to rollback if needed (previous config versions)
- **Validation**: use `validate` or `check` mode when available

### Rollback Procedures
```yaml
- name: Configure with rollback safety
  vyos.vyos.vyos_config:
    lines:
      - set interfaces ethernet eth1 address '10.0.1.1/24'
    backup: yes
    comment: "Automated config - {{ ansible_date_time.iso8601 }}"
  register: config_result
  
- name: Rollback on failure
  vyos.vyos.vyos_config:
    lines:
      - rollback 1
    save: yes
  when: config_result.failed
```

### Common Error Scenarios
- Syntax errors in configuration commands
- Conflicting configuration statements
- Network connectivity issues
- Authentication/authorization failures
- Resource constraints (memory, disk space)

## Show Commands and Information Gathering

### Approved Show Commands
```yaml
- name: Gather system information
  vyos.vyos.vyos_command:
    commands:
      - show version
      - show interfaces
      - show ip route
      - show configuration
      - show system uptime
  register: system_info
```

### Information Gathering Tasks
- Use `vyos.vyos.vyos_command` for show commands
- Gather facts with `vyos.vyos.vyos_facts`
- Register output for further processing
- Parse structured data when available

## Common Configuration Patterns

### Interface Configuration
```yaml
- name: Configure interfaces
  vyos.vyos.vyos_config:
    lines:
      - set interfaces ethernet {{ item.name }} address {{ item.address }}
      - set interfaces ethernet {{ item.name }} description '{{ item.description }}'
    backup: yes
    save: yes
    comment: "Interface configuration via Ansible"
  loop: "{{ interface_config }}"
  when: interface_config is defined
```

### Firewall Configuration
```yaml
- name: Configure firewall rules
  vyos.vyos.vyos_config:
    lines:
      - set firewall name OUTSIDE-IN rule 10 action accept
      - set firewall name OUTSIDE-IN rule 10 state established enable
      - set firewall name OUTSIDE-IN rule 10 state related enable
    backup: yes
    save: yes
    comment: "Basic firewall rules"
```

### Routing Configuration
```yaml
- name: Configure static routes
  vyos.vyos.vyos_config:
    lines:
      - set protocols static route {{ item.network }} next-hop {{ item.next_hop }}
    backup: yes
    save: yes
    comment: "Static route configuration"
  loop: "{{ static_routes }}"
  when: static_routes is defined
```

## Advanced Configuration

### Complex Configurations
For complex setups (VPNs, BGP, OSPF), always:
1. Consult VyOS documentation first
2. Plan configuration in logical groups
3. Use configuration templates when possible
4. Test in lab environment
5. Implement with proper error handling

### Configuration Templates
```yaml
- name: Configure BGP
  vyos.vyos.vyos_config:
    src: bgp.j2
    backup: yes
    save: yes
    comment: "BGP configuration from template"
  vars:
    bgp_asn: "{{ local_asn }}"
    neighbors: "{{ bgp_neighbors }}"
```

## Validation and Testing

### Configuration Validation
- Use `commit-confirm` for critical changes
- Validate syntax before applying
- Test connectivity after changes
- Monitor logs for errors

### Post-Configuration Verification
```yaml
- name: Verify configuration
  vyos.vyos.vyos_command:
    commands:
      - show interfaces
      - show ip route
      - show protocols
  register: verification_result
  
- name: Check connectivity
  vyos.vyos.vyos_command:
    commands:
      - ping {{ test_host }} count 3
  register: connectivity_test
```

## Secrets Management

Refer to CLAUDE.md "Secrets and Credentials Management" section for general principles.

### VyOS-Specific Requirements
```bash
# Required environment variables in .env
VYOS_USERNAME=<YOUR_VYOS_USERNAME>
VYOS_PASSWORD=<YOUR_VYOS_PASSWORD>
```

- Use Ansible's `lookup('env', 'VYOS_USERNAME')` for credentials
- Configure in group_vars or inventory with environment lookups

## Testing and Validation

### VyOS-Specific Testing
- **Primary test method**: Use `ansible-playbook --check` for dry runs
- **Connectivity testing**: Use `ansible all -m ping` before configuration
- **Configuration validation**: Use `commit-confirm` for critical changes
- **Post-change verification**: Run show commands to verify configuration

### Testing Commands
```bash
# Test connectivity
ansible vyos_hosts -m ping

# Dry run configuration
ansible-playbook --check vyos-config.yml

# Validate syntax
ansible-playbook --syntax-check vyos-config.yml
```

## Performance and Monitoring

### Configuration Performance
- Group related configuration changes
- Use atomic commits when possible
- Monitor configuration time for large changes
- Implement progress reporting for complex configurations

### Monitoring and Logging
- Check system logs after configuration changes
- Monitor resource usage during configuration
- Implement configuration change notifications
- Maintain audit trail of all changes

## Security Considerations

### Access Control
- Use principle of least privilege
- Implement proper authentication
- Use encrypted connections (SSH)
- Regular credential rotation

### Configuration Security
- Validate all configuration inputs
- Use secure defaults
- Implement proper firewall rules
- Regular security audits of configuration

## Memory Integration

After using this rule, Claude must:

- **1.** Check if `.claude-commands.memory` file exists - if not, create it with initial content:
```
## read these files upon initialization

```

- **2.** Check if `- /ai-rules/vyos-rules.md` is listed under section `## read these files upon initialization` in `.claude-commands.memory`
- **3.** If not listed: add `- /ai-rules/vyos-rules.md` to list under section `## read these files upon initialization` in `.claude-commands.memory`