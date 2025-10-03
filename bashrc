if [[ $- == *i* ]]
then
  # Interactive mode

  # I like fish (as a shell, not to eat...).
  # But apparently has some issues when set as login shell, so this bit execs
  # fish from bash (so bash can be set as login shell, but I get a fish shell).
  # Doesn't happen when using bash with -c, when running from fish, if not in
  # interactive mode, or if fish doesn't exist!
  if [[ -z "$BASH_EXECUTION_STRING" \
     && $(ps --no-header --pid=$PPID --format=comm) != "fish" \
     && -n $(type fish 2> /dev/null) ]]
  then
    shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
    exec fish $LOGIN_OPTION
  fi
fi
