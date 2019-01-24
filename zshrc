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

alias cp="cp -v"
alias catdog="cp"
alias p="pwd"
alias v="vim"
alias g="git"
alias frm="rm -rf"
alias h="history"
alias hgr="fc -l 0 -1 | grep"
alias ocaml="rlwrap ocaml"

alias diff="vimdiff"
alias less="less -R"
alias ff="find . -name"
alias zed="vim ~/.zshrc ; source ~/.zshrc"
alias zled="vim ~/.rcola/local/zshrc ; source ~/.rcola/local/zshrc"
alias rez="source ~/.zshrc"

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
bindkey "^[[3~"  delete-char     # Delete key
bindkey "^[3;5~" delete-char     # Delete key some other keyboards

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

# Setup nvm if we have it
[[ -e "$HOME/.nvm" ]] && export NVM_DIR="$HOME/.nvm"
if [[ -n "$NVM_DIR" ]]; then
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
fi

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
