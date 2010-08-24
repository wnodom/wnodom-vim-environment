" search_with_skip.vim
"
" XXX: This should be considered alpha-level code. It's useful, but not
" yet well-tested, and almost certainly contains surprises.
"

function! SearchWithSkip(pattern, flags, stopline, timeout, skip)
"
" Returns true if a match is found for {pattern}, but ignores matches
" where {skip} evaluates to false. This allows you to do nifty things
" like, say, only matching outside comments, only on odd-numbered lines,
" or whatever else you like.
"
" Mimics the built-in search() function, but adds a {skip} expression
" like that available in searchpair() and searchpairpos().
" (See the Vim help on search() for details of the other parameters.)
" 
" See below for example uses.
" 
    " Note the current position, so that if there are no unskipped
    " matches, the cursor can be restored to this location.
    "
    let l:matchpos = getpos('.')

    " Loop as long as {pattern} continues to be found.
    "
    while search(a:pattern, a:flags, a:stopline, a:timeout) > 0

        " If {skip} is true, ignore this match and continue searching.
        "
        if eval(a:skip)
            continue
        endif

        " If we get here, {pattern} was found and {skip} is false,
        " so this is a match we don't want to ignore. Update the
        " match position and stop searching.
        " 
        let l:matchpos = getpos('.')
        break

    endwhile

    " Jump to the position of the unskipped match, or to the original
    " position if there wasn't one.
    "
    call setpos('.', l:matchpos)

endfunction


function! SearchOutside(synName, pattern)

    " Search for the specified pattern, but skip matches that
    " exist within the specified syntax region.
    "
    call SearchWithSkip(a:pattern, '', '', '',
        \ 'synIDattr(synID(line("."), col("."), 0), "name") =~? "' . a:synName . '"' )

endfunction


function! SearchInside(synName, pattern)

    " Search for the specified pattern, but skip matches that don't
    " exist within the specified syntax region.
    "
    call SearchWithSkip(a:pattern, '', '', '',
        \ 'synIDattr(synID(line("."), col("."), 0), "name") !~? "' . a:synName . '"' )

endfunction


command! -nargs=+ -complete=command SearchOutside call SearchOutside(<f-args>)
command! -nargs=+ -complete=command SearchInside  call SearchInside(<f-args>)

" end search_with_skip.vim
