#!/bin/sh

# sh -c "$(curl -fsSL https://raw.githubusercontent.com/zeta709/dotfiles/master/install.sh)"

cd "$HOME" || exit 1
git clone https://github.com/zeta709/dotfiles.git .dotfiles || exit 1
cd .dotfiles || exit 1
git submodule update --init --recursive || exit 1

./install.sh || exit 1
vim +PlugInstall +qall
