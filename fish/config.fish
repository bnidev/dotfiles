if status is-interactive
  set fish_greeting # remove fish's greeting

  set parts alias functions env
  for part in $parts
    set file $HOME/.config/fish/parts/$part.fish
    if test -e $file
      source $file
    end
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
end
