# Rule: gitlab-rules

## Description
Remote GitLab platform interaction guidelines for Claude Code, covering glab CLI usage for issue management, labeling, pipeline monitoring, and GitLab collaboration via the remote platform.

## Extends
- Base: @ai-rules/git.md

## Prerequisites
- Git installed (version 2.20 or higher recommended)
- GitLab account with appropriate project access
- glab CLI installed and configured (`glab auth login`)
- Basic understanding of GitLab workflows
- Repository initialized and connected to GitLab

## Steps

### 1. Documentation and Command Reference
- **Documentation first**: Always reference glab documentation (`glab help` or `glab <command> --help`) before using unfamiliar commands
- **Error prevention**: Emphasize reading documentation to avoid error loops from incorrect usage
- **Quick reference**: Maintain familiarity with common glab commands:
  - `glab issue create` - Create new issues
  - `glab issue list` - List issues
  - `glab issue view <number>` - View issue details
  - `glab mr create` - Create merge requests
  - `glab mr list` - List merge requests
  - `glab pipeline list` - View CI/CD pipelines
- **Troubleshooting**: When glab commands fail, check authentication (`glab auth status`) and project access first

### 2. Issue Management via glab CLI
- **Issue creation**: Use `glab issue create` to create new issues on GitLab
- **Issue listing**: Use `glab issue list` to view issues
- **Issue viewing**: Use `glab issue view <number>` to view specific issue details
- **Issue commenting**: Use `glab issue comment <number>` to add comments
- **Issue status updates**: Use glab commands to update issue status and progress
- **Issue closing**: Use `glab issue close <number>` when work is complete

### 3. Label Management System
- **Required labels**: Create required labels if they don't exist:
  - 'claude-work-on-issue' (user-applied, signals ready for work)
  - 'claude-working-on-issue' (red, applied when starting work)
  - 'claude-finished-issue' (orange, applied when work is complete)
  - 'claude-awaiting-confirmation' (purple, applied when waiting for user input)
- **Label lifecycle**: Proper label lifecycle management through workflow states
- **Label creation**: Use glab CLI to create missing labels:
  ```bash
  glab label create "claude-work-on-issue" --color "#0052CC" --description "User-approved issue ready for Claude to work on"
  glab label create "claude-working-on-issue" --color "#FF0000" --description "Claude is actively working on this issue"
  glab label create "claude-finished-issue" --color "#FFA500" --description "Claude has completed work on this issue"
  glab label create "claude-awaiting-confirmation" --color "#800080" --description "Claude is waiting for user confirmation/input"
  ```
- **Color specifications**: Visual workflow status identification through consistent color coding

### 4. Merge Request Management via glab CLI
- **MR creation**: Use `glab mr create` to create merge requests on GitLab
- **MR listing**: Use `glab mr list` to view merge requests
- **MR viewing**: Use `glab mr view <number>` to view MR details
- **MR approval**: Use `glab mr approve <number>` to approve merge requests
- **MR merging**: Use `glab mr merge <number>` to merge approved requests
- **Reviewer assignment**: Use `glab mr create --reviewer <username>` to assign reviewers
- **Draft MRs**: Use `glab mr create --draft` for work-in-progress merge requests

### 5. CI/CD Pipeline Monitoring via glab CLI
- **Pipeline listing**: Use `glab pipeline list` to view pipeline status
- **Pipeline details**: Use `glab pipeline view <id>` to view specific pipeline details
- **Pipeline monitoring**: Use `glab pipeline status` to check current pipeline status
- **Pipeline artifacts**: Use `glab pipeline artifacts` to download pipeline artifacts
- **Pipeline retry**: Use `glab pipeline retry <id>` to retry failed pipelines
- **Pipeline cancellation**: Use `glab pipeline cancel <id>` to cancel running pipelines

### 6. GitLab Platform Communication via glab CLI
- **Issue commenting**: Use `glab issue comment <number> "message"` to add comments
- **Issue description updates**: Use `glab issue edit <number>` to update issue descriptions
- **Issue assignments**: Use `glab issue assign <number> <username>` to assign issues
- **Issue due dates**: Use `glab issue edit <number> --due-date <date>` to set due dates
- **Issue milestones**: Use `glab issue edit <number> --milestone <milestone>` to set milestones
- **MR commenting**: Use `glab mr comment <number> "message"` to comment on merge requests
- **MR description updates**: Use `glab mr edit <number>` to update MR descriptions

### 7. glab CLI Error Handling
- **Documentation reference**: Always check glab documentation (`glab help` or `glab <command> --help`) when encountering errors
- **Authentication issues**: Verify `glab auth status` before troubleshooting other issues
- **Project access**: Confirm project access with `glab repo view`
- **Command validation**: Use `glab <command> --help` to verify command syntax before execution
- **Connection issues**: Check network connectivity and GitLab instance availability
- **Rate limiting**: Handle GitLab API rate limits gracefully with appropriate delays

## Configuration

### Remote GitLab Configuration
- **GitLab labels**: Created via `glab label create` commands
- **Issue templates**: Configured via GitLab project settings
- **Merge request templates**: Configured via GitLab project settings
- **Branch protection rules**: Configured via GitLab project settings
- **CI/CD pipelines**: Configured via `.gitlab-ci.yml` (file operations handled by git.md)

### Local Files Modified
- `.claude-commands.memory` - Add gitlab.md to initialization list

### Labels Required
- 'claude-work-on-issue' (user-applied, blue #0052CC)
- 'claude-working-on-issue' (red #FF0000)
- 'claude-finished-issue' (orange #FFA500)
- 'claude-awaiting-confirmation' (purple #800080)

### GitLab CLI Configuration
- **Authentication**: Ensure `glab auth login` is configured
- **Project access**: Verify access to GitLab project
- **Issue permissions**: Confirm ability to create and modify issues
- **MR permissions**: Verify merge request creation permissions
- **Pipeline access**: Ensure CI/CD pipeline visibility

## Post-Setup

After applying GitLab rules:
1. Verify glab authentication: `glab auth status`
2. Check project access: `glab repo view`
3. Validate issue access: `glab issue list`
4. Test merge request permissions: `glab mr list`
5. Confirm CI/CD pipeline visibility: `glab pipeline list`
6. Create required labels if missing
7. Test issue creation and labeling workflow

## GitLab Platform Best Practices

### glab CLI Usage Patterns
- **Command verification**: Always verify glab commands with `--help` before execution
- **Batch operations**: Use glab list commands to process multiple items efficiently
- **Error handling**: Check command exit codes and handle failures gracefully
- **Authentication management**: Regularly verify `glab auth status` to prevent authentication errors

### GitLab Remote Operations
- **Issue references**: Use consistent issue referencing in titles and descriptions
- **Label application**: Apply labels systematically using glab commands
- **MR linking**: Use closing keywords ("Closes #123") in MR descriptions to auto-close issues
- **Pipeline monitoring**: Regularly check pipeline status before proceeding with operations

## Memory Integration

After using this rule, Claude must add `- @ai-rules/gitlab.md` to the memory integration list following the same process defined in git.md base rule.