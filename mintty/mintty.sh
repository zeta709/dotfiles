#!/bin/bash

SELF_DIR="$( unset CDPATH && cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# TODO: prevent muliple installs
{
	echo
	echo "# dot.mintty"
	cat "${SELF_DIR}/dot.mintty"
	echo
} >> ~/.minttyrc

cat <<- 'EOF' >> ~/.vimrc
	" mintty
	let &t_ti.="\e[1 q"
	let &t_SI.="\e[5 q"
	let &t_EI.="\e[1 q"
	let &t_te.="\e[0 q"

EOF
