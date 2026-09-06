# Shell Conventions

Bash and Fish shell script guidelines for this repository.

## Bash Scripts

Always use strict mode:

```bash
#!/bin/bash
set -euo pipefail
```

- `set -e`: Exit on error
- `set -u`: Exit on undefined variable
- `set -o pipefail`: Catch errors in pipes

## shellcheck

Run shellcheck on all scripts:

```bash
shellcheck path/to/script.sh
```

For sourced scripts:

```bash
shellcheck -x path/to/sourced_script.sh
```

Fix all warnings. Use `# shellcheck disable=` sparingly:

```bash
# shellcheck disable=SC1090  # Explanation: why disabled
source /path/to/config
```

## Fish Scripts

Use Fish conventions:

- Local variables: `set -l` (avoids polluting global scope)
- Global variables: `set -g`
- Universal variables: `set -U` (persisted across sessions)

```fish
# Good
function my_function
    set -l local_var "value"
end

# Avoid
function my_function
    set global_var "value"  # pollutes scope
end
```

## Command Substitution

### Bash

```bash
result=$(command)
```

### Fish

```fish
set result (command)
```

## Conditionals

### Bash

```bash
if [[ $var == "value" ]]; then
    echo "match"
fi
```

### Fish

```fish
if test "$var" = "value"
    echo "match"
end
```

## File Paths

Use quotes for paths with spaces:

```bash
# Bash
file="/path/with spaces/file.txt"

# Fish
set file "/path/with spaces/file.txt"
```

## Return Codes

Always check return codes for critical operations:

```bash
command || { echo "Failed"; exit 1; }
```

## Heredocs

### Bash

```bash
cat << 'EOF'
No variable expansion
EOF

cat << EOF
Variable expansion: $VAR
EOF
```

### Fish

```fish
cat << 'EOF'
No variable expansion
EOF
```

## See Also

- Fish plugins managed via Fisher in `roles/fish/files/fish_plugins`
