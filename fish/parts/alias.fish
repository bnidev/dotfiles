# directories
abbr dl 'cd ~/Downloads'

# docker
abbr dcu 'docker compose up'
abbr dsa 'docker stop (docker ps -a -q)'
abbr dce 'docker compose exec'
abbr dcd 'docker compose down'
abbr dcs 'docker compose stop'
abbr dck 'docker compose kill'
abbr dcr 'docker compose restart'
abbr dcp 'docker compose pull'

# git
abbr g 'git'
abbr gco 'git checkout'
abbr gc 'git commit -m'
abbr gd 'git diff'
abbr gs 'git status'
abbr gp 'git push'
abbr gpl 'git pull'

# shell
abbr h 'history'

# node
abbr run 'npm run'
abbr nv 'node --version'

# misc
abbr mv 'mv -i'
abbr cp 'cp -i -p'
abbr kw 'date +%V' # Get week number
abbr . 'nautilus .'
abbr du 'du -h'
abbr df 'df -P -kHl --exclude-type=tmpfs --exclude-type=devtmpfs'

# IP addresses
abbr globalip "dig +short myip.opendns.com @resolver1.opendns.com"
abbr localip 'ip -o route get to 8.8.8.8 | sed -n "s/.*src \([0-9.]\+\).*/\1/p"'

# ls
if type -q eza
  set TREE_IGNORE 'cache|log|logs|node_modules|vendor|.git'
  alias ls 'eza --icons'
  abbr ls 'ls -a'
  abbr ll 'ls -la'
  abbr ld 'ls -lD'
  abbr lf 'ls -lfa'
  abbr lt 'ls --tree -D -L 2 -I $TREE_IGNORE'
  abbr ltt 'ls --tree -D -L 3 -I $TREE_IGNORE'
  abbr lttt 'ls --tree -D -L 4 -I $TREE_IGNORE'
end
