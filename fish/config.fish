if status is-interactive
  set fish_greeting # remove fish's greeting

  set parts alias functions env
  for part in $parts
    set file $HOME/.config/fish/parts/$part.fish
    if test -e $file
      source $file
    end
  end

  starship init fish | source
end
