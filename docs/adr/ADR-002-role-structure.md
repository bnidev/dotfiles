# ADR-002: Role Structure Conventions

## Status
Accepted

## Context
Ansible roles have flexible directory structures, but consistency is important for maintainability. We need to define which directories are required, which are optional, and how to name files within them.

## Decision

### Standard Role Structure

```
roles/<role_name>/
├── defaults/          # Role-specific defaults (lowest precedence)
│   └── main.yml
├── vars/              # Internal variables (highest precedence)
│   └── main.yml
├── tasks/             # Main task list
│   ├── main.yml       # Entry point, includes distribution files
│   ├── Ubuntu.yml     # Ubuntu-specific tasks
│   └── Archlinux.yml  # Archlinux-specific tasks
├── handlers/          # Service restart handlers
│   └── main.yml
├── templates/         # Jinja2 templates
│   └── *.j2
├── files/             # Static files
│   └── *
└── meta/              # Role metadata (dependencies, galaxy info)
    └── main.yml
```

### Requirements by Directory

| Directory | Required | Purpose |
|-----------|----------|---------|
| `tasks/` | Yes | Must have `main.yml` as entry point |
| `defaults/` | No | Used for role-configurable variables |
| `vars/` | No | Internal/sensitive variables (use sparingly) |
| `handlers/` | No | Required if role restarts services |
| `templates/` | No | Required if dynamic config generation needed |
| `files/` | No | Required if static config files needed |

### Naming Conventions

- **Role names**: `kebab-case` (e.g., `neovim`, `lazygit`, `wireguard`)
- **Distribution files**: `PascalCase` matching `ansible_facts['distribution']`:
  - `Ubuntu.yml` (not `ubuntu.yml`)
  - `Archlinux.yml` (not `arch.yml` or `archlinux.yml`)
- **Variable names**: `snake_case` with role prefix: `neovim_plugins`, `wireguard_enabled`
- **Task names**: Imperative sentences with role context: `"Neovim | Install dependencies"`

### Task File Conventions

**`tasks/main.yml` Structure:**
1. Distribution detection block (see ADR-001)
2. Shared/distro-agnostic tasks
3. Optional cleanup or verification

**Distribution task files:**
- Should only contain tasks specific to that distribution
- Should not duplicate logic from main.yml
- May use distribution-specific modules (apt, pacman, etc.)

## Consequences

### Positive
- **Predictable structure**: Easy to find tasks in any role
- **Consistent file naming**: `Ubuntu.yml` not `ubuntu.yml`
- **Clear role boundaries**: Each role is self-contained
- **Reduced cognitive load**: No need to learn different patterns per role

### Negative
- **Rigid structure**: Less flexibility for non-standard roles
- **Distribution file explosion**: Each supported distro needs its own file

## Examples

### Minimal role (no OS-specific tasks)
```yaml
# roles/fonts/tasks/main.yml
---
- name: Fonts | Install Nerd Fonts
  ansible.builtin.package:
    name: fonts-ubuntu
  become: true
```

### Role with distribution tasks
```yaml
# roles/neovim/tasks/main.yml
---
- name: "Checking for Distribution Config"
  ansible.builtin.stat:
    path: "{{ role_path }}/tasks/{{ ansible_facts['distribution'] }}.yml"
  register: distribution_config

- name: "Run Tasks: {{ ansible_facts['distribution'] }}"
  ansible.builtin.include_tasks: "{{ ansible_facts['distribution'] }}.yml"
  when: distribution_config.stat.exists

- name: "Neovim | Create symlink to role files directory"
  ansible.builtin.file:
    src: "{{ role_path }}/files"
    dest: "{{ ansible_facts['user_dir'] }}/.config/nvim"
    state: link
    force: true
```

## References
- Ansible Best Practices: [Roles Directory Structure](https://docs.ansible.com/ansible/latest/playbook_guide/playbooks_reuse_roles.html#role-directory-structure)
- `roles/system/` - Minimal role example
- `roles/neovim/` - Full role with all directories
