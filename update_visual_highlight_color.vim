" update_visual_highlight_color.vim
"
" Experimental script to change the 'Visual' highlight group to different
" values depending on whether we're in 'Select' mode or not.
"
" To use, copy this script to ~/.vim and add these lines to your .vimrc:
"
"   runtime update_visual_highlight_color.vim
"   set statusline+=%{UpdateVisualHighlightColor(mode(0))}
"
" Notes:
" 
" This uses a 'statusline' function to set highlighting as a side efffect, so
" it only works if there's a status line visible in the current window.
" `:set laststatus=2` to make sure.
"
" Also, if you don't already customize 'statusline', you'll want to do
" something like this beforehand to keep the status line from being blank:
"
"    set statusline=%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P
"
" Here's why: If you leave 'statusline' at its default empty value, Vim
" displays a reasonable default status line. Once UpdateVisualHighlightColor()
" is added, however, 'statusline' is no longer empty, so Vim uses the value it
" returns -- that is, the empty string -- as the text of the status line.
" Setting 'statusline' to the value above (a reasonable approximation of Vim's
" default) before appending UpdateVisualHighlightColor() solves the problem.
"
" TODO:
" - Link to existing highlight groups (possibly predefined by the user)
"   instead of hard-coding guifg and guibg.
" - Consider converting to a plugin, with real documentation.
" - Handle Visual Block mode.
" - Complete the definitions of the default highlighting groups.
"

" Define default highlighting groups used for specific Visual sub-modes.
" (These can be overridden within a colorscheme.)
"
highlight default Select            guifg=#3c6182   guibg=White
highlight default VisualOriginal    guifg=White     guibg=#3c6182


function! UpdateVisualHighlightColor(xm)

    " Grab the short version of the current mode,
    " and convert it to uppercase so we don't have to
    " worry about the characterwise vs. linewise sub-modes.
    "
    " XXX: This doesn't (yet) handle Visual Block mode.
    "
    let l:m = toupper(a:xm)

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

" end update_visual_highlight_color.vim
