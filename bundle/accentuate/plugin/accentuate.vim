" accentuate.vim
"
" Vim plugin to access the Accentuate.us service.
"

if exists('g:loaded_accentuate')
    finish
endif
let g:loaded_accentuate = 1

" Use the default Vim compatibility options (mostly to allow long lines
" to be continued with backslashes).
"
let s:save_cpo = &cpo
set cpo&vim


" Define the user-customizable key maps.
"
if !hasmapto('<Plug>AccentuateMotion', 'n')
    nmap <unique> <silent> <Leader>'   <Plug>AccentuateMotion
endif

if !hasmapto('<Plug>AccentuateVisual', 'v')
    vmap <unique> <silent> <Leader>'   <Plug>AccentuateVisual
endif

if !hasmapto('<Plug>AccentuateRange', 'n')
    nmap <unique> <silent> <Leader>''  <Plug>AccentuateRange
endif


" Define <Plug> maps to invoke Accentuate() appropriately for each key map.
"
nnoremap <unique> <script> <Plug>AccentuateMotion
    \ :set operatorfunc=<SID>Accentuate<CR>g@

" Notice that this uses <C-U> to remove the '<,'> range specifier before
" calling Accentuate().
"
vnoremap <unique> <script> <Plug>AccentuateVisual
    \ :<C-U>call <SID>Accentuate('visual')<CR>

nnoremap <unique> <script> <Plug>AccentuateRange
    \ :call <SID>Accentuate('range')<CR>


" Define the default command and language code to use when calling the
" external client. These can also be customized by the user of the plugin.
"
if !exists('g:AccentuateCommand')
    let g:AccentuateCommand = 'sf-client.pl'
endif

if !exists('g:AccentuateLanguage')
    let g:AccentuateLanguage = 'gla'
endif


function s:Accentuate(type) range

    " Construct the appropriate range specifier for the way Accentuate()
    " was invoked.
    "
    if a:type == 'visual'

        " Function was invoked from Visual (or Visual Line) mode, so use
        " the '< and '> marks to denote the range.
        "
        let range_spec = "'<,'>"

    elseif a:type == 'range'

        " Function was invoked with a line range, so build the range specifier
        " from the first and last line numbers (which might be the same).
        "
        let range_spec = a:firstline . ',' . a:lastline

    else " type is 'line', 'char', or 'block'

        " Function was invoked with a motion (linewise, characterwise, or
        " blockwise-visual), so use the '[ and '] to denote the range.
        "
        " Note: Since we're calling a line-oriented filter, it doesn't matter
        " which type of motion was used; the external command acts on (and
        " replaces) full lines.
        "
        let range_spec = "'[,']"

    endif

    " Filter the selected set of lines through the external command.
    "
    silent execute range_spec
        \ . '!'       . g:AccentuateCommand
        \ . ' -r -l ' . g:AccentuateLanguage

endfunction

" Restore the previous Vim compatibility options.
"
let &cpo = s:save_cpo

" end accentuate.vim
