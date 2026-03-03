AGENTS — Agent Guidelines for this repository

This repository contains personal dotfiles and Ansible roles used to provision a development environment.
The guidance below is written for autonomous coding agents that will make, lint, and test changes.

Build / Lint / Test commands

Ansible syntax and playbook testing
- Syntax check a playbook:
  ```
  ansible-playbook --syntax-check main.yml
  ```
- Run a playbook locally (safe dry-run):
  ```
  ansible-playbook -i localhost, -c local main.yml --check --diff
  ```
- Run targeted with tags (fastest for single-role testing):
  ```
  dotfiles -t role_name        # via dotfiles wrapper (recommended)
  ansible-playbook ... --tags "role_name"  # direct
  ```
- Note: roles are automatically tagged by name in main.yml (see loop with `tags: "{{ roles_item }}"`)

Linting
- Run ansible-lint on entire repo:
  ```
  ansible-lint
  ```
- Lint a single role:
  ```
  ansible-lint roles/<role>
  ```
- YAML lint specific files:
  ```
  yamllint roles/<role>/tasks/*.yml
  yamllint -s path/to/file.yml  # single file, strict mode
  ```
- Shell script linting:
  ```
  shellcheck path/to/script.sh
  shellcheck -x path/to/sourced_script.sh  # for sourced files
  ```
- Lua formatting (Neovim config):
  ```
  stylua path/to/file.lua
  ```

Single-test workflow (recommended for validating changes):
1. Run `yamllint` on modified YAML files
2. Run `ansible-lint` on changed roles
3. Run `ansible-playbook --syntax-check`
4. Run targeted `ansible-playbook` with `--check --diff` and `--tags`

Repository-specific notes
- Neovim Lua formatting: see `roles/neovim/files/.stylua.toml` for formatting rules
- Always run `stylua` on Lua files before committing
- Copilot prompt templates for commit messages at `roles/neovim/files/copilot-prompts/`
- No repository-level `.cursorrules` or `.cursor/rules/` found

Code style guidelines

General principles
- Prioritize readability and idempotence: Ansible playbooks and roles must be idempotent
- Make minimal, focused commits. Run linters before committing
- Use explicit, descriptive names for variables, tasks and handlers
- Prefer native modules over shell commands where possible

YAML / Ansible
- Indentation: 2 spaces. Never use tabs
- Scalars: prefer native YAML types (true/false, numbers) not strings
- Variable naming: `snake_case` with role-specific prefix, e.g. `neovim_plugins`, `wireguard_enabled`
- Role variables: defaults in `roles/<role>/defaults/main.yml`, sensitive in `vars/main.yml`
- Task naming: descriptive names that read like imperative sentences
- Handlers: use for service restarts, name clearly (e.g. "Restart nginx")
- Use `include_tasks` for conditional/dynamic, `import_tasks` for static at parse time
- Error handling: use `failed_when` and `changed_when` for fine control
- Use `check_mode` friendly modules; prefer modules over `shell`/`command`
- Avoid excessive shell usage; use modules: `file`, `copy`, `template`, `package`, `git`, `user`
- Long commands: prefer YAML folded style with `|` or block scalars

Role structure patterns
- Each role typically has: `defaults/`, `vars/`, `tasks/`, `handlers/`, `templates/`, `files/`
- OS-specific tasks in files named by distribution: `tasks/Ubuntu.yml`, `tasks/Archlinux.yml`
- Include OS tasks conditionally using `ansible_facts['os_family']` or `ansible_facts['distribution']`
- Example pattern from existing roles:
  ```yaml
  - name: Include Ubuntu-specific tasks
    ansible.builtin.include_tasks: Ubuntu.yml
    when: ansible_facts['distribution'] == 'Ubuntu'
  ```

Shell / Scripts
- Bash scripts: use `set -euo pipefail` and check return codes
- Use `shellcheck` and fix warnings (use `# shellcheck disable=...` sparingly with explanation)
- Fish files: follow fish conventions, use `set -l` for local variables

Lua (Neovim)
- Run `stylua` before commits; follow `roles/neovim/files/.stylua.toml`
- Naming: `snake_case` for functions/variables
- Use `M` module table export pattern:
  ```lua
  local M = {}
  function M.setup() ... end
  return M
  ```
- Keep functions small and pure; avoid side-effects in require-time code

Formatting / imports / ordering
- Import order: standard libraries -> external plugins -> local modules
- Remove unused imports/requires and unused variables
- Keep names lowercase with underscores in YAML: `my_var_name`

Types and naming conventions
- Role names: use `roles/<role>` with kebab-case folder names
- Variables: use `snake_case`
- Boolean values: use YAML `true`/`false`, not `'yes'`/`'no'` strings
- Numbers: use native YAML numbers, not strings

Error handling and logs
- Tasks should fail fast with contextual messages
- Use `msg:` in `fail:` module to explain failures
- Test for existence before creating files (idempotency)
- Use `register:` on commands for output, add `when:` for conditions
- Use `changed_when: false` when a command always succeeds but Ansible thinks it changes

Testing and CI guidance
- Run linter suite before proposing changes
- If adding new role behavior, tag tasks for targeted testing
- Example tagged task:
  ```yaml
  - name: Install package
    ansible.builtin.package:
      name: vim
    tags:
      - neovim
      - vim
  ```
- Run single tagged task: `ansible-playbook ... --tags "neovim"`

Repository conventions
- Commit messages: follow conventional commits spec (https://www.conventionalcommits.org/)
- Format: `<type>: <description>` (all lowercase, imperative mood)
- Valid types: `feat` (new feature), `fix` (bug fix), `docs`, `style`, `refactor`, `perf`, `test`, `chore`, `build`, `ci`, `revert`
- Example: `feat: add pnpm to default roles` or `fix: update neovim plugin versions`
- Do NOT modify human-authored secrets or private config in `files/`
- Use existing patterns in `roles/` when adding new roles

Files to reference
- `roles/neovim/files/.stylua.toml` — Lua formatting config
- `roles/neovim/files/copilot-prompts/` — Commit message and review prompts
- `main.yml` — Repository playbook entrypoint

If you need clarification
- Make minimal, reversible changes
- If operation could be destructive (reformatting, secrets, mass refactor), ask for approval first
