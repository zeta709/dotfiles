#!/bin/bash

# THIS SCRIPT WILL BE NO MORE MAINTAINED
echo "THIS SCRIPT WILL BE NO MORE MAINTAINED"

# usage: rmlink_safe $LINK_NAME || return 1
rmlink_safe() {
	if [[ -f "$1" ]] && [[ ! -L "$1" ]]; then
		echo "error: the file '$1' exists but is not a symbolic link"
		return 1
	else
		rm -f "$1" # && ln -is /dev/null "$1"
	fi
}

# color_scheme: helper function
color_scheme() {
	if [[ "$#" -ne 5 ]]; then
		return 1
	fi
	local MODULE="$1"
	local SCHEME="$2"
	local DIR="$3"
	local SRC="$4"
	local LINK_NAME="$5"

	local SRC_PATH="$DIR/$SRC"
	local LINK_PATH="$DIR/$LINK_NAME"
	if [[ -n "$SRC" ]] && [[ -f "$SRC_PATH" ]]; then
		rmlink_safe "$LINK_PATH" || return 1
		ln -vs "$SRC" "$LINK_PATH"
		echo "$MODULE: $SCHEME"
	else
		if [[ "$SCHEME" != "default" ]]; then
			echo "$MODULE: error: no such color scheme: $SCHEME"
			echo "$MODULE: do you want to keep the current color scheme?"
			local ANS
			select ANS in "keep" "remove"; do
				case "$ANS" in
					"keep")
						return
						;;
					"remove")
						break
						;;
				esac
			done
		fi
		rmlink_safe "$LINK_PATH" || return 1
		ln -vs /dev/null "$LINK_PATH"
		echo "$MODULE: (null)"
	fi
}

mutt() {
	local DIR="$SELF_DIR/mutt"
	local SRC="colors/${SCHEME}.muttrc"
	local LINK_NAME=".colors.mutt"
	color_scheme "mutt" "$SCHEME" "$DIR" "$SRC" "$LINK_NAME"
}

main() {
	local SELF_DIR
	SELF_DIR="$(unset CDPATH && cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
	local SCHEME
	local COLORSDIR="colors"
	local SOLARIZED8

	echo "Choose color scheme:"
	local SCHEMESET=(
		"solarized-dark-16" "solarized-light-16"
		"solarized-dark-256" "solarized-light-256"
		"solarized8-dark (truecolor)"
		"default")
	select SCHEME in "${SCHEMESET[@]}"; do
		[[ -n "$SCHEME" ]] && break
	done

	case "$SCHEME" in
		solarized-light-256)
			;& # fall-through
		solarized-dark-256)
			;;
		solarized8-*)
			SOLARIZED8=1
			SCHEME="solarized-dark-256"
			;;
	esac

	readonly SELF_DIR
	mutt
	if [[ -n "$SOLARIZED8" ]]; then
		SCHEME="solarized8-dark"
	fi

	echo "Info: source shell rc to apply the color scheme in this terminal"
	echo "Info: you may change the color pallete of your terminal"
}

main
