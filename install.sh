#!/bin/bash

# myln() usage
# myln "$TARGET" "$LINKNAME"
# NOTE: use double quotation mark
myln() {
	echo "Info: trying to make link $2 to $1"
	ln -vis "$1" "$2"
	echo
}

# echo "source $BASERC" >> "$RC"
source_rc() {
	BASERC="$1"
	RC="$2"
	touch "$RC"
	if ! grep -Fq "source $BASERC" "$RC"; then
		echo "source $BASERC" >> "$RC"
	fi
	echo >> "$RC"
}

SELF_DIR="$( unset CDPATH && cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# zsh
source_rc "~/.dotfiles/zsh/dot.zsh" "$HOME/.zshrc"

# vim
source_rc "~/.dotfiles/vim/dot.vim" "$HOME/.vimrc"
mkdir -p "$HOME/.vim/autoload"
myln "$SELF_DIR/vim-pathogen/autoload/pathogen.vim" "$HOME/.vim/autoload/pathogen.vim"

# gdb
source_rc "~/.dotfiles/gdb/dot.gdb" "$HOME/.gdbinit"

# git
git config --global --add include.path "~/.dotfiles/git/dot.gitconfig"

# etc.
myln "$SELF_DIR/colorgcc/.colorgccrc" "$HOME/.colorgccrc"
myln "$SELF_DIR/mutt/.muttrc" "$HOME/.muttrc"

# yes/no
#while true; do # yes/no function: http://stackoverflow.com/questions/226703
#        read -rp "yes or no? "
#        case $REPLY in
#                [Yy] | [Yy][Ee][Ss])
#                        break
#                        ;;
#                [Nn] | [Nn][Oo])
#                        break
#                        ;;
#                *)
#			echo "Answer yes or no."
#                        ;;
#        esac
#done
