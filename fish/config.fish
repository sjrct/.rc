if status is-interactive
    # Commands to run in interactive sessions can go here

    alias tsh-l "tsh login --proxy=teleport.hackedu.io:443 teleport.hackedu.io"
    alias tsh-kl "tsh kube login labs-dev"
    alias k-dev-clear "kubectl delete pods --all -n dev-sjrct --context teleport.hackedu.io-labs-dev"

    alias ll "ls -l"
    alias l ls
    alias v vim
    alias kc kubectl

    # Docker composer aliases
    alias dc 'docker compose'
    alias dcd 'dc down'
    alias dcu 'dc up -d'
    alias dcr 'dc restart'
    alias dcl 'dc logs'

    # Git aliases
    alias g 'git'
    alias gcm 'git commit'
    alias gch 'git checkout'
    alias gd 'git diff'
    alias gl 'git log'
    alias ga 'git add'
    alias gpl 'git pull'
    alias gph 'git push'

    # fuzzy finder
    fzf --fish | source
end

set -x EDITOR nvim
