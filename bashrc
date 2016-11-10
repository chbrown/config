# If not running interactively, don't do anything
[ -z "$PS1" ] && return

[ -d ~/bin ] && export PATH=~/bin:$PATH

# history control
export HISTCONTROL=ignoredups:ignorespace
export HISTSIZE=10000000000
export HISTFILESIZE=10000000000000
shopt -s histappend
shopt -s checkwinsize
if [[ $($SHELL --version) =~ 'version 4' ]]; then
  shopt -s autocd
  shopt -s globstar
fi
stty -ixon

export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad
export EDITOR=vim

# alias awk='awk -F \\t'
# alias count='sort | uniq -c | sort -g'
alias total="awk '{sum += \$1} END {print sum}'"
alias now_d='date +%Y%m%d'
alias now_dt='date +%Y%m%dT%H%M%S'
alias py='python'
alias ipy='ipython -i'

alias lsa='ls -la'
alias perlsed='perl -pe'
alias harmony='node --harmony'
alias psqlt="psql -P footer=off -A -F $'\t'"

# tr -s indicates that multiple matches of the first string are converted into
# a single instance of the second string
alias flatten="tr -s [:space:] ' '"
# tokenize removes all characters except alphanumerics (A-Za-z0-9) and
# apostrophe (') and splits on whitespace into lines
# the deletion must come first in case there are any tokens that are only punctuation
alias tokenize="tr -C -s \"[:alnum:]'\" [:space:] | tr -s [:space:] '\n'"
alias lower="tr [:upper:] [:lower:]"
alias upper="tr [:lower:] [:upper:]"

cdp() {
  mkdir -p $1
  cd $1
}
cdr() {
  cd **/*$1*
}
lsd() {
  ls -la $@ | grep ^d
}
fullpath() {
  # http://stackoverflow.com/questions/5265702/how-to-get-full-path-of-a-file
  echo $(cd $(dirname "$1") && pwd -P)/$(basename "$1")
}
sha1() {
  printf "%s" $1 | shasum -a 1 | awk '{print $1}'
}

# Mac OS X -only functions
if [ $(uname) = Darwin ]; then
  o() {
    # $* is the list of arguments.
    # $@ is just like $*, but quoted.
    # $# is the number of args in $*, which is the same as in $@
    # in both cases of using $@ (an array) and $OPENFLAGS (also an array),
    # by using the @ indexer, we get the elements back individually quoted
    # if we wrap the whole ARR[@] in quotes
    if [ $# -eq 0 ]; then
      # if there were no arguments specified, simply start editing in the current directory
      echo Opening current directory: $(pwd)
      open "${OPENFLAGS[@]}" .
    else
      open "${OPENFLAGS[@]}" "$@"
    fi
  }
  e() {
    # the parentheses trigger a subshell, so that OPENFLAGS is not persisted globally
    (OPENFLAGS=(-a 'Sublime Text.app'); o "$@")
  }
  mou() {
    (OPENFLAGS=(-a Mou.app); o "$@")
  }
fi

# -e is true for existing files
if [ -e ~/.env ]; then
  # 'set -a' directs the shell to promote all variable assignments to environment variables
  set -a
  source ~/.env
  # 'set +a' turns off the auto-environment setting
  set +a
fi

[ -e ~/.localrc ] && source ~/.localrc

#bind 'set page-completions off'
#bind 'set completion-query-items 500'

export PS1="\[$(tput setaf 2)\][\u@$MACHINE \w]\$\[$(tput sgr0)\] "
shortPS() {
  # only show basename of working directory, and show it in magenta, instead of blue
  export PS1="\[$(tput setaf 2)\][\u@$MACHINE \[$(tput setaf 5)\]\W\[$(tput setaf 2)\]]\$\[\$(tput sgr0)\] "
}

BASHRC_D=$(dirname $(readlink $BASH_SOURCE))/bashrc.d
#source $BASHRC_D/timer
#source $BASHRC_D/lastwd
