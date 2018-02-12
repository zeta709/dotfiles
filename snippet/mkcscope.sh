#!/bin/sh 

rm -f cscope.files cscope.out cscope.in.out cscope.po.out
find . \( -name '*.[chsS]' -o -name '*.cc' -o -name '*.cpp' \) -exec realpath {} \; > cscope.files
cscope -bkq
