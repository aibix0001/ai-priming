# Rule: netbox-rules

## Description
NetBox-specific rules and workflows for Claude Code, covering MCP integration, API operations, change tracking, and network documentation management.

## Prerequisites
- NetBox MCP server configured for queries
- API token stored in `.env` file (see `/secrets` command)
- SSL considerations for self-signed certificates

## Extends
- Base: /CLAUDE.md

## Steps

### 1. Query Setup
- Use NetBox MCP for all read operations
- Implement pagination with max 10 items per page
- Never attempt to get all results in a single query

### 2. API Operations
- Use curl with API token for CREATE/UPDATE/DELETE operations
- Use `--insecure` flag for self-signed certificates
- Check API documentation for correct endpoints

### 3. Change Tracking
- Add "claude" tag to all modified objects
- Create tag if it doesn't exist
- Append descriptive comments with format: `[Claude: <date> - <description>]`

### 4. Data Management
- Use PATCH requests to preserve existing data
- Handle comment conflicts appropriately
- Implement batch operations for large datasets

### 5. Validation
- Test connectivity before bulk operations
- Verify API responses and error handling
- Validate changes through MCP queries

## Configuration

### Files Created
- None (NetBox is external service)

### Files Modified
- `.env` - Add NETBOX_URL and NETBOX_API_TOKEN
- `.claude-commands.memory` - Add netbox-rules.md to initialization list

## Post-Setup
1. Test API connectivity: `curl -s --insecure -H "Authorization: Token $NETBOX_API_TOKEN" "$NETBOX_URL/api/" | jq -e '.dcim'`
2. Verify MCP server is responding
3. Check pagination functionality with sample query
4. Validate tag creation and comment update processes

## Queries and Retrieval

### NetBox MCP Usage
- **NetBox queries**: always use netbox MCP for reading/querying data
- **Pagination required**: **must** handle pagination - netbox MCP returns max 10 items per page
- **Overflow prevention**: MCP can return too many results causing assistant overflow - ALWAYS paginate
- **Never query all**: NEVER attempt to get all results in a single query

### Query Strategy
- Start with offset=0, limit=10
- Process results in chunks
- Continue until no more results or user-specified limit reached
- Example: `filters={"offset": 0, "limit": 10}` then `{"offset": 10, "limit": 10}` etc.

### Example Query Pattern
```python
# Paginated query example
offset = 0
limit = 10
all_devices = []

while True:
    filters = {"offset": offset, "limit": limit}
    result = netbox_mcp.query("devices", filters)
    
    if not result or len(result) == 0:
        break
        
    all_devices.extend(result)
    offset += limit
    
    # Safety check to prevent infinite loops
    if len(all_devices) >= user_specified_limit:
        break
```

## Making Changes

### API Operations
- **NetBox changes**: use curl with API token for CREATE/UPDATE/DELETE operations
- **SSL certificates**: use `--insecure` flag for self-signed certificates
- **API endpoints**: check documentation for correct endpoint before making changes

### Example API Calls
```bash
# Create device
curl -X POST \
  --insecure \
  -H "Authorization: Token $NETBOX_API_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"name": "switch01", "device_type": 1, "site": 1}' \
  "$NETBOX_URL/api/dcim/devices/"

# Update device
curl -X PATCH \
  --insecure \
  -H "Authorization: Token $NETBOX_API_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"status": "active"}' \
  "$NETBOX_URL/api/dcim/devices/123/"
```

## Change Tracking

### Claude Tag Management
- **Claude tag**: **must** add tag named "claude" to all modified objects
- **Tag creation**: create tag if it doesn't exist
- **Tag properties**: simple tag with name="claude" and appropriate color

### Create Claude Tag
```bash
curl -X POST \
  --insecure \
  -H "Authorization: Token $NETBOX_API_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"name": "claude", "color": "2196f3"}' \
  "$NETBOX_URL/api/extras/tags/"
```

### Comments Management
- **Comments format**: add descriptive comment with format: `[Claude: <date> - <description>]`
- **Comment handling**: **must** use PATCH requests to append comments
- **Must not** overwrite existing comments
- **Must** preserve all existing data

### Comment Conflict Resolution
- **Existing claude comment with same date**: append with timestamp
- **Comments field is null/missing**: add it
- **Comments exceed field limit**: stop and ask user
- **Concurrent modification detected**: re-read, retry once, then ask

