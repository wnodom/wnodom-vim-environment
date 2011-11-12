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

" Lorem ipsum
"
iabbrev <expr> _lipsum ''
    \ . 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
    \ . 'Praesent hendrerit tempus adipiscing. Nullam vitae nibh ut '
    \ . 'arcu volutpat porta. Ut tristique molestie mollis. In at erat '
    \ . 'a ante molestie molestie. Suspendisse varius arcu nec augue '
    \ . 'condimentum semper. Vestibulum malesuada pulvinar mi, '
    \ . 'fermentum elementum eros adipiscing dignissim. Vestibulum at '
    \ . 'odio risus. Ut ipsum erat, volutpat sed cursus nec, blandit '
    \ . 'ac diam. Integer tincidunt sollicitudin eros, sit amet '
    \ . 'vulputate justo sollicitudin malesuada. Nulla dapibus dictum '
    \ . 'dolor id semper. Phasellus pretium dapibus massa quis auctor. '


" 
" Command-line abbreviations
"

" Replace :Set typo with :set
" 
" See http://vim.wikia.com/wiki/VimTip1285 for details.
"
cabbrev Set <C-R>=(getcmdtype()==':' && getcmdpos()==1 ? 'set' : 'Set')<CR>


" end set_abbreviations.vim
