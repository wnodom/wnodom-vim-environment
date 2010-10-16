" set_abbreviations.vim

" 
" Insert-mode abbreviations
"

" Common typos
"
iabbrev teh     the
iabbrev tihs    this
iabbrev jsut    just
iabbrev exmaple example


" E-mail addresses and signature
"
iabbrev _ett    wnodom@tmtowtdi.com
iabbrev _egm    billodom@gmail.com
iabbrev _sig    Thanks,<CR>Bill



" 
" Command-line abbreviations
"

" Replace :Set typo with :set
" 
" See http://vim.wikia.com/wiki/VimTip1285 for details.
"
cabbrev Set <C-R>=(getcmdtype()==':' && getcmdpos()==1 ? 'set' : 'Set')<CR>


" end set_abbreviations.vim
