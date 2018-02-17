[[ -z "$DOTFILES" ]] && DOTFILES="$HOME/.dotfiles"

load_oh-my-zsh() {
	## ref: oh-my-zsh/templates/zshrc.zsh-template

	local ZSH="$DOTFILES/zsh/oh-my-zsh"
	[[ -z "${ZSH_THEME+x}" ]] && local ZSH_THEME="gentoo2"
	local HYPHEN_INSENSITIVE="true"
	local DISABLE_AUTO_UPDATE="true"
	local DISABLE_UNTRACKED_FILES_DIRTY="true"
	local HIST_STAMPS="yyyy-mm-dd"
	local ZSH_CUSTOM="$DOTFILES/zsh/custom"
	#local plugins=()

	source $ZSH/oh-my-zsh.sh
}

load_oh-my-zsh && unset -f load_oh-my-zsh
source "$DOTFILES/zsh/markdown.zsh"
source "$DOTFILES/z/z.sh"

[ -r "$DOTFILES/.dircolors" ] && eval `dircolors "$DOTFILES/.dircolors"`

export PATH="$HOME/bin:$PATH"
export LANG=en_US.UTF-8

alias vi="vim"
alias ls="ls --color=auto"
alias rm="rm -i"
alias cp="cp -i"
alias mv="mv -i"
alias server="python3 -m http.server" # simple server

#unsetopt autonamedirs
unsetopt cdablevars
