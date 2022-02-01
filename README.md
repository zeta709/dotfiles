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
```

Update the repository including submodules:
``` sh
git fetch --recurse-submodules
```

Install Vim plugins after modifying the settings:
type `:PlugInstall` in vim.

Installation on Windows
-----------------------

### Font configuration (optional)

Open regedit and go to the key
`HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\FontLink\SystemLink`.
Add or edit the data of multi-string value for your font as follows:

```
SEGUISYM.TTF,Segoe UI Symbol
```

Refer the example registy: [font.reg](https://gist.github.com/zeta709/e2e10d027415c0c1305ca18ad15f25a6).
Also refer [font technology](https://docs.microsoft.com/ko-kr/globalization/input/font-technology#font-linking)
from Microsoft for more details.

Applying color schemes
----------------------

It has been moved to another repository.
See [color-schemes.md](Documentation/old/color-schemes.md) for the old document.


SSH configuration
-----------------

Generating a new SSH key:
``` sh
ssh-keygen -t ed25519 -C "your_email@example.com"
```

See also [how to configure ssh-agent](Documentation/how-to-configure-ssh-agent.md).

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
