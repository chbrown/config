#!/usr/bin/env bash

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
# trim deletes leading/trailing whitespace from each line
alias trim="sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//'"

# The following is a useful alias, according to `help fc`;
# `r` (re-)runs the last command
# `r vim` runs the last command that begins with 'vim'
# `r echo=printf` runs the last command,
#    replacing each instance of the substring "echo" with "printf"
# `r .tmp= rm` runs the last command that starts with 'rm', deleting each substring ".tmp"
alias r="fc -s --"

alias ffmpeg="ffmpeg -hide_banner"
alias ffprobe="ffprobe -hide_banner"
alias ffplay="ffplay -hide_banner"
