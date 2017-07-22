#!/bin/bash

SELF_DIR="$( unset CDPATH && cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# TODO: prevent muliple installs
echo "# solarized" >> ~/.minttyrc
cat ${SELF_DIR}/mintty-colors-solarized/.minttyrc.dark >> ~/.minttyrc
echo "# dot.mintty" >> ~/.minttyrc
cat ${SELF_DIR}/mintty/dot.mintty >> ~/.minttyrc

cat <<- 'EOF' >> ~/.vimrc
	" mintty
	let &t_ti.="\e[1 q"
	let &t_SI.="\e[5 q"
	let &t_EI.="\e[1 q"
	let &t_te.="\e[0 q"

EOF
