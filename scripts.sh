#!/usr/bin/env sh

cd ~
git clone git://github.com/chbrown/scripts.git
echo 'export PATH=$HOME/scripts:$PATH' >> .bashrc.local
