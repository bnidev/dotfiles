# docker
abbr dcu 'docker compose up'
abbr dsa 'docker stop (docker ps -a -q)'

# git
abbr g 'git'

# shell
abbr h 'history'

# node
abbr run 'npm run'
abbr nv 'node --version'

# misc
abbr mv 'mv -i'
abbr cp 'cp -i -p'
abbr week 'date +%V' # Get week number
abbr . 'nautilus .'

# IP addresses
abbr ip "dig +short myip.opendns.com @resolver1.opendns.com"
abbr localip "ipconfig getifaddr en0"
abbr ips "ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'"

# ls
if type -q eza
  set TREE_IGNORE 'cache|log|logs|node_modules|vendor|.git'
  alias ls 'eza --icons'
  abbr ls 'ls -a'
  abbr ll 'ls -la'
  abbr lt 'ls --tree -D -L 2 -I $TREE_IGNORE'
  abbr ltt 'ls --tree -D -L 3 -I $TREE_IGNORE'
  abbr lttt 'ls --tree -D -L 4 -I $TREE_IGNORE'
end
