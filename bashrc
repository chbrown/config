# If not running interactively, don't do anything
[ -z "$PS1" ] && return

export PATH=/usr/local/sbin:/usr/local/bin:$PATH
[ -d ~/bin ] && export PATH=~/bin:$PATH

# history control
export HISTCONTROL=ignoredups:ignorespace
export HISTSIZE=10000000000
export HISTFILESIZE=10000000000000
shopt -s histappend
shopt -s checkwinsize
if [[ `$SHELL --version` =~ 'version 4' ]]; then
  shopt -s autocd
  shopt -s globstar
fi
stty -ixon

export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad
export GREP_OPTIONS='--color=auto'
export EDITOR=vim

alias act='source bin/activate'
alias awk='awk -F \\t'
alias count='sort | uniq -c | sort -g'
alias flatten="tr -s [:space:] ' '"
alias hdfs='hadoop fs'
alias ipy='ipython -i'
alias iso='date +%Y%m%d'
alias lower="tr '[A-Z]' '[a-z]'"
alias lsa='ls -la'
alias lsl='ls -l'
alias perlsed='perl -pe'
alias py='python'
alias token="tr -s [:space:] '\n'"
alias upper="tr '[a-z]' '[A-Z]'"

j_arch=/usr/etc/profile.d/autojump.bash
j_mac=/usr/local/etc/autojump.sh
j_debian=/usr/share/autojump/autojump.bash
if [ -f $j_arch ]; then
  . $j_arch
elif [ -f $j_mac ]; then
  . $j_mac
elif [ -f $j_debian ]; then
  . $j_debian
fi

function cdp {
  mkdir -p $1
  cd $1
}
function cdr {
  cd **/*$1*
}
function lsd {
  lsa $@ | grep ^d
}
function fullpath {
  # http://stackoverflow.com/questions/5265702/how-to-get-full-path-of-a-file
  echo $(cd $(dirname "$1") && pwd -P)/$(basename "$1")
}

# Mac OS X -only functions
if [ `uname` = Darwin ]; then
  function o {
    # $* is the list of arguments.
    # $@ is just like $*, but quoted.
    # $# is the number of args in $*, which is the same as in $@
    # in both cases of using $@ (an array) and $OPENFLAGS (also an array),
    # by using the @ indexer, we get the elements back individually quoted
    # if we wrap the whole ARR[@] in quotes
    if [ $# -eq 0 ]; then
      # if there were no arguments specified, simply start editing in the current directory
      echo Opening current directory: `pwd`
      open "${OPENFLAGS[@]}" .
    else
      open "${OPENFLAGS[@]}" "$@"
    fi
  }
  function e {
    # the parentheses trigger a subshell, so that OPENFLAGS is not persisted globally
    (OPENFLAGS=(-a 'Sublime Text.app'); o "$@")
  }
  function mou {
    (OPENFLAGS=(-a Mou.app); o "$@")
  }
fi

# -e is true for existing files
[ -e ~/.localrc ] && source ~/.localrc

export PS1="\[\e[1;32m\][\u@$MACHINE \w]\$\[\e[0m\] "

# open last working directory if there is one.
# this should come after `source ~/.localrc` so that .localrc can `export WD=~/wherever` if desired.
#   -n is true for not-null strings
#   -z is true for null strings
if [ -n "$WD" ] && [ -d "$WD" ]; then
  cd $WD
elif [ -f /tmp/pwd ]; then
  WD=$(cat /tmp/pwd)
  if [ -n "$WD" ] && [ -d "$WD" ]; then
    cd $WD
  fi
fi

# `trap <cmd> DEBUG` runs cmd after every "simple command"
# but we only want to save the time of the first command after the prompt is shown
# The ${X-$Y} means return X even if it's set to '', else $Y
#   ${X:-$Y} syntax means return X if X is set AND X != '', else $Y
#   We unset STARTED after we show it, so we only set it the first time a command is run after that
trap 'STARTED=${STARTED-$SECONDS}' DEBUG

# PROMPT_COMMAND is executed as a regular Bash command just before Bash displays a prompt
# autojump uses PROMPT_COMMAND so we need to append to that existing command
# the PROMPT_COMMAND part below *must* be the last thing that runs.
function timer_stop {
  export LAST=$(($SECONDS - $STARTED))
  unset STARTED
}
# -z returns true when given a zero-length string
if [ -z "$PROMPT_COMMAND" ]; then
  PROMPT_COMMAND="timer_stop"
else
  PROMPT_COMMAND="$PROMPT_COMMAND; timer_stop"
fi
