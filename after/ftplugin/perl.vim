" .vim/after/ftplugin/perl.vim

" Format with perltidy
setlocal equalprg=perltidy

" Autocomplete fully-qualified identifiers
setlocal iskeyword+=:

" Use perldoc instead of man when editing Perl programs and modules
" 
" XXX: This can be improved, but it's beter than the default.
"
setlocal keywordprg=perldoc\ -f

" end .vim/after/ftplugin/perl.vim
