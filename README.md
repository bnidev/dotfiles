# Dotfiles

I automated my development setup with [Ansible](https://github.com/ansible/ansible).

## Core Tools

- **Shell:** [fish](https://fishshell.com/)
- **Terminal:** [WezTerm](https://wezfurlong.org/wezterm/) / [Ghostty](https://ghostty.org/)
- **Prompt:** [Starship](https://starship.rs/)
- **Editor:** [Neovim](https://github.com/neovim/neovim)
- **Notes:** [Obsidian](https://obsidian.md/) integrated in Neovim with [obsidian.nvim](https://github.com/epwalsh/obsidian.nvim)

## Getting Started

### Quick Start

```bash
git clone https://github.com/bnidev/dotfiles.git ~/.dotfiles
~/.dotfiles/bin/dotfiles
```

The wrapper script will:
- Detect your OS and install dependencies
- Clone/pull the dotfiles repository
- Prompt to generate SSH keys if needed
- Copy the config template to `~/.config/dotfiles/config.yml`
- Run the full playbook

### Running Specific Roles

Target one or more roles (comma-separated):
```bash
~/.dotfiles/bin/dotfiles -t neovim
~/.dotfiles/bin/dotfiles -t neovim,fish,git
```

### Dry-Run Mode

Preview changes without applying:
```bash
dotfiles --check --diff
```

## Available Roles

| Role | Description |
|------|-------------|
| `bat` | Cat clone with syntax highlighting |
| `cargo` | Rust package manager |
| `docker` | Docker and Docker Compose |
| `eza` | Modern ls replacement |
| `fd` | Fast find alternative |
| `fish` | Fish shell setup |
| `fonts` | Nerd Fonts installation |
| `fzf` | Fuzzy finder |
| `ghostty` | Terminal emulator |
| `git` | Git configuration |
| `go` | Go programming language |
| `lazydocker` | Docker TUI |
| `lazygit` | Git TUI |
| `mattermost` | Team chat |
| `mercurial` | Version control |
| `neovim` | Neovim configuration |
| `nvm` | Node version manager |
| `opencode` | AI coding agent |
| `obsidian` | Obsidian integration |
| `pnpm` | Package manager |
| `posting` | HTTP client |
| `ripgrep` | Grep alternative |
| `sshfs` | SSH filesystem |
| `sshs` | SSH TUI |
| `starship` | Prompt |
| `tldr` | Simplified man pages |
| `tokei` | Code statistics |
| `wezterm` | Terminal emulator |
| `wireguard` | VPN |
| `system` | Base system packages |

## Supported OSes

- Ubuntu 22.04 and later
- Arch Linux

## Documentation

For detailed documentation, see [`docs/`](docs/):
- [Troubleshooting](docs/guides/troubleshooting.md)
- [Adding a Role](docs/guides/adding-a-role.md)
- [Architecture Decision Records](docs/adr/)
- [Glossary](docs/glossary.md)

## Credits

The Ansible setup is inspired by [TechDufus](https://github.com/TechDufus/dotfiles/) and [Alt-F4-LLC](https://github.com/ALT-F4-LLC/dotfiles).
