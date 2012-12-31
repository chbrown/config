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
alias py='python'
alias hdfs='hadoop fs'
alias iso='date +%Y%m%d'

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

function wgetar {
    EXT='gz'
    TAR_TYPE='z'
    if [[ $1 == *bz2 ]]
    then
        EXT='bz2';
        TAR_TYPE='j';
    fi
    wget $1 -O $2.tar.$EXT
    mkdir tmp
    tar -C tmp -x -$TAR_TYPE -f $2.tar.$EXT
    rm $2.tar.$EXT
    mv tmp/* ./$2
    rmdir tmp
}
function tx {
  if [ $# -lt 1 ]
  then
    # no file specified
    TEXFILES=$(ls *.tex)
  else
    TEXFILES=($1)
  fi
  TEXFILE=${TEXFILES[0]/\.tex/}
  echo "Rendering $TEXFILE"
  latex -interaction=scrollmode $TEXFILE && dvipdf $TEXFILE && open -a TeXShop.app $TEXFILE.pdf
}
function ptx {
  if [ $# -lt 1 ]
  then
    # no file specified
    TEXFILES=$(ls *.tex)
  else
    TEXFILES=($1)
  fi
  echo "Rendering ${TEXFILES[0]}"
  pdflatex -interaction=scrollmode ${TEXFILES[0]} && open -a TeXShop.app ${TEXFILES[0]/\.tex/}.pdf
}
function copy_id_rsa {
  # like ssh-copy-id
  # eg. `copy_id_rsa chbrown@linode` or `copy_id_rsa root@66.228.38.64`
  cat ~/.ssh/id_rsa.pub | ssh $1 "mkdir -p ~/.ssh; cat - >> ~/.ssh/authorized_keys2"
}
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
#function redis-del {
#  redis-cli --raw keys $1 | xargs redis-cli del
#}
function tnls {
  ps aux | grep ssh | grep -e -L | grep : | grep -v grep
}
function gsclean {
  gs -q -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -sOutputFile=${1/.pdf/-gs.pdf} -f $1
}

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

