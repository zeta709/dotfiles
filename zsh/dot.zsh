## temporary variables
readonly DOTDIR="${${${(%):-%x}:A:h}%/*}" # see self-path repo

## environment variables (not zsh-specific)
export PATH="$HOME/bin:$PATH"
export LANG="en_US.UTF-8"
export GDBHISTFILE="$HOME/.gdb_history"
[[ -r "$HOME/.dircolors" ]] && eval "$(dircolors "$HOME/.dircolors")"

## common aliases (not zsh-specific)
alias grep='grep --color=auto --exclude-dir={.bzr,.git,.hg,.svn,CVS}'
alias vi="vim"
alias ls="ls --color=auto"
alias l="ls -l"
alias ll='ls -lah'
alias rm="rm -i"
alias cp="cp -i"
alias mv="mv -i"
alias cal="cal -mw"
alias server="python3 -m http.server" # simple server
alias viml='vim -R -n -u "NONE"'

## zsh command aliases
alias history='history -i'

## suffix aliases
function {
	local fts ft
	fts=(c cc cpp h hpp md txt)
	for ft in "${fts[@]}"; do
		alias -s "$ft"='$EDITOR'
	done
}

## global aliases
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'

## zsh variables
## typeset -U array: keep unique elements
typeset -Ug fpath precmd_functions preexec_functions
fpath=("$HOME/.zfunc" "$DOTDIR/zsh/functions" "${fpath[@]}")

## directory options
unsetopt auto_cd
setopt auto_pushd
#setopt pushd_minus # FIXME: what's this?

## directory plugins
source "$DOTDIR/z/z.sh"

## completion modules
zmodload -i zsh/complist

## completion options
#setopt always_to_end # FIXME: what's this?
unsetopt menu_complete
unsetopt rec_exact
setopt complete_in_word

## completion zstyles
## zstyle ':completion:function:completer:command:argument:tag'
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list \
	'' 'm:{a-z-}={A-Z_}' 'm:{A-Z_}={a-z-}' 'm:{a-zA-Z-_}={A-Za-z_-}' \
	'r:|.=*' 'l:|=* r:|.=*'
zstyle ':completion:*' use-cache on
zstyle ':completion:*:default' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'

## completion init
autoload -Uz compinit
function {
	local _compdump_files COMPDUMP_FILE
	COMPDUMP_FILE="${HOME}/.zcompdump-${HOST/.*/}-${ZSH_VERSION}"
	_compdump_files=("${COMPDUMP_FILE}"(Nm-24))
	if (( $#_compdump_files )); then
		compinit -C -d "${COMPDUMP_FILE}"
	else
		compinit -i -d "${COMPDUMP_FILE}"
	fi
}

## expansion and globbing options
setopt extended_glob

## history options
unsetopt hist_expire_dups_first
unsetopt hist_ignore_all_dups
unsetopt hist_ignore_dups
unsetopt hist_ignore_space
unsetopt hist_save_no_dups
setopt extended_history
setopt hist_fcntl_lock
setopt hist_find_no_dups
setopt hist_no_store
setopt hist_reduce_blanks
setopt hist_verify
setopt share_history

## history parameters
HISTFILE="$HOME/.zsh_history"
HISTORY_IGNORE="(ls|ll|ls -[laAh1]#)"
HISTSIZE=10000
SAVEHIST=10000

## input/output options
setopt interactive_comments

## job control options
unsetopt bg_nice
setopt long_list_jobs

## prompting options
setopt prompt_subst

## prompting parameters
autoload -Uz my_git_info
precmd_functions+=(my_git_info)
PS1='%(?..%F{red}%? )%(!.%F{red}.%F{green}%n@)%m %F{blue}%~ $MY_GIT_INFO'
PS1+=$'%($(($COLUMNS/2))l.\n.)%F{blue}%(!.#.$)%f '
RPS1="%F{green}%T%f"

## scripts and functions options

## bindkey settings
source "$DOTDIR/zsh/bindkey.zsh"

## misc
autoload -Uz colors && colors

## unset temporary variables
typeset +r DOTDIR
unset DOTDIR
