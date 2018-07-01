" configure_ale.vim
"
" ALE (Asynchronous Lint Engine) settings

" Always show the sign column, to keep the the window contents
" from shifting back and forth.
"
let g:ale_sign_column_always = 1

" Customize the error and warning symbols in the sign column.
"
" NOTE: The leading spaces in the symbols are non-breaking spaces
" (ASCII 160 vs ASCII 32). Normal spaces cause errors.
"
let g:ale_sign_error    = ' »'
let g:ale_sign_warning  = ' ›'

" Define fixers for issues that can be fixed automatically.
"
let g:ale_fixers = {}
let g:ale_fixers.typescript = [ 'tslint', 'trim_whitespace' ]

" Automatically open the location list for lint errors.
"
"let g:ale_open_list = 1

" Automatically close the location list when the buffer is closed.
"
"augroup CloseLoclistWindowGroup
"  autocmd!
"  autocmd QuitPre * if empty(&buftype) | lclose | endif
"augroup END

