# Troubleshooting

Common issues and their solutions when running the dotfiles playbook.

## Playbook Stuck in "Updating cache"

### Symptom
The playbook appears to hang on "Updating cache" or "Gathering Facts" tasks.

### Cause
Ubuntu's package cache update is waiting for user input due to a stalled package upgrade.

### Solution
1. Cancel the playbook (`Ctrl+C`)
2. Manually update your system:
   ```bash
   sudo apt update
   sudo apt upgrade
   ```
3. Address any warnings or prompts that appear
4. Re-run the playbook

## Playbook Fails When Adding Keyrings and/or Sources

### Symptom
Ansible fails when trying to add repository keyrings or package sources.

### Cause
The keyring or source already exists but with a different name or version.

### Solution
1. Identify the failing repository from the error output
2. Remove the existing keyring or source:
   ```bash
   # For keyrings
   sudo rm /etc/apt/keyrings/<name>.gpg

   # For sources
   sudo rm /etc/apt/sources.list.d/<name>.list
   ```
3. Re-run the playbook

## WSL Detection Issues

### Symptom
WSL-specific roles (like wezterm) don't run or behave unexpectedly.

### Cause
WSL detection relies on checking `/proc/version`.

### Solution
1. Verify WSL is detected:
   ```bash
   cat /proc/version | grep -i microsoft
   ```
2. If empty, WSL detection will fail
3. Check that `ansible_host_environment_is_wsl` fact is set correctly

## Role Fails on Non-Supported Distribution

### Symptom
A role fails with "file not found" or similar error.

### Cause
The role may not have OS-specific tasks for your distribution.

### Solution
1. Check if your distribution is supported (Ubuntu or Arch Linux)
2. If using a different distribution, you may need to create OS-specific task files
3. See [Adding a Role](adding-a-role.md) for how to add distribution support

## SSH Key Generation Skipped

### Symptom
The playbook skips SSH key generation even though you need keys.

### Cause
The `dotfiles` wrapper only prompts for key generation if `~/.ssh/id_rsa` doesn't exist.

### Solution
1. Manually generate keys:
   ```bash
   ssh-keygen -b 4096 -t rsa -f ~/.ssh/id_rsa -N ''
   ```
2. Add your public key to GitHub/GitLab
3. Re-run the playbook if needed

## Permission Denied Errors

### Symptom
Tasks fail with "Permission denied" errors.

### Cause
The playbook requires sudo privileges for system-level changes.

### Solution
1. The playbook should prompt for sudo password at the start
2. If running non-interactively, use:
   ```bash
   ansible-playbook --ask-become-pass -i localhost, -c local main.yml
   ```
3. Or ensure your user has passwordless sudo configured

## Getting Help

If you encounter an issue not covered here:

1. Check the Ansible output for specific error messages
2. Run with verbose output: `ansible-playbook -v main.yml`
3. Check the [GitHub Issues](https://github.com/bnidev/dotfiles/issues) for known problems
