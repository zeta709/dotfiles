#!/bin/bash
# vim: set colorcolumn=100: set textwidth=100:

# NOTE
# https://gist.github.com/zeta709/6233038#file-readme-md
# https://gist.github.com/zeta709/6232968#file-readme-md

SELF_DIR="$( unset CDPATH && cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "Choose color scheme:"
SCHEME=""
select ans in "solarized-dark-16" "solarized-light-16" \
	"solarized-dark-256" "solarized-light-256" "default"; do
	if [ -n "$ans" ]; then
		SCHEME="$ans"
		break;
	fi
done

# usage: rmlink_safe $LINK_NAME || return 1
rmlink_safe() {
	if [ -f "$1" ] && [ ! -L "$1" ]; then
		echo "error: the file '$1' exists but is not a symbolic link" && return 1
	else
		rm -f "$1" # && ln -is /dev/null "$1"
	fi
}

# color_scheme
color_scheme() {
	if [ "$#" -ne 5 ]; then
		return 1
	fi
	local MODULE="$1"
	local SCHEME="$2"
	local DIR="$3"
	local SRC="$4"
	local LINK_NAME="$5"

	local SRC_PATH="$DIR/$SRC"
	local LINK_PATH="$DIR/$LINK_NAME"
	rmlink_safe "$LINK_PATH" || return 1
	if [ -n "$SRC" ]; then
		if [ -f "$SRC_PATH" ]; then
			ln -vs "$SRC" "$LINK_PATH"
			echo "$MODULE: $SCHEME"
		else
			ln -vs /dev/null "$LINK_PATH"
			echo "$MODULE: error: no such file: $SRC_PATH"
		fi
	else
		ln -vs /dev/null "$LINK_PATH"
		echo "$MODULE: (default)"
	fi
}

mysh() {
	local LINK_NAME="$SELF_DIR/sh/.term.sh"
	rmlink_safe "$LINK_NAME" || return 1

	case "$SCHEME" in
		solarized-dark-256 | solarized-light-256)
			ln -vs "256.sh" "$LINK_NAME"
			;;
		*)
			ln -vs "16.sh" "$LINK_NAME"
			;;
	esac
	echo "info: type \"source $LINK_NAME\" to apply the color scheme in this terminal."
}

mydircolors() {
	local DIR="$SELF_DIR"
	local SRC=""
	local LINK_NAME=".dircolors"

	if [ "$SCHEME" = "solarized-light-256" ]; then
		echo "error: $SCHEME is not supported for dircolors"
	fi

	if [ "$SCHEME" != "default" ]; then
		local SRC="dircolors/${SCHEME}"
	fi

	color_scheme "dircolors" "$SCHEME" "$DIR" "$SRC" "$LINK_NAME"
}

tmux() {
	local LINK_NAME_T="$SELF_DIR/tmux/.terminal.tmux.conf"
	rmlink_safe "$LINK_NAME_T" || return 1

	case "$SCHEME" in
		solarized-dark-256 | solarized-light-256)
			ln -vs "256.tmux.conf" "$LINK_NAME_T"
			;;
		*)
			ln -vs /dev/null "$LINK_NAME_T"
			;;
	esac

	local DIR="$SELF_DIR/tmux"
	local SRC=""
	local LINK_NAME=".colors.tmux.conf"

	if [ "$SCHEME" = "solarized-light-256" ]; then
		echo "error: $SCHEME is not supported for tmux"
	fi

	if [ "$SCHEME" != "default" ]; then
		local SRC="colors/${SCHEME}.tmux.conf"
	fi

	color_scheme "tmux" "$SCHEME" "$DIR" "$SRC" "$LINK_NAME"
}

vim() {
	local DIR="$SELF_DIR/vim"
	local SRC=""
	local LINK_NAME=".colors.vim"

	if [ "$SCHEME" != "default" ]; then
		local SRC="colors/${SCHEME}.vim"
	fi

	color_scheme "vim" "$SCHEME" "$DIR" "$SRC" "$LINK_NAME"
}

mutt() {
	local DIR="$SELF_DIR/mutt"
	local SRC=""
	local LINK_NAME=".colors.mutt"

	if [ "$SCHEME" != "default" ]; then
		SRC="mutt-colors-solarized/mutt-colors-${SCHEME}.muttrc"
	fi

	color_scheme "mutt" "$SCHEME" "$DIR" "$SRC" "$LINK_NAME"
}

mutt
vim
tmux
mydircolors
mysh
