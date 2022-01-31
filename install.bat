@echo off

mkdir %USERPROFILE%\vimfiles\autoload
copy vim\vim-plug\plug.vim %USERPROFILE%\vimfiles\autoload\plug.vim

set FILE="%USERPROFILE%/_vimrc"
echo source ~/.dotfiles/vim/dot.vim >> %FILE%
echo source ~/.dotfiles/vim/gui.vim >> %FILE%
echo. >> %FILE%
echo call plug#begin('~/.vim/plugged') >> %FILE%
echo source ~/.dotfiles/vim/dot-plugins.vim >> %FILE%
echo call plug#end() >> %FILE%
echo. >> %FILE%
echo ^" dotfiles are installed >> %FILE%
