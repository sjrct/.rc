# Aliases
if [ "$OSTYPE" == linux-gnu ]; then
  # GNU ls
  LS_FLAGS="--color --group-directories-first"
else
  # BSD/Mac ls
  LS_FLAGS="-G"
fi

VIM=vim

alias ls="ls $LS_FLAGS"
alias l="ls $LS_FLAGS"
alias la="ls -a $LS_FLAGS"
alias ll="ls -l $LS_FLAGS"

alias cp="cp -v"
alias p="pwd"
alias v="$VIM"
alias vim="$VIM"

alias g="git"
alias h="history"
alias hgr="fc -l 0 -1 | grep"
alias ocaml="rlwrap ocaml"

alias less="less -R"
alias ff="find . -iname"
alias zed="$VIM ~/.zshrc ; source ~/.zshrc"
alias zled="$VIM ~/.rc/local/zshrc ; source ~/.rc/local/zshrc"
alias rez="source ~/.zshrc"
alias hb=halibot

uprc() {
  pushd ~/.rc
  git add zshrc vimrc link
  git commit -m 'Update rc files'
  git push origin master
  popd
}

# Key bindings
bindkey -e
bindkey "^[[3~"  delete-char     # Delete key
bindkey "^[3;5~" delete-char     # Delete key some other keyboards

export EDITOR=$VIM
export LESSHISTFILE=/dev/null

# History options
#export HISTFILE=~/.zhist
#export HISTSIZE=10000
#export SAVEHIST=10000
#setopt hist_ignore_dups extended_history hist_find_no_dups

# Prompt
export PROMPT="%B%F{blue}%2~%f%b %# "
export RPROMPT="%(?..%B[%?]%b)%1(j.%F{green}%j%f.)"

export PATH=$HOME/bin:$PATH:/usr/local/bin
export GOPATH=$HOME/go

# Erlang flags
export ERL_AFLAGS="-kernel shell_history enabled"

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

# Load local options/overrides
source $HOME/.rc/local/zshrc
