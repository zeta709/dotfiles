if !has("gui")
	finish
endif

if has("windows")
	if v:version < 703
		"" vim 7.2
		lang en
		source $VIMRUNTIME/delmenu.vim
		set langmenu=ko.UTF-8
		source $VIMRUNTIME/menu.vim
	else
		"" vim 7.3/8.0
		"set langmenu=en_US.UTF-8
		"let $LANG='en_US.UTF-8'
		"set langmenu=ko_KR.UTF-8
		"let $LANG='ko_KR.UTF-8'
		source $VIMRUNTIME/delmenu.vim
		source $VIMRUNTIME/menu.vim
	endif
endif

"set guifont=Dejavu\ Sans\ Mono:h10:cDEFAULT
set guifont=Source\ Code\ Pro\ Semi-Bold\ 11
