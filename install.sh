#!/bin/bash

# myln() usage
# myln "$TARGET" "$LINKNAME"
# NOTE: use double quotation mark
myln() {
	echo "Info: trying to make link $2 to $1"
	ln -vis $1 $2
	echo
}

# echo "source $BASERC" >> "$RC"
source_baserc() {
	BASERC="$1"
	RC="$2"
	touch $RC
	grep -Fq "source $BASERC" "$RC"
	if [ "$?" -ne "0" ]; then
		echo "source $BASERC" >> "$RC"
	fi
}

SELF_DIR="$( unset CDPATH && cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# zsh
source_baserc "~/.dotfiles/zsh/dot.zsh" "$HOME/.zshrc"

# vim
source_baserc "~/.dotfiles/vim/dot.vim" "$HOME/.vimrc"
mkdir -p "$HOME/.vim/autoload"
myln "$SELF_DIR/vim-pathogen/autoload/pathogen.vim" "$HOME/.vim/autoload/pathogen.vim"

# git
git config --global --add include.path "~/.dotfiles/git/dot.gitconfig"

# etc.
myln "$SELF_DIR/colorgcc/.colorgccrc" "$HOME/.colorgccrc"
myln "$SELF_DIR/mutt/.muttrc" "$HOME/.muttrc"

# yes/no
#while true; do # yes/no function: http://stackoverflow.com/questions/226703
#        read -p "yes or no? "
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

#for src in `find $SELF_DIR -name \*.symlink`; do
#	src_dir=`dirname ${src#$SELF_DIR/}`
#	dest_dir=`dirname $HOME/$src_dir`
#	dest="$dest_dir/`basename ${src%.*}`"
#	if [ -e $dest ]; then
#		echo "$dest aleady exists."
#	else
#		echo "ln -s $src $dest"
#	fi
#done
