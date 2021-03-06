# Version controlled configuration files

First, prepare the home directory structure, so that non-config files don't creep in:

    mkdir -p ~/.{ansible,clojure,config,cpan,lein} \
             ~/.sbt/{0.13,1.0}/plugins \
             ~/.ipython/profile_default/startup \
             ~/.jupyter/lab/user-settings/@jupyterlab/{apputils,codemirror,docmanager,fileeditor,notebook,shortcuts,statusbar}-extension

Install [`dotfiles/`](dotfiles/) with [GNU Stow](https://www.gnu.org/software/stow/):

    git clone https://github.com/chbrown/config
    cd config
    stow --ignore=DS_Store -t $HOME -S dotfiles

N.b.: `stow`'s `--ignore=REGEX` option implicitly adds an `$` to the end.

`.bashrc` sources `~/.localrc` if it exists.

    echo 'export MACHINE=local' > ~/.localrc

Install the other macOS-only configuration files:

    stow -t $HOME -S macOS


## Uninstall

Unstow:

    stow -t $HOME -D dotfiles
    stow -t $HOME -D macOS


## Install Alfred Preferences

Create directories so that only files are linked:

    ALFRED=~/Dropbox/Alfredv2/Alfred.alfredpreferences
    (cd alfred && find . -type d) | (cd $ALFRED && xargs mkdir -p)

Link all files:

    stow -t $ALFRED -S alfred


## macOS system settings

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


## License

Copyright © 2011-2017 Christopher Brown. [MIT Licensed](https://chbrown.github.io/licenses/MIT/#2011-2017).
