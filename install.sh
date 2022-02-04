#!/bin/bash
# vim: noexpandtab:sw=4:ts=4

# usage: source_rc "$baserc_escaped" "$rc"
source_rc() {
	local baserc="$1"
	local rc="$2"
	[ -f "$rc" ] || touch "$rc"
	if ! grep -Fq "source $baserc" "$rc"; then
		echo "source $baserc" >> "$rc"
	fi
}

scriptdir="$(unset CDPATH && cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
scriptdir_escaped="$(printf "%q" "$scriptdir")"

# zsh
source_rc "$scriptdir_escaped/zsh/dot.zsh" "$HOME/.zshrc"
echo "note: .zlogin/.zlogout will not be installed automatically"

# vim
[ -f "$HOME/.vimrc" ] || touch "$HOME/.vimrc"
if [ ! -f "$HOME/.vim/autoload/plug.vim" ]; then
	mkdir -p "$HOME/.vim/autoload"
	ln -vis "$scriptdir/vim/vim-plug/plug.vim" "$HOME/.vim/autoload/plug.vim"
fi
if ! grep -q "$scriptdir_escaped" "$HOME/.vimrc"; then
	cat <<- EOF >> "$HOME/.vimrc"
		source $scriptdir_escaped/vim/dot.vim
		source $scriptdir_escaped/vim/gui.vim

		call plug#begin('$HOME/.vim/plugged')
		source $scriptdir_escaped/vim/dot-plugins.vim
		Plug '$scriptdir_escaped/fzf'
		Plug 'junegunn/fzf.vim'
		call plug#end()
	EOF
fi

# gdb
source_rc "$scriptdir_escaped/gdb/dot.gdb" "$HOME/.gdbinit"

# git
dotgitconfig="$(git config --global --get-all include.path "^$scriptdir/git/dot.gitconfig$")"
if [ -z "$dotgitconfig" ]; then
	git config --global --add include.path "$scriptdir/git/dot.gitconfig"
fi

# tmux
source_rc "$scriptdir_escaped/tmux/dot.tmux.conf" "$HOME/.tmux.conf"

# bin
mkdir -p "$HOME/bin"
find "$scriptdir/bin" -type f -executable -exec ln -vis -t "$HOME/bin" "{}" \;

## fzf
"$scriptdir/fzf/install"
[ ! -e "$HOME/.fzf" ] && ln -vis "$scriptdir/fzf" "$HOME/.fzf"

# etc.
#ln -vis "$scriptdir/mutt/.muttrc" "$HOME/.muttrc"
