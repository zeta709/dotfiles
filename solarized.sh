#!/bin/bash
# vim: set colorcolumn=100: set textwidth=100:

# NOTE
# https://gist.github.com/zeta709/6233038#file-readme-md
# https://gist.github.com/zeta709/6232968#file-readme-md

# myln() usage
# myln "$SRC" "$DEST"
# NOTE: use double quotation mark
myln() {
	echo "Info: trying to make link $1 to $2"
	ln -vis $1 $2
}

SELF_DIR="$( unset CDPATH && cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "Choose color scheme:"
select ans in "dark-16" "light-16" "dark-256" "light-256"; do
	if [ -n "$ans" ]; then
		SCHEME="$ans"
		break;
	fi
done

mybash() {
	BASHRC="$HOME/.bashrc"
	case "$SCHEME" in
		dark-16 | light-16)
			grep -Eq "source\s+~/.bash-256.sh(\s*#.*|\s*)$" "$BASHRC"
			if [ "$?" -eq "0" ]; then
				sed -ri '/source\s+~\/\.bash-256\.sh(\s*#.*|\s*)$/d' "$BASHRC"
			fi
			echo "Info: you may need to do \"export TERM=xterm\""
			echo "Info: you may need to change your terminal palette."
			;;
		dark-256 | light-256)
			SRC="$SELF_DIR/bash/256.sh"
			DEST="$HOME/.bash-256.sh"
			myln "$SRC" "$DEST"
			grep -Eq "source\s+~/\.bash-256\.sh(\s*#.*|\s*)$" "$BASHRC"
			if [ "$?" -ne "0" ]; then
				echo "source ~/.bash-256.sh" >> "$BASHRC"
			fi
			;;
		*)
			echo "Error"
			;;
	esac
	echo "Info: you may need to do \"source ~/.bashrc\""
}

mydircolors() {
	DIRCOLORS_SOLARIZED_DIR="$SELF_DIR/dircolors-solarized"
	if [ -d "$DIRCOLORS_SOLARIZED_DIR" ]; then
		case "$SCHEME" in
			dark-16)
				SRC="$DIRCOLORS_SOLARIZED_DIR/dircolors.ansi-dark"
				;;
			light-16)
				SRC="$DIRCOLORS_SOLARIZED_DIR/dircolors.ansi-light"
				;;
			dark-256)
				SRC="$DIRCOLORS_SOLARIZED_DIR/dircolors.256-dark"
				;;
			light-256 | *)
				SRC=""
				echo "(dircolors): not supported."
				;;
		esac
		DEST="$HOME/.dir_colors"
		if [ -f "$SRC" ]; then
			myln "$SRC" "$DEST"
			echo "Info: you may need to edit .bashrc to load dircolors"
		fi
	fi
}

tmux() {
	TMUXCONF="$HOME/.tmux.conf"
	TMUX_SOLARIZED_DIR="$SELF_DIR/tmux-colors-solarized"
	touch "$TMUXCONF"
	if [ -d "$TMUX_SOLARIZED_DIR" ] && [ -f "$TMUXCONF" ]; then
		case "$SCHEME" in
			dark-16 | light-16)
				grep -Eq "source\s+~/\.tmux-256\.conf(\s*#.*|\s*)$" "$TMUXCONF"
				if [ "$?" -eq "0" ]; then
					sed -ri '/source\s+~\/\.tmux-256\.conf(\s*#.*|\s*)$/d' "$TMUXCONF"
				fi
				;;
			dark-256 | light-256)
				SRC="$SELF_DIR/tmux/256.conf"
				DEST="$HOME/.tmux-256.conf"
				myln "$SRC" "$DEST"
				grep -Eq "source\s+~/\.tmux-256\.conf(\s*#.*|\s*)$" "$TMUXCONF"
				if [ "$?" -ne "0" ]; then
					echo "source ~/.tmux-256.conf" >> "$TMUXCONF"
				fi
				;;
			*)
				echo "Error"
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
			*)
				SRC=""
				echo "Error"
				;;
		esac
		DEST="$HOME/.tmux-colors.conf"
		if [ -f "$SRC" ]; then
			myln "$SRC" "$DEST"
			grep -Eq "source\s+~/\.tmux-colors\.conf(\s*#.*|\s*)$" "$TMUXCONF"
			if [ "$?" -ne "0" ]; then
				echo "source ~/.tmux-colors.conf" >> "$TMUXCONF"
			fi
			echo "Info: done for tmux."
		fi

	else
		echo "Warn: tmux-colors-solarized or ~/.tmux.conf not exists."
	fi
}

vim() {
	VIMRC="$HOME/.vimrc"
	VIM_DIR="$SELF_DIR/vim"
	VIM_SOLARIZED_DIR="$SELF_DIR/vim-colors-solarized"
	touch "$VIMRC"
	if [ -d "$VIM_SOLARIZED_DIR" ] && [ -f "$VIMRC" ]; then
		grep -Eq "execute\s+pathogen#infect\(\)(\s*\".*|\s*)$" "$VIMRC"
		if [ "$?" -ne "0" ]; then
			echo "Warn: pathogen is not installed."
		else
			SRC="$VIM_SOLARIZED_DIR"
			DEST="$HOME/.vim/bundle/vim-colors-solarized"
			if [ -d "$DEST" ]; then
				:
			else
				mkdir -pv "$HOME/.vim/bundle"
				myln "$SRC" "$DEST"
			fi
			SRC="$VIM_DIR/vim-colors-solarized-${SCHEME}.vimrc"
			DEST="$HOME/.vim-colors.vimrc"
			if [ -f "$SRC" ]; then
				myln "$SRC" "$DEST"
				grep -Eq "source\s+~/\.vim-colors\.vimrc(\s*\".*|\s*)$" "$VIMRC"
				if [ "$?" -ne "0" ]; then
					echo "source ~/.vim-colors.vimrc" >> "$VIMRC"
				fi
				echo "Info: done for vim."
			fi
		fi
	else
		echo "Warn: vim-colors-solarized or ~/.vimrc not exists."
	fi
}

mutt() {
	MUTTRC="$HOME/.muttrc"
	MUTT_SOLARIZED_DIR="$SELF_DIR/mutt-colors-solarized"
	touch "$MUTTRC"
	if [ -d "$MUTT_SOLARIZED_DIR" ] && [ -f "$MUTTRC" ]; then
		SRC="$MUTT_SOLARIZED_DIR/mutt-colors-solarized-${SCHEME}.muttrc"
		DEST="$HOME/.mutt-colors.muttrc"
		if [ -f "$SRC" ]; then
			myln "$SRC" "$DEST"
			grep -Eq "source\s+~/\.mutt-colors\.muttrc(\s*#.*|\s*)$" "$MUTTRC"
			if [ "$?" -ne "0" ]; then
				echo "source ~/.mutt-colors.muttrc" >> "$MUTTRC"
			fi
			echo "Info: done for mutt."
		fi
	else
		echo "Warn: mutt-colors-solarized or ~/.muttrc not exists."
	fi
}

mutt
vim
tmux
mydircolors
mybash
