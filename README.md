Custom local settings that I like
===

To install, run:

    ./INSTALL
    
Then stick whatever custom settings you like in your existing or newly created `~/.bashrc.local` file.

`~/.bashrc.local` is the only copied file. Everything else is merely symlinked.

These settings are intended to be agnostic between Mac OS X and Arch Linux.

At the time of writing, here are the files/directories that are symlinked:
* .ackrc
* .bash_logout
* .bash_profile
* .bashrc
* .gemrc
* .gitconfig
* .gitignore_global
* .hgrc
* .vim/
* .vimrc