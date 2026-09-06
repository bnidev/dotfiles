# ADR-001: Cross-Distribution Task Organization

## Status
Accepted

## Context
The dotfiles repository needs to support multiple Linux distributions (Ubuntu and Arch Linux). Each tool installation may require different package managers, repositories, and installation methods. We need a consistent approach to organize OS-specific tasks without duplicating logic or creating tightly coupled role code.

## Decision
We use a **distribution task file pattern** with conditional inclusion in each role.

### Pattern

Each role that needs OS-specific behavior:

1. Creates a `tasks/main.yml` that:
   - Statically checks if a distribution-specific file exists
   - Conditionally includes it via `ansible.builtin.include_tasks`

```yaml
---
- name: "{{ role_name }} | Checking for Distribution Config: {{ ansible_facts['distribution'] }}"
  ansible.builtin.stat:
    path: "{{ role_path }}/tasks/{{ ansible_facts['distribution'] }}.yml"
  register: distribution_config

- name: "{{ role_name }} | Run Tasks: {{ ansible_facts['distribution'] }}"
  ansible.builtin.include_tasks: "{{ ansible_facts['distribution'] }}.yml"
  when: distribution_config.stat.exists
```

2. Adds per-distribution files in `tasks/`:
   - `tasks/Ubuntu.yml`
   - `tasks/Archlinux.yml`

3. Includes shared/distro-agnostic logic directly in `tasks/main.yml` after the include.

### Distribution Detection
We use `ansible_facts['distribution']` for the conditional include because it returns exact values like `Ubuntu` and `Archlinux`. `ansible_facts['os_family']` is too coarse (`Debian` includes many distributions).

### Supported Distributions
- **Ubuntu** (22.04+)
- **Archlinux** (rolling release)

## Consequences

### Positive
- **Consistent pattern**: Every role that needs OS-specific behavior follows the same structure
- **Graceful degradation**: If no distribution file exists, the role still runs shared logic
- **Easy to extend**: Adding a new distribution is just creating a new YAML file
- **Idempotent**: The `stat` check is idempotent and produces no changes

### Negative
- **Duplicated pattern**: Every role repeats the same 6-8 lines of boilerplate
- **Implicit requirement**: Roles must have OS files in `tasks/` for those distros to work
- **No fallback**: If distribution is not Ubuntu or Archlinux, the role may partially fail

## Alternatives Considered

### Alternative 1: Single file with `when` conditions
```yaml
- name: Install on Ubuntu
  ansible.builtin.apt: ...
  when: ansible_facts['distribution'] == 'Ubuntu'

- name: Install on Arch
  ansible.builtin.pacman: ...
  when: ansible_facts['distribution'] == 'Archlinux'
```
**Rejected because**: Creates large files, harder to maintain, mixes concerns.

### Alternative 2: Using `import_tasks` instead of `include_tasks`
**Rejected because**: `import_tasks` is static (parsed at playbook load time) and doesn't support dynamic file lookup based on facts.

## References
- `roles/neovim/tasks/main.yml` - Reference implementation
- `roles/docker/tasks/main.yml` - Another example
- Ansible documentation: [Using Variables](https://docs.ansible.com/ansible/latest/playbook_guide/playbooks_variables.html)
