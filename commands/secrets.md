# Secrets and Credentials Management Command

This command provides comprehensive credential and secrets management rules for Claude Code across all tools and platforms.

## Basic Rules

### Credential Storage
- **Credential storage**: **must** store all credentials, tokens, and secrets in `.env` file
- **Git security**: `.env` file **must not** ever be committed to git
- **.gitignore**: **must** ensure `.env` is in `.gitignore`
- **Example file**: **must** create and maintain `.env.example` with all variables but generic values
- **Example maintenance**: when adding new env variable to `.env`, **must** immediately add to `.env.example`
- **Commit example**: `.env.example` **must** be committed to git as reference

### .env.example Format
```bash
# API Configuration
API_BASE_URL=https://api.example.com
API_TOKEN=<YOUR_API_TOKEN>

# Database Configuration
DB_HOST=localhost
DB_PORT=5432
DB_NAME=myapp
DB_USER=<YOUR_DB_USER>
DB_PASSWORD=<YOUR_DB_PASSWORD>

# Third-party Services
NETBOX_URL=https://netbox.example.com
NETBOX_API_TOKEN=<YOUR_NETBOX_API_TOKEN>

# Infrastructure Access
VYOS_USERNAME=<YOUR_VYOS_USERNAME>
VYOS_PASSWORD=<YOUR_VYOS_PASSWORD>
ANSIBLE_VAULT_PASSWORD=<YOUR_VAULT_PASSWORD>

# Remember to rotate credentials regularly
```

## Context-Specific Handling

### Python Scripts
- **Must** use `python-dotenv` to load `.env`
- Add to script start: `load_dotenv()`
- **Must** add `python-dotenv` to requirements.txt

```python
from dotenv import load_dotenv
import os

load_dotenv()

API_TOKEN = os.getenv('API_TOKEN')
DB_PASSWORD = os.getenv('DB_PASSWORD')
```

### Ansible
- Use `lookup('env', 'VARIABLE_NAME')` in playbooks
- For inventory: export vars before running or use wrapper script
- Vault password: use `ANSIBLE_VAULT_PASSWORD_FILE` env var pointing to file

```yaml
# In playbook
- name: Connect to API
  uri:
    url: "{{ lookup('env', 'API_BASE_URL') }}/endpoint"
    headers:
      Authorization: "Bearer {{ lookup('env', 'API_TOKEN') }}"
```

### Docker
- **Must** add `.env` to `.dockerignore`
- Use `env_file: .env` in docker-compose.yml
- For production: use Docker secrets or environment-specific `.env` files

```yaml
# docker-compose.yml
services:
  app:
    build: .
    env_file: .env
    # Or specific environment variables
    environment:
      - API_TOKEN=${API_TOKEN}
```

### Shell Scripts
- Source .env file: `. ./.env` or `source ./.env`
- **Must** check if `.env` exists before sourcing

```bash
#!/bin/bash
if [ -f .env ]; then
    source .env
fi

curl -H "Authorization: Bearer $API_TOKEN" "$API_BASE_URL/endpoint"
```

### CI/CD
- **Must not** store `.env` in repository
- Document required env vars in `.env.example` and README
- Use CI/CD platform's secret management:
  - GitHub Secrets
  - GitLab Variables
  - Jenkins Credentials
  - Azure DevOps Variable Groups

## Security Best Practices

### File Permissions
- `.env` file should have restricted permissions (600 or 640)
- Never make `.env` world-readable

```bash
chmod 600 .env
```

### Rotation and Maintenance
- Add comment in `.env.example` about regular credential rotation
- Document credential sources and renewal processes
- Set up alerts for credential expiration where possible

### Backup Security
- Never backup `.env` files to shared/public locations
- If backup needed, use encrypted storage
- Consider using dedicated secret management systems for production

## Tool-Specific Integration

### NetBox
```bash
NETBOX_URL=https://netbox.example.com
NETBOX_API_TOKEN=<YOUR_NETBOX_API_TOKEN>
```

### VyOS
```bash
VYOS_USERNAME=<YOUR_VYOS_USERNAME>
VYOS_PASSWORD=<YOUR_VYOS_PASSWORD>
```

### Ansible Vault
```bash
ANSIBLE_VAULT_PASSWORD=<YOUR_VAULT_PASSWORD>
ANSIBLE_VAULT_PASSWORD_FILE=.vault_pass
```

## Production Considerations

### Environment-Specific Files
- `.env.development`
- `.env.staging`
- `.env.production`
- Load appropriate file based on environment

### Secret Management Systems
For production environments, consider:
- HashiCorp Vault
- AWS Secrets Manager
- Azure Key Vault
- Google Secret Manager
- Kubernetes Secrets

## Common Patterns

### Loading Environment Variables
```python
import os
from dotenv import load_dotenv

load_dotenv()

# Required environment variables
REQUIRED_VARS = ['API_TOKEN', 'DB_PASSWORD', 'SECRET_KEY']

for var in REQUIRED_VARS:
    if not os.getenv(var):
        raise ValueError(f"Required environment variable {var} is not set")
```

### Configuration Class
```python
class Config:
    def __init__(self):
        load_dotenv()
        self.api_token = os.getenv('API_TOKEN')
        self.db_password = os.getenv('DB_PASSWORD')
        self.debug = os.getenv('DEBUG', 'False').lower() == 'true'
```

## Integration with Other Commands

This command integrates with:
- `/python` - for python-dotenv usage
- `/ansible` - for vault and inventory management
- `/docker` - for container environment management
- All other commands that handle credentials