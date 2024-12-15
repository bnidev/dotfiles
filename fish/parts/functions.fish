# Reload shell
function reload
  source ~/.config/fish/config.fish
  echo "Reloaded shell configuration"
end

# Create a new directory and enter it
function mkd
	mkdir -p "$argv" && cd "$argv"
end

# automatically run nvm use in directories when .nvmrc is present
function check_nvm_version --on-variable PWD --description 'Do nvm stuff'
  if test -f .nvmrc
    set node_version (node -v)
    set nvmrc_node_version (nvm list | grep (cat .nvmrc))

    if set -q $nvmrc_node_version
      nvm install
    else if string match -q -- "*$node_version" $nvmrc_node_version
      # already current node version
    else
      nvm use
    end
  end
end

# check version of all regularly used services
function cva
  echo "Node.js version: $(node --version)"
  echo "npm version: $(npm --version)"
  docker --version
  docker compose version
  git version
  fish --version
end

function gbr --description "Git browse commits"
    set -l log_line_to_hash "echo {} | grep -o '[a-f0-9]\{7\}' | head -1"
    set -l view_commit "$log_line_to_hash | xargs -I % sh -c 'git show --color=always % | diff-so-fancy | less -R'"
    set -l copy_commit_hash "$log_line_to_hash | xclip"
    set -l git_checkout "$log_line_to_hash | xargs -I % sh -c 'git checkout %'"
    set -l open_cmd "open"

    if test (uname) = Linux
        set open_cmd "xdg-open"
    end

    set github_open "$log_line_to_hash | xargs -I % sh -c '$open_cmd https://github.\$(git config remote.origin.url | cut -f2 -d. | tr \':\' /)/commit/%'"

    git log --color=always --format='%C(auto)%h%d %s %C(green)%C(bold)%cr% C(blue)%an' | \
        fzf --no-sort --reverse --tiebreak=index --no-multi --ansi \
            --preview="$view_commit" \
            --header="ENTER to view, CTRL-Y to copy hash, CTRL-O to open on GitHub, CTRL-X to checkout, CTRL-C to exit" \
            --bind "enter:execute:$view_commit" \
            --bind "ctrl-y:execute:$copy_commit_hash" \
            --bind "ctrl-x:execute:$git_checkout" \
            --bind "ctrl-o:execute:$github_open"
end
