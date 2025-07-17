# AI-Rules Refactoring Implementation Plan

## Executive Summary

This document provides a comprehensive specification for refactoring the ai-rules directory to standardize structure, improve consistency, and enhance usability. The refactoring will rename files to follow the `[technology]-rules.md` convention and restructure content to match the documented template format.

## Current State Analysis

### Existing Files
- `ai-rules/README.md` - Documentation (compliant)
- `ai-rules/ansible.md` - Ansible automation workflows
- `ai-rules/netbox.md` - NetBox network management
- `ai-rules/python.md` - Python development (uv-first approach)
- `ai-rules/typescript.md` - TypeScript development
- `ai-rules/vyos.md` - VyOS network device configuration

### Issues Identified

#### 1. Naming Convention Non-Compliance
- **Current**: `[technology].md`
- **Expected**: `[technology]-rules.md`
- **Impact**: Inconsistent with documented standards

#### 2. Structure Template Non-Compliance
- **Missing Header Format**: Should be `# Rule: [technology-name]`
- **Missing Required Sections**:
  - `## Description`
  - `## Steps` (atomic, verifiable instructions)
  - `## Configuration` with `### Files Created` and `### Files Modified`
  - `## Post-Setup`
- **Missing Rule Inheritance**: No `## Extends` sections

#### 3. Content Organization Issues
- Files contain comprehensive guidelines but lack actionable step-by-step instructions
- Prerequisites sections are inconsistent in format
- Memory integration sections are present but reference old filenames

#### 4. Reference Inconsistencies
- README.md references will need updating
- Memory integration sections reference old filenames
- Cross-references between rules may exist

## Target State Definition

### File Naming Convention
```
[technology]-rules.md
```

### Standard Template Structure
```markdown
# Rule: [technology-name]

## Description
Brief description of what this rule provides

## Prerequisites
- List of requirements before applying this rule
- E.g., "Empty directory" or "Node.js installed"

## Extends
- Base: /CLAUDE.md
- Rule: /ai-rules/[dependency-rule].md (if applicable)

## Steps
1. Step-by-step instructions
2. Each step should be atomic and verifiable
3. Include validation checks

## Configuration
### Files Created
- List of files that will be created

### Files Modified  
- List of files that will be modified

## Post-Setup
Instructions or commands to run after setup

## [Technology-Specific Content]
[Preserve existing detailed content with improved organization]

## Memory Integration
[Updated memory integration with new filename]
```

## File Renaming Matrix

| Current Filename | New Filename | Status |
|------------------|--------------|--------|
| `ansible.md` | `ansible-rules.md` | Rename + Restructure |
| `netbox.md` | `netbox-rules.md` | Rename + Restructure |
| `python.md` | `python-rules.md` | Rename + Restructure |
| `typescript.md` | `typescript-rules.md` | Rename + Restructure |
| `vyos.md` | `vyos-rules.md` | Rename + Restructure |
| `README.md` | `README.md` | Update References |

## Content Migration Strategy

### Preservation Requirements
- **Maintain all existing technical content**
- **Preserve comprehensive guidelines and best practices**
- **Keep all security and testing requirements**
- **Retain technology-specific configurations and examples**

### Restructuring Approach
1. **Extract Description**: Create concise description from existing introduction
2. **Formalize Prerequisites**: Standardize prerequisite formatting
3. **Create Action Steps**: Convert guidelines into actionable steps
4. **Organize Configuration**: Identify files created/modified by each rule
5. **Define Post-Setup**: Extract post-implementation instructions
6. **Preserve Detailed Content**: Keep existing comprehensive sections

### Content Mapping Template

For each rule file:
```markdown
# Rule: [technology] → Extract from current header
## Description → Extract from introduction/purpose
## Prerequisites → Standardize existing prerequisites
## Extends → Add reference to base CLAUDE.md
## Steps → Create from key workflow sections
## Configuration → Identify file operations
## Post-Setup → Extract verification/finalization steps
## [Existing Content] → Preserve with improved organization
```

## Reference Updates Required

### 1. README.md Updates
- Update "Available Rules" section with new filenames
- Update any examples or references to rule files
- Update file structure documentation

### 2. Memory Integration Updates
Each rule file contains memory integration sections that reference the old filename:
```markdown
# Current
- @ai-rules/[technology].md

# New
- @ai-rules/[technology]-rules.md
```

### 3. Cross-Reference Updates
- Check for any internal references between rule files
- Update any documentation that references specific rule files
- Verify no broken links or references

## Detailed Implementation Steps

### Phase 1: Preparation and Analysis
1. **Backup Current State**
   ```bash
   git add -A && git commit -m "backup: ai-rules before refactoring"
   ```

2. **Validate Current Structure**
   - Verify all files are present
   - Check for any uncommitted changes
   - Identify all cross-references

