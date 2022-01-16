#!/bin/sh

# sh -c "$(curl -fsSL https://raw.githubusercontent.com/zeta709/dotfiles/master/install.sh)"

set -e

cd $HOME
git clone https://github.com/zeta709/dotfiles.git .dotfiles
cd .dotfiles
git submodule update --init --recursive
./install.sh
./fzf/install
vim +PlugInstall +qall
echo 1 | ./colorscheme.sh
