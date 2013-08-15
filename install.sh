#!/bin/bash

# myln() usage
# myln "$SRC" "$DEST"
# NOTE: use double quotation mark
myln() {
	echo "Info: trying to make link $1 to $2"
	ln -vis $1 $2
}

SELF_DIR="$( unset CDPATH && cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

myln "$SELF_DIR/vim/.vimrc" "$HOME/.vimrc"
myln "$SELF_DIR/colorgcc/.colorgccrc" "$HOME/.colorgccrc"
myln "$SELF_DIR/mutt/.muttrc" "$HOME/.muttrc"


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
