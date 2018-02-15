#!/bin/bash
# vim: set colorcolumn=100: set textwidth=100:

# NOTE
# https://gist.github.com/zeta709/6233038#file-readme-md
# https://gist.github.com/zeta709/6232968#file-readme-md

SELF_DIR="$( unset CDPATH && cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "Choose solarized color scheme:"
select ans in "dark-16" "light-16" "dark-256" "light-256" "unsolarized"; do
	if [ -n "$ans" ]; then
		SCHEME="$ans"
		break;
	fi
done

mysh() {
	local SHRCBASE=".zshrc"
	local SHRC="$HOME/$SHRCBASE"
	case "$SCHEME" in
		unsolarized | dark-16 | light-16)
			if ! grep -Eq "source\\s+~/.bash-256.sh(\\s*#.*|\\s*)$" "$SHRC"; then
				sed -ri '/source\s+~\/\.bash-256\.sh(\s*#.*|\s*)$/d' "$SHRC"
				echo "info: run \"export TERM=xterm\""
			fi
			echo "info: change your terminal palette"
			;;
		dark-256 | light-256)
			SRC="$SELF_DIR/bash/256.sh"
			LINK_NAME="$HOME/.bash-256.sh"
			ln -vis "$SRC" "$LINK_NAME"
			if ! grep -Eq "source\\s+~/\\.bash-256\\.sh(\\s*#.*|\\s*)$" "$SHRC"; then
				echo "source ~/.bash-256.sh" >> "$SHRC"
			fi
			;;
		*)
			echo "Error"
			;;
	esac
	echo "info: run \"source ~/$SHRCBASE\""
	echo
}

mydircolors() {
	local DIRCOLORS_SOLARIZED_DIR="$SELF_DIR/dircolors-solarized"
	local SRC=""
	local LINK_NAME="$SELF_DIR/.dircolors"

	if [ -L $LINK_NAME ]; then
		rm -f $LINK_NAME
	fi

	case "$SCHEME" in
		unsolarized)
			;;
		dark-16)
			SRC="dircolors.ansi-dark"
			;;
		light-16)
			SRC="dircolors.ansi-light"
			;;
		dark-256)
			SRC="dircolors.256dark"
			;;
		light-256 | *)
			echo "error: $SCHEME is not supported for dircolors"
			;;
	esac

	if [ -z "$SRC" ]; then
		echo "dircolors: not solarized"
		return
	fi

	if [ ! -d "$DIRCOLORS_SOLARIZED_DIR" ]; then
		echo "error: $DIRCOLORS_SOLARIZED_DIR not found"
		echo "dircolors: not solarized"
		return
	fi

	SRC="$DIRCOLORS_SOLARIZED_DIR/$SRC"
	if [ ! -f "$SRC" ]; then
		echo "error: $SRC not found"
		echo "dircolors: not solarized"
		return
	fi

	ln -vis "$SRC" "$LINK_NAME"
	echo "dircolors: solarized"
	echo
}

tmux() {
	local TMUXCONF="$HOME/.tmux.conf"
	local TMUX_SOLARIZED_DIR="$SELF_DIR/tmux/tmux-colors-solarized"
	local SRC=""
	touch "$TMUXCONF"
	if [ -d "$TMUX_SOLARIZED_DIR" ] && [ -f "$TMUXCONF" ]; then
		case "$SCHEME" in
			dark-16 | light-16 | unsolarized)
				if ! grep -Eq "source\\s+~/\\.tmux-256\\.conf(\\s*#.*|\\s*)$" "$TMUXCONF"; then
					sed -ri '/source\s+~\/\.tmux-256\.conf(\s*#.*|\s*)$/d' "$TMUXCONF"
				fi
				;;
			dark-256 | light-256)
				if ! grep -Eq "source\\s+~/\\.dotfiles/tmux/tmux-256\\.conf(\\s*#.*|\\s*)$" "$TMUXCONF"; then
					echo "source ~/.dotfiles/tmux/tmux-256.conf" >> "$TMUXCONF"
				fi
				;;
			*)
				echo "error: $SCHEME is not supported for tmux"
				;;
		esac
		case "$SCHEME" in
			dark-16)
				SRC="$TMUX_SOLARIZED_DIR/tmuxcolors-dark.conf"
				;;
			light-16)
				SRC="$TMUX_SOLARIZED_DIR/tmuxcolors-light.conf"
				;;
			dark-256 | light-256)
				SRC="$TMUX_SOLARIZED_DIR/tmuxcolors-256.conf"
				;;
			unsolarized)
				;;
			*)
				echo "error: $SCHEME is not supported for tmux"
				;;
		esac
		LINK_NAME="$SELF_DIR/tmux/.colors.tmux.conf"
		if [ -f "$SRC" ]; then
			ln -vis "$SRC" "$LINK_NAME"
			if ! grep -Eq "source\\s+~/\\.dotfiles/tmux/\\.colors\\.tmux\\.conf(\\s*#.*|\\s*)$" "$TMUXCONF"; then
				echo "source ~/.dotfiles/tmux/.colors.tmux.conf" >> "$TMUXCONF"
			fi
			echo "tmux: solarized"
		else
			if [ -L $LINK_NAME ]; then
				rm -f $LINK_NAME
			fi
			echo "tmux: not solarized"
		fi

	else
		echo "error: tmux-colors-solarized not found"
		echo "tmux: not solarized"
	fi
	echo
}

vim() {
	local VIM_SOLARIZED_DIR="$HOME/.vim/plugged/vim-colors-solarized"
	local SRC=""
	local LINK_NAME="$SELF_DIR/vim/.colors.vim"

	if [ -L $LINK_NAME ]; then
		rm -f $LINK_NAME
	fi

	case "$SCHEME" in
		unsolarized)
			;;
		*)
			SRC="colors/solarized-${SCHEME}.vim"
			;;
	esac

	if [ -z "$SRC" ]; then
		echo "vim: not solarized"
		return
	fi

	if [ ! -d "$VIM_SOLARIZED_DIR" ]; then
		echo "error: vim-colors-solarized not found"
		echo "vim: not solarized"
		return
	fi

	if [ ! -f "$SELF_DIR/vim/$SRC" ]; then
		echo "error: $SRC not found"
		echo "vim: not solarized"
		return
	fi

	ln -vis "$SRC" "$LINK_NAME"
	echo "vim: solarized"
	echo
}

mutt() {
	local MUTTRC="$HOME/dot.mutt"
	local MUTT_SOLARIZED_DIR="$SELF_DIR/mutt/mutt-colors-solarized"
	touch "$MUTTRC"
	if [ -d "$MUTT_SOLARIZED_DIR" ] && [ -f "$MUTTRC" ]; then
		SRC="$MUTT_SOLARIZED_DIR/mutt-colors-solarized-${SCHEME}.muttrc"
		LINK_NAME="$SELF_DIR/mutt/.colors.mutt"
		if [ -f "$SRC" ]; then
			ln -vis "$SRC" "$LINK_NAME"
			echo "Info: done for mutt."
		fi
	else
		echo "Warn: mutt-colors-solarized or ~/.muttrc not exists."
	fi
	echo
}

mutt
vim
tmux
mydircolors
#mysh
