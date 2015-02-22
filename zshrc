source $HOME/.rccola/local/zshrc

# Aliases
alias ls="ls -G"
alias l="ls -G"
alias la="ls -a -G"
alias ll="ls -l -G"
alias p="pwd"

alias diff="colordiff -up"
alias less="less -R"
alias ag="ag -u"
alias ff="find . -name"
alias zed="vim ~/.zshrc ; source ~/.zshrc"
alias rez="source ~/.zshrc"

uprc() {
  set -e
  pushd ~/.rccola
  git add zshrc vimrc link
  git commit -m 'Update rc files'
  git push origin master
  popd
}

# Key bindings
bindkey -e

# History options
export HISTFILE=~/.zhist
export HISTSIZE=10000
export SAVEHIST=10000
set hist_ignore_dups extended_history hist_find_no_dups

# Prompt
export PROMPT="%B%F{blue}%2~%f%b %# "
export RPROMPT="%(?..%B[%?]%b)%1(j.%F{green}%j%f.)"

export PATH=/usr/local/bin:$PATH

# Directory history
export DIRSTACKSIZE=20
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

zstyle ':completion:*' special-dirs true

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

