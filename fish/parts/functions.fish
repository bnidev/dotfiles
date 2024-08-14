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
    set node_version (nvm version)
    set nvmrc_node_version (nvm version (cat .nvmrc))

    if [ $nvmrc_node_version = "N/A" ]
      nvm install
    else if [ $nvmrc_node_version != $node_version ]
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
