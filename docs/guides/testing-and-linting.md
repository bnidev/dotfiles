# Testing and Linting

Pre-commit checks and validation workflow for this repository.

## Quick Test Workflow

Before committing or proposing changes:

1. Run `yamllint` on modified YAML files
2. Run `ansible-lint` on changed roles
3. Run `ansible-playbook --syntax-check`
4. Run targeted playbook with `--check --diff` and `--tags`

## Ansible Syntax Check

Verify playbook syntax without running:

```bash
ansible-playbook --syntax-check main.yml
```

## Playbook Dry-Run

Preview changes without applying:

```bash
ansible-playbook -i localhost, -c local main.yml --check --diff
```

## Targeted Role Testing

Test a single role (fastest):

```bash
dotfiles -t role_name        # via wrapper (recommended)
ansible-playbook ... --tags "role_name"  # direct
```

## Linting Tools

### ansible-lint

Lint entire repo or single role:

```bash
ansible-lint                # whole repo
ansible-lint roles/<role>   # single role
```

### yamllint

Lint YAML files:

```bash
yamllint roles/<role>/tasks/*.yml    # role tasks
yamllint -s path/to/file.yml        # single file, strict mode
```

### shellcheck

Lint shell scripts:

```bash
shellcheck path/to/script.sh           # regular script
shellcheck -x path/to/sourced.sh      # sourced script
```

### stylua

Format Lua files (Neovim config):

```bash
stylua path/to/file.lua
```

## Continuous Integration Pattern

When adding new role behavior, tag tasks for targeted testing:

```yaml
- name: Install package
  ansible.builtin.package:
    name: vim
  become: true
  tags:
    - neovim
    - vim
```

Run single tagged task:

```bash
ansible-playbook ... --tags "neovim"
```

## Troubleshooting Lint Errors

### ansible-lint warnings

Address all warnings, especially:
- Use FQCN (fully qualified collection names)
- Missing `changed_when` on commands
- Deprecated module usage

### yamllint errors

Common issues:
- Line too long (max 80 chars)
- Wrong indentation (use 2 spaces)
- Missing document start (`---`)

### shellcheck warnings

Fix all warnings. Use `# shellcheck disable=` sparingly with explanation:

```bash
# shellcheck disable=SC1090  # cannot follow non-constant source
source /path/to/config
```
