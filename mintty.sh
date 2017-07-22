#!/bin/bash

SELF_DIR="$( unset CDPATH && cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# TODO: prevent muliple installs
cat ${SELF_DIR}/mintty-colors-solarized/.minttyrc.dark >> ~/.minttyrc
cat ${SELF_DIR}/mintty/dot.mintty >> ~/.minttyrc
