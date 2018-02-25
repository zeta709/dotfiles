[[ -z "$DOTFILES" ]] && DOTFILES="$HOME/.dotfiles"

load_oh-my-zsh() {
	## TODO: remove oh-my-zsh
	## ref: oh-my-zsh/templates/zshrc.zsh-template

	# some variables should be non-local since they are used in funtions
	ZSH="$DOTFILES/zsh/oh-my-zsh"

	[[ -z "${ZSH_THEME+x}" ]] && local ZSH_THEME=""
	local HYPHEN_INSENSITIVE="true"
	local DISABLE_AUTO_UPDATE="true"
	DISABLE_UNTRACKED_FILES_DIRTY="true"
	local HIST_STAMPS="yyyy-mm-dd"
	ZSH_CUSTOM="$DOTFILES/zsh/custom"
	#plugins=()

	source "$ZSH/oh-my-zsh.sh"
}

[[ -r "$DOTFILES/.dircolors" ]] && eval "$(dircolors "$DOTFILES/.dircolors")"
load_oh-my-zsh && unset -f load_oh-my-zsh
source "$DOTFILES/z/z.sh"

if [[ -z "${fpath[(r)$DOTFILES/zsh/functions]}" ]]; then
	fpath=("$DOTFILES/zsh/functions" $fpath)
fi
autoload -Uz my_git_info
if [[ -z "${precmd_functions[(r)my_git_info]}" ]]; then
	precmd_functions+=(my_git_info)
fi

PS1='%(?..%F{red}%? )%(!.%F{red}.%F{green}%n@)%m %F{blue}%~ $MY_GIT_INFO%($(($COLUMNS/2))l.'$'\n.)%F{blue}%(!.#.$)%f '

export PATH="$HOME/bin:$PATH"
export LANG=en_US.UTF-8

alias vi="vim"
alias ls="ls --color=auto"
alias rm="rm -i"
alias cp="cp -i"
alias mv="mv -i"
alias cal="cal -mw"
alias server="python3 -m http.server" # simple server

fts=(c cc cpp h hpp md txt)
for ft in "${fts[@]}"; do
	alias -s "$ft"='$EDITOR'
done
unset fts
unset ft

#unsetopt autonamedirs
unsetopt cdablevars
