# If not running interactively, don't do anything
[ -z "$PS1" ] && return

source ~/.bashrc.local

# history control
export HISTCONTROL=ignoredups:ignorespace
export HISTSIZE=1000000
export HISTFILESIZE=1000000000
shopt -s histappend
shopt -s autocd
shopt -s checkwinsize

export PS1="[\u@$MACHINE \w]\$ "
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad
export LD_LIBRARY_PATH=/usr/local/lib:/usr/lib/
export EDITOR=vim
[ -f ~/bin ] && export PATH=~/bin:$PATH

alias sl='ls'
alias lsa='ls -la'
alias m='mate'
alias st='open -a "Sublime Text 2.app"'
alias o='open'
alias py='python'
alias ipy='ipython -i'
alias psgrep='ps aux | grep $(echo $1 | sed "s/^\(.\)/[\1]/g")'

if [ -f ~/.local/bin/bashmarks.sh ]; then
  source ~/.local/bin/bashmarks.sh
fi

# open last pwd if there is one:
if [ -f /tmp/pwd ] && [ -z $WD ]; then
  echo Navigating to last directory: `cat /tmp/pwd`
  cd `cat /tmp/pwd`
fi
if [ -n "$WD" ]; then
  cd $WD
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
    latex -interaction=scrollmode $1 && dvipdf $1 && open -a TeXShop.app $1.pdf;
}
function ptx {
    pdflatex -interaction=scrollmode $1 && open -a TeXShop.app $1.pdf;
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
