## key array
## reference: `man 5 terminfo`
## print the key sequence: `cat > /dev/null` and press the key (combination)
## print the key array: `printf '%q => %q\n' "${(@kv)key}"`
typeset -A key
key=(
	"Backspace"  "$terminfo[kbs]"
	"Insert"     "$terminfo[kich1]"
	"Delete"     "$terminfo[kdch1]"
	"Home"       "$terminfo[khome]"
	"End"        "$terminfo[kend]"
	"PageUp"     "$terminfo[kpp]"
	"PageDown"   "$terminfo[knp]"
	"Up"         "$terminfo[kcuu1]"
	"Down"       "$terminfo[kcud1]"
	"Left"       "$terminfo[kcub1]"
	"Right"      "$terminfo[kcuf1]"
	"Ctrl-Left"  "^[[1;5D"
	"Ctrl-Right" "^[[1;5C"
	"Shift-Tab"  "$terminfo[kcbt]"
)

## load zle widgets
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

## bindkey settings
bindkey -e

function my_bindkey() {
	local sequence="${key[$1]}"
	local widget="$2"
	[[ -n "$sequence" ]] && bindkey "$sequence" "$widget"
}

my_bindkey "Backspace"  backward-delete-char
my_bindkey "Insert"     overwrite-mode
my_bindkey "Delete"     delete-char
my_bindkey "Home"       beginning-of-line
my_bindkey "End"        end-of-line
my_bindkey "PageUp"     up-line-or-history
my_bindkey "PageDown"   down-line-or-history
my_bindkey "Up"         up-line-or-beginning-search
my_bindkey "Down"       down-line-or-beginning-search
my_bindkey "Left"       backward-char
my_bindkey "Right"      forward-char
my_bindkey "Ctrl-Left"  backward-word
my_bindkey "Ctrl-Right" forward-word
my_bindkey "Shift-Tab"  reverse-menu-complete

unfunction my_bindkey

## set application mode when zle is active
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
	function zle-line-init() {
		emulate -L zsh
		echoti smkx
	}
	function zle-line-finish() {
		emulate -L zsh
		echoti rmkx
	}
	zle -N zle-line-init
	zle -N zle-line-finish
fi
