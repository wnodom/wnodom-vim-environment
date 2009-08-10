" insert_matching_spaces.vim

function! InsertMatchingSpaces()
"
" Algorithm:
" - starting at current column position in the current line...
" - find the end of the next whitespace run in the previous non-blank
"   line
" - insert the correct number of spaces in the current line to reach
"   that same position
"
" Example use:
"
"   imap <expr> <S-Tab> InsertMatchingSpaces()
"
"   Maps Shift+Tab in Insert mode to automatically jump to the next
"   'column position' based on the first non-blank line above the
"   current line.
"
    let l:cur_col = col(".")

    let l:pnbline = getline( prevnonblank( line(".") - 1 ) )

    let l:num_spaces = matchend(l:pnbline, ' \+', l:cur_col) - l:cur_col + 1

    return repeat(" ", l:num_spaces)

endfunction

" end insert_matching_spaces.vim
