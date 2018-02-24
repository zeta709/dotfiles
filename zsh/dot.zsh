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

load_oh-my-zsh && unset -f load_oh-my-zsh
source "$DOTFILES/z/z.sh"

[[ -r "$DOTFILES/.dircolors" ]] && eval "$(dircolors "$DOTFILES/.dircolors")"

my_git_info() {
	## NOTE
	## $ git symbolic-ref [--short] HEAD
	##   - no result if HEAD is detached
	## $ git rev-parse --abbrev-ref HEAD
	##   - wrong result if HEAD is detached: result is "HEAD"
	## $ git rev-parse [--short] HEAD
	##   - result is always SHA1
	## $ git branch
	##   - no result if the repo has no commit
	local MY_GIT_DIR_NEW="$(git rev-parse --git-dir 2>/dev/null)"
	if [[ -n "$MY_GIT_DIR_NEW" ]]; then
		MY_GIT_DIR_NEW="$(realpath "$MY_GIT_DIR_NEW")"
		local MY_GIT_FILE_STAMP="$(stat -c "%Y" "$MY_GIT_DIR_NEW/HEAD")"
		if [[ -z "$MY_GIT_DIR" ]] || [[ "$MY_GIT_DIR" != "$MY_GIT_DIR_NEW" ]] \
			|| [[ -z "$MY_GIT_STAMP" ]] || [[ "$MY_GIT_STAMP" -lt "$MY_GIT_FILE_STAMP" ]]; then
			MY_GIT_DIR="$MY_GIT_DIR_NEW"
			local MY_GIT_SYMREF="$(git symbolic-ref --short HEAD 2>/dev/null)"
			if [[ -n "$MY_GIT_SYMREF" ]]; then
				MY_GIT_INFO="%F{cyan}($MY_GIT_SYMREF)%f "
			else
				MY_GIT_INFO="%F{cyan}($(git branch 2>/dev/null | grep "^\*" | sed -E -e 's/\(HEAD detached (at|from) (.*)\)/%F{magenta}\2%F{cyan}/;s/\* //'))%f "
			fi
			MY_GIT_STAMP="$(date +%s)"
		fi
	else
		MY_GIT_DIR=""
		MY_GIT_INFO=""
		MY_GIT_STAMP=""
	fi
}

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
