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
alias ll='ls -lah'
alias rm="rm -i"
alias cp="cp -i"
alias mv="mv -i"
alias cal="cal -mw"
alias server="python3 -m http.server" # simple server

## zsh command aliases
alias history='history -i'

## suffix aliases
function {
	local fts=(c cc cpp h hpp md txt)
	local ft
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
fpath=("$DOTDIR/zsh/functions" "${fpath[@]}")

## directory options
setopt auto_cd
setopt auto_pushd
#setopt pushd_minus # FIXME: what's this?

## directory plugins
source "$DOTDIR/z/z.sh"

## completion modules
zmodload -i zsh/complist

## completion options
#setopt always_to_end # FIXME: what's this?
setopt complete_in_word

## completion zstyles
## zstyle ':completion:function:completer:command:argument:tag'
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'l:|{a-zA-Z-_}={A-Za-z_-}' # FIXME
zstyle ':completion:*' use-cache on
zstyle ':completion:*:default' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'

## completion init
autoload -Uz compinit
compinit -i -d "${HOME}/.zcompdump-${HOST/.*/}-${ZSH_VERSION}"

## expansion and globbing options
setopt extended_glob

## history options
setopt extended_history
#setopt hist_expire_dups_first
#setopt hist_fcntl_lock # FIXME: need to be tested
setopt hist_no_store
setopt hist_reduce_blanks
setopt hist_verify
setopt share_history

## history parameters
HISTFILE="$HOME/.zsh_history"
HISTORY_IGNORE="(ls|ll|ls -[laAh1]#|cd|cd -|cd .##(/.#)#)"
HISTSIZE=10000
SAVEHIST=10000

## input/output options
setopt interactive_comments

## job control options
setopt long_list_jobs

## prompting options
setopt prompt_subst

## prompting parameters
autoload -Uz my_git_info
precmd_functions+=(my_git_info)
PS1='%(?..%F{red}%? )%(!.%F{red}.%F{green}%n@)%m %F{blue}%~ $MY_GIT_INFO'
PS1+=$'%($(($COLUMNS/2))l.\n.)%F{blue}%(!.#.$)%f '

## scripts and functions options

## bindkey settings
source "$DOTDIR/zsh/bindkey.zsh"

## misc
autoload -Uz colors && colors

## unset temporary variables
typeset +r DOTDIR
unset DOTDIR
