# AGENTS

Personal dotfiles and Ansible roles for development environment provisioning.

## Quick Reference

- **Test a role:** `dotfiles -t <role_name>`
- **Syntax check:** `ansible-playbook --syntax-check main.yml`
- **Lint everything:** `ansible-lint`
- **Lint one role:** `ansible-lint roles/<role>`

## Critical Rules

- Never commit or push without explicit user permission
- Do NOT hardcode secrets, API keys, or credentials
- Do NOT modify human-authored files in `roles/*/files/`
- Do NOT run destructive commands without confirmation
- Do NOT modify files outside `roles/` and `docs/` without approval
- Make minimal, reversible changes

## Detailed Conventions

- [Ansible conventions](docs/guides/ansible-conventions.md) - Role patterns, YAML style, modules
- [Testing and linting](docs/guides/testing-and-linting.md) - Pre-commit workflow
- [Shell conventions](docs/guides/shell-conventions.md) - Bash, Fish scripts
- [Lua conventions](docs/guides/lua-conventions.md) - Neovim configuration
- [Git workflow](docs/guides/git-workflow.md) - Commit messages, pushing
- [Repository notes](docs/guides/repository-notes.md) - Special files, facts
