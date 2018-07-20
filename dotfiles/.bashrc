# If not running interactively, don't do anything
[ -z "$PS1" ] && return

[ -d ~/bin ] && export PATH=~/bin:$PATH

set -o noclobber

## History configuration ##
# HISTFILE: path to the history file (defaults to ~/.bash_history)
# HISTCONTROL: colon-separated list of keywords
# - ignorespace: lines beginning with a space character are not saved
# - ignoredups: lines matching the previous history entry are not saved
# - ignoreboth: shorthand for ignorespace:ignoredups
# - erasedups: erase all previous occurrences matching the current line
export HISTCONTROL=ignorespace:ignoredups
# HISTSIZE: limits how many history items to save to HISTFILE when the shell exits (default is 500)
# When HISTSIZE < 0, there is no limit to the number of commands stored.
export HISTSIZE=-1
# HISTFILESIZE: causes HISTFILE to be truncated to at most HISTFILESIZE lines when the shell starts
export HISTFILESIZE=
# HISTTIMEFORMAT: if set, causes timestamps to be written to the history file
# These timestamps consist of the shell comment character and the time in epoch
# seconds, e.g., `#1521069947`, which applies to the command on the subsequent line.
# The format value is only used except by the `history` command, which calls
# strftime to format the timestamp, inserting it between the history line
# number and the command itself.
# If any timestamps are missing, `history` uses the login time of the current shell session.
export HISTTIMEFORMAT='%Y-%m-%dT%H:%M:%S%z '
# histappend (shell option): causes the shell to append new history items to HISTFILE,
# instead of overwriting it
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

# the pip docs are a lie; to avoid depending on vague defaults:
export PIP_CONFIG_FILE=$HOME/.config/pip/pip.conf

# improve privacy and speed up first-time installs with Homebrew (brew.sh)
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_AUTO_UPDATE=1
# set up alias for regular homebrew (+ cask) maintenance
alias brew-up='brew update && brew upgrade --cleanup --ignore-pinned && brew cask upgrade --greedy && brew cask cleanup'

# disable "Update available x -> y" notifications from npm (npmjs.com)
export NO_UPDATE_NOTIFIER=1

# never tab-complete these suffixes (= extensions)
export FIGNORE=.aux:.bbl:.blg:.fls:.log:.toc:.fdb_latexmk:.egg-info:.retry

# alias awk='awk -F \\t'
# alias count='sort | uniq -c | sort -g'
alias now_d='date +%Y%m%d'
alias now_dt='date +%Y%m%dT%H%M%S'
alias py='python'
alias ipy='ipython -i'

alias lsa='ls -la'
alias perlsed='perl -pe'
alias chown-me='chown -R "$(id -un):$(id -gn)"'

# tr -s indicates that multiple matches of the first string are converted into
# a single instance of the second string
alias flatten="tr -s [:space:] ' '"
# tokenize removes all characters except alphanumerics (A-Za-z0-9) and
# apostrophe (') and splits on whitespace into lines
# the deletion must come first in case there are any tokens that are only punctuation
alias tokenize="tr -C -s \"[:alnum:]'\" [:space:] | tr -s [:space:] '\\n'"
alias lower="tr [:upper:] [:lower:]"
alias upper="tr [:lower:] [:upper:]"

# The following is a useful alias, according to `help fc`;
# `r` (re-)runs the last command
# `r vim` runs the last command that begins with 'vim'
# `r echo=printf` runs the last command,
#    replacing each instance of the substring "echo" with "printf"
# `r .tmp= rm` runs the last command that starts with 'rm', deleting each substring ".tmp"
alias r="fc -s --"

cdp() {
  mkdir -p "$1" && cd "$1"
}
source_if_exists() {
  [[ -e "$1" ]] && source "$1"
}
fullpath() {
  # http://stackoverflow.com/questions/5265702/how-to-get-full-path-of-a-file
  printf '%s\n' "$(cd "$(dirname "$1")" && pwd -P)/$(basename "$1")"
}
sha1() {
  if [ $# -eq 1 ]; then
    printf '%s' "$1" | shasum -a 1 | awk '{print $1}'
  else
    >&2 printf '%s must be called with exactly one argument, not %d.\n' "$FUNCNAME" "$#"
    return 1
  fi
}
iperl() {
  # Based on https://stackoverflow.com/a/22840242
  printf 'Starting Interactive Perl\n'
  # rlwrap options:
  #   -A, --ansi-colour-aware  Support prompts with color
  #   -p, --prompt-colour      Set prompt color
  #   -S, --substitute-prompt  Use this prompt
  # perl options:
  #   -w  Turn on warnings
  #   -n  Wrap whole program in while (<>) { ... } loop
  #   -E  Like -e but with all optional features
  rlwrap -A -pgreen -S"perl> " perl -wnE'say eval()//$@'
}

# only define the function 'o' if the command 'open' exists
if command -v open >/dev/null 2>&1; then
  o() {
    if [ $# -eq 0 ]; then
      # if there were no arguments specified, simply open the current directory
      >&2 printf 'Opening current directory: %s\n' "$(pwd)"
      open .
    else
      open "$@"
    fi
  }
  if [ -e /Applications/Base.app ]; then
    base() {
      open -a Base.app "$@"
    }
  fi
fi

# -e is true for existing files
if [ -e ~/.env ]; then
  # 'set -a' directs the shell to promote all variable assignments to environment variables
  set -a
  source ~/.env
  # 'set +a' turns off the auto-environment setting
  set +a
fi

# If Sublime Text is installed (the `subl` command exists), set up `a` and `e` functions.
# We can't use aliases since we default to current directory when no arguments are supplied.
if command -v subl >/dev/null 2>&1; then
  e() {
    subl --new-window "${@-.}"
  }
  a() {
    subl --add "${@-.}"
  }
fi

source_if_exists "$HOME/.localrc"
source_if_exists "$HOME/.iterm2_shell_integration.bash"

#bind 'set page-completions off'
#bind 'set completion-query-items 500'

COLOR_GREEN=$(tput setaf 2)
COLOR_MAGENTA=$(tput setaf 5)
COLOR_RESET=$(tput sgr0)

export PS1="\\[$COLOR_GREEN\\][\\u@$MACHINE \\w]\$\\[$COLOR_RESET\\] "
shortPS() {
  # only show basename of working directory, and show it in magenta, instead of green
  export PS1="\\[$COLOR_GREEN\\][\\u@$MACHINE \\[$COLOR_MAGENTA\\]\\W\\[$COLOR_GREEN\\]]\$\\[$COLOR_RESET\\] "
}

BASHRC_D=$(dirname "$(readlink "$BASH_SOURCE")")/bashrc.d
#source $BASHRC_D/timer
#source $BASHRC_D/lastwd
