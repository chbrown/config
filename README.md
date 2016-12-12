# Version controlled configuration files

**Installation:**

    cd ~
    git clone git://github.com/chbrown/dotfiles.git .dotfiles
    cd .dotfiles
    ./INSTALL

You can also run `./INSTALL --help` to see the options.

These files / directories are currently symlinked:

    .bash_logout
    .bash_profile
    .bashrc
    .eslintrc
    .gemrc
    .gitconfig
    .gitignore_global
    .inputrc
    .ipython/profile_default/ipython_config.py
    .jshintrc
    .psqlrc
    .screenrc
    .tmux.conf
    .vim/
    .vimrc

`./INSTALL` will also create a file, `~/.localrc`, which should contain any sensitive credentials or machine-specific settings.

These config settings are intended to be agnostic or adaptive between Mac OS X, Arch Linux, and Ubuntu.


## Mac OS X system settings

`/etc/paths` should look something like this:

    /usr/sbin
    /usr/bin
    /sbin
    /bin

These are loaded into the PATH variable, separated by colons.

`/etc/path.d/*` might also contain some files. These are put after the contents of `/etc/paths`.

This repository also provides a [`new_mac.sh`](new_mac.sh) script that helps configure an OS X install with reasonable defaults.
It does a few things:

* `chown`'s the system Python site-packages to the current user.
* Installs some basic useful packages with [Homebrew](http://brew.sh/).
* Uses `defaults` to remove many animations, disable a few warnings, overall making OS X more expert-friendly.

## TODO

Consider replacing INSTALL script with [GNU stow](https://www.gnu.org/software/stow/), à la [this blog post](https://taihen.org/managing-dotfiles-with-gnu-stow/).

## License

Copyright © 2011-2013 Christopher Brown. [MIT Licensed](http://opensource.org/licenses/MIT).
