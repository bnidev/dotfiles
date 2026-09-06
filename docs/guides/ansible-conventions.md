# Ansible Conventions

Role patterns, YAML style, and module usage for this repository.

## Role Structure

Roles live in `roles/<role_name>/`. Standard directories:

- `tasks/` - Task files (required)
- `defaults/` - Default variables
- `vars/` - Internal variables
- `handlers/` - Service restart handlers
- `templates/` - Jinja2 templates
- `files/` - Static files

Role names use kebab-case: `roles/neovim/`, `roles/lazygit/`.

## Cross-Distribution Tasks

Use the stat-check pattern to conditionally include OS-specific tasks:

```yaml
- name: "{{ role_name }} | Checking for Distribution Config"
  ansible.builtin.stat:
    path: "{{ role_path }}/tasks/{{ ansible_facts['distribution'] }}.yml"
  register: distribution_config
  changed_when: false

- name: "{{ role_name }} | Run Tasks"
  ansible.builtin.include_tasks: "{{ ansible_facts['distribution'] }}.yml"
  when: distribution_config.stat.exists
```

OS-specific files: `tasks/Ubuntu.yml`, `tasks/Archlinux.yml`.

## YAML Style

- Indentation: 2 spaces (never tabs)
- Booleans: native YAML `true`/`false`, not `'yes'`/`'no'`
- Numbers: native YAML numbers, not strings
- Long commands: YAML folded style with `|` or block scalars

```yaml
# Good
enabled: true
count: 42

# Bad
enabled: 'yes'
count: '42'
```

## Variable Naming

- Variables: `snake_case` with role prefix: `neovim_plugins`, `wireguard_enabled`
- Role variables: defaults in `roles/<role>/defaults/main.yml`
- Sensitive variables: `vars/main.yml`

## Task Naming

Use descriptive names that read like imperative sentences:

```yaml
- name: "Neovim | Install dependencies"
- name: "Docker | Enable service"
```

## Handlers

Use for service restarts. Name clearly:

```yaml
- name: Restart docker
  ansible.builtin.systemd:
    name: docker
    state: restarted
  become: true
```

## Modules

Use native Ansible modules over shell commands:

- `ansible.builtin.package` (preferred for cross-platform)
- `ansible.builtin.file` (symlinks, permissions)
- `ansible.builtin.copy` (static files)
- `ansible.builtin.template` (dynamic configs)
- `ansible.builtin.git`
- `ansible.posix.synchronize` (rsync)
- `community.general.git_config`

Avoid `shell` and `command` unless necessary.

## include_tasks vs import_tasks

- `include_tasks`: Dynamic inclusion (runtime), supports `when` conditions
- `import_tasks`: Static inclusion (parse time), faster but less flexible

Use `include_tasks` for the distribution task pattern.

## Error Handling

Use `failed_when` and `changed_when` for fine control:

```yaml
- name: Check version
  ansible.builtin.command: tool --version
  register: version_check
  failed_when: version_check.rc not in [0, 1]
  changed_when: false
```

Use `changed_when: false` on read-only tasks like `stat`:

```yaml
- name: Check file exists
  ansible.builtin.stat:
    path: /path/to/file
  register: file_stat
  changed_when: false
```

## Check Mode

Use check-mode friendly modules. When a task must run during check mode, use `check_mode: false`:

```yaml
- name: Install package
  ansible.builtin.apt:
    name: vim
  become: true
  check_mode: false
```

## References

- [ADR-001: Cross-Distribution Pattern](../adr/ADR-001-cross-distro-pattern.md)
- [ADR-002: Role Structure](../adr/ADR-002-role-structure.md)
