#!/usr/bin/env bash

# If not running interactively, don't do anything
[[ -z "$PS1" ]] && return

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
shopt -s autocd
shopt -s globstar
shopt -s no_empty_cmd_completion
stty -ixon

export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad
export EDITOR=vim

# TIME_STYLE is only read by `gls` (GNU ls), not the default POSIX/BSD `ls`
export TIME_STYLE='+%Y-%m-%d %H:%M:%S'

# the pip docs are a lie; to avoid depending on vague defaults:
export PIP_CONFIG_FILE=$HOME/.config/pip/pip.conf

# improve privacy and speed up first-time installs with Homebrew (brew.sh)
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_AUTO_UPDATE=1
# set up function for regular homebrew (+ cask) maintenance
function brew-up() {
  # Usage: brew-up [--greedy]
  brew update
  brew upgrade --ignore-pinned "$@"
  brew cleanup
}

# disable "Update available x -> y" notifications from npm (npmjs.com)
export NO_UPDATE_NOTIFIER=1

# never tab-complete these suffixes (= extensions)
export FIGNORE=.aux:.bbl:.blg:.fls:.toc:.lot:.lof:.fdb_latexmk:.egg-info:.retry:__pycache__

[[ -e ~/.bash_aliases ]] && source ~/.bash_aliases

cdp() {
  mkdir -p "$1" && cd "$1"
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

#bind 'set page-completions off'
#bind 'set completion-query-items 500'

# n.b. the \[...\] escapes are important for proper handling of history search (Ctrl R), etc.
export PS1='\[\e[32m\][\u@\h \w]$\[\e[0m\] '
#             ↑       ↑↑ ↑↑  ↑ ↑↑  ↑      ↑
#             |       || ||  | ||  |      10 literal space
#             |       || ||  | ||  9 ansi reset
#             |       || ||  | |8 literal dollar sign
#             |       || ||  | 7 literal close bracket
#             |       || ||  6 working directory
#             |       || |5 hostname up to the first "."
#             |       || 4 literal at-sign
#             |       |3 username
#             |       2 literal open bracket
#             1 ansi foreground green
shortPS() {
  # only show basename of working directory, and show it in magenta, instead of green
  export PS1='\[\e[32m\][\u@\h \[\e[35m\]\W\[\e[32m\]]$\[\e[0m\] '
}

BASHRC_D=$(dirname "$(readlink "$BASH_SOURCE")")/bashrc.d
#source $BASHRC_D/timer
#source $BASHRC_D/lastwd

[[ -e ~/.localrc ]] && source ~/.localrc
[[ -e ~/.iterm2_shell_integration.bash ]] && source ~/.iterm2_shell_integration.bash
[[ -d ~/.iterm2 ]] && export PATH=~/.iterm2:$PATH

# Initialize fasd (https://github.com/clvv/fasd) if available
if command -v fasd >/dev/null 2>&1; then
  # The fasd README says to install into the shell with `eval $(fasd --init auto)`
  # For bash, that evaluates to: `eval "$(fasd --init posix-alias bash-hook bash-ccomp bash-ccomp-install)"`
  # posix-alias = define aliases for: a, s, sd, sf, d, f, z, zz
  #               also defines fasd_cd, a function called by z and zz
  # bash-hook = define function _fasd_prompt_func and add it to PROMPT_COMMAND
  #             (if it is not already there)
  # bash-ccomp = define functions _fasd_bash_cmd_complete and _fasd_bash_hook_cmd_complete
  # bash-ccomp-install = call _fasd_bash_hook_cmd_complete with args: fasd a s d f sd sf z zz
  # Use the definition of fasd_cd() from `fasd --init posix-alias`, but not the aliases
  eval "$(fasd --init posix-alias | grep -v alias)"
  alias j='fasd_cd -d' # same as default 'z' alias expansion
  # Use default implementations for command completions and hook
  eval "$(fasd --init bash-ccomp bash-hook)"
  # This is the same as `fasd --init bash-ccomp-install` but only for "j"
  _fasd_bash_hook_cmd_complete fasd j
  # Integrate with bash-preexec.sh from ~/.iterm2_shell_integration.bash
  preexec_functions+=(_fasd_prompt_func)
fi
