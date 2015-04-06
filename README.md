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

### Get the latest submodules

```
$ git submodule foreach git pull origin master
```

Applying solarized theme
------------------------

```
$ ./solarized.sh
$ source ~/.bashrc
```

* 256-color에서 16-color로 바꾼 경우 `export TERM=xterm`을 수작업으로 해줘야 한다.
* dark-256의 경우 일부 환경에서 문제가 되는 것 같다.

### Note for terminal users

Read the following document.
[https://github.com/altercation/vim-colors-solarized#important-note-for-terminal-users]
