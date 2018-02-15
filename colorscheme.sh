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

# usage: nullify $LINK_NAME || return 1
nullify() {
	if [ -f "$1" ] && [ ! -L "$1" ]; then
		echo "error: the file '$1' exists but is not a symbolic link" && return 1
	else
		rm -f "$1" && ln -is /dev/null "$1"
	fi
}

mysh() {
	local LINK_NAME="$SELF_DIR/sh/.term.sh"
	nullify "$LINK_NAME" || return 1

	case "$SCHEME" in
		solarized-dark-256 | solarized-light-256)
			ln -vsf "256.sh" "$LINK_NAME"
			;;
		*)
			ln -vsf "16.sh" "$LINK_NAME"
			;;
	esac
	echo "info: type \"source $LINK_NAME\" to apply the color scheme in this terminal."
}

mydircolors() {
	local LINK_NAME="$SELF_DIR/.dircolors"
	nullify $LINK_NAME || return 1

	local SRC=""
	case "$SCHEME" in
		default)
			;;
		solarized-dark-16)
			SRC="dircolors-solarized/dircolors.ansi-dark"
			;;
		solarized-light-16)
			SRC="dircolors-solarized/dircolors.ansi-light"
			;;
		solarized-dark-256)
			SRC="dircolors-solarized/dircolors.256dark"
			;;
		solarized-light-256 | *)
			SRC="dircolors-solarized/dircolors.256dark"
			echo "error: $SCHEME is not supported for dircolors"
			;;
	esac

	if [ -n "$SRC" ]; then
		if [ -f "$SELF_DIR/$SRC" ]; then
			ln -vsf "$SRC" "$LINK_NAME"
			echo "dircolors: $SCHEME"
		else
			echo "error: no such file: $SELF_DIR/$SRC"
		fi
	else
		echo "dircolors: default"
	fi
}

tmux() {
	local LINK_NAME="$SELF_DIR/tmux/.colors.tmux.conf"
	nullify "$LINK_NAME" || return 1

	local LINK_NAME_T="$SELF_DIR/tmux/.terminal.tmux.conf"
	nullify "$LINK_NAME_T" || return 1

	case "$SCHEME" in
		solarized-dark-256)
			ln -vsf "256.tmux.conf" "$LINK_NAME_T"
			;;
		solarized-light-256)
			echo "error: $SCHEME is not supported for tmux"
			ln -vsf "256.tmux.conf" "$LINK_NAME_T"
			;;
		*)
			;;
	esac

	if [ "$SCHEME" != "default" ]; then
		local SRC="colors/${SCHEME}.tmux.conf"
		if [ -f "$SELF_DIR/tmux/$SRC" ]; then
			ln -vsf "$SRC" "$LINK_NAME"
			echo "tmux: $SCHEME"
		else
			echo "error: no such file: $SELF_DIR/tmux/$SRC"
		fi
	else
		echo "tmux: default"
	fi
}

vim() {
	local LINK_NAME="$SELF_DIR/vim/.colors.vim"
	nullify $LINK_NAME || return 1

	if [ "$SCHEME" != "default" ]; then
		local SRC="colors/${SCHEME}.vim"
		if [ -f "$SELF_DIR/vim/$SRC" ]; then
			ln -vsf "$SRC" "$LINK_NAME"
			echo "vim: $SCHEME"
		else
			echo "error: no such file: $SELF_DIR/vim/$SRC"
		fi
	else
		echo "vim: default"
	fi
}

mutt() {
	local LINK_NAME="$SELF_DIR/mutt/.colors.mutt"
	nullify $LINK_NAME || return 1

	if [ "$SCHEME" != "default" ]; then
		local SRC="mutt-colors-solarized/mutt-colors-${SCHEME}.muttrc"
		if [ -f "$SELF_DIR/mutt/$SRC" ]; then
			ln -vsf "$SRC" "$LINK_NAME"
			echo "mutt: $SCHEME"
		else
			echo "error: no such file: $SELF_DIR/mutt/$SRC"
		fi
	else
		echo "mutt: default"
	fi
}

mutt
vim
tmux
mydircolors
mysh
