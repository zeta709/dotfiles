#!/bin/bash

# usage: source_rc "$BASERC" "$RC"
source_rc() {
	local BASERC="$1"
	local RC="$2"
	[ -f "$RC" ] || touch "$RC"
	if ! grep -q "source $BASERC" "$RC"; then
		echo "source $BASERC" >> "$RC"
		echo >> "$RC"
	fi
}

SELF_DIR="$( unset CDPATH && cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
SELF_DIRQ="$( printf "%q" "$SELF_DIR" )"

# zsh
source_rc "$SELF_DIRQ/zsh/dot.zsh" "$HOME/.zshrc"

# vim
[ -f "$HOME/.vimrc" ] || touch "$HOME/.vimrc"
if [ ! -f "$HOME/.vim/autoload/plug.vim" ]; then
	mkdir -p "$HOME/.vim/autoload"
	ln -vis "$SELF_DIR/vim/vim-plug/plug.vim" "$HOME/.vim/autoload/plug.vim"
fi
if ! grep -q "call plug#begin" "$HOME/.vimrc"; then
	cat <<- EOF >> "$HOME/.vimrc"
		"" vim plugins
		call plug#begin('$HOME/.vim/plugged')
		source $SELF_DIRQ/vim/dot-plugins.vim
		call plug#end()

	EOF
fi
source_rc "$SELF_DIRQ/vim/dot.vim" "$HOME/.vimrc"

# gdb
source_rc "$SELF_DIRQ/gdb/dot.gdb" "$HOME/.gdbinit"

# git
DOTGITCONFIG=`git config --global --get-all include.path "^$SELF_DIR/git/dot.gitconfig$"`
if [ -z "$DOTGITCONFIG" ]; then
	git config --global --add include.path "$SELF_DIR/git/dot.gitconfig"
fi

# tmux
source_rc "$SELF_DIRQ/tmux/dot.tmux.conf" "$HOME/.tmux.conf"

# etc.
#ln -vis "$SELF_DIR/colorgcc/.colorgccrc" "$HOME/.colorgccrc"
#ln -vis "$SELF_DIR/mutt/.muttrc" "$HOME/.muttrc"

