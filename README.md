# Dotfiles

I automated my development setup with [Ansible](https://github.com/ansible/ansible).

## Core Tools

- **Shell:** [fish](https://fishshell.com/)
- **Terminal:** [WezTerm](https://wezfurlong.org/wezterm/)
- **Prompt:** [Starship](https://starship.rs/)
- **Editor:** [Neovim](https://github.com/neovim/neovim)

## Noteworthy CLI Tools and Plugins

- [Fisher](https://github.com/jorgebucaran/fisher) - A plugin manager for `fish`
- [eza](https://eza.rocks/) - A modern replacement for `ls`
- [z](https://github.com/jethrokuan/z) - Tracks your most used directories and let's you jump to it quickly
- [fzf](https://github.com/junegunn/fzf) - A fuzzy finder for the command-line
- [nvm.fish](https://github.com/jorgebucaran/nvm.fish) - Node version manager built for `fish`
- [lazygit](https://github.com/jesseduffield/lazygit) - A simple terminal UI for git commands
- [sshs](https://github.com/quantumsheep/sshs) - A terminal UI for SSH connections

## Known Issues / Troubleshooting

### The playbook is stuck in "Updating cache"

Make sure your OS is up to date and does not have any warnings or errors when you run `sudo apt update` or `sudo apt upgrade`. I encountered this issue when Ubuntu failed to update a package.

### The playbook fails when adding keyrings and/or sources

The keyring or source may already exist, but with a different name or version. Try removing it and running the playbook again.

## Credits
The Ansible setup is inspired by [TechDufus](https://github.com/TechDufus/dotfiles/) and [Alt-F4-LLC](https://github.com/ALT-F4-LLC/dotfiles).
