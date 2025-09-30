# vim:foldmethod=marker

if [ (fish --version | cut -f3 -d' ' | cut -f1 -d.) -lt 4 ]
  echo Fish version less than 4... vi mode is wonky, some binds dont work
end

if status is-interactive
  # FIXME
  source $HOME/.rc/aliases

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
