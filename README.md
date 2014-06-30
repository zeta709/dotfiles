dotfiles
========

Personal dotfiles.

Installation
------------

```
$ cd $HOME
$ git clone https://github.com/zeta709/dotfiles.git .dotfiles
$ cd .dotfiles/
$ git submodule update --init --recursive
$ ./install.sh
$ echo 'eval `dircolors ~/.dir_colors`' >> ~/.bashrc
```

Applying solarized theme
------------------------

```
$ ./solarized.sh
$ source ~/.bashrc
```

Note for terminal users
-----------------------

Read the following document.
[https://github.com/altercation/vim-colors-solarized#important-note-for-terminal-users]
