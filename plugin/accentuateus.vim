" accentuateus.vim
"
" Vim plugin to access the Accentuate.us service.
"

if exists('g:loaded_accentuate_us')
    finish
endif
let g:loaded_accentuate_us = 1

" Use the default Vim compatibility options (mostly to allow long lines
" to be continued with backslashes).
"
let s:save_cpo = &cpo
set cpo&vim


" Define the user-customizable key maps.
"
if !hasmapto('<Plug>AccentuateUsCorrectMotion', 'n')
    nmap <unique> <silent> <Leader>'   <Plug>AccentuateUsCorrectMotion
endif

if !hasmapto('<Plug>AccentuateUsCorrectVisual', 'v')
    vmap <unique> <silent> <Leader>'   <Plug>AccentuateUsCorrectVisual
endif

if !hasmapto('<Plug>AccentuateUsCorrectRange', 'n')
    nmap <unique> <silent> <Leader>''  <Plug>AccentuateUsCorrectRange
endif


" Define <Plug> maps to invoke Correct() appropriately for each key map.
"
nnoremap <unique> <script> <Plug>AccentuateUsCorrectMotion
    \ :set operatorfunc=<SID>Correct<CR>g@

vnoremap <unique> <script> <Plug>AccentuateUsCorrectVisual
    \ :<C-U>call <SID>Correct('visual')<CR>

nnoremap <unique> <script> <Plug>AccentuateUsCorrectRange
    \ :call <SID>Correct('range')<CR>


" Define the default command and language code to use when calling the
" external client. These can also be customized by the user of the
" plugin.
"
if !exists('g:AccentuateUsCommand')
    let g:AccentuateUsCommand = 'sf-client.pl'
endif

if !exists('g:AccentuateUsLanguage')
    let g:AccentuateUsLanguage = 'ga'
endif


function s:Correct(type) range

    " Construct the appropriate range specifier for the way Correct()
    " was invoked.
    "
    if a:type == 'visual'

        " Function was invoked from Visual (or Visual Line) mode, so use
        " the '< and '> marks to denote the range.
        "
        let range_spec = "'<,'>"

    elseif a:type == 'range'

        " Function was invoked with a line range, so build the range
        " specifier from the first and last line numbers (which might be
        " the same).
        "
        let range_spec = a:firstline . ',' . a:lastline

    else " type is 'line', 'char', or 'block'

        " Function was invoked with a motion (linewise, characterwise,
        " or blockwise-visual), so use the '[ and '] to denote the
        " range.
        "
        " Note: Since we're calling a line-oriented filter, it doesn't
        " matter which type of motion was used; the external command
        " acts on (and replaces) full lines.
        "
        let range_spec = "'[,']"

    endif

    " Filter the selected set of lines through the external command.
    "
    silent execute range_spec
        \ . '!'       . g:AccentuateUsCommand
        \ . ' -r -l ' . g:AccentuateUsLanguage

endfunction

" Restore the previous Vim compatibility options.
"
let &cpo = s:save_cpo

" end accentuateus.vim
