# Glossary

Terms and concepts used throughout this dotfiles repository and its Ansible configuration.

## A

### Ansible
Configuration management tool that uses YAML-based playbooks to define infrastructure as code. This repository uses Ansible to automate the setup of a development environment.

### Archlinux
Rolling-release Linux distribution supported by this dotfiles repository. Roles use `pacman` package manager and `Archlinux.yml` task files.

### ADR (Architecture Decision Record)
Markdown file documenting significant architectural decisions, their context, and consequences. See `docs/ADR-*` files.

## B

### become
Ansible keyword for privilege escalation. Used to run tasks as root (via `sudo` by default). In this repo, package installations and system-level changes use `become: true`.

## C

### Common Task
Task logic shared across distributions, typically placed directly in `tasks/main.yml` after the distribution include block.

### Cross-Distro
Term referring to roles that work on multiple Linux distributions (Ubuntu, Arch Linux).

## D

### Default Variables
Variables defined in `roles/<role>/defaults/main.yml` with the lowest precedence. Users can override these in `group_vars/` or playbook vars.

### Distribution Task File
OS-specific YAML file in `roles/<role>/tasks/` named after the distribution:
- `tasks/Ubuntu.yml`
- `tasks/Archlinux.yml`

## E

### Entrypoint
The `tasks/main.yml` file of a role, which is automatically included by Ansible when the role is invoked.

## F

### FQCN (Fully Qualified Collection Name)
Ansible's complete module naming convention, e.g., `ansible.builtin.apt` or `community.general.git_config`. This repo uses FQCN for all module references.

## H

### Handler
Ansible task that runs only when notified by another task. Commonly used for service restarts after configuration changes. See `roles/lazygit/handlers/main.yml` for an example.

## I

### Idempotent
Property of Ansible tasks where running them multiple times produces the same result. This repo prioritizes idempotency: tasks should not cause unnecessary changes on re-runs.

### include_tasks
Ansible keyword for dynamic task inclusion (parsed at runtime). Used in this repo for conditional distribution file inclusion.

### import_tasks
Ansible keyword for static task inclusion (parsed at playbook load time). Faster than `include_tasks` but doesn't support runtime conditionals.

## P

### Playbook
YAML file containing Ansible plays. The main entry point is `main.yml`.

### Pre-Task
Task that runs before main role execution, typically used for environment detection. See `pre_tasks/` directory.

## R

### Role
Self-contained Ansible unit for installing and configuring a single tool. Located in `roles/<role_name>/`. Examples: `roles/neovim`, `roles/fish`.

### Run Tags
Dynamically computed list of roles to execute, based on `default_roles`, `work_roles`, and `--tags` CLI arguments. See `main.yml` for logic.

## S

### Symlink
Filesystem link to another file. This repo uses `ansible.builtin.file: state=link` to point `~/.config/<tool>` to role files in `roles/<tool>/files/`.

## T

### Tag
Label attached to tasks/roles for selective execution. In this repo, roles are automatically tagged by name via `main.yml`, enabling `dotfiles -t neovim`.

## U

### Ubuntu
Debian-based Linux distribution supported by this dotfiles repository. Roles use `apt` package manager and `Ubuntu.yml` task files. Targets Ubuntu 22.04 and later.

## V

### Variable Precedence
Order in which Ansible resolves variable values. Lower precedence (defaults) is overridden by higher precedence (vars, group_vars, extra-vars).

## W

### WSL (Windows Subsystem for Linux)
Microsoft's Linux compatibility layer for Windows. This repo detects WSL via `pre_tasks/detect_wsl.yml` and adapts certain roles (e.g., `wezterm` configures Windows-side WezTerm).

---

## Related Documentation

- [ADR-001: Cross-Distribution Task Organization](adr/ADR-001-cross-distro-pattern.md)
- [ADR-002: Role Structure Conventions](adr/ADR-002-role-structure.md)
- [AGENTS.md](../AGENTS.md) - Guidelines for AI agents
- [README.md](../README.md) - User-facing documentation
