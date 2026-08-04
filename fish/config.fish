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

  # Docker & docker composer abbrevs
  abbr -a d 'docker'
  abbr -a dc 'docker compose'
  abbr -a dcm 'docker compose'
  abbr -a dcn 'docker container'
  abbr -a di 'docker image'
  abbr -a dim 'docker image'
  abbr -a din 'docker inspect'
  abbr -a docker-compose 'docker compose'
  # docker subcommands
  _subcmd_abbr docker b build 2
  _subcmd_abbr docker cm compose 2
  _subcmd_abbr docker com compose 2
  _subcmd_abbr docker cn container 2
  _subcmd_abbr docker con container 2
  _subcmd_abbr docker cont container 2
  _subcmd_abbr docker e exec 2
  _subcmd_abbr docker x exec 2
  _subcmd_abbr docker im image 2
  _subcmd_abbr docker in inspect 2
  _subcmd_abbr docker n network 2
  _subcmd_abbr docker p pull 2
  _subcmd_abbr docker r run 2
  _subcmd_abbr docker s search 2
  # compose/image/container subcommands (together as they all use arg 3)
  _subcmd_abbr docker d down 3
  _subcmd_abbr docker di diff 3
  _subcmd_abbr docker e exec 3
  _subcmd_abbr docker x exec 3
  _subcmd_abbr docker h history 3
  _subcmd_abbr docker i inspect 3
  _subcmd_abbr docker k kill 3
  _subcmd_abbr docker l logs 3
  _subcmd_abbr docker pa pause 3
  _subcmd_abbr docker po port 3
  _subcmd_abbr docker r restart 3
  _subcmd_abbr docker u 'up -d' 3
  _subcmd_abbr docker unp unpause 3

  # Git abbrevs
  abbr -a g 'git'
  _subcmd_abbr git a add 2
  _subcmd_abbr git ch checkout 2
  _subcmd_abbr git co commit 2
  _subcmd_abbr git cm commit 2
  _subcmd_abbr git d diff 2
  _subcmd_abbr git di diff 2
  _subcmd_abbr git l log 2
  _subcmd_abbr git ph push 2
  _subcmd_abbr git pl pull 2
  _subcmd_abbr git r reset 2
  _subcmd_abbr git re reset 2
  _subcmd_abbr git rv revert 2
  _subcmd_abbr git st status 2
  _subcmd_abbr git sw switch 2

  type -q xclip && alias xcopy 'xclip -in -selection clipboard'
  type -q xclip && alias xpaste 'xclip -out -selection clipboard'

  type -q eza && alias ls 'eza --icons=auto'

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
    fi jorgebucaran/nvm.fish
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

  # Private mode {{{
  function toggle_private_mode
    if set -q fish_private_mode
      set -e fish_private_mode
    else
      set -g fish_private_mode 1
    end
  end

  bind -M insert ctrl-\\ toggle_private_mode

  # So that kitty (or whoever) can know if a particular PID is in private mode
  function _track_private_mode --on-variable fish_private_mode
    if set -q fish_private_mode
      touch /tmp/fish-private-$fish_pid
    else
      rm -f /tmp/fish-private-$fish_pid
    end
  end

  # Handles --private
  _track_private_mode

  function _cleanup_track_private_mode --on-event fish_exit
    rm -f /tmp/fish-private-$fish_pid
  end
  # }}}
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
