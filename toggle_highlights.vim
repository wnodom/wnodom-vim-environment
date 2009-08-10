" toggle_highlights.vim
"

function! ToggleHighlights()
"
" Toggles visibility of search highlighting, 'list' characters (tabs, trailing
" spaces, newlines, etc.), and the cursor line.
"
" Note: Search highlighting is a little odd, since (as far as I can tell)
" there's no way to determine if search highlighting is actually visible or
" not. You can check the 'hlsearch' setting, but that doesn't tell you if the
" user has executed the :nohlsearch command, which is what I really need to
" know.
"
" To deal with this, the first time this function is called, it acts as if the
" 'highlights are visible' flag is already true, indicating that search
" highlighting is on, since that will usually be the case. (The user will
" bounce on the toggle to turn off highlighting after a search.)
" 
" Speaking of :nohlsearch... it doesn't accomplish much inside a function,
" since the highlighting state is restored when the function exits. To deal
" with this, the function doesn't attempt to run the command that affects
" search highlighting; instead, it *returns* the command as a string to the
" caller, so the caller can do this (usually inside a keymap)...
"
"   :execute ToggleHighlights()
"
" ...and the effect will be that highlighting will be toggled appropriately.
" (Yes, this is hackish and weird, but I haven't yet come up with anything
" better.)
"
" XXX: This is still broken (or not-quite-unbroken-enough) to make me happy.
" It doesn't even quite work the way I've described it above.
"
"
    " Flip the flag, or set it if it doesn't yet exist.
    "
    " Note that the flag starts off true (highlights are visible),
    " since most of the time that this function is first called,
    " it will be because the user wants to to turn *off* highlighting.
    " Pretending it's already on when first run does a halfway-decent job of
    " this.
    "
    let w:highlights_visible =
    \   exists('w:highlights_visible') ? !w:highlights_visible : 1

    let l:hlsearch_command = ''

    " Change highlight visibility according to the state of the flag.
    "
    if w:highlights_visible " ...then turn them off

        " Provide the command that the caller should use to temporarily
        " turn off search highlighting.
        "
        let l:hlsearch_command = 'nohlsearch'

        match none
        set nolist
        set nocursorline

    else " ...turn the highlights on

        " Provide the command that the caller should use to (re)activate
        " search highlighting. This will have no effect if 'hlsearch' is
        " not set.
        "
        let l:hlsearch_command = 'let &hls = &hls'

        set list
        set cursorline

    endif

    " Return the command that should be executed in order to
    " affect search highlighting.
    "
    return l:hlsearch_command

endfunction

" end highlights_visible.vim
