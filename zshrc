# Aliases
if ls --color 2> /dev/null > /dev/null ; then
  # GNU ls
  LS_FLAGS="--color --group-directories-first"
else
  # BSD/Mac ls
  LS_FLAGS="-G"
fi

alias ls="ls $LS_FLAGS"
alias l="ls $LS_FLAGS"
alias la="ls -a $LS_FLAGS"
alias ll="ls -l $LS_FLAGS"

alias rm="rm -v"
alias cp="cp -v"
alias catdog="cp"
alias p="pwd"
alias v="vim"
alias g="git"
alias frm="rm -rf"
alias h="history"
alias hgr="fc -l 0 -1 | grep"
alias ocaml="rlwrap ocaml"

alias diff="colordiff -up"
alias less="less -R"
alias ff="find . -name"
alias zed="vim ~/.zshrc ; source ~/.zshrc"
alias zled="vim ~/.rcola/local/zshrc ; source ~/.rcola/local/zshrc"
alias rez="source ~/.zshrc"

alias gtcl='git clone'
alias gtpl='git pull'
alias gtrb='git rebase'
alias gtph='git push'
alias gtst='git status'
alias gtdf='git diff'
alias gtcm='git commit'
alias gtlg='git log --oneline'
alias gtad='git add'
alias gtch='git checkout'
alias gtcb='git checkout -b'
alias gtbr='git branch'

uprc() {
  pushd ~/.rcola
  git add zshrc vimrc link
  git commit -m 'Update rc files'
  git push origin master
  popd
}

vf() {
  vim `find . -name $1` $2 $3 $4 $5 $6 $7 $8 $9
}

# Key bindings
bindkey -e

export EDITOR=vim
export LESSHISTFILE=/dev/null

# History options
export HISTFILE=~/.zhist
export HISTSIZE=10000
export SAVEHIST=10000
setopt hist_ignore_dups extended_history hist_find_no_dups

# Prompt
export PROMPT="%B%F{blue}%2~%f%b %# "
export RPROMPT="%(?..%B[%?]%b)%1(j.%F{green}%j%f.)"

export PATH=/usr/local/bin:$PATH
export GOPATH=$HOME/go

# Directory history
export DIRSTACKSIZE=20
setopt autocd
setopt auto_pushd pushd_minus pushd_silent
alias dh="dirs -v"
alias dhg="dirs -v | grep"

# The following lines were added by compinstall

zstyle ':completion:*' completer _complete _ignored
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' menu select=1
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' verbose true
zstyle :compinstall filename '/Users/chrisharding/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.cache/zsh/comp
zstyle ':completion:*' accept-exact '*(N)'

zstyle ':completion:*' special-dirs true
setopt extended_glob

# So beautiful, its like a waterfall!
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'
alias -g .......='../../../../../..'
alias -g ........='../../../../../../..'
alias -g .........='../../../../../../../..'
alias -g ..........='../../../../../../../../..'
alias -g ...........='../../../../../../../../../..'
alias -g ............='../../../../../../../../../../..'
alias -g .............='../../../../../../../../../../../..'
alias -g ..............='../../../../../../../../../../../../..'
alias -g ...............='../../../../../../../../../../../../../..'
alias -g ................='../../../../../../../../../../../../../../..'
alias -g .................='../../../../../../../../../../../../../../../..'
alias -g ..................='../../../../../../../../../../../../../../../../..'
alias -g ...................='../../../../../../../../../../../../../../../../../..'
alias -g ....................='../../../../../../../../../../../../../../../../../../..'
alias -g .....................='../../../../../../../../../../../../../../../../../../../..'
alias -g ......................='../../../../../../../../../../../../../../../../../../../../..'
alias -g .......................='../../../../../../../../../../../../../../../../../../../../../..'
alias -g ........................='../../../../../../../../../../../../../../../../../../../../../../..'
alias -g .........................='../../../../../../../../../../../../../../../../../../../../../../../..'
alias -g ..........................='../../../../../../../../../../../../../../../../../../../../../../../../..'
alias -g ...........................='../../../../../../../../../../../../../../../../../../../../../../../../../..'
alias -g ............................='../../../../../../../../../../../../../../../../../../../../../../../../../../..'
alias -g .............................='../../../../../../../../../../../../../../../../../../../../../../../../../../../..'
alias -g ..............................='../../../../../../../../../../../../../../../../../../../../../../../../../../../../..'
alias -g ...............................='../../../../../../../../../../../../../../../../../../../../../../../../../../../../../..'
alias -g ................................='../../../../../../../../../../../../../../../../../../../../../../../../../../../../../../..'

# Load local options/overrides
source $HOME/.rcola/local/zshrc
