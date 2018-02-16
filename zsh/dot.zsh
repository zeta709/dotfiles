# If you come from bash you might have to change your $PATH.
export PATH="$HOME/bin:/usr/local/bin:$PATH"

[[ -z "$DOTFILES" ]] && DOTFILES="$HOME/.dotfiles"

# Path to your oh-my-zsh installation.
export ZSH="$DOTFILES/zsh/oh-my-zsh"

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
[[ -z "$ZSH_THEME" ]] && ZSH_THEME="agnoster-light"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"
DISABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="yyyy-mm-dd"

# Would you like to use another custom folder than $ZSH/custom?
ZSH_CUSTOM="$DOTFILES/zsh/custom"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
#plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

alias vi="vim"

alias ls="ls --color=auto"
alias rm="rm -i"
alias cp="cp -i"
alias mv="mv -i"

# dircolors
[ -r "$DOTFILES/.dircolors" ] && eval `dircolors "$DOTFILES/.dircolors"`

#unsetopt autonamedirs
unsetopt cdablevars

# simple server
alias server="python3 -m http.server"
# simple server for markdown
mdserver() {
  if [ "$#" -ne 1 ]; then
    echo "Usage: mdserver file.md"
    return
  fi

  local TMP="$HOME/tmp"
  mkdir -p "$TMP" || return
  local CSS="markdown_pandoc.css"
  if [ ! -r "$TMP/$CSS" ]; then
    (
    cd "$TMP" || return
    if [ ! -r markdown.css ]; then
      curl -O "https://guides.github.com/components/primer/markdown.css" || return
    fi
    sed 's/.markdown-//g' markdown.css > "$CSS" || return
    )
  fi

  local OPT="-f markdown_github -t html5 --self-contained --standalone"
  pandoc ${=OPT} --css "$TMP/$CSS" -o "$TMP/index.html" -- "$1" || return
  (cd "$TMP" && python3 -m http.server)
}

source "$DOTFILES/z/z.sh"
