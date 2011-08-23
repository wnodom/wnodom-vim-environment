" update_visual_highlight_color.vim
"
" Experimental script to change the 'Visual' highlight group to different
" values depending on whether we're in 'Select' mode or not.
"
" To use, copy this script to ~/.vim and add this line to your .vimrc:
"
"   runtime update_visual_highlight_color.vim
"
" Notes:
"
" At the moment, this script uses a 'statusline' function to work its magic,
" but that may not always be the case. A status line function is executed
" after nearly every user-visible Vim action, and I'm only using it because I
" haven't yet found a great combination of autocommands to provide the same
" capability. It has a few annoying drawbacks, one of which is that a
" status line function is only executed when there's a status line visible in
" the current window. `:set laststatus=2` to make sure.
"
" 
" TODO:
" - Build the default highlighting groups from the the existing Visual
"   highlighting group.
" - Consider converting to a plugin, with real documentation.
" - Handle Visual Block mode.
" - Complete the definitions of the default highlighting groups.
"

" Define default highlighting groups used for specific Visual sub-modes.
" (These can be overridden within a colorscheme.)
"
highlight default VisualOriginal    guifg=#3c6182   guibg=White
highlight default Select            guifg=White     guibg=#3c6182


if hlexists('Visual')

    " XXX: Left off here, working out how best to copy
    " the Visual highlight definition into VisualOriginal.

endif


function! UpdateVisualHighlightColor()

    " Grab the short version of the current mode,
    " and convert it to uppercase so we don't have to
    " worry about the characterwise vs. linewise sub-modes.
    "
    " XXX: This doesn't (yet) handle Visual Block mode.
    "
    let l:m = toupper(mode(0))

    " Link the Visual highlighting to the appropriate highlighting group
    " based on the current mode.
    "
    if l:m ==# "S"
        highlight! link Visual Select
        redraw
    elseif l:m ==# "V"
        highlight! link Visual VisualOriginal
        redraw
    endif

    " Don't contribute anything to the statusline. This
    " is all about the side effects.
    "
    return ""

endfunction


""
"" Initialization and Setup
""

" If 'statusline' isn't defined, define one that's reasonably close to the Vim
" default, to avoid displaying a blank status line.
"
" Here's why this is necessary: If you leave 'statusline' at its default empty
" value, Vim displays a reasonable default status line. Once
" UpdateVisualHighlightColor() is added, however, 'statusline' is no longer
" empty, so Vim uses the value the function returns -- that is, the empty
" string -- as the status line text. Setting 'statusline' to the value below
" (a reasonable approximation of Vim's default) before appending
" UpdateVisualHighlightColor() solves the problem.
"
if &statusline == ''
    set statusline=%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P0
endif

" Add the function to 'statusline', so the highlight color
" can (potentially) be updated whenever the status line changes.
" 
set statusline+=%{UpdateVisualHighlightColor()}


" end update_visual_highlight_color.vim
