# If not running interactively, don't do anything
[ -z "$PS1" ] && return

export PATH=/usr/local/sbin:/usr/local/bin:$PATH
#export LD_LIBRARY_PATH=/usr/local/lib:/usr/lib/:$LD_LIBRARY_PATH

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
export EDITOR=vim
[ -d ~/bin ] && export PATH=~/bin:$PATH

alias lsa='ls -la'
alias lsl='ls -l'
alias lower="tr '[A-Z]' '[a-z]'"
alias upper="tr '[a-z]' '[A-Z]'"
alias token="tr -s [:space:] '\n'"
alias flatten="tr -s [:space:] ' '"
alias py='python'
alias ipy='ipython -i'
alias hdfs='hadoop fs'
alias iso='date +%Y%m%d'
alias perlsed='perl -pe'
alias count='sort | uniq -c | sort -g'

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
    default_target="."
    open ${1:-$default_target}
  }
  function e {
    APP='Sublime Text 2.app'
    # $* is the list of arguments, $@ is $* but quoted, and $# is the number of args in $*/$@
    [ $# -lt 1 ] && open -a "$APP" . || open -a "$APP" $@
  }
fi

source ~/.bashrc.local

#export PS1="[\u@$MACHINE \w]\$ "
# above: normal prompt. below: green prompt.
export PS1="\[\e[1;32m\][\u@$MACHINE \w]\$\[\e[0m\] "
# the \[\033[G\] at the beginning glues the rest to the front of the prompt.
# but it doesn't play nice with virtualenv
#export PS1='\h:\W \u\$ ' # original Mac OS X PS1

# open last pwd if there is one:
if [ -f /tmp/pwd ] && [ -z $WD ]; then
  echo Navigating to last directory: `cat /tmp/pwd`
  cd `cat /tmp/pwd`
fi
if [ -n "$WD" ]; then
  cd $WD
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
