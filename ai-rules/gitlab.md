# Rule: gitlab-rules

## Description
GitLab-specific workflow guidelines and best practices for Claude Code, covering issue management, merge request workflows, CI/CD integration, and GitLab collaboration patterns.

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

### 2. Issue Management Workflow
- **Issue creation**: All bugs, new features, or fixes must start as an issue (`glab issue create`)
- **Work authorization**: Check for 'claude-work-on-issue' label before starting work
- **Authorization requirement**: Assistant must not start working on issues without 'claude-work-on-issue' label
- **Pre-work check**: Check issue comments for last-minute user input before starting work
- **User questions**: If user asks questions in comments, answer and mark with 'claude-awaiting-confirmation' label (purple)
- **Status updates**: Update issue status/progress with comments during work
- **Progress tracking**: Regular comments with implementation progress and status updates

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

### 4. Branch and Merge Request Workflow
- **Branch naming**: Create branches with issue numbers (e.g., `feature/123-implement-login`)
- **Automated creation**: Use `glab issue create --branch` when possible for automatic branch creation
- **Merge request creation**: Create merge requests using `glab mr create` when work is complete
- **MR title standards**: MR title should reference issue number (e.g., "Fix: Resolve issue #123")
- **MR description standards**: MR description should link to original issue and include testing notes
- **Reviewer assignment**: Assign merge requests to appropriate reviewers if specified
- **Automatic closure**: Close issues automatically when MR is merged (using closing keywords like "Closes #123")

### 5. CI/CD Integration
- **Pipeline monitoring**: Check pipeline status before creating merge requests
- **Quality gates**: Wait for CI/CD pipelines to pass before marking work as complete
- **Pipeline failures**: Monitor pipeline failures and create follow-up issues if needed
- **Status reporting**: Include pipeline status in work progress updates
- **Pipeline validation**: Use `glab pipeline list` to check current pipeline status
- **CI/CD compliance**: Respect CI/CD quality requirements and gates

### 6. Communication and Documentation
- **Implementation details**: Update issue descriptions with implementation details
- **Failed approaches**: Document failed approaches in issue comments
- **Blocker handling**: Create follow-up issues for blockers encountered during work
- **Communication timeline**: Maintain clear communication timeline in issue comments
- **Documentation reference**: Reference relevant GitLab project documentation
- **Progress transparency**: Provide regular status updates throughout work progression

### 7. Issue Lifecycle Management
- **Discovery phase**: Issue created by user or system
- **Review phase**: User adds 'claude-work-on-issue' label after review
- **Pre-work check**: Assistant checks comments for questions/clarifications
- **Confirmation phase**: If questions exist, add 'claude-awaiting-confirmation' label and wait
- **Work start**: Add 'claude-working-on-issue' label and begin implementation
- **Progress updates**: Regular comments with status updates
- **Completion phase**: Add 'claude-finished-issue' label when work is done
- **Merge phase**: Create MR, wait for CI/CD, merge, auto-close issue

### 8. Error Handling and Recovery
- **Documentation reference**: Always check glab documentation when encountering errors
- **Authentication issues**: Verify `glab auth status` before troubleshooting other issues
- **Project access**: Confirm project access with `glab repo view`
- **Command validation**: Use `glab <command> --help` to verify command syntax
- **Error documentation**: Document errors and solutions in issue comments
- **Follow-up issues**: Create separate issues for unresolved blockers

## Configuration

### Files Created
- `.gitlab-ci.yml` - May be updated as part of CI/CD workflow
- Branch protection rules - Via GitLab project settings
- Issue templates - Via GitLab project settings

### Files Modified
- `README.md` - May be updated with GitLab workflow documentation
- Project files - As part of normal development workflow
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

## GitLab-Specific Best Practices

### Merge Request Best Practices
- **Title standards**: Consistent, descriptive titles with issue references
- **Description templates**: Comprehensive descriptions with testing notes
- **Review process**: Proper reviewer assignment and review workflow
- **Merge strategy**: Appropriate merge methods for different scenarios
- **Closing keywords**: Use "Closes #123" or "Fixes #123" to auto-close issues

### Communication Protocols
- **Issue comments**: Structured progress updates and status reports
- **Documentation**: Clear documentation of approaches and decisions
- **Error reporting**: Comprehensive error and blocker documentation
- **Follow-up**: Proper creation of follow-up issues for unresolved items

### Workflow Automation
- **Label automation**: Automatic label application based on workflow state
- **Issue linking**: Proper linking between issues, branches, and merge requests
- **Pipeline integration**: Automated pipeline status checking and reporting
- **Status synchronization**: Keep issue status synchronized with actual work progress

## Memory Integration

After using this rule, Claude must:

- **1.** Check if `.claude-commands.memory` file exists - if not, create it with initial content:
```
## read these files upon initialization

```

- **2.** Check if `- @ai-rules/gitlab.md` is listed under section `## read these files upon initialization` in `.claude-commands.memory`
- **3.** If not listed: add `- @ai-rules/gitlab.md` to list under section `## read these files upon initialization` in `.claude-commands.memory`