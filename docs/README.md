# Documentation

This directory contains documentation for the dotfiles repository.

## Structure

```
docs/
├── README.md                # This file
├── glossary.md              # Terminology and concepts
├── guides/
│   ├── troubleshooting.md   # Common issues and solutions
│   ├── adding-a-role.md     # How to add a new role
│   ├── ansible-conventions.md  # Role patterns, YAML style
│   ├── testing-and-linting.md  # Lint, syntax-check, test workflow
│   ├── shell-conventions.md    # Bash, Fish, scripts
│   ├── lua-conventions.md      # Neovim Lua style
│   ├── git-workflow.md         # Commits, conventional commits
│   └── repository-notes.md     # Special files, facts
└── adr/
    ├── ADR-001-cross-distro-pattern.md  # OS-specific task pattern
    └── ADR-002-role-structure.md        # Role conventions
```

## Quick Links

### Guides
- [Troubleshooting](guides/troubleshooting.md) - Solutions for common problems
- [Adding a Role](guides/adding-a-role.md) - Guide for creating new roles
- [Ansible Conventions](guides/ansible-conventions.md) - Role patterns, YAML style
- [Testing and Linting](guides/testing-and-linting.md) - Pre-commit workflow
- [Shell Conventions](guides/shell-conventions.md) - Bash, Fish scripts
- [Lua Conventions](guides/lua-conventions.md) - Neovim configuration
- [Git Workflow](guides/git-workflow.md) - Commit messages, pushing
- [Repository Notes](guides/repository-notes.md) - Special files, facts

### Reference
- [Glossary](glossary.md) - Ansible and dotfiles terminology
- [ADR-001](adr/ADR-001-cross-distro-pattern.md) - Cross-distribution task pattern
- [ADR-002](adr/ADR-002-role-structure.md) - Role structure conventions

## Overview

### For Users

If you're setting up a new machine:
1. Start with the main [README.md](../README.md)
2. Run the quick start commands
3. If issues arise, check [Troubleshooting](guides/troubleshooting.md)

### For Contributors

If you're adding a new role or modifying existing ones:
1. Read [ADR-002](adr/ADR-002-role-structure.md) for role conventions
2. Read [ADR-001](adr/ADR-001-cross-distro-pattern.md) for OS-specific tasks
3. Follow [Adding a Role](guides/adding-a-role.md) guide
4. Review [Ansible Conventions](guides/ansible-conventions.md)

### For AI Agents

See [AGENTS.md](../AGENTS.md) for AI agent guidelines. The root AGENTS.md is intentionally minimal - detailed conventions are in the linked guides.
