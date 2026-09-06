# Git Workflow

Commit conventions and branch strategy for this repository.

## Commit Messages

Follow [Conventional Commits](https://www.conventionalcommits.org/) format:

```
<type>: <description>
```

### Format Rules

- All lowercase
- Imperative mood ("add" not "added")
- No period at end
- Max 72 characters for first line

### Valid Types

| Type | Description |
|------|-------------|
| `feat` | New feature |
| `fix` | Bug fix |
| `docs` | Documentation changes |
| `style` | Formatting, no code change |
| `refactor` | Code restructuring |
| `perf` | Performance improvement |
| `test` | Adding/updating tests |
| `chore` | Maintenance tasks |
| `build` | Build system changes |
| `ci` | CI configuration |
| `revert` | Revert previous commit |

### Examples

```bash
feat: add pnpm to default roles
fix: update neovim plugin versions
docs: add troubleshooting guide
style: reformat ansible tasks
refactor: extract common tasks to shared file
```

## Pre-Commit Checklist

Before committing:

- [ ] Run linters (`yamllint`, `ansible-lint`, `shellcheck`)
- [ ] Run syntax check (`ansible-playbook --syntax-check`)
- [ ] Verify changes are minimal and focused
- [ ] Commit message follows convention

## Branch Strategy

For this personal repository, keep it simple:

- `main` - stable, tested code
- Feature branches for larger changes (optional)

## Pushing

**Never push without explicit user permission.**

When user approves:

```bash
git push origin main
```

For feature branches:

```bash
git push origin feature/my-feature
```

## Rollback

If a commit causes issues, revert:

```bash
git revert <commit-hash>
```

## Commit Scope

Include scope for clarity (optional):

```
feat(neovim): add telescope integration
fix(docker): update compose syntax
```

## Commit Message Body

For complex changes, add body after blank line:

```
fix: resolve idempotency issue in docker role

The service restart was running even when config unchanged.
Added changed_when check to prevent unnecessary restarts.

Closes #123
```

## Destructive Operations

Always ask user before:
- Force pushes (`git push --force`)
- Deleting branches
- Destructive git operations