### Comment Format Examples
```bash
# Format: Always append with newline
existing_comment + "\n[Claude: 2024-01-07 - Description]"

# Example result:
"Original device comment\n[Claude: 2024-01-07 - Added VLAN 100 for management]"
```

### Safe Comment Update Process
```bash
# 1. Get current object
current_data=$(curl -s --insecure \
  -H "Authorization: Token $NETBOX_API_TOKEN" \
  "$NETBOX_URL/api/dcim/devices/123/")

# 2. Extract existing comments
existing_comments=$(echo "$current_data" | jq -r '.comments // ""')

# 3. Append new comment
new_comment="$existing_comments\n[Claude: $(date +%Y-%m-%d) - $DESCRIPTION]"

# 4. Update with PATCH
curl -X PATCH \
  --insecure \
  -H "Authorization: Token $NETBOX_API_TOKEN" \
  -H "Content-Type: application/json" \
  -d "{\"comments\": \"$new_comment\"}" \
  "$NETBOX_URL/api/dcim/devices/123/"
```

## Performance and Limits

### Batch Operations
- **Batch operations**: max 50 items per batch for NetBox updates
- Process large datasets in manageable chunks
- Include progress updates for long-running operations

### Rate Limiting
- Be mindful of API rate limits
- Implement delays between requests if needed
- Monitor response times and adjust accordingly

## Documentation and Verification

### Required Reading
- **Required reading**: consult https://netbox.readthedocs.io before implementing new functionality
- **API reference**: use API docs to verify endpoints and required fields
- Check NetBox version compatibility for features

### API Endpoint Verification
```bash
# List available endpoints
curl -s --insecure \
  -H "Authorization: Token $NETBOX_API_TOKEN" \
  "$NETBOX_URL/api/" | jq

# Check specific endpoint schema
curl -s --insecure \
  -H "Authorization: Token $NETBOX_API_TOKEN" \
  "$NETBOX_URL/api/dcim/devices/" | jq
```

## Error Handling

### Common Error Scenarios
- Invalid API token
- SSL certificate issues
- Rate limiting
- Data validation errors
- Concurrent modification conflicts

### Error Response Handling
```python
def handle_netbox_error(response):
    if response.status_code == 401:
        raise ValueError("Invalid API token")
    elif response.status_code == 403:
        raise ValueError("Insufficient permissions")
    elif response.status_code == 404:
        raise ValueError("Resource not found")
    elif response.status_code == 400:
        raise ValueError(f"Validation error: {response.json()}")
    else:
        response.raise_for_status()
```

## Secrets Management

Refer to CLAUDE.md "Secrets and Credentials Management" section for general principles.

### NetBox-Specific Requirements
```bash
# Required environment variables in .env
NETBOX_URL=https://netbox.example.com
NETBOX_API_TOKEN=<YOUR_NETBOX_API_TOKEN>
```

- Use `--insecure` flag for self-signed certificates in curl commands
- Access via shell: `$NETBOX_API_TOKEN` and `$NETBOX_URL`

## Testing and Validation

### API Integration Testing
- Test connectivity before bulk operations
- Validate API responses and error handling
- Use pagination to test data retrieval
- Verify CRUD operations in development environment

### Example Test Pattern
```bash
# Test API connectivity
curl -s --insecure \
  -H "Authorization: Token $NETBOX_API_TOKEN" \
  "$NETBOX_URL/api/" | jq -e '.dcim'
```

## Common Workflows

### Device Management
1. Query existing devices using MCP
2. Create/update devices using API
3. Add Claude tag to modified objects
4. Append descriptive comments
5. Verify changes through MCP queries

### VLAN Management
1. Query existing VLANs with pagination
2. Create new VLANs with proper site/tenant assignment
3. Update device interfaces with VLAN assignments
4. Tag and comment all changes
5. Verify configuration consistency

## Memory Integration

After using this rule, Claude must:

- **1.** Check if `.claude-commands.memory` file exists - if not, create it with initial content:
```
## read these files upon initialization

```

- **2.** Check if `- /ai-rules/netbox-rules.md` is listed under section `## read these files upon initialization` in `.claude-commands.memory`
- **3.** If not listed: add `- /ai-rules/netbox-rules.md` to list under section `## read these files upon initialization` in `.claude-commands.memory`