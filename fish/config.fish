if status is-interactive
    set fish_greeting # remove fish's greeting

    set parts alias functions
    for part in $parts
      set file $HOME/.config/fish/parts/$part.fish
      if test -e $file
        source $file
      end
    end

    export LS_COLORS="ow=34" # fix highlight color for directory writable to others (ow)
end
