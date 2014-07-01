#!/bin/bash

# myln() usage
# myln "$TARGET" "$LINKNAME"
# NOTE: use double quotation mark
myln() {
	echo "Info: trying to make link $2 to $1"
	ln -vis $1 $2
	echo
}

SELF_DIR="$( unset CDPATH && cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

myln "$SELF_DIR/vim/.vimrc" "$HOME/.vimrc"
myln "$SELF_DIR/vim-pathogen/autoload/pathogen.vim" "$HOME/.vim/autoload/pathogen.vim"
myln "$SELF_DIR/colorgcc/.colorgccrc" "$HOME/.colorgccrc"
myln "$SELF_DIR/mutt/.muttrc" "$HOME/.muttrc"

# .gitconfig
while true; do # yes/no function: http://stackoverflow.com/questions/226703
        read -p "Overwrite '$HOME/.gitconfig'? "
        case $REPLY in
                [Yy] | [Yy][Ee][Ss])
                        cp -i "$SELF_DIR/git/.gitconfig" "$HOME/.gitconfig"
                        read -p "Enter name for $HOME/.gitconfig: " git_user_name
                        git config --global user.name $git_user_name
                        read -p "Enter email for $HOME/.gitconfig: " git_user_email
                        git config --global user.email $git_user_email
                        echo
                        break
                        ;;
                [Nn] | [Nn][Oo])
                        break
                        ;;
                *)
			echo "Answer yes or no."
                        ;;
        esac
done


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
