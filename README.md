dotfiles
========

Personal dotfiles.

Installation
------------

Basic install:
``` sh
cd "$HOME"
git clone https://github.com/zeta709/dotfiles.git .dotfiles
cd .dotfiles
git submodule update --init --recursive

./install.sh
vim +PlugInstall +qall
echo 1 | ./colorscheme.sh # optional
```

Update the repository including submodules:
``` sh
git fetch --recurse-submodules
```

Install Vim plugins after modifying the settings:
type `:PlugInstall` in vim.

Installation on Windows
-----------------------

### Font configuration

Open regedit and go to the key
`HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\FontLink\SystemLink`.
Add or edit the data of multi-string value for your font as follows:

```
SEGUISYM.TTF,Segoe UI Symbol
```

See [registry example for font configuration](https://gist.github.com/zeta709/e2e10d027415c0c1305ca18ad15f25a6).

Refer the document for [font technology](https://docs.microsoft.com/ko-kr/globalization/input/font-technology#font-linking) from Microsoft for more details.

### Windows subsystem for Linux

It works!

### MinGW

> **Note**
>
> This section is outdated.

MinGW 환경에서는 거의 비슷하게 동작하며, 필요에 따라 mintty 설정만 추가하면 된다.

### Native Windows

> **Note**
>
> This section is outdated.

순수 Windows 환경에서는 git, vim 설정만 사용할 수 있다. 윈도우용 batch 파일도
작성했지만 몇가지 문제가 있다.
특히 `intall.bat`은 줄바꿈 문자를 무조건 윈도우 형식으로 넣기 때문에
`_vimrc`의 줄바꿈 문자를 미리 윈도우 형식으로 변경해 두어야 하며,
`_vimrc`의 줄바꿈 문자가 유닉스 형식인 상태에서 `install.bat`을 실행하면
`_vimrc`를 망가뜨리게 된다.
그리고 `install.bat`을 중복으로 실행해도 `_vimrc`를 망가뜨리게 된다.

Applying Solarized color scheme
-------------------------------

Solarized color schemes can be applied easily by `colorscheme.sh`.

``` sh
$HOME/.dotfiles/colorscheme.sh
```

> **Note**
>
> 256-color settings are not fully tested yet.

### Windows Terminal

See [fixing Windows terminal Solarized dark](https://gist.github.com/zeta709/823deda7e0685739f5642c3bfe100919).

### PuTTY

See [registry example](https://gist.github.com/zeta709/edbbe8cfc50b3b81fb9ab8d64b2620bd).

See also [putty-colors-solarized](https://github.com/altercation/solarized/tree/master/putty-colors-solarized)
and [solarized-and-modern-putty](https://github.com/jblaine/solarized-and-modern-putty).

### Note for terminal users

See [important-note-for-terminal-users](https://github.com/altercation/vim-colors-solarized#important-note-for-terminal-users).

SSH configuration
-----------------

Generating a new SSH key:
``` sh
ssh-keygen -t ed25519 -C "your_email@example.com"
```

See also [how to configure ssh-agent](Documentation/how-to-configure-ssh-agent.md).

Dotfiles sturucture
-------------------

See [dotfiles-structure.md](Documentation/dotfiles-structure.md) (written in Korean).

Miscellaneous
-------------

Install fzf again:
``` sh
cd "$HOME/.dotfiles" && ./fzf/install
```

Quick install using curl (the script is out of maintenance):
``` sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/zeta709/dotfiles/master/install_quick.sh)"
```

For older git users (if `git fetch --recurse-submodules` doesn't work):
``` sh
git fetch
git submodule update --recursive --remote # for >=git-1.8.2, or
git submodule foreach git pull origin master
```
I'd rather update git to the latest version though.
