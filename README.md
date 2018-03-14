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
```

### Get the latest submodules

```
$ git submodule foreach git pull origin master
```

### Install vim plugins

Type `:PlugInstall` in vim.

### Font configuration (Windows SSH client)

Open regedit and go to the key
`HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\FontLink\SystemLink`.
Add or edit the data of multi-string value for your font as follows:

```
SEGUISYM.TTF,Segoe UI Symbol
```

Registry example: <https://gist.github.com/zeta709/e2e10d027415c0c1305ca18ad15f25a6>.

See [1] for more detail about font linking.

### Windows

MinGW 환경에서는 거의 비슷하게 동작하며, 필요에 따라 mintty 설정만 추가하면 된다.

순수 Windows 환경에서는 git, vim 설정만 사용할 수 있다. 윈도우용 batch 파일도
작성했지만 몇가지 문제가 있다.
특히 `intall.bat`은 줄바꿈 문자를 무조건 윈도우 형식으로 넣기 때문에
`_vimrc`의 줄바꿈 문자를 미리 윈도우 형식으로 변경해 두어야 하며,
`_vimrc`의 줄바꿈 문자가 유닉스 형식인 상태에서 `install.bat`을 실행하면
`_vimrc`를 망가뜨리게 된다.
그리고 `install.bat`을 중복으로 실행해도 `_vimrc`를 망가뜨리게 된다.

Apply color schemes
-------------------

Color schemes for shell, vim, and tmux can be changed automatically by
the script `colorscheme.sh`. Note that color schemes including
`solarized-dark-256` may have some problems.

```
$ $HOME/.dotfiles/colorscheme.sh
```

### putty

Registry example: <https://gist.github.com/zeta709/edbbe8cfc50b3b81fb9ab8d64b2620bd>.

See also [2] and [3].

### Note for terminal users

Refer [4].

설정 파일 구조
--------------

Documentation을 참고하라.

References
----------

1. https://docs.microsoft.com/ko-kr/globalization/input/font-technology#font-linking
2. https://github.com/altercation/solarized/tree/master/putty-colors-solarized
3. https://github.com/jblaine/solarized-and-modern-putty
4. https://github.com/altercation/vim-colors-solarized#important-note-for-terminal-users

[1]: https://docs.microsoft.com/ko-kr/globalization/input/font-technology#font-linking
[2]: https://github.com/altercation/solarized/tree/master/putty-colors-solarized
[3]: https://github.com/jblaine/solarized-and-modern-putty
[4]: https://github.com/altercation/vim-colors-solarized#important-note-for-terminal-users
