" set_abbreviations.vim

" 
" Insert-mode abbreviations
"

iabbrev teh the
iabbrev tihs this


" 
" Command-line abbreviations
"

" Replace :Set typo with :set
" 
" See http://vim.wikia.com/wiki/VimTip1285 for details.
"
cabbrev Set <C-R>=(getcmdtype()==':' && getcmdpos()==1 ? 'set' : 'Set')<CR>

" end set_abbreviations.vim
