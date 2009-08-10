" search_enhancements.vim

function! StringToPattern(string)
"
" Returns the specified string as a pattern suitable for use in a Vim /
" or ? search, or in a :s// substitution.
"
" Transforms problematic characters (like newlines, backspaces, tabs,
" etc.) into suitable escape sequences, then wraps the transformed
" string with \V ('very nomagic') and \m ('normal magic') to allow the
" pattern to be used without escaping all of the usual Vim regex
" metacharacters (like dot and star and caret and dollar sign and...).
" Using \V and \m also means that the resulting pattern doesn't depend
" on the current 'magic' setting.
"
" See GetLiteralPattern() for an example of using this function.
"
    " Initialize the pattern to the string itself, to make the transformation
    " assignments consistent.
    "
    let l:pattern = a:string

    " Start by escaping backslashes and slashes (that is, prefixing each
    " with a backslash). Backslashes are the only metacharacters in a
    " 'very nomagic' pattern, and slashes delimit a search pattern, so
    " both have to be escaped to avoid interfering with typical searches
    " and substitutions.
    "
    let l:pattern = escape(l:pattern, '\\/')

    " Replace carriage returns with a backslash-n (two characters), to handle
    " multi-line matches. This has to be done separately from the larger
    " catch-all substitution below, since Vim treats newlines differently from
    " other characters.
    "
    let l:pattern = substitute(l:pattern, "\r", '\\n', 'g')

    " Replace any character that isn't a letter, number, punctuation, or space
    " with a \%dNNN escape sequence (where NNN is the numeric value of the
    " character returned by char2nr). Surround the escape sequence with
    " non-capturing parens \%(...\) to ensure that the numeric code doesn't
    " accidentally run into any following digits.
    "
    let l:pattern = substitute(l:pattern,
        \   '\([^[:alnum:][:punct:] ]\)',
        \   '\="\\%(\\%d" . char2nr(submatch(1)) . "\\)"',
        \   'g')

    " Return the sanitized string, wrapped in the \V ... \m escape
    " sequences.
    "
    return '\V' . l:pattern . '\m'

endfunction


function! GetLiteralPattern()
"
" Prompts for a string from the user, then returns it as an escaped regex
" suitable for use as a search pattern. If the user doesn't enter a string (or
" hits Escape), then an empty string is returned. (This avoids mucking up any
" existing pattern with spurious \V\m sequences.)
"
" This is most useful in a search command or the search portion of a :s//
" command, where it makes it easy for a user to enter punctuation-heavy text
" (like URLs or source code) without requiring the user to manually escape
" metacharacters within the text.
"
" Use this function in a mapping like this:
"
"   cmap <C-G>  <C-R><C-R>=GetLiteralPattern()<CR>
"
" With this mapping, a user can, for example, begin a search by typing a
" forward slash in Vim's normal mode, and then begin entering text as usual:
"
"   /here is a URL: 
"
" ...then type Control+G for the 'escaped search' prompt \/ and enter a URL:
"
"   \/http://example.com/script.cgi?param=123
"
" Once the user hits Enter, the search expression will now look like this:
"
"   /here is a URL: \Vhttp:\/\/example.com\/script.cgi?param=123\m
"
" At this point, the user can just hit Enter to perform the search, or add a
" closing slash and add any search options.
"
" This technique can be used multiple times within a single search pattern,
" and also works within the search portion of a :substitute command.
"
" Note: You can also use an expression mapping like this:
"
"   cmap <expr> <C-E>  GetLiteralPattern()
"
" While it's cleaner and easier to understand than the insert-literal-register
" version, it falls victim to an apparent bug in the Vim input() function.
" Specifically, if the user hits Escape or doesn't enter any text, then the
" current command line doesn't get redrawn. The user is left either looking at
" a blank command line, or at the old input prompt, with no indication of what
" to do next. The first mapping doesn't have this problem.
"
    " Get the string, with a prompt to indicate that this
    " is an 'escaped' pattern.
    "
    let l:string = input('\/')

    " Return the converted string, or an empty string
    " if the user didn't enter anything.
    "
    return ( empty(l:string) ? '' : StringToPattern(l:string) )

endfunction


" end search_enhancements.vim
