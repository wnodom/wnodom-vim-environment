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

" Mappings
"
" Some other mappings to consider:
"
" <Plug>(ale_detail)
" <Plug>(ale_go_to_definition)
" <Plug>(ale_hover)
" <Plug>(ale_lint)
" <Plug>(ale_toggle_buffer)
"
nmap  \lf  <Plug>(ale_fix)
nmap  \ld  <Plug>(ale_go_to_definition_in_tab)
nmap  \lr  <Plug>(ale_find_references)
nmap  \lt  <Plug>(ale_toggle):echo 'ALE ' . (g:ale_enabled ? 'enabled' : 'disabled')<CR>


" XXX: Auto-opening of lint issues list disabled for now, since it
" seems a little buggy.

" " Automatically open the location list for lint errors.
" " Limit the list to 5 lines (vs the default 10).
" "
" let g:ale_open_list = 1
" let g:ale_list_window_size = 5
" 
" " Automatically close the location list when the buffer is closed.
" "
" augroup CloseLoclistWindowGroup
"   autocmd!
"   autocmd QuitPre * if empty(&buftype) | lclose | endif
" augroup END
