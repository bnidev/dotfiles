if status is-interactive
  # remove fish's greeting
  set fish_greeting

  # load config parts
  set parts (ls $HOME/.config/fish/parts/*.fish)
  for file in $parts
    source $file
  end

  # Starship prompt
  if command -v 'starship' &>/dev/null
    starship init fish | source
  end

  # FZF
  fzf --fish | source

  export FZF_DEFAULT_OPTS="--height 50% --layout=default --border --color=hl:#2dd4bf"

  export FZF_CTRL_T_OPTS="--preview 'bat --color=always -n --line-range :500 {}'"
  export FZF_ALT_C_OPTS="--preview 'eza --icons=always --tree --color=always {} | head -200'"
  export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"

  # Node Version
  check_nvm_version
end
