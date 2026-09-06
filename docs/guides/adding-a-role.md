# Adding a New Role

This guide explains how to add a new role to the dotfiles repository. Roles are self-contained Ansible units that install and configure a single tool.

## Overview

Each role lives in `roles/<role_name>/` and follows a standard structure. For detailed conventions, see [ADR-002: Role Structure](../adr/ADR-002-role-structure.md).

## Step-by-Step Guide

### 1. Create the Role Directory

```bash
mkdir -p roles/<role_name>/tasks
```

For roles with configuration files or templates:

```bash
mkdir -p roles/<role_name>/{tasks,files,templates,defaults,handlers}
```

### 2. Create the Main Task File

Create `roles/<role_name>/tasks/main.yml`:

```yaml
---
- name: "{{ role_name }} | Checking for Distribution Config: {{ ansible_facts['distribution'] }}"
  ansible.builtin.stat:
    path: "{{ role_path }}/tasks/{{ ansible_facts['distribution'] }}.yml"
  register: distribution_config
  changed_when: false

- name: "{{ role_name }} | Run Tasks: {{ ansible_facts['distribution'] }}"
  ansible.builtin.include_tasks: "{{ ansible_facts['distribution'] }}.yml"
  when: distribution_config.stat.exists

# Add distro-agnostic tasks below
```

The first two tasks are the standard distribution detection pattern (see [ADR-001](../adr/ADR-001-cross-distro-pattern.md)).

### 3. Add Distribution-Specific Tasks (if needed)

If your tool requires different installation methods per distribution, create:

**`roles/<role_name>/tasks/Ubuntu.yml`:**
```yaml
---
- name: "<Tool> | Install via apt"
  become: true
  ansible.builtin.apt:
    name: <package-name>
    state: present
```

**`roles/<role_name>/tasks/Archlinux.yml`:**
```yaml
---
- name: "<Tool> | Install via pacman"
  become: true
  ansible.builtin.pacman:
    name: <package-name>
    state: present
```

### 4. Add Configuration Files (if needed)

Place static config files in `roles/<role_name>/files/`.

For dynamic configs with variables, use templates:
1. Create `roles/<role_name>/templates/<config>.j2`
2. Use the `template` module in tasks:

```yaml
- name: "<Tool> | Deploy config"
  ansible.builtin.template:
    src: <config>.j2
    dest: "{{ ansible_facts['user_dir'] }}/.config/<tool>/<config>"
    mode: '0644'
```

### 5. Add Defaults (if needed)

Create `roles/<role_name>/defaults/main.yml` for configurable variables:

```yaml
---
<tool>_option: default_value
```

### 6. Add Handlers (if needed)

Create `roles/<role_name>/handlers/main.yml` for service restarts:

```yaml
---
- name: Restart <service>
  ansible.builtin.systemd:
    name: <service>
    state: restarted
  become: true
```

Reference in tasks:

```yaml
- name: "<Tool> | Update config"
  ansible.builtin.copy:
    src: <config>
    dest: /etc/<tool>/<config>
  notify: Restart <service>
```

### 7. Add to Default Roles

Edit `group_vars/all.yml` and add your role to the `default_roles` list:

```yaml
default_roles:
  - system
  - bat
  - <your-new-role>  # Add here
  # ...
```

### 8. Update README

Add your role to the "Available Roles" table in `README.md`:

```markdown
| `<role_name>` | Brief description |
```

## Testing Your Role

### Syntax Check
```bash
ansible-playbook --syntax-check main.yml
```

### Dry Run
```bash
ansible-playbook -i localhost, -c local main.yml --tags "<role_name>" --check --diff
```

### Targeted Run
```bash
dotfiles -t <role_name>
```

## Best Practices

### Use Native Modules
Prefer Ansible modules over shell commands:
- ✅ `ansible.builtin.apt` instead of `shell: apt install`
- ✅ `ansible.builtin.copy` instead of `shell: cp`
- ✅ `ansible.builtin.file` for symlinks and permissions

### Add `changed_when: false` to Read-Only Tasks
```yaml
- name: "Check if file exists"
  ansible.builtin.stat:
    path: /path/to/file
  register: file_stat
  changed_when: false  # stat is read-only
```

### Use FQCN
Always use fully qualified collection names:
```yaml
- name: "Install package"
  ansible.builtin.package:  # Not just "package"
    name: vim
```

### Make Tasks Idempotent
Tasks should produce the same result on multiple runs. Avoid:
- ❌ `shell: echo "config" >> ~/.bashrc` (keeps appending)
- ✅ `blockinfile` with a marker (idempotent)

### Test on Multiple Distributions
If your role supports both Ubuntu and Arch, test on both:
```bash
# Ubuntu
dotfiles -t <role_name>

# Arch
dotfiles -t <role_name>
```

## Examples

### Simple Role (no OS-specific tasks)
See `roles/fonts/` - installs packages on all distributions.

### Role with OS-Specific Tasks
See `roles/neovim/` - different install methods for Ubuntu and Arch.

### Role with Configuration Files
See `roles/fish/` - installs packages and copies config files.

### Role with Handlers
See `roles/lazygit/` - uses handlers for service restarts.

## Need Help?

- Review existing roles in `roles/` for examples
- Check [ADR-001](../adr/ADR-001-cross-distro-pattern.md) and [ADR-002](../adr/ADR-002-role-structure.md) for conventions
- See [Ansible Best Practices](https://docs.ansible.com/ansible/latest/playbook_guide/playbooks_best_practices.html)
