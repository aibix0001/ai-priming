# VyOS Management Command

This command provides VyOS-specific rules and workflows for Claude Code.

## Prerequisites

- VyOS devices accessible via SSH
- Ansible with VyOS collection installed
- Credentials configured (see `/secrets` command)
- Network connectivity to target devices

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

### Device Authentication
```bash
# Required environment variables
VYOS_USERNAME=<YOUR_VYOS_USERNAME>
VYOS_PASSWORD=<YOUR_VYOS_PASSWORD>
```

### Credential Handling
- Store device credentials in `.env` file following `secrets.md` guidelines
- Use environment variable lookup in Ansible playbooks
- Never hardcode passwords in playbooks or inventory files
- Implement credential rotation procedures

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

## Integration with Other Commands

**Required Reading**: Before applying VyOS-specific rules, the assistant must read:
- `secrets.md` - for universal credential management principles
- `testing.md` - for configuration testing philosophy
- Generic CLAUDE.md rules for version control and change management

**Related Commands**: This command also works with:
- `ansible.md` - for playbook development and execution
- `netbox.md` - for device inventory and documentation

This command extends and implements the universal principles defined in the required files.

## Command Memory Tracking

**Important**: When this command is invoked, add the following to the project's command memory:
```bash
echo "$(date '+%Y-%m-%d %H:%M:%S'): .claude/commands/vyos.md" >> .claude-commands.memory
```

This helps track which commands have been used in the project for automatic rule refreshing.

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