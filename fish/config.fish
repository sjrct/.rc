# vim:foldmethod=marker

if [ (fish --version | cut -f3 -d' ' | cut -f1 -d.) -lt 4 ]
  echo Fish version less than 4... vi mode is wonky, some binds dont work
end

if status is-interactive
  #: Abbreviations / aliases {{{

  function _subcmd_abbr -a cmd from to pos
    eval "function _abbr-$cmd-$from -a token
      if [ (count (commandline | string split -n ' ')) -eq $pos ]
        echo $to
      else
        echo \$token
      end
    end"
    abbr -a $cmd-$from -c $cmd -r $from -f _abbr-$cmd-$from
  end

  abbr -a ll 'ls -l'
  abbr -a la 'ls -a'
  abbr -a v nvim
  # I've given in...
  abbr -a vim nvim
  abbr -a kc kubectl

  # Docker composer abbrevs
  function _dc_subcmd_abbr -a from to
    _subcmd_abbr docker $from $to 3
    abbr -a dc$from "git $to"
  end

  abbr -a dc 'docker compose'
  abbr -a docker-compose 'docker compose'
  _dc_subcmd_abbr d down
  _dc_subcmd_abbr u 'up -d'
  _dc_subcmd_abbr r restart
  _dc_subcmd_abbr l logs
  _dc_subcmd_abbr e exec

  # Git abbrevs
  function _git_subcmd_abbr -a from to
    _subcmd_abbr git $from $to 2
    abbr -a g$from "git $to"
  end

  abbr -a g 'git'
  _git_subcmd_abbr a add
  _git_subcmd_abbr ch checkout
  _git_subcmd_abbr cm commit
  _git_subcmd_abbr d diff
  _git_subcmd_abbr l log
  _git_subcmd_abbr ph push
  _git_subcmd_abbr pl pull
  _git_subcmd_abbr st status
  _git_subcmd_abbr sw switch

  type -q xclip && alias xcopy 'xclip -in -selection clipboard'
  type -q xclip && alias xpaste 'xclip -out -selection clipboard'

  type -q eza && alias ls 'eza --icons=auto'

  [ $TERM = xterm-kitty ] && alias ssh 'kitten ssh'

  # In case I accidentally remember anything from (ba|z)sh...
  abbr --position=anywhere '$?' '$status'
  abbr --position=anywhere '$!' '$last_pid'
  abbr --position=anywhere '$$' '$fish_pid'
  abbr '\\' command
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
  alias bat=batcat
end

if type -q fdfind
  alias fd=fdfind
end

[ -e $HOME/.bin ] && fish_add_path $HOME/.bin
[ -e $HOME/.cargo/bin ] && fish_add_path $HOME/.cargo/bin
