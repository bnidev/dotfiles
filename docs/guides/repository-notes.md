# Repository Notes

Special files, configurations, and locations in this repository.

## Entry Points

| File | Purpose |
|------|---------|
| `main.yml` | Ansible playbook entry point |
| `bin/dotfiles` | Wrapper script for running playbook |

## Special Directories

| Directory | Purpose |
|-----------|---------|
| `roles/` | Ansible role definitions |
| `pre_tasks/` | Pre-playbook tasks (detection) |
| `group_vars/` | Variable definitions |
| `templates/` | Configuration templates |

## Neovim Configuration

| File/Directory | Purpose |
|----------------|---------|
| `roles/neovim/files/.stylua.toml` | Lua formatting rules |
| `roles/neovim/files/copilot-prompts/` | AI commit/review prompts |

## Pre-Task Files

| File | Purpose |
|------|---------|
| `pre_tasks/detect_wsl.yml` | Detect WSL environment |
| `pre_tasks/detect_shell.yml` | Detect user shell |
| `pre_tasks/whoami.yml` | Detect host user |
| `pre_tasks/whoami_wsl.yml` | Detect Windows user (WSL) |

## Wrapper Script

The `bin/dotfiles` wrapper:
- Detects OS and installs dependencies
- Clones/pulls repository
- Prompts for SSH key generation
- Copies config template
- Runs playbook with password prompt

## Supported Distributions

- Ubuntu 22.04+
- Arch Linux (rolling)

## Forbidden Actions

Do NOT modify:
- Human-authored secrets in `roles/*/files/`
- Private configuration files
- Binary files or artifacts

Do NOT:
- Hardcode credentials or API keys
- Run destructive commands without confirmation
- Modify files outside `roles/` and `docs/` without approval

## Role Tags

All roles are automatically tagged by their name in `main.yml`. Use for targeted runs:

```bash
dotfiles -t neovim
ansible-playbook ... --tags "neovim"
```

## Variable Precedence

From lowest to highest:
1. `roles/<role>/defaults/main.yml`
2. `group_vars/all.yml`
3. `group_vars/work.yml` / `group_vars/personal.yml`
4. `~/.config/dotfiles/config.yml`
5. Command line `--extra-vars`

## Detected Facts

Available Ansible facts after pre-tasks:

| Variable | Description |
|----------|-------------|
| `ansible_host_environment_is_wsl` | Boolean: running in WSL |
| `wsl_host_user` | Windows username |
| `wsl_host_user_folder` | Windows user folder |
| `wsl_default_distro` | Default WSL distro name |
| `ansible_facts['user_dir']` | User home directory |
| `ansible_facts['distribution']` | Linux distribution |
