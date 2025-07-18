# GitLab Rules Blueprint Specification

## Overview
This document provides a comprehensive specification for creating a GitLab-specific `gitlab.md` rule file that extends the base `@ai-rules/git.md` and follows the established ai-rules structure from README.md.

## Purpose
The gitlab.md file will provide Claude Code with comprehensive GitLab workflow guidance, including issue management, merge request workflows, CI/CD integration, and GitLab-specific collaboration patterns, while building upon the generic Git rules foundation.

## Structure (Following README.md Template)

### Rule Header
```markdown
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
```

### Core Sections to Include

#### 1. Documentation and Command Reference
**Steps:**
- Always reference glab documentation (`glab help` or `glab <command> --help`) before using unfamiliar commands
- Emphasize reading documentation to avoid error loops from incorrect usage
- Provide quick reference for common glab commands
- Include troubleshooting section for common glab issues

#### 2. Issue Management via glab CLI
**Steps:**
- Use `glab issue create` to create new issues on GitLab
- Use `glab issue list` to view issues
- Use `glab issue view <number>` to view specific issue details
- Use `glab issue comment <number>` to add comments
- Use glab commands to update issue status and progress
- Use `glab issue close <number>` when work is complete

#### 3. Label Management System
**Steps:**
- Create required labels if they don't exist:
  - 'claude-work-on-issue' (user-applied, signals ready for work)
  - 'claude-working-on-issue' (red, applied when starting work)
  - 'claude-finished-issue' (orange, applied when work is complete)
  - 'claude-awaiting-confirmation' (purple, applied when waiting for user input)
- Proper label lifecycle management
- Label creation commands using glab CLI
- Label color specifications and meanings

#### 4. Merge Request Management via glab CLI
**Steps:**
- Use `glab mr create` to create merge requests on GitLab
- Use `glab mr list` to view merge requests
- Use `glab mr view <number>` to view MR details
- Use `glab mr approve <number>` to approve merge requests
- Use `glab mr merge <number>` to merge approved requests
- Use `glab mr create --reviewer <username>` to assign reviewers
- Use `glab mr create --draft` for work-in-progress merge requests

#### 5. CI/CD Pipeline Monitoring via glab CLI
**Steps:**
- Use `glab pipeline list` to view pipeline status
- Use `glab pipeline view <id>` to view specific pipeline details
- Use `glab pipeline status` to check current pipeline status
- Use `glab pipeline artifacts` to download pipeline artifacts
- Use `glab pipeline retry <id>` to retry failed pipelines
- Use `glab pipeline cancel <id>` to cancel running pipelines

#### 6. GitLab Platform Communication via glab CLI
**Steps:**
- Use `glab issue comment <number> "message"` to add comments
- Use `glab issue edit <number>` to update issue descriptions
- Use `glab issue assign <number> <username>` to assign issues
- Use `glab issue edit <number> --due-date <date>` to set due dates
- Use `glab issue edit <number> --milestone <milestone>` to set milestones
- Use `glab mr comment <number> "message"` to comment on merge requests
- Use `glab mr edit <number>` to update MR descriptions

### Configuration Section
```markdown
## Configuration
### Remote GitLab Configuration
- GitLab labels: Created via `glab label create` commands
- Issue templates: Configured via GitLab project settings
- Merge request templates: Configured via GitLab project settings
- Branch protection rules: Configured via GitLab project settings
- CI/CD pipelines: Configured via `.gitlab-ci.yml` (file operations handled by git.md)

### Local Files Modified
- `.claude-commands.memory` - Add gitlab.md to initialization list

### Labels Required
- 'claude-work-on-issue' (user-applied, blue #0052CC)
- 'claude-working-on-issue' (red #FF0000)
- 'claude-finished-issue' (orange #FFA500)
- 'claude-awaiting-confirmation' (purple #800080)
```

### Post-Setup Section
```markdown
## Post-Setup
After applying GitLab rules:
1. Verify glab authentication: `glab auth status`
2. Check project access: `glab repo view`
3. Validate issue access: `glab issue list`
4. Test merge request permissions: `glab mr list`
5. Confirm CI/CD pipeline visibility: `glab pipeline list`
```

## Detailed Content Areas

### Complete Rule Set

#### User-Provided Rules
1. **glab CLI Usage**: All GitLab interaction must be done via glab command line utility
2. **Issue Creation**: Bugs, new features, or fixes must start as an issue
3. **User Review Process**: User tags reviewed issues with 'claude-work-on-issue' label
4. **Work Authorization**: Assistant must not start working on issues without 'claude-work-on-issue' label
5. **Work Status Tracking**: Assistant adds 'claude-working-on-issue' label (red) when starting work
6. **Completion Tracking**: Assistant adds 'claude-finished-issue' label (orange) when finished
7. **Communication Check**: Check comments before starting work, use 'claude-awaiting-confirmation' label (purple) for questions

