# Custom local settings that I like

## Installation

    cd ~
    git clone git://github.com/chbrown/dotfiles.git .dotfiles
    cd .dotfiles
    ./INSTALL

Then stick whatever custom settings you like in your existing or newly created `~/.bashrc.local` file.

`~/.bashrc.local` is the only copied file. Everything else is merely symlinked.

These settings are intended to be agnostic (or adaptive) between Mac OS X, Arch Linux, and Ubuntu.

# Affected Files

At the time of writing, here are the files/directories that are symlinked:

* `.ackrc`
* `.bash_logout`
* `.bash_profile`
* `.bashrc`
* `.gemrc`
* `.gitconfig`
* `.gitignore_global`
* `.hgrc`
* `.vim/`
* `.vimrc`

## Mac OS X system settings

`/etc/paths` should look something like this:

    /usr/sbin
    /usr/bin
    /sbin
    /bin

`/etc/path.d/*` might also have some things. These are put after the contents of `/etc/paths`.