### Phase 2: File Renaming
1. **Rename Files** (Git-aware)
   ```bash
   git mv ai-rules/ansible.md ai-rules/ansible-rules.md
   git mv ai-rules/netbox.md ai-rules/netbox-rules.md
   git mv ai-rules/python.md ai-rules/python-rules.md
   git mv ai-rules/typescript.md ai-rules/typescript-rules.md
   git mv ai-rules/vyos.md ai-rules/vyos-rules.md
   ```

### Phase 3: Content Restructuring
For each rule file:

1. **Update Header**
   ```markdown
   # Rule: [technology-name]
   ```

2. **Add Standard Sections**
   - Extract/create `## Description`
   - Standardize `## Prerequisites`
   - Add `## Extends` referencing base CLAUDE.md
   - Create `## Steps` from workflow content
   - Add `## Configuration` sections
   - Create `## Post-Setup` instructions

3. **Preserve Existing Content**
   - Keep all technical guidelines
   - Maintain security requirements
   - Preserve examples and configurations
   - Keep testing procedures

4. **Update Memory Integration**
   - Change filename references in memory sections
   - Update command paths

### Phase 4: Reference Updates
1. **Update README.md**
   - Available Rules section
   - File structure references
   - Examples and documentation

2. **Verify Cross-References**
   - Check for internal links
   - Verify no broken references
   - Update any documentation

### Phase 5: Validation and Testing
1. **Structure Compliance Check**
   - Verify all files follow template
   - Check required sections present
   - Validate formatting consistency

2. **Content Integrity Check**
   - Verify all original content preserved
   - Check no information lost
   - Validate examples still work

3. **Reference Validation**
   - Check all links work
   - Verify memory integration functional
   - Test cross-references

## Risk Assessment and Mitigation

### High Risk Items
1. **Content Loss During Restructuring**
   - **Mitigation**: Git commit before each file modification
   - **Recovery**: Git revert capability

2. **Broken References**
   - **Mitigation**: Comprehensive reference audit
   - **Recovery**: Systematic reference checking

3. **Memory Integration Failure**
   - **Mitigation**: Test memory integration after each change
   - **Recovery**: Revert to working state

### Medium Risk Items
1. **Inconsistent Template Application**
   - **Mitigation**: Detailed template specification
   - **Recovery**: Standardization pass

2. **Lost Technical Details**
   - **Mitigation**: Content preservation checklist
   - **Recovery**: Re-read original files

### Low Risk Items
1. **Minor Formatting Issues**
   - **Mitigation**: Consistent formatting guidelines
   - **Recovery**: Minor adjustments

## Success Criteria

### Functional Requirements
- [ ] All files renamed to `[technology]-rules.md` format
- [ ] All files follow standard template structure
- [ ] All original content preserved
- [ ] All references updated correctly
- [ ] Memory integration functional

### Quality Requirements
- [ ] Consistent formatting across all files
- [ ] Clear, actionable step-by-step instructions
- [ ] Proper section organization
- [ ] No broken links or references

### Validation Requirements
- [ ] All files pass structure compliance check
- [ ] All technical content verified intact
- [ ] All examples and configurations work
- [ ] Memory integration tested and functional

## Implementation Timeline

### Phase 1: Preparation (30 minutes)
- Backup and validation
- Reference analysis

### Phase 2: File Renaming (15 minutes)
- Git-aware file renaming
- Initial commit

### Phase 3: Content Restructuring (2-3 hours)
- Template application to all 5 files
- Content preservation and organization

### Phase 4: Reference Updates (30 minutes)
- README.md updates
- Cross-reference validation

### Phase 5: Validation (45 minutes)
- Structure compliance
- Content integrity
- Reference validation

**Total Estimated Time: 4-5 hours**

## Post-Implementation Verification

### Checklist Items
- [ ] All files renamed correctly
- [ ] All files follow template structure
- [ ] All content preserved
- [ ] README.md updated
- [ ] Memory integration works
- [ ] No broken references
- [ ] Git history clean
- [ ] All tests pass

### Verification Commands
```bash
# Check file structure
ls -la ai-rules/

# Validate git history
git log --oneline -10

# Check for broken references
grep -r "ai-rules/" . --include="*.md"

# Verify memory integration
grep -r "claude-commands.memory" ai-rules/
```

## Rollback Plan

If issues arise:
1. **Immediate Rollback**: `git reset --hard HEAD~[n]`
2. **Selective Rollback**: `git checkout HEAD~[n] -- ai-rules/`
3. **File-Specific Rollback**: `git checkout HEAD~[n] -- ai-rules/[filename]`

## Conclusion

This refactoring will standardize the ai-rules directory structure, improve consistency, and enhance usability while preserving all valuable technical content. The systematic approach ensures minimal risk and maximum benefit.