#### Additional GitLab-Specific Rules
8. **Documentation Reference**: Always reference glab documentation to avoid error loops from incorrect usage
9. **Merge Request Creation**: Create merge requests using `glab mr create` when work is complete
10. **MR Title Standards**: MR title should reference issue number (e.g., "Fix: Resolve issue #123")
11. **MR Description Standards**: MR description should link to original issue and include testing notes
12. **Branch Naming**: Branch names should include issue number (e.g., `feature/123-implement-login`)
13. **Progress Updates**: Update issue status/progress with comments during work
14. **Automatic Issue Closing**: Close issues automatically when MR is merged (using closing keywords)
15. **Pipeline Validation**: Check pipeline status before creating merge requests
16. **CI/CD Compliance**: Wait for CI/CD pipelines to pass before marking work complete
17. **Error Handling**: Create follow-up issues for blockers encountered during work
18. **Documentation**: Document failed approaches in issue comments

### Issue Lifecycle Management
- **Discovery**: Issue created by user or system
- **Review**: User adds 'claude-work-on-issue' label after review
- **Pre-work Check**: Assistant checks comments for questions/clarifications
- **Confirmation**: If questions exist, add 'claude-awaiting-confirmation' label and wait
- **Work Start**: Add 'claude-working-on-issue' label and begin implementation
- **Progress Updates**: Regular comments with status updates
- **Completion**: Add 'claude-finished-issue' label when work is done
- **Merge**: Create MR, wait for CI/CD, merge, auto-close issue

### Label System Design
- **Color Coding**: Visual workflow status identification
- **Automation**: Automatic label application based on workflow state
- **Creation**: Dynamic label creation if missing
- **Lifecycle**: Clear progression through workflow states

### GitLab CI/CD Integration
- **Pipeline Awareness**: Monitor and respond to pipeline states
- **Quality Gates**: Respect CI/CD quality requirements
- **Failure Handling**: Proper response to pipeline failures
- **Status Reporting**: Include pipeline status in progress updates

### Merge Request Best Practices
- **Title Standards**: Consistent, descriptive titles with issue references
- **Description Templates**: Comprehensive descriptions with testing notes
- **Review Process**: Proper reviewer assignment and review workflow
- **Merge Strategy**: Appropriate merge methods for different scenarios

### Communication Protocols
- **Issue Comments**: Structured progress updates and status reports
- **Documentation**: Clear documentation of approaches and decisions
- **Error Reporting**: Comprehensive error and blocker documentation
- **Follow-up**: Proper creation of follow-up issues for unresolved items

## Integration Requirements

### Memory Integration
The gitlab.md file must include a memory integration section:
```markdown
## Memory Integration

After using this rule, Claude must:

- **1.** Check if `.claude-commands.memory` file exists - if not, create it with initial content:
```
## read these files upon initialization

```

- **2.** Check if `- @ai-rules/gitlab.md` is listed under section `## read these files upon initialization` in `.claude-commands.memory`
- **3.** If not listed: add `- @ai-rules/gitlab.md` to list under section `## read these files upon initialization` in `.claude-commands.memory`
```

### Integration with Base Rules
The gitlab.md must properly extend @ai-rules/git.md:
- Use "Extends" section to reference base git rules
- Build upon local Git operations with remote GitLab platform interactions
- Avoid duplicating local Git workflow content already covered in base rules
- Focus exclusively on glab CLI commands and remote GitLab platform operations
- All local repository operations (branching, merging, commits) remain in git.md

## Blueprint Characteristics

### GitLab-Specific Focus
- Remote GitLab platform operations only (via glab CLI)
- GitLab terminology (issues, merge requests, pipelines, labels)
- glab CLI command usage exclusively
- GitLab project management features (labels, milestones, assignments)
- GitLab CI/CD pipeline monitoring and management

### Consistency with README.md Structure
- Follows exact template structure from README.md
- Maintains section ordering and naming
- Includes all required sections (Description, Prerequisites, Steps, Configuration, Post-Setup)
- Uses consistent markdown formatting
- Includes proper "Extends" section

### Comprehensive Workflow Coverage
- Complete issue lifecycle management
- Comprehensive label system
- Full merge request workflow
- CI/CD pipeline integration
- Communication and documentation protocols

### Error Prevention Focus
- Strong emphasis on glab documentation reference
- Clear command usage guidelines
- Error handling and recovery procedures
- Loop prevention through proper documentation usage

## Implementation Notes

### Scope Requirements
- Must focus exclusively on remote GitLab platform operations
- Must use glab CLI for all GitLab interactions
- Must extend base git.md rules without duplicating local Git operations
- Must include comprehensive label management system
- Must NOT include local repository operations (covered by git.md)

### Quality Standards
- Each step must be atomic and verifiable
- Include validation checks where appropriate
- Provide clear error handling guidance
- Maintain idempotent operations
- Emphasize documentation reading to prevent errors

### Testing Considerations
- Rules should be safe to apply multiple times
- Include rollback procedures for major changes
- Provide verification steps for each operation
- Document edge cases and limitations
- Test with various GitLab project configurations

### Documentation Requirements
- Clear glab command examples with explanations
- Comprehensive troubleshooting section
- Reference to official GitLab and glab documentation
- Step-by-step workflow guides
- Common error scenarios and solutions