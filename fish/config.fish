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

  if type -q eza
    alias ls='eza --icons=auto'
  end
  #: }}}

  #: Plugins {{{
  if type -q fisher
    function fi -a pkg
      if not fisher list | grep $pkg &> /dev/null
        fisher install $pkg
      end
    end

    fi patrickf1/fzf.fish
  end
  #: }}}

  #: Key bindings {{{
  fish_vi_key_bindings

  # A few emacsish bindings...
  bind -M default ctrl-a beginning-of-line
  bind -M default ctrl-e end-of-line
  bind -M default delete delete-char
  bind -M default backspace backward-delete-char
  bind -M default alt-backspace backward-kill-word
  bind -M default ctrl-backspace backward-kill-word
  bind -M insert ctrl-a beginning-of-line
  bind -M insert ctrl-e end-of-line
  bind -M insert delete delete-char
  bind -M insert backspace backward-delete-char
  bind -M insert alt-backspace backward-kill-word
  bind -M insert ctrl-backspace backward-kill-word
  #: }}}
end

#: Set EDITOR and MANPAGER {{{
if type -q nvim
  set -x EDITOR nvim
  if nvim --appimage-version &> /dev/null
    # Appimage version (and snap version...) break with MANPAGER
    set -x MANPAGER "nvim --appimage-extract-and-run +Man!"
  else
    set -x MANPAGER "nvim +Man!"
  end
else if type -q vim
  set -x EDITOR vim
  set -x MANPAGER "/bin/sh -c 'col -b -x | vim -R -'"
end
#: }}}

if type -q batcat
  alias bat='batcat'
end

if type -q fdfind
  alias fd='fdfind'
end

[ -e $HOME/.bin ] && fish_add_path $HOME/.bin
[ -e $HOME/.cargo/bin ] && fish_add_path $HOME/.cargo/bin
