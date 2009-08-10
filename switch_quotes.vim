" switch_quotes.vim
"
" Function and key mapping to allow easy flipping between
" single and double quotes on the current string.
"
" NOTE: This doesn't currently handle strings with embedded
" quotes, like 'this " string' for example.  (I'm working on it,
" but I'm not done yet.) It does work pretty well with multi-line
" strings, however, which was a pleasant surprise.
" 
"

"" Some early alternatives that worked reasonably well, but
"" not as well as the function-based version. These didn't
"" attempt to figure out which quotes were currently used,
"" so they required two mappings.


" These are nice and simple, but didn't remember the original
" cursor position.
"
"map ,' F"r'f"r'
"map ," F'r"f'r"

" Not too complex, and they restore the cursor to its
" original position when complete. Still needed two mappings,
" though.
"
"map <silent> ," :let b:save_curs = getpos(".")<CR>F'r",r":call setpos('.',b:save_curs)<CR>
"map <silent> ,' :let b:save_curs = getpos(".")<CR>F"r',r':call setpos('.',b:save_curs)<CR>


function! SwitchQuotesOnCurrentString()

    " Remember the original cursor position, so it can be
    " restored at the end.
    "
    let l:save_cursor = getpos('.')
    
    " Search backward for the first quote (single or double)
    "
    let l:quote_found = search("['\"]", 'b')

    " Leave now if no quote was found.
    if l:quote_found == 0
        return
    endif

    " Get the character under the cursor.
    let l:quote_char = getline(".")[col(".") - 1]

    let l:other_quote_char = tr(l:quote_char, "'\"", "\"'")
    
    " Replace the current quote character with its opposite.
    execute "normal r" . l:other_quote_char

    " Search forward to the ending quote character.
    let l:quote_found = search(l:quote_char)

    " Replace the current quote character with its opposite.
    execute "normal r" . l:other_quote_char

    " Restore the original cursor position.
    call setpos('.', l:save_cursor)

endfunction

" This is now done within the calling .vim file, so the caller
" can choose the mapping.
"
"map <silent> ,' :call SwitchQuotesOnCurrentString()<CR>


" end switch_quotes.vim
