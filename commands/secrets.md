# Secrets and Credentials Management

Universal credential and secrets management rules for Claude Code across all tools and platforms.

## Core Principles

### Environment File Management
- **Storage**: Store all credentials, tokens, and secrets in `.env` file
- **Git exclusion**: `.env` file **must never** be committed to git
- **Gitignore**: Ensure `.env` is in `.gitignore`
- **Template**: Create and maintain `.env.example` with placeholder values
- **Maintenance**: When adding new env variable to `.env`, immediately add to `.env.example`
- **Version control**: `.env.example` must be committed to git as reference

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

# Remember to rotate credentials regularly
```

## Security Best Practices

### File Permissions
- Set restrictive permissions on `.env` file (600 or 640)
- Never make `.env` world-readable
```bash
chmod 600 .env
```

### Credential Rotation
- Add rotation reminders in `.env.example`
- Document credential sources and renewal processes
- Set up alerts for credential expiration where possible

### Backup Security
- Never backup `.env` files to shared/public locations
- Use encrypted storage for backups when needed
- Consider dedicated secret management systems for production

## Production Considerations

### Environment-Specific Files
- Use separate files for different environments
- Load appropriate file based on environment context
- Never mix development and production credentials

### Secret Management Systems
For production environments, consider:
- HashiCorp Vault
- AWS Secrets Manager
- Azure Key Vault
- Google Secret Manager
- Kubernetes Secrets

## Integration with Other Commands

Tool-specific credential handling:
- See `python.md` for python-dotenv usage patterns
- See `ansible.md` for vault and inventory management
- See `netbox.md` for NetBox API token configuration
- See `vyos.md` for device authentication setup

## Command Memory Tracking

**Important**: When this command is invoked, add the following to the project's command memory:
```bash
echo "$(date '+%Y-%m-%d %H:%M:%S'): /secrets" >> .claude-commands.memory
```

This helps track which commands have been used in the project for automatic rule refreshing.