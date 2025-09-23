# vim:foldmethod=marker

if status is-interactive
  #: Aliases {{{
  alias ll 'ls -l'
  alias la 'ls -a'
  alias v nvim
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
  alias gst 'git status'

  if which xclip &> /dev/null
    alias xcopy='xclip -in -selection clipboard'
    alias xpaste='xclip -out -selection clipboard'
  end

  if [ $TERM = xterm-kitty ]
    alias ssh='kitten ssh'
  end

  if eza --version &> /dev/null
    alias ls='eza --icons=auto'
  end
  #: }}}

  if fisher --version &> /dev/null
    function fi -a pkg
      if not fisher list | grep $pkg &> /dev/null
        fisher install $pkg
      end
    end

    fi patrickf1/fzf.fish
  end
end

#: Set EDITOR and MANPAGER {{{
if which nvim &> /dev/null
  set -x EDITOR nvim
  if nvim --appimage-version &> /dev/null
    # Appimage version (and snap version...) break with MANPAGER
    set -x MANPAGER "nvim --appimage-extract-and-run +Man!"
  else
    set -x MANPAGER "nvim +Man!"
  end
else if which vim &> /dev/null
  set -x EDITOR vim
  set -x MANPAGER "/bin/sh -c 'col -b -x | vim -R -'"
end
#: }}}

if which batcat &> /dev/null
  alias bat='batcat'
end

if which fdfind &> /dev/null
  alias fd='fdfind'
end

[ -e $HOME/.bin ] && fish_add_path $HOME/.bin
[ -e $HOME/.cargo/bin ] && fish_add_path $HOME/.cargo/bin
