" accentuate-us.vim
"
" Vim plugin to access the Accentuate.us translation service.
"
" Last Change:  Mon Oct 25 18:05:45 2010
" Maintainer:   ...
" License:      ...
"

if exists('g:loaded_accentuate_us')
    finish
endif
let g:loaded_accentuate_us = 1

let s:save_cpo = &cpo
set cpo&vim


"
" Define key maps. All of these can be customized by the user of the plugin.
"
" XXX: Are both maps in each of the following <Plug>/<SID> pairs necessary?
" Can (or should) I get away with just the first of each pair?
" 
" XXX: Consider flipping the order of the hasmapto()/<Plug>/<SID> definitions.
"

if !hasmapto('<Plug>AccentuateUsCorrectMotion', 'n')
    nmap <unique> <Leader>'  <Plug>AccentuateUsCorrectMotion
endif
nnoremap <unique> <script> <Plug>AccentuateUsCorrectMotion  <SID>CorrectMotion
nnoremap <SID>CorrectMotion  :set opfunc=<SID>Correct<CR>g@

"nnoremap <unique> <script> <Plug>AccentuateUsCorrectMotion  :set opfunc=<SID>Correct<CR>g@


if !hasmapto('<Plug>AccentuateUsCorrectVisual', 'v')
    vmap <unique> <Leader>'  <Plug>AccentuateUsCorrectVisual
endif
vnoremap <unique> <script> <Plug>AccentuateUsCorrectVisual  <SID>CorrectVisual
vnoremap <SID>CorrectVisual  :<C-U>call <SID>Correct("visual")<CR>


if !hasmapto('<Plug>AccentuateUsCorrectRange', 'n')
    nmap <unique> <Leader>''  <Plug>AccentuateUsCorrectRange
endif
nnoremap <unique> <script> <Plug>AccentuateUsCorrectRange  <SID>CorrectRange
nnoremap <SID>CorrectRange  :call <SID>Correct("range")<CR>

"
" Define the default command and language code to use when calling the
" external client. These can also be customized by the user of the plugin.
"

if !exists('g:AccentuateUsCommand')
    let g:AccentuateUsCommand = 'sf-client.pl'
endif

if !exists('g:AccentuateUsLanguage')
    let g:AccentuateUsLanguage = 'ga'
endif


function s:Correct(type) range

    let sel_save = &selection
    let &selection = 'inclusive'

    " Construct the appropriate range specifier for the way Correct() was
    " invoked.
    "
    if a:type == 'visual'

        " Function was invoked from Visual (or Visual Line) mode, so use
        " the '< and '> marks to denote the range.
        "
        let range = "'<,'>"

    elseif a:type == 'range'

        " Function was invoked with a line range, so build the range specifier
        " from the first and last line numbers (which might be the same).
        "
        let range = a:firstline . ',' . a:lastline

    else " type is 'line', 'char', or 'block'

        " Function was invoked with a motion (linewise, characterwise, or
        " blockwise-visual, so use the '[ and '] to denote the range.
        "
        " Note: Since we're calling a line-oriented filter, it doesn't matter
        " which type of motion was used; the external command acts on (and
        " replaces) full lines.
        "
        let range = "'[,']"

    endif

    execute range . '!' . g:AccentuateUsCommand . ' -r -l ' . g:AccentuateUsLanguage

    let &selection = sel_save

    " Debugging:
    " echo 'a:type = ' . a:type . ' / a:firstline = ' . a:firstline . ' / a:lastline ' . a:lastline

endfunction


let &cpo = s:save_cpo

" end accentuate-us.vim
